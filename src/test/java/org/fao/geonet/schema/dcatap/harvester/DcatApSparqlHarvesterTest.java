package org.fao.geonet.schema.dcatap.harvester;

import static org.junit.Assert.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpServer;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URIBuilder;
import org.apache.jena.query.QueryExecution;
import org.apache.jena.query.QueryExecutionFactory;
import org.apache.jena.query.ResultSetFormatter;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.rdf.model.Resource;
import org.apache.jena.riot.Lang;
import org.apache.jena.riot.RDFDataMgr;
import org.apache.jena.vocabulary.RDF;
import org.fao.geonet.exceptions.XSDValidationErrorEx;
import org.fao.geonet.kernel.harvest.harvester.AbstractHarvester;
import org.fao.geonet.utils.Xml;
import org.fao.geonet.utils.TransformerFactoryFactory;
import org.jdom.Element;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.support.DefaultListableBeanFactory;
import org.springframework.beans.factory.xml.XmlBeanDefinitionReader;
import org.springframework.core.io.FileSystemResource;

public class DcatApSparqlHarvesterTest {
    private static final Path SCHEMA = Paths.get("src/main/plugin/dcat-ap").toAbsolutePath();
    private static final Path QUERIES = Paths.get("src/main/resources/dcat-ap/harvesting/sparql");
    private static final String BASE = "https://example.org/entity/";
    private static final String PRODUCT = BASE + "dataProduct/00000000-0000-0000-0000-000000000001";
    private static final String DCAT = "http://www.w3.org/ns/dcat#";
    private static final String DCT = "http://purl.org/dc/terms/";
    private static final String HEALTH = "http://healthdataportal.eu/ns/health#";
    private static final String CSVW = "http://www.w3.org/ns/csvw#";
    private static final String VCARD = "http://www.w3.org/2006/vcard/ns#";
    private static final String CV = "http://data.europa.eu/m8g/";
    private Model fixture;
    private HttpServer server;
    private final AtomicInteger status = new AtomicInteger(200);
    private Lang graphFormat = Lang.RDFXML;
    private boolean postOnly;
    private boolean jsonPostOnly;
    private String expectedAuthorization = "Bearer test-token";

    @Before
    public void setUp() throws Exception {
        TransformerFactoryFactory.init("net.sf.saxon.TransformerFactoryImpl");
        fixture = ModelFactory.createDefaultModel();
        RDFDataMgr.read(fixture, "src/test/resources/sparql-default.ttl");
        server = HttpServer.create(new InetSocketAddress("127.0.0.1", 0), 0);
        server.createContext("/sparql", exchange -> {
            boolean post = "POST".equals(exchange.getRequestMethod());
            if ((postOnly || jsonPostOnly) && !post) {
                exchange.sendResponseHeaders(jsonPostOnly ? 431 : 405, -1);
                exchange.close();
                return;
            }
            if (jsonPostOnly && !"application/json".equals(exchange.getRequestHeaders().getFirst("Content-Type"))) {
                exchange.getRequestBody().readAllBytes();
                exchange.sendResponseHeaders(415, -1);
                exchange.close();
                return;
            }
            byte[] response;
            try {
                Map<String, String> parameters = new java.util.HashMap<>();
                for (NameValuePair p : new URIBuilder(exchange.getRequestURI()).getQueryParams()) {
                    parameters.put(p.getName(), p.getValue());
                }
                assertEquals(expectedAuthorization, exchange.getRequestHeaders().getFirst("Authorization"));
                String queryText = parameters.get("query");
                if (post) {
                    String body = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
                    queryText = jsonPostOnly ? new ObjectMapper().readTree(body).get("query").asText() : body;
                }
                ByteArrayOutputStream output = new ByteArrayOutputStream();
                try (QueryExecution query = QueryExecutionFactory.create(queryText, fixture)) {
                    if (query.getQuery().isSelectType()) {
                        exchange.getResponseHeaders().set("Content-Type", "application/sparql-results+json");
                        ResultSetFormatter.outputAsJSON(output, query.execSelect());
                    } else {
                        String mediaType = graphFormat.equals(Lang.RDFXML) ? "application/sparql-results+json"
                            : graphFormat.getContentType().getContentTypeStr();
                        exchange.getResponseHeaders().set("Content-Type", mediaType);
                        RDFDataMgr.write(output, query.execConstruct(), graphFormat);
                    }
                }
                response = output.toByteArray();
            } catch (Exception e) {
                e.printStackTrace();
                exchange.sendResponseHeaders(500, -1);
                exchange.close();
                return;
            }
            exchange.sendResponseHeaders(status.get(), response.length);
            try (java.io.OutputStream output = exchange.getResponseBody()) {
                output.write(response);
            }
        });
        server.start();
    }

