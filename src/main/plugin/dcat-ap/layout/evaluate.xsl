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

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:spdx="http://spdx.org/rdf/terms#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:adms="http://www.w3.org/ns/adms#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:dcatap="http://data.europa.eu/r5r/"
                xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:schema="http://schema.org/"
                xmlns:locn="http://www.w3.org/ns/locn#"
                xmlns:cnt="http://www.w3.org/2011/content#"
                xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:mobilitydcatap="https://w3id.org/mobilitydcat-ap"
                xmlns:gn="http://www.fao.org/geonetwork"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all">

  <xsl:import href="../dcat-profiles.xsl"/>

  <!-- Evaluate an expression. This is schema dependant in order to properly
        set namespaces required for evaluate.

    "The static context for the expression includes all the in-scope namespaces,
    types, and functions from the calling stylesheet or query"
    http://saxonica.com/documentation9.4-demo/html/extensions/functions/evaluate.html
    -->
  <xsl:template name="evaluate-dcat-ap">
    <xsl:param name="base" as="node()"/>
    <xsl:param name="in"/>

    <!-- $p2 is the dcat-ap profiles list -->
    <xsl:variable name="p2" as="xs:string*">
      <xsl:for-each select="$metadata//dcat:CatalogRecord/dct:conformsTo/dct:Standard">
        <xsl:variable name="stdURI" select="@rdf:about"/>
        <xsl:sequence select="string($dcat-profiles/profile[@uri = $stdURI]/alias)"/>
      </xsl:for-each>
    </xsl:variable>

    <!-- $p3 is the DCAT version -->
    <xsl:variable name="p3" select="$dcat-profiles/profile[@uri = ($metadata//dcat:CatalogRecord/dct:conformsTo/dct:Standard/@rdf:about)[1]]/dcatVersion/string()"/>

    <xsl:variable name="nodeOrAttribute" select="saxon:evaluate(concat('$p1', if (ends-with($in,'.')) then concat($in,'/text()') else $in), $base, $p2, $p3)"/>

    <xsl:choose>
      <xsl:when test="$nodeOrAttribute instance of text()+">
        <xsl:value-of select="$nodeOrAttribute"/>
      </xsl:when>
      <xsl:when test="$nodeOrAttribute instance of element()+">
        <xsl:copy-of select="$nodeOrAttribute"/>
      </xsl:when>
      <xsl:when test="$nodeOrAttribute instance of attribute()+">
        <xsl:value-of select="$nodeOrAttribute"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$nodeOrAttribute"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Evaluate XPath returning a boolean value. -->
  <xsl:template name="evaluate-dcat-ap-boolean">
    <xsl:param name="base" as="node()"/>
    <xsl:param name="in"/>

    <!-- $p2 is the dcat-ap profiles list -->
    <xsl:variable name="p2" as="xs:string*">
      <xsl:for-each select="$metadata//dcat:CatalogRecord/dct:conformsTo/dct:Standard">
        <xsl:variable name="stdURI" select="@rdf:about"/>
        <xsl:sequence select="string($dcat-profiles/profile[@uri = $stdURI]/alias)"/>
      </xsl:for-each>
    </xsl:variable>

    <!-- $p3 is the DCAT version -->
    <xsl:variable name="p3" select="$dcat-profiles/profile[@uri = ($metadata//dcat:CatalogRecord/dct:conformsTo/dct:Standard/@rdf:about)[1]]/dcatVersion/string()"/>

    <xsl:value-of select="saxon:evaluate(concat('$p1', $in), $base, $p2, $p3)"/>
  </xsl:template>
</xsl:stylesheet>
