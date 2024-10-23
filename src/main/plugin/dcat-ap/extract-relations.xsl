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
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:gn-fn-rel="http://geonetwork-opensource.org/xsl/functions/relations"
                exclude-result-prefixes="#all">

  <xsl:import href="layout/utility-tpl-multilingual.xsl" />

  <xsl:template mode="relation" match="metadata[rdf:RDF/dcat:Catalog]" priority="100">
    <xsl:if test="count(*/descendant::*[name(.) = 'foaf:page']/*) > 0">

      <xsl:variable name="mainLanguage">
        <xsl:call-template name="get-dcat-ap-language">
          <xsl:with-param name="languageIri"
                          select=".//dcat:CatalogRecord/dct:language[1]/(@rdf:resource|skos:Concept/@rdf:about|dct:LinguisticSystem/@rdf:about)" />
        </xsl:call-template>
      </xsl:variable>

      <thumbnails>
        <xsl:for-each select="*/descendant::*[name(.) = 'foaf:page' and foaf:Document[matches(@rdf:about, '.*(.gif|.png|.jpeg|.jpg)$', 'i')]]">
          <item>
            <id>
              <xsl:value-of select="foaf:Document/@rdf:about"/>
            </id>
            <url>
              <xsl:variable name="url" select="foaf:Document/@rdf:about" />

              <value lang="{$mainLanguage}">
                <xsl:value-of select="$url"/>
              </value>
            </url>
            <title>
                <xsl:for-each select="dct:description">
                  <xsl:variable name="localeId"
                                select="@xml:lang"/>

                  <value lang="{$localeId}">
                    <xsl:value-of select="."/>
                  </value>
                </xsl:for-each>
            </title>
            <type>thumbnail</type>
          </item>
        </xsl:for-each>
      </thumbnails>
    </xsl:if>

  </xsl:template>


</xsl:stylesheet>
