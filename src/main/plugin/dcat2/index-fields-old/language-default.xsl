<?xml version="1.0" encoding="UTF-8" ?>

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

<xsl:stylesheet version="2.0" xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:schema="http://schema.org/"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:dct="http://purl.org/dc/terms/" xmlns:spdx="http://spdx.org/rdf/terms#"
                xmlns:adms="http://www.w3.org/ns/adms#" xmlns:locn="http://www.w3.org/ns/locn#"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:util="java:org.fao.geonet.util.XslUtil" xmlns:geonet="http://www.fao.org/geonetwork">
  <xsl:import href="common/index-utils.xsl"/>
  <xsl:include href="../convert/functions.xsl"/>
  <xsl:include href="../../../../xsl/utils-fn.xsl"/>
  <xsl:include href="common-default.xsl"/>

  <!-- This file defines what parts of the metadata are indexed by Lucene
         Searches can be conducted on indexes defined here.
         The Field@name attribute defines the name of the search variable.
         If a variable has to be maintained in the user session, it needs to be
         added to the GeoNetwork constants in the Java source code.
         Please keep indexes consistent among metadata standards if they should
         work accross different metadata resources -->
  <!-- ========================================================================================= -->

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>

  <!-- ========================================================================================= -->

  <xsl:variable name="isoCatalogLangId">
    <xsl:call-template name="catalog-langId-dcat2" />
  </xsl:variable>

  <xsl:variable name="catalogLangId">
    <xsl:if test="$isoCatalogLangId!=''">
      <xsl:call-template name="langId3to2">
        <xsl:with-param name="langId-3char" select="$isoCatalogLangId"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:variable>

  <xsl:template match="/">
    <Documents>
      <xsl:variable name="catalogRecord" select="rdf:RDF/dcat:Catalog/dcat:record/dcat:CatalogRecord"/>
      <xsl:variable name="datasetOrDataservice" select="rdf:RDF/dcat:Catalog/dcat:dataset/dcat:Dataset|rdf:RDF/dcat:Catalog/dcat:service/dcat:DataService"/>
      <xsl:for-each select="distinct-values(//dct:title[name(..)=('dcat:Dataset','dcat:DataService')]/@xml:lang)">
        <xsl:variable name="isoLangId">
          <xsl:call-template name="langId2to3">
            <xsl:with-param name="langId-2char" select="." />
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="not($isoLangId = $isoDocLangId) and not($isoLangId = $catalogLangId)">
          <xsl:call-template name="document">
            <xsl:with-param name="catalogRecord" select="$catalogRecord"/>
            <xsl:with-param name="datasetOrDataservice" select="$datasetOrDataservice"/>
            <xsl:with-param name="isoLangId" select="$isoLangId"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>

      <xsl:if test="not($catalogLangId='')">
        <xsl:variable name="isoLangId">
          <xsl:call-template name="langId2to3">
            <xsl:with-param name="langId-2char" select="$catalogLangId" />
          </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="document">
          <xsl:with-param name="catalogRecord" select="$catalogRecord"/>
          <xsl:with-param name="datasetOrDataservice" select="$datasetOrDataservice"/>
          <xsl:with-param name="isoLangId" select="$isoLangId"/>
        </xsl:call-template>
      </xsl:if>
    </Documents>

  </xsl:template>

</xsl:stylesheet>
