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
                xmlns:adms="http://www.w3.org/ns/adms#"
                xmlns:geonet="http://www.fao.org/geonetwork"
                exclude-result-prefixes="#all"
                version="2.0">

  <!-- Thumbnail base url (mandatory) -->
  <xsl:param name="thumbnail_url"/>
  <xsl:param name="thumbnail_desc" select="''"/>

  <xsl:template match="/root">
    <xsl:apply-templates select="rdf:RDF"/>
  </xsl:template>

  <xsl:template match="dcat:Dataset|dcat:DataService">
    <xsl:variable name="elements-after"
                  select="dcat:qualifiedRelation|
                        dct:creator|
                        dct:isReferencedBy|
                        dct:rights" />

    <xsl:copy copy-namespaces="no">
      <xsl:copy-of select="* except $elements-after" copy-namespaces="no" />
      <xsl:call-template name="fill"/>
      <xsl:copy-of select="$elements-after" copy-namespaces="no" />
    </xsl:copy>
  </xsl:template>

  <xsl:template name="fill">
    <xsl:if test="$thumbnail_url != ''">
      <adms:sample>
        <dcat:Distribution>
          <dcat:downloadURL rdf:resource="{$thumbnail_url}"/>
          <xsl:if test="$thumbnail_desc!=''">
            <dct:title xml:lang="nl"><xsl:value-of select="$thumbnail_desc"/></dct:title>
          </xsl:if>
        </dcat:Distribution>
      </adms:sample>
    </xsl:if>
  </xsl:template>


  <!-- Do a copy of every nodes and attributes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Always remove geonet:* elements. -->
  <xsl:template match="geonet:*" priority="2"/>

</xsl:stylesheet>
