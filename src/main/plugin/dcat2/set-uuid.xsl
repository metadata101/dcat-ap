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
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:util="java:java.util.UUID">

  <xsl:variable name="record" select="/root/rdf:RDF/dcat:Catalog/dcat:record/dcat:CatalogRecord"/>

  <xsl:variable name="resource" select="/root/rdf:RDF/dcat:Catalog/dcat:dataset/dcat:Dataset|
                                        /root/rdf:RDF/dcat:Catalog/dcat:service/dcat:DataService"/>

  <xsl:variable name="resourceType">
    <xsl:choose>
      <xsl:when test="/root/rdf:RDF/dcat:Catalog/dcat:dataset/dcat:Dataset">
        <xsl:value-of select="'dataset'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'service'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="recordUUID" select="/root/env/uuid"/>

  <xsl:variable name="resourceUUID">
    <xsl:choose>
      <xsl:when test="$resource/dct:identifier">
        <xsl:value-of select="$resource/dct:identifier[1]"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="util:toString(util:randomUUID())"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="recordAbout">
    <xsl:choose>
      <xsl:when test="$record/@rdf:about">
        <xsl:value-of select="replace($record/@rdf:about,
                                      '([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}',
                                      $recordUUID)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat(/root/env/nodeURL, 'api/records/', $recordUUID)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="resourceAbout">
    <xsl:variable name="existingAbout" select="$resource/@rdf:about"/>
    <xsl:choose>
      <xsl:when test="normalize-space($existingAbout) != ''">
        <xsl:value-of select="replace($existingAbout,
                                      '([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}',
                                      $resourceUUID)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat(/root/env/baseURL, 'doc/', $resourceType, '/', $resourceUUID)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>


  <xsl:template match="/">
    <xsl:apply-templates select="root/rdf:RDF"/>
  </xsl:template>

  <xsl:template match="dcat:Catalog[not(dcat:record)]">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="dct:title|
                                   dct:description|
                                   dct:publisher|
                                   foaf:homepage|
                                   dct:license|
                                   dct:language|
                                   dct:issued|
                                   dct:modified|
                                   dcat:themeTaxonomy|
                                   dct:hasPart|
                                   dct:isPartOf"/>

      <xsl:call-template name="generate-record"/>

      <xsl:apply-templates select="dct:rights|
                                   dct:spatial|
                                   dcat:dataset|
                                   dcat:service|
                                   dcat:contactPoint|
                                   dcat:keyword|
                                   dcat:landingPage|
                                   dcat:qualifiedRelation|
                                   dcat:theme|
                                   dct:accessRights|
                                   dct:conformsTo|
                                   dct:creator|
                                   dct:identifier|
                                   dct:isReferencedBy|
                                   dct:relation|
                                   dct:type"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="dcat:record[not(dcat:CatalogRecord)]">
    <xsl:call-template name="generate-record"/>
  </xsl:template>

  <xsl:template match="dcat:CatalogRecord">
    <xsl:copy>
      <xsl:apply-templates select="@*[not(name(.) = 'rdf:about')]"/>
      <xsl:attribute name="rdf:about" select="$recordAbout"/>
      <xsl:element name="dct:identifier">
        <xsl:value-of select="$recordUUID"/>
      </xsl:element>
      <foaf:primaryTopic rdf:resource="{$resourceAbout}"/>
      <xsl:if test="not(dct:modified)">
        <xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01]')"/>
      </xsl:if>
      <xsl:apply-templates select="*[name(.) != 'dct:identifier' and name(.) != 'foaf:primaryTopic']"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="dcat:Dataset|dcat:DataService">
    <xsl:copy>
      <xsl:attribute name="rdf:about" select="$resourceAbout"/>
      <xsl:if test="not($resource/dct:identifier)">
        <dct:identifier>
          <xsl:value-of select="$resourceUUID"/>
        </dct:identifier>
      </xsl:if>
      <xsl:apply-templates select="*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- ================================================= -->
  <xsl:template name="generate-record">
    <xsl:element name="dcat:record">
      <xsl:element name="dcat:CatalogRecord">
        <xsl:attribute name="rdf:about" select="$recordAbout"/>
        <dct:identifier>
          <xsl:value-of select="$recordUUID"/>
        </dct:identifier>
        <foaf:primaryTopic rdf:resource="{$resourceAbout}"/>
        <dct:modified>
          <xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01]')"/>
        </dct:modified>
      </xsl:element>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
