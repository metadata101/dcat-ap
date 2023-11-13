/*
 * Copyright (C) 2001-2016 Food and Agriculture Organization of the
 * United Nations (FAO-UN), United Nations World Food Programme (WFP)
 * and United Nations Environment Programme (UNEP)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
 *
 * Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
 * Rome - Italy. email: geonetwork@osgeo.org
 */

package org.fao.geonet.schema.dcatap;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.fao.geonet.ApplicationContextHolder;
import org.fao.geonet.constants.Geonet;
import org.fao.geonet.index.es.EsRestClient;
import org.fao.geonet.kernel.schema.SchemaPlugin;
import org.fao.geonet.kernel.schema.AssociatedResource;
import org.fao.geonet.kernel.schema.AssociatedResourcesSchemaPlugin;
import org.fao.geonet.kernel.schema.MultilingualSchemaPlugin;
import org.fao.geonet.kernel.search.EsSearchManager;
import org.fao.geonet.kernel.setting.SettingManager;
import org.fao.geonet.utils.Log;
import org.fao.geonet.utils.Xml;
import org.jdom.Attribute;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.Namespace;
import org.jdom.filter.ElementFilter;

import com.google.common.collect.ImmutableMap;
import com.google.common.collect.ImmutableSet;

/**
 *
 */
public class DCAT2SchemaPlugin extends SchemaPlugin implements AssociatedResourcesSchemaPlugin, MultilingualSchemaPlugin {
    public static final String IDENTIFIER = "dcat2";
    private static final Pattern UUID_PATTERN = Pattern.compile("([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}");

    private static final ImmutableSet<Namespace> allNamespaces;
    private static final Map<String, Namespace> allTypenames;

    static {
        allNamespaces = ImmutableSet.<Namespace>builder()
            .add(DCAT2Namespaces.DC)
            .add(DCAT2Namespaces.DCT)
            .add(DCAT2Namespaces.DCAT)
            .add(DCAT2Namespaces.VCARD)
            .add(DCAT2Namespaces.FOAF)
            .add(DCAT2Namespaces.MDCAT)
            .build();

        allTypenames = ImmutableMap.<String, Namespace>builder()
            .put("csw:Record", Namespace.getNamespace("csw", "http://www.opengis.net/cat/csw/2.0.2"))
            .put("dcat", DCAT2Namespaces.DCAT)
            .build();
    }

    public DCAT2SchemaPlugin() {
        super(IDENTIFIER, allNamespaces);
    }


    /**
     * Always return null. Not implemented for DCAT-AP records.
     *
     * @param metadata
     * @return
     */
    @Override
    public Set<AssociatedResource> getAssociatedResourcesUUIDs(Element metadata) {
        return Collections.emptySet();
    }

    @Override
    public Set<String> getAssociatedParentUUIDs(Element metadata) {
        return getAssociatedParents(metadata)
            .stream()
            .map(AssociatedResource::getUuid)
            .collect(Collectors.toSet());
    }

    @Override
    public Set<String> getAssociatedDatasetUUIDs(Element metadata) {
        return getAssociatedDatasets(metadata)
            .stream()
            .map(AssociatedResource::getUuid)
            .collect(Collectors.toSet());
    }

    // @Override
    // public Set<String> getAssociatedExternalDatasetLinks(Element metadata) {
    //     ElementFilter elementFilter = new ElementFilter("servesDataset", DCAT2Namespaces.DCAT);
    //     return this.getAssociatedExternalRdfLinks(metadata, elementFilter);
    // }

    @Override
    public Set<String> getAssociatedFeatureCatalogueUUIDs(Element metadata) {
        return getAssociatedFeatureCatalogues(metadata)
            .stream()
            .map(AssociatedResource::getUuid)
            .collect(Collectors.toSet());
    }

    @Override
    public Set<String> getAssociatedSourceUUIDs(Element metadata) {
        return getAssociatedSources(metadata)
            .stream()
            .map(AssociatedResource::getUuid)
            .collect(Collectors.toSet());
    }

    @Override
    public Set<AssociatedResource> getAssociatedParents(Element metadata) {
        return Collections.emptySet();
    }

    @Override
    public Set<AssociatedResource> getAssociatedDatasets(Element metadata) {
        try {
            return Xml.selectNodes(metadata, "*//dcat:DataService/dcat:servesDataset/@rdf:resource|*//dcat:DataService/dcat:servesDataset/dcat:Dataset/@rdf:about", allNamespaces.asList())
                .stream()
                .filter(node -> node instanceof Attribute)
                .map(node -> ((Attribute)node).getValue())
                .map(this::getAssociatedResourceByURI)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());
        } catch (JDOMException e) {
            e.printStackTrace();
        }
        return Collections.emptySet();
    }

    @Override
    public Set<AssociatedResource> getAssociatedFeatureCatalogues(Element metadata) {
        return Collections.emptySet();
    }

    @Override
    public Set<AssociatedResource> getAssociatedSources(Element metadata) {
        return Collections.emptySet();
    }

    @Override
    public Map<String, Namespace> getCswTypeNames() {
        return allTypenames;
    }

    @Override
    public List<Element> getTranslationForElement(Element element, String languageIdentifier) {
        return Collections.emptyList();
    }


    @Override
    public void addTranslationToElement(Element element, String languageIdentifier, String value) {
    }


    @Override
    public Element removeTranslationFromElement(Element element, List<String> mdLang) throws JDOMException {
        return null;
    }

    private AssociatedResource getAssociatedResourceByURI(String uri) {
        var client = ApplicationContextHolder.get().getBean(EsRestClient.class);
        var searchManager = ApplicationContextHolder.get().getBean(EsSearchManager.class);
        try {
            var request = new SearchRequest(searchManager.getDefaultIndex());
            var ssb = new SearchSourceBuilder();
            ssb.fetchSource(new String[]{
                "uuid",
                "resourceTitleObject.default"
            }, null);
            ssb.query(QueryBuilders.matchQuery("rdfResourceIdentifier.link", uri));
            request.source(ssb);

            var response = client.getClient().search(request, RequestOptions.DEFAULT);
            if (response.getHits().getTotalHits().value == 0) {
                return null;
            }
            var associatedRecord = response.getHits().getHits()[0].getSourceAsMap();;
            return new AssociatedResource(
                (String)associatedRecord.get("uuid"),
                "",
                "",
                uri,
                ((Map<String, String>)associatedRecord.get("resourceTitleObject")).get("default")
            );
        } catch (Exception e) {
            Log.error(Geonet.GEONETWORK,
                "GET associated resource '" + uri + "' error: " + e.getMessage(), e);
        }
        return null;
    }
}
