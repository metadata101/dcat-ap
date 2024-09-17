<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright (C) 2001-2016 Food and Agriculture Organization of the
  ~ United Nations (FAO-UN), United Nations World Food Programme (WFP)
  ~ and United Nations Environment Programme (UNEP)
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or (at
  ~ your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful, but
  ~ WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  ~ General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  ~
  ~ Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
  ~ Rome - Italy. email: geonetwork@osgeo.org
  -->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:adms="http://www.w3.org/ns/adms#"
                exclude-result-prefixes="#all">

  <xsl:template mode="relation" match="metadata[rdf:RDF/dcat:Catalog]" priority="100">
    <xsl:if test="count(*/descendant::*[name(.) = 'adms:sample']/*) > 0">
      <thumbnails>
        <xsl:for-each select="*/descendant::*[name(.) = 'adms:sample']">
          <item>
            <id>
              <xsl:value-of select="dcat:Distribution/dcat:downloadURL/@rdf:resource"/>
            </id>
            <url>
              <value lang="dut"><xsl:value-of select="dcat:Distribution/dcat:downloadURL/@rdf:resource"/></value>
            </url>
            <title>
              <value lang="dut"><xsl:value-of select="dct:title[1]"/></value>
            </title>
            <type>thumbnail</type>
          </item>
        </xsl:for-each>
      </thumbnails>
    </xsl:if>

  </xsl:template>


</xsl:stylesheet>
