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

import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Hit;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Sets;
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
public class DCATAPSchemaPlugin extends SchemaPlugin implements AssociatedResourcesSchemaPlugin, MultilingualSchemaPlugin {
    public static final String IDENTIFIER = "dcat-ap";
    private static final Pattern UUID_PATTERN = Pattern.compile("([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}");

    private static final ImmutableSet<Namespace> allNamespaces;
    private static final Map<String, Namespace> allTypenames;

    static {
        allNamespaces = ImmutableSet.<Namespace>builder()
            .add(DCATAPNamespaces.DC)
            .add(DCATAPNamespaces.DCT)
            .add(DCATAPNamespaces.DCAT)
            .add(DCATAPNamespaces.VCARD)
            .add(DCATAPNamespaces.FOAF)
            .add(DCATAPNamespaces.MDCAT)
            .build();

        allTypenames = ImmutableMap.<String, Namespace>builder()
            .put("csw:Record", Namespace.getNamespace("csw", "http://www.opengis.net/cat/csw/2.0.2"))
            .put("dcat", DCATAPNamespaces.DCAT)
            .build();
    }

    public DCATAPSchemaPlugin() {
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
    //     ElementFilter elementFilter = new ElementFilter("servesDataset", DCATAPNamespaces.DCAT);
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
                .filter(s -> s != null && !s.isBlank())
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
        var searchManager = ApplicationContextHolder.get().getBean(EsSearchManager.class);
        try {
            var response = searchManager.query(String.format("+rdfResourceIdentifier.keyword:\"%s\"", uri), null,
                    Sets.newHashSet("uuid", "resourceTitleObject.default"),
                    0, 1);

            if (response.hits().hits().isEmpty()) {
                return null;
            }
            if (response.hits().hits().size() > 1) {
                Log.error(Log.JEEVES, "Multiple resources was found for URI " + uri + ". Returning first result");
            }

            ObjectMapper objectMapper = new ObjectMapper();
            Hit h = (Hit) response.hits().hits().get(0);
            Map associatedRecord = objectMapper.convertValue(h.source(), Map.class);
            return new AssociatedResource(
                (String)associatedRecord.get("uuid"),
                "",
                "",
                uri,
                ((Map<String, String>)associatedRecord.get("resourceTitleObject")).get("default")
            );
        } catch (Exception e) {
            Log.error(Log.JEEVES, "GET associated resource '" + uri + "' error: " + e.getMessage(), e);
        }
        return null;
    }
}
