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
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.riot.RDFDataMgr;
import org.fao.geonet.Logger;
import org.fao.geonet.domain.ISODate;
import org.fao.geonet.exceptions.BadServerResponseEx;
import org.fao.geonet.kernel.DataManager;
import org.fao.geonet.kernel.harvest.harvester.HarvestError;
import org.fao.geonet.kernel.harvest.harvester.HarvestResult;
import org.fao.geonet.kernel.harvest.harvester.IHarvester;
import org.fao.geonet.utils.Xml;
import org.jdom.Element;
import org.jdom.JDOMException;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
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
    private final DCATAPParams params;

    // ---------------------------------------------------------------------------
    private final ServiceContext context;

    // ---------------------------------------------------------------------------
    /**
     * Contains a list of accumulated errors during the executing of this
     * harvest.
     */
    private final List<HarvestError> errors = new LinkedList<HarvestError>();

    private final Path xslFile;

    private final String fixBlankNodeQueryStr;
    private final String getIdsQueryStr;
    private final String buildRecordQueryStr;

    public Harvester(AtomicBoolean cancelMonitor, Logger log, ServiceContext context, DCATAPParams params) throws IOException {

        this.cancelMonitor = cancelMonitor;
        this.log = log;
        this.context = context;
        this.params = params;
        this.xslFile = context.getApplicationContext().getBean(DataManager.class).getSchemaDir("metadata-dcat")
            .resolve("import/rdf-to-xml.xsl");

        this.fixBlankNodeQueryStr = this.getResourceQueryAsString("fix-blank-node.rq");
        this.getIdsQueryStr = this.getResourceQueryAsString("get-ids.rq");
        this.buildRecordQueryStr = this.getResourceQueryAsString("build-record.rq");
    }

    public HarvestResult harvest(Logger log) throws Exception {
        this.log = log;

        try {
            // Retrieve all DCAT-AP records and normalize them via SPARQL+XSL
            // transformation
            Set<DCATAPRecordInfo> recordsInfo = search();
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

    /**
     * Does DCAT-AP search request. Executes a SPARQL query to retrieve all
     * UUIDs and add them to a Set with RecordInfo
     */
    private Set<DCATAPRecordInfo> search() throws Exception {

        Set<DCATAPRecordInfo> records = new HashSet<DCATAPRecordInfo>();

        try {
            int maxResults = params.maxResults;

            // Create an empty in-memory model and populate it from the graph
            Model model = ModelFactory.createMemModelMaker().createDefaultModel();
            RDFDataMgr.read(model, params.baseUrl);

            Query queryFixBlankNodes = QueryFactory.create(this.fixBlankNodeQueryStr);
            QueryExecution qe = QueryExecutionFactory.create(queryFixBlankNodes, model);
            model = qe.execConstruct();
            qe.close();

            Query queryIds = QueryFactory.create(this.getIdsQueryStr);
            qe = QueryExecutionFactory.create(queryIds, model);
            ResultSet resultIds = qe.execSelect();

            while (resultIds.hasNext()) {
                QuerySolution result = resultIds.nextSolution();
                String datasetId = result.getResource("datasetid").toString();

                // System.out.println(datasetId);

                if (log.isDebugEnabled())
                    log.debug("Dataset in response: " + datasetId);

                if (cancelMonitor.get()) {
                    return Collections.emptySet();
                }
                DCATAPRecordInfo recInfo = getRecordInfo(result, model);
                if (recInfo != null)
                    records.add(recInfo);

                if (records.size() > maxResults) {
                    log.warning("Forcing harvest end since maximum records to be harvested is reached");
                    break;
                }

            }

            qe.close();
            model.close();
            log.info("Records added to result list : " + records.size());

        } catch (Exception e) {
            HarvestError harvestError = new HarvestError(context, e);
            harvestError.setDescription(harvestError.getDescription());
            //BadServerResponseEx et = new BadServerResponseEx(e.getMessage());
            //errors.add(new HarvestError(context, et));
            throw new Exception("The server returned an answer that could not be processed: " + e.getMessage());
        }

        return records;

    }

    private DCATAPRecordInfo getRecordInfo(QuerySolution solution, Model model) {
        try {
            String datasetId = solution.getResource("datasetid").toString();
            String modified = "";
            Date modDate = null;
            // convert the pubDate to a known format (ISOdate)
            if (solution.getResource("modified") != null) {
                modDate = parseDate(solution.getResource("modified").toString());
            }
            if (modDate != null) {

                modified = new ISODate(modDate.getTime(), false).toString();
            }
            if (modified != null && modified.length() == 0)
                modified = null;

            if (log.isDebugEnabled())
                log.debug("getRecordInfo: adding " + datasetId + " with modification date " + modified);


            String queryStringRecord = this.buildRecordQueryStr.replaceAll("%datasetId%", datasetId);
            Query queryRecord = QueryFactory.create(queryStringRecord);
            QueryExecution qe = QueryExecutionFactory.create(queryRecord, model);
            ResultSet results = qe.execSelect();
            if (results.hasNext()) {
                // Output query results
                ByteArrayOutputStream outxml = new ByteArrayOutputStream();
                ResultSetFormatter.outputAsXML(outxml, results);

                // Apply XSLT transformation
                Element sparqlResults = Xml.loadStream(new ByteArrayInputStream(outxml.toByteArray()));
                /*
                 * Issue: GeoNetwork works best (only?) with UUIDs as dataset
                 * identifiers. The following lines of code extract a uuid from the
                 * dataset URI. If no UUID is found, the dataset URIs are converted
                 * into a (unique) UUID using generateUUID. Note that URL encoding
                 * does not work, as the GeoNetwork URLs still clash and don't work
                 * in all situations.
                 * //java.net.URLEncoder.encode(datasetId,"utf-8");
                 */
                Pattern pattern = Pattern.compile("([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}");
                Matcher matcher = pattern.matcher(datasetId);
                String datasetUuid;
                if (matcher.find()) {
                    datasetUuid = datasetId.substring(matcher.start(), matcher.end());
                } else {
                    datasetUuid = UUID.nameUUIDFromBytes(datasetId.getBytes()).toString();
                }
                Map<String, Object> params = new HashMap<>();
                params.put("identifier", datasetUuid);
                Element dcatXML = Xml.transform(sparqlResults, xslFile, params);
                qe.close();

                return new DCATAPRecordInfo(datasetUuid, datasetId, modified, "metadata-dcat", "TODO: source?", dcatXML);
            } else {
                String errorMessage = "No dcat:Dataset found with datasetId " + datasetId + ", rdf:about attribute empty?";
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
     * Parse the date provided in the pubDate field.
     *
     * @param modifiedDate the date to parse
     * @return
     */
    protected Date parseDate(String modifiedDate) throws ParseException {

        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD'T'HH:mm:ss");
        try {
            return sdf.parse(modifiedDate.toUpperCase());
        } catch (Exception e) {
            log.debug("Date '" + modifiedDate + "' is not parsable");
        }
        return null;
    }

    @Override
    public List<HarvestError> getErrors() {
        return errors;
    }

    private String getResourceQueryAsString(String queryName) throws IOException {
        ClassLoader classLoader = this.getClass().getClassLoader();
        InputStream inputStream = Objects.requireNonNull(classLoader.getResourceAsStream("/sparql/" + queryName));
        return new Scanner(inputStream, "UTF-8")
            .useDelimiter("\\A")
            .next();
    }

}

// =============================================================================
