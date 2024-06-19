// //=============================================================================
// //===    Copyright (C) 2001-2013 Food and Agriculture Organization of the
// //===    United Nations (FAO-UN), United Nations World Food Programme (WFP)
// //===    and United Nations Environment Programme (UNEP)
// //===
// //===    This program is free software; you can redistribute it and/or modify
// //===    it under the terms of the GNU General Public License as published by
// //===    the Free Software Foundation; either version 2 of the License, or (at
// //===    your option) any later version.
// //===
// //===    This program is distributed in the hope that it will be useful, but
// //===    WITHOUT ANY WARRANTY; without even the implied warranty of
// //===    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
// //===    General Public License for more details.
// //===
// //===    You should have received a copy of the GNU General Public License
// //===    along with this program; if not, write to the Free Software
// //===    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
// //===
// //===    Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
// //===    Rome - Italy. email: geonetwork@osgeo.org
// //==============================================================================
//
// package org.fao.geonet.kernel.harvest.harvester.dcatap;
//
// import jeeves.server.context.ServiceContext;
// import org.apache.commons.io.IOUtils;
// import org.apache.jena.query.*;
// import org.apache.jena.rdf.model.Literal;
// import org.apache.jena.rdf.model.Model;
// import org.apache.jena.rdf.model.ModelFactory;
// import org.apache.jena.rdf.model.RDFNode;
// import org.apache.jena.riot.Lang;
// import org.apache.jena.riot.RDFDataMgr;
// import org.apache.jena.riot.RDFFormat;
// import org.fao.geonet.Constants;
// import org.fao.geonet.Logger;
// import org.fao.geonet.domain.ISODate;
// import org.fao.geonet.exceptions.BadServerResponseEx;
// import org.fao.geonet.kernel.datamanager.IMetadataSchemaUtils;
// import org.fao.geonet.kernel.harvest.harvester.HarvestError;
// import org.fao.geonet.kernel.harvest.harvester.HarvestResult;
// import org.fao.geonet.kernel.harvest.harvester.IHarvester;
// import org.fao.geonet.kernel.setting.SettingManager;
// import org.fao.geonet.util.XslUtil;
// import org.fao.geonet.utils.Xml;
// import org.jdom.Element;
// import org.jdom.JDOMException;
//
// import java.io.*;
// import java.nio.charset.StandardCharsets;
// import java.nio.file.Files;
// import java.nio.file.Path;
// import java.text.ParseException;
// import java.text.SimpleDateFormat;
// import java.util.*;
// import java.util.concurrent.atomic.AtomicBoolean;
// import java.util.regex.Matcher;
// import java.util.regex.Pattern;
//
// //=============================================================================
//
// class Harvester implements IHarvester<HarvestResult> {
//     private final AtomicBoolean cancelMonitor;
//     // --------------------------------------------------------------------------
//     // ---
//     // --- Constructor
//     // ---
//     // --------------------------------------------------------------------------
//     // ---------------------------------------------------------------------------
//     // ---
//     // --- Variables
//     // ---
//     // ---------------------------------------------------------------------------
//     private Logger log;
//
//     // ---------------------------------------------------------------------------
//     // ---
//     // --- API methods
//     // ---
//     // ---------------------------------------------------------------------------
//     private final DCAT2Params params;
//
//     // ---------------------------------------------------------------------------
//     private final ServiceContext context;
//
//     private final SettingManager settingManager;
//
//     private final Path schemaDir;
//
//     // ---------------------------------------------------------------------------
//     /**
//      * Contains a list of accumulated errors during the executing of this
//      * harvest.
//      */
//     private final List<HarvestError> errors = new LinkedList<HarvestError>();
//
//     private final Path xslFile;
//     private final Path xslBlankNodeFile;
//
//     private final Pattern identifierPattern;
//
//     public Harvester(AtomicBoolean cancelMonitor, Logger log, ServiceContext context, DCAT2Params params) {
//         this.cancelMonitor = cancelMonitor;
//         this.log = log;
//         this.params = params;
//         this.context = context;
//         this.settingManager = context.getApplicationContext().getBean(SettingManager.class);
//
//         this.schemaDir = context.getApplicationContext()
//             .getBean(IMetadataSchemaUtils.class)
//             .getSchemaDir("dcat2");
//
//
//         this.xslFile = this.schemaDir.resolve("import/rdf-to-xml.xsl");
//         this.xslBlankNodeFile = this.schemaDir.resolve("import/rdf-fix-blank-nodes.xsl");
//         this.identifierPattern = Pattern.compile("([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}");
//     }
//
//     @Override
//     public HarvestResult harvest(Logger log) throws Exception {
//         this.log = log;
//
//         try {
//             // Retrieve all DCAT-AP records and normalize them via SPARQL+XSL transformation
//             Set<DCAT2RecordInfo> recordsInfo = this.search();
//             // Create, update, delete all records
//             Aligner aligner = new Aligner(cancelMonitor, log, context, params);
//             log.info("Total records processed in all searches: " + recordsInfo.size());
//             return aligner.align(recordsInfo, errors);
//
//         } catch (Exception t) {
//             log.error("Error while trying to harvest");
//             log.error(t.getMessage());
//             BadServerResponseEx et = new BadServerResponseEx(t.getMessage());
//             HarvestError harvestError = new HarvestError(context, et);
//             harvestError.setDescription((String) et.getObject());
//             errors.add(harvestError);
//         } catch (Throwable t) {
//             log.fatal("Something unknown and terrible happened while harvesting");
//             log.fatal(t.getMessage());
//             BadServerResponseEx et = new BadServerResponseEx(t.getMessage());
//             errors.add(new HarvestError(context, et));
//         }
//
//         // return empty harvest result in case of errors
//         return new HarvestResult();
//     }
//
//     @Override
//     public List<HarvestError> getErrors() {
//         return errors;
//     }
//
//     private String getQueryString(String queryFile) throws IOException {
//         return new String(Files.readAllBytes(this.schemaDir.resolve("sparql/" + queryFile)), Constants.CHARSET);
//     }
//
//     /**
//      * Does DCAT-AP search request. Executes a SPARQL query to retrieve all
//      * UUIDs and add them to a Set with RecordInfo
//      */
//     private Set<DCAT2RecordInfo> search() throws Exception {
//         if (cancelMonitor.get()) {
//             return Collections.emptySet();
//         }
//
//         Set<DCAT2RecordInfo> records = new HashSet<>();
//
//         try {
//             // Create an empty in-memory model and populate it from the graph
//             Model model = ModelFactory.createMemModelMaker().createDefaultModel();
//             RDFDataMgr.read(model, params.baseUrl);
//
//             model = this.fixBlankResourceNode(model);
//             model = this.fixMissingRecords(model);
//
//             Query queryRecordIds = QueryFactory.create(this.getQueryString("extract-records-ids.rq"));
//             QueryExecution qe = QueryExecutionFactory.create(queryRecordIds, model);
//             ResultSet resultIds = qe.execSelect();
//
//             while (resultIds.hasNext()) {
//                 DCAT2RecordInfo recInfo = this.getRecordInfo(resultIds.nextSolution(), model);
//
//                 if (recInfo != null) {
//                     records.add(recInfo);
//                 }
//
//                 if (records.size() > params.maxResults) {
//                     log.warning("Forcing harvest end since maximum records to be harvested is reached");
//                     break;
//                 }
//             }
//
//             qe.close();
//             model.close();
//             log.info("Records added to result list : " + records.size());
//
//         } catch (Exception e) {
//             throw new Exception("The server returned an answer that could not be processed: " + e.getMessage());
//         }
//
//         return records;
//     }
//
//     private Model fixBlankResourceNode(Model model) throws Exception {
//         Element rdfModel = Xml.loadStream(IOUtils.toInputStream(this.toRdfString(model), StandardCharsets.UTF_8.displayName()));
//         Element fixedRdfModel = Xml.transform(rdfModel, xslBlankNodeFile, new HashMap<>());
//         Model newModel = ModelFactory.createMemModelMaker().createDefaultModel();
//         RDFDataMgr.read(newModel, IOUtils.toInputStream(Xml.getString(fixedRdfModel), StandardCharsets.UTF_8.displayName()), Lang.RDFXML);
//         return newModel;
//     }
//
//     private Model fixMissingRecords(Model model) throws IOException {
//         Query queryExtractNoRec = QueryFactory.create(this.getQueryString("extract-resources-no-records.rq"));
//         QueryExecution qe = QueryExecutionFactory.create(queryExtractNoRec, model);
//
//         Model newModel = model;
//         ResultSet resultIds = qe.execSelect();
//         while (resultIds.hasNext()) {
//             QuerySolution solution = resultIds.nextSolution();
//             newModel = this.createCatalogRecord(
//                 newModel,
//                 solution.get("resourceId").toString(),
//                 solution.get("catalogId").toString()
//             );
//         }
//
//         return newModel;
//     }
//
//     private Model createCatalogRecord(Model model, String resourceId, String catalogId) throws IOException {
//         String recordUUID = UUID.nameUUIDFromBytes(resourceId.getBytes()).toString();
//         String localQuery = this.getQueryString("add-CatalogRecord.rq")
//             .replaceAll("%recordID%", this.settingManager.getNodeURL() + "api/records/" + recordUUID)
//             .replaceAll("%recordUUID%", recordUUID)
//             .replaceAll("%resourceId%", resourceId)
//             .replaceAll("%modifiedDate%", this.normalizeDate(new Date()))
//             .replaceAll("%catalogId%", catalogId);
//
//         Query queryFixBlankNodes = QueryFactory.create(localQuery);
//         QueryExecution qe = QueryExecutionFactory.create(queryFixBlankNodes, model);
//         Model newModel = qe.execConstruct();
//         qe.close();
//         return newModel;
//     }
//
//     private DCAT2RecordInfo getRecordInfo(QuerySolution solution, Model model) {
//         try {
//             String catalogId = solution.get("catalogId").toString();
//             String recordId = solution.get("recordId").toString();
//             String resourceId = solution.get("resourceId").toString();
//             String baseRecordUUID = solution.get("baseRecordUUID").toString();
//             String baseResourceUUID = solution.get("baseResourceUUID").toString();
//
//             if (log.isDebugEnabled()) {
//                 log.debug("Record in response: " + recordId + " With resource: " + resourceId);
//             }
//
//             String localQueryBuildRecord = this.getQueryString("build-record.rq")
//                 .replaceAll("%recordId%", recordId)
//                 .replaceAll("%resourceId%", resourceId);
//
//             Query queryRecord = QueryFactory.create(localQueryBuildRecord);
//             QueryExecution qe = QueryExecutionFactory.create(queryRecord, model);
//             ResultSet results = qe.execSelect();
//
//             if (results.hasNext()) {
//                 ByteArrayOutputStream outxml = new ByteArrayOutputStream();
//                 ResultSetFormatter.outputAsXML(outxml, results);
//                 Element sparqlResults = Xml.loadStream(new ByteArrayInputStream(outxml.toByteArray()));
//                 qe.close();
//
//                 String recordUUID = this.transformUUID(baseRecordUUID, catalogId);
//                 Map<String, Object> params = new HashMap<>();
//                 params.put("recordUUID", recordUUID);
//                 params.put("harvesterURL", this.params.baseUrl);
//
//                 if (!this.isStrongIdentifier(baseResourceUUID)) {
//                     params.put("newResourceUUID", this.transformUUID(baseResourceUUID, catalogId));
//                     params.put("oldResourceUUID", baseResourceUUID);
//                 }
//
//                 Element dcatXML = Xml.transform(sparqlResults, xslFile, params);
//
//                 String modified = this.normalizeDate(solution.getLiteral("modified"));
//
//                 if (log.isDebugEnabled()) {
//                     log.debug("getRecordInfo: adding " + recordId + " with modification date " + modified);
//                 }
//
//                 return new DCAT2RecordInfo(recordUUID, recordId, modified, "dcat2", "TODO: source?", dcatXML);
//             } else {
//                 qe.close();
//                 String errorMessage = "No dcat:Dataset found with datasetId " + recordId + ", rdf:about attribute empty?";
//                 HarvestError harvestError = new HarvestError(context, new Exception(errorMessage));
//                 harvestError.setDescription(harvestError.getDescription());
//                 errors.add(harvestError);
//             }
//
//         } catch (ParseException | JDOMException | IOException e) {
//             HarvestError harvestError = new HarvestError(context, e);
//             harvestError.setDescription(harvestError.getDescription());
//             errors.add(harvestError);
//         } catch (Exception e) {
//             BadServerResponseEx et = new BadServerResponseEx(e.getMessage());
//             HarvestError harvestError = new HarvestError(context, et);
//             harvestError.setDescription(harvestError.getDescription());
//             errors.add(harvestError);
//         }
//
//         // we get here if we couldn't get the UUID or date modified
//         return null;
//
//     }
//
//     /**
//      * @return normalize date to format yyyy-MM-dd
//      */
//     private String normalizeDate(Literal literal) throws ParseException {
//         if (literal == null) {
//             return null;
//         }
//
//         Date date = this.parseDate(literal.toString());
//         return this.normalizeDate(date);
//     }
//
//     private String normalizeDate(Date date) {
//         if (date == null) {
//             return null;
//         }
//         // convert the date to a known format "yyyy-MM-ddThh:mm:ss"
//         return new ISODate(date.getTime(), false).toString();
//             // .substring(0, 10);
//     }
//
//     /**
//      * Parse the date provided in the pubDate field.
//      *
//      * @param modifiedDate the date to parse
//      * @return Date object
//      */
//     private Date parseDate(String modifiedDate) {
//
//         try {
//             SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
//             return dateTimeFormat.parse(modifiedDate.toUpperCase());
//         } catch (ParseException e) {
//             try {
//                 SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd");
//                 return dateTimeFormat.parse(modifiedDate.toUpperCase());
//             } catch (ParseException ex) {
//                 log.debug("Date '" + modifiedDate + "' is not parsable");
//             }
//         }
//         return null;
//     }
//
//     /**
//      * Issue: GeoNetwork works best (only?) with UUIDs as record
//      * identifiers. The following method extract a uuid from the
//      * string. If no UUID is found, the string is converted
//      * into a (unique) UUID using generateUUID. Note that URL encoding
//      * does not work, as the GeoNetwork URLs still clash and don't work
//      * in all situations.
//      */
//     private String transformUUID(String str, String catalogId) {
//         Matcher matcher = this.identifierPattern.matcher(str);
//         if (matcher.find()) {
//             return str.substring(matcher.start(), matcher.end());
//         } else {
//             return UUID.nameUUIDFromBytes((catalogId + "-" + str).getBytes()).toString();
//         }
//     }
//
//     private boolean isStrongIdentifier(String str) {
//         Matcher matcher = this.identifierPattern.matcher(str);
//         return matcher.find();
//     }
//
//     /**
//      * Convert a model back to RDF XML
//      * Only used for debugging
//      */
//     private String toRdfString(Model model) {
//         StringWriter out = new StringWriter();
//         RDFDataMgr.write(out, model, Lang.RDFXML);
//         return out.toString();
//     }
// }