    @After
    public void tearDown() {
        server.stop(0);
        fixture.close();
    }

    @Test
    public void mapsJsonRowsVocabularyContactsAndDeepVariablesWithoutDuplicatingDistributions() throws Exception {
        Map<String, Element> records = fetch(openMetadataParams());
        assertEquals(4, records.size());
        Model mapped = readRecord(records.get("00000000-0000-0000-0000-000000000001"));
        Resource dataset = mapped.getResource(PRODUCT);
        assertEquals("00000000-0000-0000-0000-000000000001",
            mapped.getResource(PRODUCT + "/record").getProperty(mapped.createProperty(DCT + "identifier")).getString());
        assertEquals("<p>Mock & example</p>", dataset.getProperty(mapped.createProperty(DCT + "description")).getString());
        assertEquals(2, dataset.listProperties(mapped.createProperty(DCAT + "distribution")).toList().size());
        assertTrue(mapped.contains(null, mapped.createProperty(DCAT + "accessURL"), mapped.createResource("https://example.org/data.csv")));
        assertTrue(mapped.contains(dataset, mapped.createProperty(DCAT + "theme"),
            mapped.createResource("http://publications.europa.eu/resource/authority/data-theme/HEAL")));
        Resource contact = dataset.getPropertyResourceValue(mapped.createProperty(DCAT + "contactPoint"));
        assertTrue(contact.hasProperty(RDF.type, mapped.createResource(VCARD + "Organization")));
        assertTrue(contact.hasProperty(mapped.createProperty(VCARD + "hasEmail"), mapped.createResource("mailto:mock@example.org")));
        assertTrue(contact.hasProperty(mapped.createProperty(VCARD + "hasURL"), mapped.createResource("https://example.org/contact")));
        Resource hdab = dataset.getPropertyResourceValue(mapped.createProperty(HEALTH + "hdab"));
        Resource hdabContact = hdab.getPropertyResourceValue(mapped.createProperty(CV + "contactPoint"));
        assertTrue(hdabContact.hasProperty(RDF.type, mapped.createResource(CV + "ContactPoint")));
        assertTrue(hdabContact.hasProperty(mapped.createProperty(CV + "email"), "hdab@example.org"));
        assertTrue(hdabContact.hasProperty(mapped.createProperty(CV + "contactPage"), mapped.createResource("https://example.org/hdab")));
        assertEquals("true", dataset.getProperty(mapped.createProperty(HEALTH + "hasStructuredData")).getString());
        Resource variables = dataset.getPropertyResourceValue(mapped.createProperty(HEALTH + "hasVariables"));
        assertEquals(2, variables.listProperties(mapped.createProperty(CSVW + "table")).toList().size());
        assertEquals(4, mapped.listStatements(null, mapped.createProperty(CSVW + "name"), (String) null).toList().size());
        assertTrue(mapped.contains(null, mapped.createProperty(CSVW + "datatype"), "integer"));
        assertEquals(2, dataset.listProperties(mapped.createProperty(DCAT + "keyword")).toList().size());
        Model again = readRecord(fetch(openMetadataParams()).get("00000000-0000-0000-0000-000000000001"));
        assertTrue(mapped.isIsomorphicWith(again));
        mapped.close();
        again.close();
    }

