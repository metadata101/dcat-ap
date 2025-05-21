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

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:csw="http://www.opengis.net/cat/csw/2.0.2"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:dcat="http://www.w3.org/ns/dcat#"
    xmlns:geonet="http://www.fao.org/geonetwork">

  <xsl:param name="displayInfo"/>

  <xsl:template match="//dcat:Catalog/dcat:record/dcat:CatalogRecord">
    <xsl:variable name="info" select="geonet:info"/>
    <csw:BriefRecord>
      <xsl:for-each select="dct:identifier">
        <dc:identifier>
          <xsl:value-of select="."/>
        </dc:identifier>
      </xsl:for-each>

      <!-- Change for CSW 2.0.2 - title is mandatory -->
      <xsl:for-each select="../..//dcat:Dataset/dct:title|../..//dcat:DataService/dct:title">
        <dc:title>
          <xsl:value-of select="."/>
        </dc:title>
      </xsl:for-each>

      <xsl:if test="//dcat:Dataset">
        <dc:type>dataset</dc:type>
      </xsl:if>
      <xsl:if test="//dcat:DataService">
        <dc:type>service</dc:type>
      </xsl:if>

      <!-- GeoNetwork elements added when resultType is equal to results_with_summary -->
      <xsl:if test="$displayInfo = 'true'">
        <xsl:copy-of select="$info"/>
      </xsl:if>

    </csw:BriefRecord>
  </xsl:template>

  <xsl:template match="@*|node()" priority="0">
    <xsl:apply-templates select="@*|node()"/>
  </xsl:template>
</xsl:stylesheet>
