package org.fao.geonet.schema.dcatap.harvester;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.function.Function;
import org.fao.geonet.utils.Xml;
import org.jdom.Element;
import org.jdom.Namespace;

final class SparqlRecords {
    private static final Namespace RDF = Namespace.getNamespace("rdf", "http://www.w3.org/1999/02/22-rdf-syntax-ns#");
    private static final Namespace DCAT = Namespace.getNamespace("dcat", "http://www.w3.org/ns/dcat#");
    private static final Namespace DCT = Namespace.getNamespace("dct", "http://purl.org/dc/terms/");

    private SparqlRecords() {
    }

    static Map<String, Element> fetch(DcatApSparqlParams params, Path schemaDir,
                                      Function<String, Path> resolveConversion) throws Exception {
        String mapping = params.getImportXslt();
        Path stylesheet = mapping == null || mapping.isBlank() || "none".equals(mapping)
            ? schemaDir.resolve("convert/fromOpenMetadataSparql.xsl") : resolveConversion.apply(mapping);
        if (stylesheet == null || !Files.isRegularFile(stylesheet)) {
            throw new IOException("SPARQL mapping stylesheet not found: " + mapping);
        }

        // shortcut: the query result is mapped as one batch. Use a bounded query for large endpoints.
        String query = params.query.isBlank() ? defaultQuery() : params.query;
        Element source = new SparqlClient(params).execute(query);
        Element output = Xml.transform(source, stylesheet, Map.of("catalogName", params.getName()));
        List<?> documents = output.getName().equals("records") && output.getNamespaceURI().isEmpty()
            ? output.getChildren() : List.of(output);
        Map<String, Element> records = new LinkedHashMap<>();
        for (Object item : documents) {
            Element record = (Element) item;
            String uuid = assignUuid(record);
            if (records.putIfAbsent(uuid, (Element) record.clone()) != null) {
                throw new IOException("Duplicate DCAT record identifier: " + uuid);
            }
        }
        return records;
    }

    private static String assignUuid(Element record) throws IOException {
        if (!record.getName().equals("RDF") || !record.getNamespaceURI().equals(RDF.getURI())) {
            throw new IOException("SPARQL mapping must return rdf:RDF records.");
        }
        Element catalog = record.getChild("Catalog", DCAT);
        if (catalog == null || record.getChildren().size() != 1) {
            throw new IOException("Each SPARQL mapping result must contain one dcat:Catalog.");
        }
        List<?> catalogRecords = catalog.getChildren("record", DCAT);
        if (catalogRecords.size() != 1) {
            throw new IOException("Each SPARQL mapping result must contain one dcat:CatalogRecord.");
        }
        Element catalogRecord = ((Element) catalogRecords.get(0)).getChild("CatalogRecord", DCAT);
        if (catalogRecord == null) {
            throw new IOException("A SPARQL mapping result is missing its dcat:CatalogRecord.");
        }
        List<?> identifiers = catalogRecord.getChildren("identifier", DCT);
        if (identifiers.size() != 1) {
            throw new IOException("A SPARQL mapping result must have one stable dct:identifier on its dcat:CatalogRecord.");
        }
        Element identifier = (Element) identifiers.get(0);
        String id = identifier.getTextTrim();
        if (id.isEmpty()) {
            throw new IOException("A SPARQL mapping result has an empty dcat:CatalogRecord identifier.");
        }
        String uuid;
        try {
            uuid = UUID.fromString(id).toString();
            if (!uuid.equalsIgnoreCase(id)) {
                uuid = UUID.nameUUIDFromBytes(id.getBytes(StandardCharsets.UTF_8)).toString();
            }
        } catch (IllegalArgumentException e) {
            uuid = UUID.nameUUIDFromBytes(id.getBytes(StandardCharsets.UTF_8)).toString();
        }
        identifier.setText(uuid);
        return uuid;
    }

    private static String defaultQuery() throws IOException {
        try (InputStream input = SparqlRecords.class.getResourceAsStream("/dcat-ap/harvesting/sparql/default.rq")) {
            if (input == null) {
                throw new IOException("Missing bundled SPARQL query.");
            }
            return new String(input.readAllBytes(), StandardCharsets.UTF_8);
        }
    }
}