    @Test
    public void joinsCustomDistributionToAssetWhenUrlIsProjected() throws Exception {
        RDFDataMgr.read(fixture, "src/test/resources/sparql-default-with-asset-url.ttl");
        Model mapped = readRecord(fetch(openMetadataParams()).get("00000000-0000-0000-0000-000000000001"));
        Resource dataset = mapped.getResource(PRODUCT);
        assertEquals(2, dataset.listProperties(mapped.createProperty(DCAT + "distribution")).toList().size());
        assertTrue(mapped.contains(mapped.getResource(PRODUCT + "/distribution/00000000-0000-0000-0000-000000000101"),
            mapped.createProperty(DCAT + "accessURL"), mapped.createResource("https://example.org/data.json")));
        assertTrue(mapped.contains(null, mapped.createProperty(DCAT + "accessService"), mapped.createResource(BASE + "apiService/mock")));
        assertFalse(mapped.contains(null, RDF.type, mapped.createResource(DCAT + "DataService")));
        mapped.close();
    }

    @Test
    public void preservesIncompleteOpenMetadataSourceRecordsForValidation() throws Exception {
        Map<String, Element> records = fetch(openMetadataParams());
        assertEquals(4, records.size());
        Xml.validate(SCHEMA.resolve("schema.xsd"), records.get("00000000-0000-0000-0000-000000000001"));
        assertThrows(XSDValidationErrorEx.class,
            () -> Xml.validate(SCHEMA.resolve("schema.xsd"), records.get("00000000-0000-0000-0000-000000000002")));
    }

    @Test
    public void mapsConfiguredSelectResultsWithTheChosenStylesheet() throws Exception {
        postOnly = true;
        DcatApSparqlParams params = params();
        params.query = "SELECT ?title WHERE { VALUES ?title { \"A & B < C\" } }";
        params.setImportXslt("schema:dcat-ap:convert/fromCustom");
        Path stylesheet = Paths.get("src/test/resources/fromCustomSparql.xsl").toAbsolutePath();
        Map<String, Element> records = SparqlRecords.fetch(params, SCHEMA, id -> {
            assertEquals("schema:dcat-ap:convert/fromCustom", id);
            return stylesheet;
        });
        assertEquals(1, records.size());
        String uuid = records.keySet().iterator().next();
        Model mapped = readRecord(records.get(uuid));
        try {
            assertTrue(mapped.contains(mapped.getResource("urn:dataset:example"), mapped.createProperty(DCT + "title"), "A & B < C"));
            assertTrue(mapped.contains(null, mapped.createProperty(DCT + "identifier"), uuid));
        } finally {
            mapped.close();
        }
    }

