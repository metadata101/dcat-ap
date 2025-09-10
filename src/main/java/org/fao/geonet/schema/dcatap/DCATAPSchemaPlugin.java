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

import co.elastic.clients.elasticsearch.core.search.Hit;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.ImmutableMap;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Sets;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import org.apache.commons.lang.StringUtils;
import org.fao.geonet.ApplicationContextHolder;
import org.fao.geonet.kernel.schema.AssociatedResource;
import org.fao.geonet.kernel.schema.AssociatedResourcesSchemaPlugin;
import org.fao.geonet.kernel.schema.MultilingualSchemaPlugin;
import org.fao.geonet.kernel.schema.SchemaPlugin;
import org.fao.geonet.kernel.search.EsSearchManager;
import org.fao.geonet.kernel.setting.SettingManager;
import org.fao.geonet.utils.Log;
import org.fao.geonet.utils.Xml;
import org.jdom.Attribute;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.Namespace;

/**
 *
 */
public class DCATAPSchemaPlugin extends SchemaPlugin implements AssociatedResourcesSchemaPlugin, MultilingualSchemaPlugin {
    public static final String IDENTIFIER = "dcat-ap";
    private static final Pattern UUID_PATTERN = Pattern.compile("([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}");

    public static final ImmutableSet<Namespace> allNamespaces;
    private static final Map<String, Namespace> allTypenames;

    static {
        allNamespaces = ImmutableSet.<Namespace>builder()
            .add(DCATAPNamespaces.RDF)
            .add(DCATAPNamespaces.DC)
            .add(DCATAPNamespaces.DCT)
            .add(DCATAPNamespaces.DCAT)
            .add(DCATAPNamespaces.DCATAP)
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
     * For virtual catalog, return dcat:record elements
     *
     * @param metadata
     * @return
     */
    @Override
    public Set<AssociatedResource> getAssociatedResourcesUUIDs(Element metadata) {

        String xpathForAggregationInfo = "dcat:Catalog/dcat:record";
        Set<AssociatedResource> listOfResources = new HashSet<>();
        List<?> sibs = null;
        try {
            sibs = Xml
                .selectNodes(
                    metadata,
                    xpathForAggregationInfo,
                    allNamespaces.asList());

            SettingManager settingManager = ApplicationContextHolder.get().getBean(SettingManager.class);
            String baseURL = settingManager.getBaseURL();


            for (Object o : sibs) {
                if (o instanceof Element) {
                    Element sib = (Element) o;
                    String url = sib.getAttributeValue("resource", DCATAPNamespaces.RDF);
                    if (StringUtils.isNotEmpty(url)) {
                        boolean isRemote = !url.startsWith(baseURL);

                        List<?> titleNode = Xml
                            .selectNodes(
                                metadata,
                                String.format("dcat:CatalogRecord[@rdf:about='%s']/dct:title", url),
                                allNamespaces.asList());

                        AssociatedResource resource =
                            new AssociatedResource(
                                isRemote ? url : url.substring(url.lastIndexOf('#') + 1),
                                "", "isComposedOf", url,
                                titleNode == null || titleNode.isEmpty() ? "" : ((Element) titleNode.get(0)).getTextNormalize());
                        listOfResources.add(resource);
                    }
                }
            }
        } catch (JDOMException e) {
            e.printStackTrace();
        }
        return listOfResources;

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

    private Set<AssociatedResource> getAssociatedResourcesByXpath(Element metadata, String xpath) {
        try {
            return Xml.selectNodes(metadata, xpath, allNamespaces.asList())
                .stream()
                .filter(node -> node instanceof Attribute)
                .map(node -> ((Attribute) node).getValue())
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
    public Set<AssociatedResource> getAssociatedParents(Element metadata) {
        return getAssociatedResourcesByXpath(metadata, "*//dcat:inSeries/@rdf:resource");
    }

    @Override
    public Set<AssociatedResource> getAssociatedDatasets(Element metadata) {
        return getAssociatedResourcesByXpath(metadata, "*//dcat:DataService/dcat:servesDataset/@rdf:resource|*//dcat:DataService/dcat:servesDataset/dcat:Dataset/@rdf:about");
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

    @Override
    public List<String> getMetadataLanguages(Element metadata) {
        return List.of();
    }

    @Override
    public boolean isMultilingualElementType(String elementType) {
        List<String> multilingualElementTypes = List.of("rdf:plainLiteral");
        return multilingualElementTypes.contains(elementType);
    }

    @Override
    public boolean duplicateElementsForMultilingual() {
        return true;
    }

}
