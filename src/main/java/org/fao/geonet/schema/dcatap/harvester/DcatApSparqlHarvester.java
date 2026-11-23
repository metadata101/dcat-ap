package org.fao.geonet.schema.dcatap.harvester;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Map;
import org.fao.geonet.Logger;
import org.fao.geonet.domain.AbstractMetadata;
import org.fao.geonet.domain.ISODate;
import org.fao.geonet.domain.Metadata;
import org.fao.geonet.domain.MetadataType;
import org.fao.geonet.kernel.GeonetworkDataDirectory;
import org.fao.geonet.kernel.SchemaManager;
import org.fao.geonet.kernel.UpdateDatestamp;
import org.fao.geonet.kernel.harvest.BaseAligner;
import org.fao.geonet.kernel.harvest.harvester.AbstractHarvester;
import org.fao.geonet.kernel.harvest.harvester.CategoryMapper;
import org.fao.geonet.kernel.harvest.harvester.GroupMapper;
import org.fao.geonet.kernel.harvest.harvester.HarvestResult;
import org.fao.geonet.kernel.search.IndexingMode;
import org.jdom.Element;

public class DcatApSparqlHarvester extends AbstractHarvester<HarvestResult, DcatApSparqlParams> {
    @Override
    protected DcatApSparqlParams createParams() {
        return new DcatApSparqlParams(dataMan);
    }

    @Override
    protected void storeNodeExtra(DcatApSparqlParams params, String path, String siteId, String optionsId) throws java.sql.SQLException {
        harvesterSettingsManager.add("id:" + siteId, "url", params.url);
        harvesterSettingsManager.add("id:" + siteId, "icon", params.icon);
        harvesterSettingsManager.add("id:" + siteId, "query", params.query);
    }

    @Override
    protected void doHarvest(Logger logger) throws Exception {
        result = new HarvestResult();
        result.createdUuids = new ArrayList<>();
        result.modifiedUuids = new ArrayList<>();
        result.deletedUuids = new ArrayList<>();
        Path schemaDir = context.getBean(SchemaManager.class).getSchemaDir("dcat-ap");
        GeonetworkDataDirectory dataDir = context.getBean(GeonetworkDataDirectory.class);
        Map<String, Element> records = SparqlRecords.fetch(params, schemaDir, dataDir::getXsltConversion);
        if (cancelMonitor.get()) {
            return;
        }
        logger.info("Built " + records.size() + " DCAT-ap records from SPARQL");
        new Aligner().align(records);
    }

    private class Aligner extends BaseAligner<DcatApSparqlParams> {
        Aligner() {
            super(DcatApSparqlHarvester.this.cancelMonitor);
            setParams(DcatApSparqlHarvester.this.params);
        }

        void align(Map<String, Element> records) throws Exception {
            GroupMapper groups = new GroupMapper(context);
            CategoryMapper categories = new CategoryMapper(context);
            for (Element metadata : records.values()) {
                params.getValidate().validate(dataMan, context, metadata, getGroupOwner());
            }
            for (Map.Entry<String, Element> entry : records.entrySet()) {
                if (cancelMonitor.get()) {
                    return;
                }
                String uuid = entry.getKey();
                Element xml = entry.getValue();
                AbstractMetadata metadata = metadataUtils.findOneByUuid(uuid);
                result.totalMetadata++;
                result.originalMetadata++;
                if (metadata != null && !params.getUuid().equals(metadata.getHarvestInfo().getUuid())) {
                    result.datasetUuidExist++;
                    result.uuidSkipped++;
                    log.warning("Skipped record already managed outside this harvester: " + uuid);
                    continue;
                }
                String modified = dataMan.extractDateModified("dcat-ap", xml);
                if (metadata == null) {
                    metadata = new Metadata();
                    metadata.setUuid(uuid);
                    ISODate date = modified.isBlank() ? new ISODate() : new ISODate(modified);
                    metadata.getDataInfo().setSchemaId("dcat-ap").setRoot(xml.getQualifiedName())
                        .setType(MetadataType.METADATA).setCreateDate(date).setChangeDate(date);
                    metadata.getSourceInfo().setSourceId(params.getUuid()).setOwner(getOwner()).setGroupOwner(getGroupOwner());
                    metadata.getHarvestInfo().setHarvested(true).setUuid(params.getUuid());
                    addCategories(metadata, params.getCategories(), categories, context, null, false);
                    metadata = metadataManager.insertMetadata(context, metadata, xml, IndexingMode.none,
                        false, UpdateDatestamp.NO, false, false);
                    result.addedMetadata++;
                    result.createdUuids.add(uuid);
                } else {
                    metadata = metadataManager.updateMetadata(context, String.valueOf(metadata.getId()), xml,
                        false, false, context.getLanguage(), modified, true, IndexingMode.none);
                    metadata.getCategories().clear();
                    addCategories(metadata, params.getCategories(), categories, context, null, true);
                    result.updatedMetadata++;
                    result.modifiedUuids.add(uuid);
                }
                String id = String.valueOf(metadata.getId());
                addPrivileges(id, params.getPrivileges(), groups, context);
                metadataIndexer.indexMetadata(id, true, IndexingMode.full);
            }
            // A custom query may return a partial snapshot, so absence does not imply deletion.
            dataMan.forceIndexChanges();
        }
    }
}
