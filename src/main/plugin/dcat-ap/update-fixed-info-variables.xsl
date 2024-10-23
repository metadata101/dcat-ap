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
                xmlns:uuid="java:java.util.UUID"
                xmlns:java="java:org.fao.geonet.util.XslUtil"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:include href="layout/utility-tpl-multilingual.xsl"/>

  <xsl:variable name="serviceUrl" select="/root/env/siteURL"/>
  <xsl:variable name="env" select="/root/env"/>
  <xsl:variable name="iso2letterLanguageCode" select="lower-case(java:twoCharLangCode(/root/gui/language))"/>
  <xsl:variable name="resourcePrefix" select="$env/metadata/resourceIdentifierPrefix"/>

  <xsl:variable name="metadata"
                select="/root/rdf:RDF"/>

  <xsl:variable name="mainLanguage">
    <xsl:call-template name="get-dcat-ap-language"/>
  </xsl:variable>

  <xsl:variable name="locales">
    <xsl:call-template name="get-dcat-ap-other-languages"/>
  </xsl:variable>

  <xsl:variable name="isMultilingual"
                select="count($locales/*) > 1"/>

  <xsl:variable name="isLanguageSet"
                select="count($locales/*) >= 1"/>

  <xsl:variable name="editorConfig"
                select="document('layout/config-editor.xml')"/>

  <xsl:variable name="resourceType">
    <xsl:choose>
      <xsl:when test="/root/rdf:RDF/dcat:Catalog/dcat:dataset/dcat:Dataset">
        <xsl:value-of select="'datasets'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'services'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="profile" select="string(/root/rdf:RDF/dcat:Catalog/dcat:record/dcat:CatalogRecord/dct:conformsTo/dct:Standard/@rdf:about)"/>
  <xsl:variable name="uuidRegex" select="'([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}'"/>
  <xsl:variable name="record" select="/root/rdf:RDF/dcat:Catalog/dcat:record/dcat:CatalogRecord"/>
  <xsl:variable name="resource" select="/root/rdf:RDF/dcat:Catalog/dcat:dataset/dcat:Dataset|
                                        /root/rdf:RDF/dcat:Catalog/dcat:service/dcat:DataService"/>

  <xsl:variable name="recordUUID" select="/root/env/uuid"/>
  <xsl:variable name="recordAbout" select="concat(/root/env/nodeURL, 'api/records/', $recordUUID)"/>

  <xsl:variable name="resourceUUID">
    <xsl:choose>
      <xsl:when test="count($resource/dct:identifier[matches(., concat('^', $uuidRegex, '$'))]) > 0">
        <xsl:value-of select="$resource/dct:identifier[matches(., concat('^', $uuidRegex, '$'))][1]"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="uuid:toString(uuid:randomUUID())"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="resourceAbout" select="concat(/root/env/nodeURL, 'resources/', $resourceType, '/', $resourceUUID)"/>

  <!-- Multilingual support -->
  <xsl:variable name="nonMultilingualElements"
                select="$editorConfig/editor/multilingualFields/exclude/name"/>


</xsl:stylesheet>