    @Test
    public void harvestsNativeDcatGraphWithStableSeparateRecords() throws Exception {
        fixture.removeAll();
        graphFormat = Lang.TURTLE;
        Resource first = fixture.createResource("https://example.org/datasets/first");
        Resource second = fixture.createResource("https://example.org/datasets/second");
        Resource third = fixture.createResource("https://example.org/datasets/third");
        String dqv = "http://www.w3.org/ns/dqv#";
        var structured = fixture.createProperty(HEALTH + "hasStructuredData");
        var annotationProperty = fixture.createProperty(dqv + "hasQualityAnnotation");
        Resource annotation = fixture.createResource()
            .addProperty(RDF.type, fixture.createResource(dqv + "QualityAnnotation"))
            .addProperty(fixture.createProperty("http://www.w3.org/ns/oa#hasBody"), fixture.createResource("https://example.org/quality"));
        Resource distribution = fixture.createResource();
        distribution.addProperty(RDF.type, fixture.createResource(DCAT + "Distribution"));
        distribution.addProperty(fixture.createProperty(DCAT + "accessURL"), fixture.createResource("https://example.org/data.csv"));
        first.addProperty(RDF.type, fixture.createResource(DCAT + "Dataset"))
            .addProperty(fixture.createProperty(DCT + "title"), "First dataset")
            .addProperty(fixture.createProperty(DCAT + "theme"),
                fixture.createResource("http://publications.europa.eu/resource/authority/data-theme/HEAL"))
            .addProperty(fixture.createProperty(DCAT + "distribution"), distribution)
            .addProperty(annotationProperty, annotation);
        second.addProperty(RDF.type, fixture.createResource(DCAT + "DatasetSeries"))
            .addProperty(fixture.createProperty(DCT + "title"), "Second dataset");
        third.addProperty(RDF.type, fixture.createResource(DCAT + "Dataset")).addLiteral(structured, true);
        Resource catalog = fixture.createResource("https://example.org/catalog");
        catalog.addProperty(RDF.type, fixture.createResource(DCAT + "Catalog"))
            .addProperty(fixture.createProperty(DCAT + "dataset"), first)
            .addProperty(fixture.createProperty(DCAT + "dataset"), second);

        DcatApSparqlParams params = params();
        Map<String, Element> records = fetch(params);
        assertEquals(3, records.size());
        assertEquals(records.keySet(), fetch(params).keySet());
        for (Element xml : records.values()) {
            Model mapped = readRecord(xml);
            try {
                boolean hasFirst = mapped.containsResource(first);
                boolean hasSecond = mapped.containsResource(second);
                boolean hasThird = mapped.containsResource(third);
                assertEquals(1, (hasFirst ? 1 : 0) + (hasSecond ? 1 : 0) + (hasThird ? 1 : 0));
                if (hasFirst) {
                    assertThrows(XSDValidationErrorEx.class, () -> Xml.validate(SCHEMA.resolve("schema.xsd"), xml));
                    assertFalse(mapped.getResource(first.getURI()).hasProperty(structured));
                    assertTrue(mapped.contains(mapped.getResource(first.getURI()), mapped.createProperty(DCAT + "theme"),
                        mapped.createResource("http://publications.europa.eu/resource/authority/data-theme/HEAL")));
                    assertEquals(1, Xml.selectNodes(xml, ".//*[local-name()='hasQualityAnnotation']").size());
                } else if (hasThird) {
                    assertEquals("true", mapped.getResource(third.getURI()).getProperty(structured).getString());
                }
                if (!hasFirst) {
                    Xml.validate(SCHEMA.resolve("schema.xsd"), xml);
                }
                assertEquals(hasFirst, mapped.contains(null, mapped.createProperty(DCAT + "accessURL"),
                    mapped.createResource("https://example.org/data.csv")));
            } finally {
                mapped.close();
            }
        }
    }

    @Test
    public void sendsBareJwtAsBearerAuthorization() throws Exception {
        String jwt = "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJ0ZXN0In0.signature";
        expectedAuthorization = "Bearer " + jwt;
        DcatApSparqlParams params = openMetadataParams();
        params.setApiKey(jwt);
        assertEquals(4, fetch(params).size());
    }

