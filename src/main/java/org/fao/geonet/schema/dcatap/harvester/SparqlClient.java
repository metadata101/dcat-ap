package org.fao.geonet.schema.dcatap.harvester;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Base64;
import org.apache.http.client.utils.URIBuilder;
import org.apache.jena.query.Query;
import org.apache.jena.query.QueryFactory;
import org.apache.jena.query.ResultSetFactory;
import org.apache.jena.query.ResultSetFormatter;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.riot.Lang;
import org.apache.jena.riot.RDFDataMgr;
import org.apache.jena.riot.RDFFormat;
import org.apache.jena.riot.RDFLanguages;
import org.apache.jena.riot.RDFParser;
import org.fao.geonet.utils.Xml;
import org.jdom.Element;

class SparqlClient {
    private final DcatApSparqlParams params;
    private final HttpClient http = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(30)).build();

    SparqlClient(DcatApSparqlParams params) {
        this.params = params;
    }

    Element execute(String queryText) throws Exception {
        Query query = QueryFactory.create(queryText);
        boolean select = query.isSelectType();
        if (!select && !query.isConstructType() && !query.isDescribeType()) {
            throw new IOException("Harvesting requires a SELECT, CONSTRUCT, or DESCRIBE query.");
        }

        String accept = (select ? "application/sparql-results+xml, application/sparql-results+json;q=0.9"
            : "application/rdf+xml, text/turtle;q=0.9, application/n-triples;q=0.8, application/ld+json;q=0.8") + ", */*;q=0.1";
        var response = http.send(request().uri(new URIBuilder(params.url).setParameter("query", queryText).build())
            .header("Accept", accept).GET().build(), HttpResponse.BodyHandlers.ofByteArray());
        if (response.statusCode() == 405 || response.statusCode() == 414) {
            response = http.send(request().uri(new URIBuilder(params.url).build()).header("Accept", accept)
                .header("Content-Type", "application/sparql-query; charset=UTF-8")
                .POST(HttpRequest.BodyPublishers.ofString(queryText)).build(), HttpResponse.BodyHandlers.ofByteArray());
        }
        if (response.statusCode() != 200) {
            throw new IOException("SPARQL endpoint returned HTTP " + response.statusCode());
        }

        String contentType = response.headers().firstValue("Content-Type").orElse("").split(";", 2)[0].trim();
        ByteArrayInputStream input = new ByteArrayInputStream(response.body());
        ByteArrayOutputStream xml = new ByteArrayOutputStream();
        if (select) {
            if (!contentType.endsWith("json")) {
                Element results = Xml.loadStream(input);
                if (!"sparql".equals(results.getName())
                    || !"http://www.w3.org/2005/sparql-results#".equals(results.getNamespaceURI())) {
                    throw new IOException("Expected SPARQL SELECT results.");
                }
                return results;
            }
            ResultSetFormatter.outputAsXML(xml, ResultSetFactory.fromJSON(input));
        } else {
            // Some endpoints use their SELECT response type even when returning an RDF/XML graph.
            Lang lang = contentType.startsWith("application/sparql-results+") ? Lang.RDFXML
                : RDFLanguages.contentTypeToLang(contentType);
            if (lang == null) {
                lang = Lang.RDFXML;
            }
            Model graph = ModelFactory.createDefaultModel();
            try {
                RDFParser.source(input).lang(lang).base(params.url).parse(graph);
                RDFDataMgr.write(xml, graph, RDFFormat.RDFXML_PLAIN);
            } finally {
                graph.close();
            }
        }
        return Xml.loadStream(new ByteArrayInputStream(xml.toByteArray()));
    }

    private HttpRequest.Builder request() {
        HttpRequest.Builder request = HttpRequest.newBuilder().timeout(Duration.ofSeconds(60));
        if (params.getApiKey() != null && !params.getApiKey().isBlank()) {
            String header = params.getApiKeyHeader();
            header = header == null || header.isBlank() ? "Authorization" : header;
            String value = params.getApiKey().trim();
            if ("Authorization".equalsIgnoreCase(header) && value.matches("[A-Za-z0-9_-]+\\.[A-Za-z0-9_-]+\\.[A-Za-z0-9_-]+")) {
                value = "Bearer " + value;
            }
            return request.header(header, value);
        }
        if (params.isUseAccount()) {
            String credentials = params.getUsername() + ":" + params.getPassword();
            request.header("Authorization", "Basic " + Base64.getEncoder()
                .encodeToString(credentials.getBytes(StandardCharsets.UTF_8)));
        }
        return request;
    }
}
