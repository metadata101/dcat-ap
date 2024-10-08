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
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:java="java:org.fao.geonet.util.XslUtil"
                xmlns:java2="java:org.fao.geonet.schema.dcatap.util.XslUtil"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:gn-fn-dcat-ap="http://geonetwork-opensource.org/xsl/functions/profiles/dcat-ap"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all">

  <xsl:function name="gn-fn-dcat-ap:getRdfTypeByElementName" as="xs:string">
    <xsl:param name="elementName"/>
    <xsl:param name="parentElementName"/>
    <xsl:choose>
      <xsl:when test="$elementName = 'dct:accrualPeriodicity'">
        <xsl:value-of select="'http://purl.org/dc/terms/Frequency'"/>
      </xsl:when>
      <xsl:when test="$elementName = 'dct:language'">
        <xsl:value-of select="'http://purl.org/dc/terms/LinguisticSystem'"/>
      </xsl:when>
      <xsl:when test="$elementName = 'dct:format'">
        <xsl:value-of select="'http://purl.org/dc/terms/MediaTypeOrExtent'"/>
      </xsl:when>
      <xsl:when test="$elementName = ('dcat:mediaType', 'dcat:compressFormat', 'dcat:packageFormat')">
        <xsl:value-of select="'http://purl.org/dc/terms/MediaType'"/>
      </xsl:when>
      <xsl:when test="$elementName = 'dct:accessRights'">
        <xsl:value-of select="'http://purl.org/dc/terms/RightsStatement'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="''"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="gn-fn-dcat-ap:isNotMultilingualField" as="xs:boolean">
    <xsl:param name="element" as="node()"/>
    <xsl:param name="editorConfig" as="node()"/>

    <xsl:variable name="elementName" select="name($element)"/>

    <xsl:variable name="exclusionMatchesParent" as="xs:boolean">
      <xsl:variable name="parentName"
                    select="name($element/..)"/>

      <xsl:value-of select="count($editorConfig/editor/multilingualFields/exclude/
                                  name[. = $elementName]/@parent[. = $parentName]) > 0"/>
    </xsl:variable>


    <xsl:variable name="exclusionMatchesAncestor" as="xs:boolean">
      <xsl:variable name="ancestorNames"
                    select="$element/ancestor::*/name()"/>

      <xsl:value-of select="count($editorConfig/editor/multilingualFields/exclude/
                                  name[. = $elementName]/@ancestor[. = $ancestorNames]) > 0"/>
    </xsl:variable>


    <xsl:variable name="exclusionMatchesChild" as="xs:boolean">
      <xsl:variable name="childName"
                    select="name($element/*[1])"/>

      <xsl:value-of select="count($editorConfig/editor/multilingualFields/exclude/
                                  name[. = $elementName]/@child[. = $childName]) > 0"/>
    </xsl:variable>


    <xsl:variable name="excluded"
                  as="xs:boolean"
                  select="
                    count($editorConfig/editor/multilingualFields/exclude/name[. = $elementName and not(@*)]) > 0 or
                      $exclusionMatchesAncestor = true() or
                      $exclusionMatchesParent = true() or
                      $exclusionMatchesChild = true()"/>

    <xsl:value-of select="$excluded"/>
  </xsl:function>

  <!-- Get field if templateModeOnly is true based on editor configuration.
  Search by element name or the child element name (the one
  containing the value).

  The child element take priority if defined.
  -->
  <xsl:function name="gn-fn-dcat-ap:getField" as="node()">
    <xsl:param name="configuration" as="node()"/>
    <!-- The container element -->
    <xsl:param name="name" as="xs:string"/>
    <!-- The element containing the value eg. gco:Date -->
    <xsl:param name="childName" as="xs:string?"/>
    <xsl:variable name="childNode"
                  select="$configuration/editor/fields/for[@name = $childName and @templateModeOnly]"/>
    <xsl:variable name="node"
                  select="$configuration/editor/fields/for[@name = $name and @templateModeOnly]"/>

    <xsl:choose>
      <xsl:when test="count($childNode/*)>0">
        <xsl:value-of select="$childNode"/>
      </xsl:when>
      <xsl:when test="count($node/*)>0">
        <xsl:value-of select="$node"/>
      </xsl:when>
      <xsl:otherwise>
        <for/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="gn-fn-dcat-ap:isForceDisplayAttributes" as="xs:boolean">
    <xsl:param name="element" as="node()"/>
    <xsl:choose>
      <xsl:when test="$element[@xml:lang or @rdf:about or @rdf:resource]">
        <xsl:value-of select="true()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="false()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="gn-fn-dcat-ap:getBboxCoordinates" as="xs:string">
    <xsl:param name="geometryElement" as="node()"/>
    <xsl:variable name="bbox">
      <xsl:choose>
        <xsl:when test="ends-with($geometryElement/@rdf:datatype,'#wktLiteral')">
          <xsl:value-of select="java2:wktGeomToBbox(saxon:serialize($geometryElement,'default-serialize-mode'))"/>
        </xsl:when>
        <xsl:when test="ends-with($geometryElement/@rdf:datatype,'#gmlLiteral')">
          <xsl:value-of select="java:geomToBbox(saxon:serialize($geometryElement,'default-serialize-mode'))"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length($bbox)>0">
        <xsl:value-of select="$bbox"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- Initialize with Flanders bbox when locn:geometry contains invalid geometry -->
        <xsl:value-of select="'2.53|50.67|5.92|51.51|Vlaams Gewest|https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Vlaamse-Administratieve-Eenheden'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="gn-fn-dcat-ap:concatXPaths" as="xs:string">
    <xsl:param name="parentXPath" as="xs:string"/>
    <xsl:param name="childXPath" as="xs:string"/>
    <xsl:param name="childNodeName" as="xs:string"/>
    <xsl:choose>
      <xsl:when test="ends-with($parentXPath, $childNodeName)">
        <xsl:value-of select="$parentXPath"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($parentXPath, $childXPath)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>
