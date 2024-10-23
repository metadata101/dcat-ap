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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:saxon="http://saxon.sf.net/"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:variable name="metadata" select="//rdf:RDF"/>

  <xsl:variable name="allLanguages">
    <xsl:variable name="listOfLanguage">
      <xsl:call-template name="get-dcat-ap-other-languages"/>
    </xsl:variable>
    <xsl:for-each select="$listOfLanguage/lang">
      <lang value="{@code}" code="{@id}">
        <xsl:if test="@default">
          <xsl:attribute name="id" select="'default'"/>
        </xsl:if>
      </lang>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="defaultMainLanguage3Char" select="$allLanguages/lang[@id]/@value"/>

  <xsl:variable name="defaultMainLanguage2Char" select="$allLanguages/lang[@id]/@code"/>

  <xsl:variable name="editorConfig"
                select="document('../layout/config-editor.xml')"/>

  <xsl:variable name="protocolConcepts" select="document('../thesauri/theme/protocol.rdf')/rdf:RDF"/>

  <xsl:variable name="profile" select="$metadata/dcat:Catalog/dcat:record/dcat:CatalogRecord/dct:conformsTo/dct:Standard/@rdf:about/string()"/>
</xsl:stylesheet>
