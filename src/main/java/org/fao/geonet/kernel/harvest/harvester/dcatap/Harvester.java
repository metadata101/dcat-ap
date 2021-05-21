//=============================================================================
//===    Copyright (C) 2001-2013 Food and Agriculture Organization of the
//===    United Nations (FAO-UN), United Nations World Food Programme (WFP)
//===    and United Nations Environment Programme (UNEP)
//===
//===    This program is free software; you can redistribute it and/or modify
//===    it under the terms of the GNU General Public License as published by
//===    the Free Software Foundation; either version 2 of the License, or (at
//===    your option) any later version.
//===
//===    This program is distributed in the hope that it will be useful, but
//===    WITHOUT ANY WARRANTY; without even the implied warranty of
//===    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
//===    General Public License for more details.
//===
//===    You should have received a copy of the GNU General Public License
//===    along with this program; if not, write to the Free Software
//===    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
//===
//===    Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
//===    Rome - Italy. email: geonetwork@osgeo.org
//==============================================================================

package org.fao.geonet.kernel.harvest.harvester.dcatap;

import jeeves.server.context.ServiceContext;
import org.apache.jena.query.*;
import org.apache.jena.rdf.model.Literal;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.riot.RDFDataMgr;
import org.fao.geonet.Constants;
import org.fao.geonet.Logger;
import org.fao.geonet.domain.ISODate;
import org.fao.geonet.exceptions.BadServerResponseEx;
import org.fao.geonet.kernel.datamanager.IMetadataSchemaUtils;
import org.fao.geonet.kernel.harvest.harvester.HarvestError;
import org.fao.geonet.kernel.harvest.harvester.HarvestResult;
import org.fao.geonet.kernel.harvest.harvester.IHarvester;
import org.fao.geonet.utils.Xml;
import org.jdom.Element;
import org.jdom.JDOMException;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

//=============================================================================

class Harvester implements IHarvester<HarvestResult> {
    private final AtomicBoolean cancelMonitor;
    // --------------------------------------------------------------------------
    // ---
    // --- Constructor
    // ---
    // --------------------------------------------------------------------------
    // ---------------------------------------------------------------------------
    // ---
    // --- Variables
    // ---
    // ---------------------------------------------------------------------------
    private Logger log;

    // ---------------------------------------------------------------------------
    // ---
    // --- API methods
    // ---
    // ---------------------------------------------------------------------------
    private final DCAT2Params params;

    // ---------------------------------------------------------------------------
    private final ServiceContext context;

    // ---------------------------------------------------------------------------
    /**
     * Contains a list of accumulated errors during the executing of this
     * harvest.
     */
    private final List<HarvestError> errors = new LinkedList<HarvestError>();

    private final Path xslFile;

    private final String queryExtractIds;
    private final String queryBuildRecord;
    private final String fixBlankNodeQueryStr;

    public Harvester(AtomicBoolean cancelMonitor, Logger log, ServiceContext context, DCAT2Params params) throws IOException {
        this.cancelMonitor = cancelMonitor;
        this.log = log;
        this.context = context;
        this.params = params;

        Path schemaDir = context.getApplicationContext()
            .getBean(IMetadataSchemaUtils.class)
            .getSchemaDir("dcat2");

        this.xslFile = schemaDir.resolve("import/rdf-to-xml.xsl");

        this.queryExtractIds = new String(Files.readAllBytes(schemaDir.resolve("sparql/extract-records-ids.rq")), Constants.CHARSET);
        this.queryBuildRecord = new String(Files.readAllBytes(schemaDir.resolve("sparql/build-record.rq")), Constants.CHARSET);

        this.fixBlankNodeQueryStr = new String(Files.readAllBytes(schemaDir.resolve("sparql/fix-blank-node.rq")), Constants.CHARSET);
    }

    @Override
    public HarvestResult harvest(Logger log) throws Exception {
        this.log = log;

        try {
            // Retrieve all DCAT-AP records and normalize them via SPARQL+XSL transformation
            Set<DCAT2RecordInfo> recordsInfo = this.search();
            // Create, update, delete all records
            Aligner aligner = new Aligner(cancelMonitor, log, context, params);
            log.info("Total records processed in all searches: " + recordsInfo.size());
            return aligner.align(recordsInfo, errors);

        } catch (Exception t) {
            log.error("Error while trying to harvest");
            log.error(t.getMessage());
            BadServerResponseEx et = new BadServerResponseEx(t.getMessage());
            HarvestError harvestError = new HarvestError(context, et);
            harvestError.setDescription((String) et.getObject());
            errors.add(harvestError);
        } catch (Throwable t) {
            log.fatal("Something unknown and terrible happened while harvesting");
            log.fatal(t.getMessage());
            BadServerResponseEx et = new BadServerResponseEx(t.getMessage());
            errors.add(new HarvestError(context, et));
        }

        // return empty harvest result in case of errors
        return new HarvestResult();
    }

    @Override
    public List<HarvestError> getErrors() {
        return errors;
    }

