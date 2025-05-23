/*
 * Copyright (C) 2001-2017 Food and Agriculture Organization of the
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
package org.fao.geonet.schema.dcatap.util;

import com.vividsolutions.jts.geom.Envelope;
import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.io.WKTReader;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import org.fao.geonet.ApplicationContextHolder;
import org.fao.geonet.constants.Geonet;
import org.fao.geonet.exceptions.TermNotFoundException;
import org.fao.geonet.kernel.KeywordBean;
import org.fao.geonet.kernel.Thesaurus;
import org.fao.geonet.kernel.ThesaurusManager;
import org.fao.geonet.utils.Log;
import org.fao.geonet.utils.Xml;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.output.DOMOutputter;
import org.springframework.context.ApplicationContext;
import org.w3c.dom.Node;

/**
 * These are all extension methods for calling from xsl docs.  Note:  All params are objects because
 * it is hard to determine what is passed in from XSLT. Most are converted to string by calling
 * tostring.
 *
 * @author Gustaaf Vandeboel
 */
public final class XslUtil {

    /**
     * Searches the thesaurus for the keyword with the given uri and returns the keyword labels for each language.
     * If thesaurus is not specified, all thesauri are searched. First match is returned.
     *
     * <pre>
     *     <keyword>
     *         <dut>Provincie Limburg</dut>
     *         <eng>Provincie Limburg</eng>
     *     </keyword>
     * </pre>
     *
     * @param langCode the language code or a comma separated list of language codes (3 letters)
     */
    public static Node getKeywordValuesByUri(String uri, String thesaurusId, String langCode) {
        ApplicationContext applicationContext = ApplicationContextHolder.get();
        ThesaurusManager thesaurusManager = applicationContext.getBean(ThesaurusManager.class);

        Map<String, Thesaurus> thesaurusList = new HashMap<>();

        if (StringUtils.isEmpty(thesaurusId)) {
            thesaurusList = thesaurusManager.getThesauriMap();
        } else {
            thesaurusId = thesaurusId.replaceAll("geonetwork.thesaurus.", "");
            Thesaurus thesaurus = thesaurusManager.getThesaurusByName(thesaurusId);
            thesaurusList.put(thesaurusId, thesaurus);
        }

        for (Thesaurus thesaurus : thesaurusList.values()) {
            try {
                KeywordBean keywordBean = thesaurus.getKeyword(uri, langCode.split(","));
                if (keywordBean != null) {
                    Element keywordElement = new Element("keyword");
                    keywordBean.getValues().forEach((key, value) -> {
                        Element element = new Element(key);
                        element.setText(value);
                        keywordElement.addContent(element);
                    });
                    DOMOutputter outputter = new DOMOutputter();
                    return outputter.output(new Document(keywordElement));
                }
            } catch (TermNotFoundException exception)   {
                // Moving to next thesaurus
            } catch (JDOMException e) {
                Log.error(Geonet.GEONETWORK, "Error returning keyword elements.", e);
            }
        }
        return null;
    }

    // TODO : use core/src/main/java/org/fao/geonet/util/XslUtil.java:wktGeomToBbox instead
    public static String wktGeomToBbox(Object geometryAsXmlString) throws Exception {
        String ret = "";
        try {
            Element geometryElement = Xml.loadString((String) geometryAsXmlString, false);
            if (geometryElement != null) {
                String wktString = (String) geometryElement.getValue();
                if (wktString != null && wktString.length() > 0) {
                    WKTReader reader = new WKTReader();
                    Geometry geometry = reader.read(wktString);
                    if (geometry != null) {
                        final Envelope envelope = geometry.getEnvelopeInternal();
                        return
                            String.format("%f|%f|%f|%f",
                                envelope.getMinX(), envelope.getMinY(),
                                envelope.getMaxX(), envelope.getMaxY());
                    }
                }
            }
        } catch (Throwable e) {
        }
        return ret;
    }
}