    @Test
    public void harvestsCareDepartmentGraphUsingNativeFormatterAndJsonPost() throws Exception {
        RDFDataMgr.read(fixture, "src/test/resources/sparql-care-department.ttl");
        String incompleteId = "00000000-0000-0000-0000-000000000002";
        fixture.removeAll(fixture.getResource(BASE + "dataProduct/" + incompleteId),
            fixture.createProperty(DCT + "modified"), null);
        jsonPostOnly = true;
        DcatApSparqlParams params = params();
        params.query = Files.readString(QUERIES.resolve("om-care-department-to-dcat.rq"));
        Map<String, Element> records = fetch(params);
        assertEquals(java.util.Set.of("00000000-0000-0000-0000-000000000001", incompleteId), records.keySet());
        Element record = records.get("00000000-0000-0000-0000-000000000001");
        Xml.validate(SCHEMA.resolve("schema.xsd"), record);
        Model mapped = readRecord(record);
        try {
            Resource dataset = mapped.getResource(PRODUCT);
            assertEquals(2, dataset.listProperties(mapped.createProperty(DCAT + "distribution")).toList().size());
            assertEquals(2, dataset.listProperties(mapped.createProperty(DCAT + "keyword")).toList().size());
            assertEquals(4, mapped.listStatements(null, mapped.createProperty(CSVW + "name"), (String) null).toList().size());
            assertTrue(dataset.hasProperty(mapped.createProperty(DCT + "type")));
            assertTrue(dataset.hasProperty(mapped.createProperty(DCT + "provenance")));
            assertTrue(mapped.contains(null, mapped.createProperty(VCARD + "hasEmail"), mapped.createResource("mailto:mock@example.org")));
            assertTrue(mapped.contains(null, mapped.createProperty(CV + "email"), "hdab@example.org"));
        } finally {
            mapped.close();
        }
        for (Element incomplete : List.of(records.get(incompleteId), fetch(openMetadataParams()).get(incompleteId))) {
            assertThrows(XSDValidationErrorEx.class, () -> Xml.validate(SCHEMA.resolve("schema.xsd"), incomplete));
            Model partial = readRecord(incomplete);
            try {
                Resource dataset = partial.getResource(BASE + "dataProduct/" + incompleteId);
                assertFalse(dataset.hasProperty(partial.createProperty(DCT + "modified")));
                assertFalse(dataset.hasProperty(partial.createProperty(HEALTH + "hasStructuredData")));
                assertFalse(dataset.hasProperty(partial.createProperty(DCAT + "keyword")));
                Resource distribution = dataset.getPropertyResourceValue(partial.createProperty(DCAT + "distribution"));
                assertNotNull(distribution);
                assertFalse(distribution.hasProperty(partial.createProperty(DCAT + "accessURL")));
                assertTrue(distribution.hasProperty(partial.createProperty("http://data.europa.eu/r5r/applicableLegislation")));
                Resource hdab = dataset.getPropertyResourceValue(partial.createProperty(HEALTH + "hdab"));
                assertNotNull(hdab);
                assertFalse(hdab.hasProperty(partial.createProperty("http://xmlns.com/foaf/0.1/name")));
                assertTrue(hdab.hasProperty(partial.createProperty(CV + "contactPoint")));
            } finally {
                partial.close();
            }
        }
    }

    @Test
    public void rejectsHttpFailuresInsteadOfTreatingThemAsAnEmptyCatalogue() throws Exception {
        status.set(401);
        try {
            fetch(params());
            fail("HTTP 401 must fail the harvest");
        } catch (IOException expected) {
            assertTrue(expected.getMessage().contains("401"));
        }
    }

    @Test
    public void pluginRegistersItsOwnPrototypeAndPackagesTheForm() {
        DefaultListableBeanFactory factory = new DefaultListableBeanFactory();
        new XmlBeanDefinitionReader(factory).loadBeanDefinitions(new FileSystemResource("src/main/resources/config-spring-geonetwork.xml"));
        assertTrue(factory.getBean("dcatapsparql") instanceof AbstractHarvester);
        assertNotSame(factory.getBean("dcatapsparql"), factory.getBean("dcatapsparql"));
        assertNotNull(getClass().getResource("/META-INF/catalog/templates/admin/harvest/type/dcatapsparql.js"));
        assertNotNull(getClass().getResource("/META-INF/catalog/templates/admin/harvest/type/dcatapsparql.html"));
        assertNotNull(getClass().getResource("/dcat-ap/harvesting/dcatapsparql.xsl"));
    }

    private DcatApSparqlParams params() {
        DcatApSparqlParams params = new DcatApSparqlParams(null);
        params.url = "http://127.0.0.1:" + server.getAddress().getPort() + "/sparql";
        params.setApiKey("Bearer test-token");
        params.setName("Mock catalogue");
        return params;
    }

    private DcatApSparqlParams openMetadataParams() throws IOException {
        DcatApSparqlParams params = params();
        params.query = Files.readString(QUERIES.resolve("fetch-om-generic-data-product.rq"));
        params.setImportXslt("schema:dcat-ap:convert/fromOpenMetadataSparql");
        return params;
    }

    private Map<String, Element> fetch(DcatApSparqlParams params) throws Exception {
        return SparqlRecords.fetch(params, SCHEMA, id ->
            SCHEMA.resolve(id.substring("schema:dcat-ap:".length()) + ".xsl"));
    }

    private Model readRecord(Element record) throws Exception {
        String xml = Xml.getString(record);
        Model mapped = ModelFactory.createDefaultModel();
        RDFDataMgr.read(mapped, new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)), Lang.RDFXML);
        return mapped;
    }


}