    /**
     * Does DCAT-AP search request. Executes a SPARQL query to retrieve all
     * UUIDs and add them to a Set with RecordInfo
     */
    private Set<DCAT2RecordInfo> search() throws Exception {
        if (cancelMonitor.get()) {
            return Collections.emptySet();
        }

        Set<DCAT2RecordInfo> records = new HashSet<>();

        try {
            // Create an empty in-memory model and populate it from the graph
            Model model = ModelFactory.createMemModelMaker().createDefaultModel();
            RDFDataMgr.read(model, params.baseUrl);

            model = this.fixMissingRecords(model);

            Query queryRecordIds = QueryFactory.create(this.queryExtractIds);
            QueryExecution qe = QueryExecutionFactory.create(queryRecordIds, model);
            ResultSet resultIds = qe.execSelect();

            while (resultIds.hasNext()) {
                DCAT2RecordInfo recInfo = this.getRecordInfo(resultIds.nextSolution(), model);

                if (recInfo != null) {
                    records.add(recInfo);
                }

                if (records.size() > params.maxResults) {
                    log.warning("Forcing harvest end since maximum records to be harvested is reached");
                    break;
                }
            }

            qe.close();
            model.close();
            log.info("Records added to result list : " + records.size());

        } catch (Exception e) {
            throw new Exception("The server returned an answer that could not be processed: " + e.getMessage());
        }

        return records;
    }

    private Model fixMissingRecords(Model model) {
        // TODO
        Query queryFixBlankNodes = QueryFactory.create(this.fixBlankNodeQueryStr);
        QueryExecution qe = QueryExecutionFactory.create(queryFixBlankNodes, model);
        Model newModel = qe.execConstruct();
        qe.close();
        return newModel;
    }

    private DCAT2RecordInfo getRecordInfo(QuerySolution solution, Model model) {
        try {
            String recordId = solution.getResource("recordId").toString();
            String resourceId = solution.getResource("resourceId").toString();

            if (log.isDebugEnabled()) {
                log.debug("Record in response: " + recordId + " With resource: " + resourceId);
            }

            String localQueryBuildRecord = this.queryBuildRecord
                .replaceAll("%recordId%", recordId)
                .replaceAll("%resourceId%", resourceId);

            Query queryRecord = QueryFactory.create(localQueryBuildRecord);
            QueryExecution qe = QueryExecutionFactory.create(queryRecord, model);
            ResultSet results = qe.execSelect();

            if (results.hasNext()) {
                ByteArrayOutputStream outxml = new ByteArrayOutputStream();
                ResultSetFormatter.outputAsXML(outxml, results);
                Element sparqlResults = Xml.loadStream(new ByteArrayInputStream(outxml.toByteArray()));
                qe.close();

                String recordUUID = this.getRecordUUID(recordId);
                Map<String, Object> params = new HashMap<>();
                params.put("identifier", recordUUID);
                Element dcatXML = Xml.transform(sparqlResults, xslFile, params);

                String modified = this.normalizeDate(solution.getLiteral("modified"));

                if (log.isDebugEnabled()) {
                    log.debug("getRecordInfo: adding " + recordId + " with modification date " + modified);
                }

                return new DCAT2RecordInfo(recordUUID, recordId, modified, "dcat2", "TODO: source?", dcatXML);
            } else {
                qe.close();
                String errorMessage = "No dcat:Dataset found with datasetId " + recordId + ", rdf:about attribute empty?";
                HarvestError harvestError = new HarvestError(context, new Exception(errorMessage));
                harvestError.setDescription(harvestError.getDescription());
                errors.add(harvestError);
            }

        } catch (ParseException | JDOMException | IOException e) {
            HarvestError harvestError = new HarvestError(context, e);
            harvestError.setDescription(harvestError.getDescription());
            errors.add(harvestError);
        } catch (Exception e) {
            BadServerResponseEx et = new BadServerResponseEx(e.getMessage());
            HarvestError harvestError = new HarvestError(context, et);
            harvestError.setDescription(harvestError.getDescription());
            errors.add(harvestError);
        }

        // we get here if we couldn't get the UUID or date modified
        return null;

    }

    /**
     * @return normalize date to format yyyy-MM-dd
     */
    private String normalizeDate(Literal modified) throws ParseException {
        if (modified == null) {
            return null;
        }

        Date modDate = this.parseDate(modified.toString());
        if (modDate == null) {
            return null;
        }
        // convert the date to a known format "yyyy-MM-dd"
        return new ISODate(modDate.getTime(), false)
            .toString()
            .substring(0, 10);
    }

    /**
     * Parse the date provided in the pubDate field.
     *
     * @param modifiedDate the date to parse
     * @return Date object
     */
    private Date parseDate(String modifiedDate) {

        try {
            SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
            return dateTimeFormat.parse(modifiedDate.toUpperCase());
        } catch (ParseException e) {
            try {
                SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd");
                return dateTimeFormat.parse(modifiedDate.toUpperCase());
            } catch (ParseException ex) {
                log.debug("Date '" + modifiedDate + "' is not parsable");
            }
        }
        return null;
    }

    /**
     * Issue: GeoNetwork works best (only?) with UUIDs as record
     * identifiers. The following method extract a uuid from the
     * record URI. If no UUID is found, the record URIs are converted
     * into a (unique) UUID using generateUUID. Note that URL encoding
     * does not work, as the GeoNetwork URLs still clash and don't work
     * in all situations.
     */
    private String getRecordUUID(String recordId) {
        Pattern pattern = Pattern.compile("([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}");
        Matcher matcher = pattern.matcher(recordId);
        String recordUUID;
        if (matcher.find()) {
            recordUUID = recordId.substring(matcher.start(), matcher.end());
        } else {
            recordUUID = UUID.nameUUIDFromBytes(recordId.getBytes()).toString();
        }
        return recordUUID;
    }
}
