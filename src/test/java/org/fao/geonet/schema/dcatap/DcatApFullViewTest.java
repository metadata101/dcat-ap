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
import java.util.Map;
import org.fao.geonet.schemas.AbstractFormatterTest;
import org.fao.geonet.schemas.TestSupport;
import static org.fao.geonet.schemas.TestSupport.getResource;
import static org.fao.geonet.schemas.TestSupport.getResourceInsideSchema;
import org.fao.geonet.utils.Xml;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.junit.Test;

public class DcatApFullViewTest extends AbstractFormatterTest {

    private static final boolean GENERATE_EXPECTED_FILE = true;

    @Test
    public void fullViewMultilingual() throws Exception {
        Path xslFile = getResourceInsideSchema("formatter/xsl-view/view.xsl");
        Path xmlFile = getResource("dataset.xml");
        Element source = Xml.loadFile(xmlFile);

        Element transformed = Xml.transform(source, xslFile, Map.of("view", "default", "approved", "true", "root", "div"));

        XMLOutputter xmlOutputter = new XMLOutputter(Format.getPrettyFormat().setLineSeparator("\n"));
        String actual = xmlOutputter.outputString(new Document(transformed));
        TestSupport.assertGeneratedDataByteMatchExpected("dataset-full-view.html", actual, GENERATE_EXPECTED_FILE);
    }
}
