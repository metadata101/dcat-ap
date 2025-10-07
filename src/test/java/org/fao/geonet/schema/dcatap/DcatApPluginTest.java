/*
 * Copyright (C) 2001-2024 Food and Agriculture Organization of the
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

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import org.fao.geonet.schemas.XslProcessTest;
import org.fao.geonet.utils.Xml;
import static org.hamcrest.CoreMatchers.equalTo;
import org.jdom.Element;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;
import org.junit.Test;
import static org.xmlunit.matchers.EvaluateXPathMatcher.hasXPath;

public class DcatApPluginTest extends XslProcessTest {

    public DcatApPluginTest() {
        super();
        this.setNs(DCATAPSchemaPlugin.allNamespaces);
    }

    @Test
    public void testExtractUuidConversion() throws Exception {
        Map<String, String> fileAndUuids = Map.of(
            "templates/dcat-ap3-dataset.xml", "",
            "sample-data/agrarisch-groen-ontoegankelijk-antwerpen.xml", "6803e58d-cb97-3468-974a-9ecf692e4988",
            "virtualcatalogue.xml", "00d11159-1bf8-4149-b3a4-98c272344736"
        );

        xslFile = Paths.get(testClass.getClassLoader().getResource("extract-uuid.xsl").toURI());

        for (Map.Entry<String, String> entry : fileAndUuids.entrySet()) {
            Path xmlFile = Paths.get(testClass.getClassLoader().getResource(entry.getKey()).toURI());
            Element inputElement = Xml.loadFile(xmlFile);
            Element resultElement = Xml.transform(inputElement, xslFile);

            assertEquals(entry.getValue(), resultElement.getTextTrim());
        }
    }

    @Test
    public void testSetUuidConversion() throws Exception {
        // Test file and prefix of the rdf:about attribute
        Map<String, String> fileAndUuids = Map.of(
            "templates/dcat-ap3-dataset.xml", "value-for-nodeUrlapi/records/",
            "sample-data/agrarisch-groen-ontoegankelijk-antwerpen.xml", "value-for-nodeUrlapi/records/",
            "virtualcatalogue.xml", "https://metadata.dev-vlaanderen.be/srv/api/records/"
        );
        String newUuid = "ABC";

        xslFile = Paths.get(testClass.getClassLoader().getResource("set-uuid.xsl").toURI());

        for (Map.Entry<String, String> entry : fileAndUuids.entrySet()) {
            Path xmlFile = Paths.get(testClass.getClassLoader().getResource(entry.getKey()).toURI());
            Element metadata = Xml.loadFile(xmlFile);
            Element root = new Element("root");
            Element env = new Element("env");
            env.addContent(new Element("uuid").setText(newUuid));
            root.addContent(env);
            root.addContent(metadata);
            Element resultElement = Xml.transform(root, xslFile);
            String resultString = Xml.getString(resultElement);

            // Check that the rdf:about attribute and dct:identifier element have been set correctly
            assertThat(
                resultString,
                hasXPath("rdf:RDF/dcat:Catalog/dcat:record/dcat:CatalogRecord/@rdf:about",
                    equalTo(entry.getValue() + newUuid))
                    .withNamespaceContext(ns)
            );
            assertThat(
                resultString,
                hasXPath("rdf:RDF/dcat:Catalog/dcat:record/dcat:CatalogRecord/dct:identifier",
                    equalTo(newUuid))
                    .withNamespaceContext(ns)
            );

            // For virtual catalogue, check that related records are not changed
            if (entry.getKey().equals("virtualcatalogue.xml")) {
                assertThat(
                    resultString,
                    hasXPath("rdf:RDF/dcat:CatalogRecord[1]/@rdf:about",
                        equalTo("https://metadata.dev-vlaanderen.be/srv/api/records/00d11159-1bf8-4149-b3a4-98c272344736/b51c0f35-7f52-530a-8498-d668339192b6"))
                        .withNamespaceContext(ns)
                );
            }
        }
    }
}
