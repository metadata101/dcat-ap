<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (C) 2001-2016 Food and Agriculture Organization of the ~
  United Nations (FAO-UN), United Nations World Food Programme (WFP) ~ and
  United Nations Environment Programme (UNEP) ~ ~ This program is free software;
  you can redistribute it and/or modify ~ it under the terms of the GNU General
  Public License as published by ~ the Free Software Foundation; either version
  2 of the License, or (at ~ your option) any later version. ~ ~ This program
  is distributed in the hope that it will be useful, but ~ WITHOUT ANY WARRANTY;
  without even the implied warranty of ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR
  PURPOSE. See the GNU ~ General Public License for more details. ~ ~ You should
  have received a copy of the GNU General Public License ~ along with this
  program; if not, write to the Free Software ~ Foundation, Inc., 51 Franklin
  St, Fifth Floor, Boston, MA 02110-1301, USA ~ ~ Contact: Jeroen Ticheler
  - FAO - Viale delle Terme di Caracalla 2, ~ Rome - Italy. email: geonetwork@osgeo.org -->
<xsl:stylesheet version="2.0" xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:schema="http://schema.org/"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:dct="http://purl.org/dc/terms/" xmlns:spdx="http://spdx.org/rdf/terms#"
                xmlns:adms="http://www.w3.org/ns/adms#" xmlns:locn="http://www.w3.org/ns/locn#"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:geodcat="http://data.europa.eu/930/" xmlns:util="java:org.fao.geonet.util.XslUtil"
                xmlns:gn-fn-index="http://geonetwork-opensource.org/xsl/functions/index"
                xmlns:mdcat="http://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:geonet="http://www.fao.org/geonetwork">

  <xsl:import href="common/inspire-constant.xsl"/>
  <xsl:import href="common/index-utils.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:output name="default-serialize-mode"
              indent="no"
              omit-xml-declaration="yes"
              encoding="utf-8"
              escape-uri-attributes="yes"/>


  <xsl:variable name="allLanguages">
    <lang id="default" value="'dut'"/>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:apply-templates mode="index"/>
  </xsl:template>

  <xsl:template match="rdf:RDF"
                mode="index">
    <xsl:message select="."/>

    <xsl:variable name="identifier" select="dcat:Catalog/dcat:record/dcat:CatalogRecord/dct:identifier"/>
    <doc>
      <xsl:copy-of select="gn-fn-index:add-field('docType', 'metadata')"/>

      <xsl:copy-of select="gn-fn-index:add-field('metadataIdentifier', $identifier)"/>

      <xsl:copy-of select="gn-fn-index:add-field('mainLanguage', 'dut')"/>


      <xsl:for-each select="dcat:Catalog/dcat:service/dcat:DataService|dcat:Catalog/dcat:dataset/dcat:Dataset">
        <xsl:copy-of select="gn-fn-index:add-multilingual-field('resourceTitle', dct:title, $allLanguages)"/>
        <xsl:copy-of select="gn-fn-index:add-multilingual-field('resourceAltTitle', dct:description, $allLanguages)"/>
      </xsl:for-each>
    </doc>
  </xsl:template>
</xsl:stylesheet>
