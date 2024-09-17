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
    xmlns:spdx="http://spdx.org/rdf/terms#"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:adms="http://www.w3.org/ns/adms#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:dcat="http://www.w3.org/ns/dcat#"
    xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:schema="http://schema.org/"
    xmlns:locn="http://www.w3.org/ns/locn#"
    xmlns:gml="http://www.opengis.net/gml"
    xmlns:gn="http://www.fao.org/geonetwork"
    xmlns:gn-fn-metadata="http://geonetwork-opensource.org/xsl/functions/metadata"
    xmlns:gn-fn-dcat2="http://geonetwork-opensource.org/xsl/functions/profiles/dcat2"
    xmlns:saxon="http://saxon.sf.net/"
    extension-element-prefixes="saxon"
    version="2.0"
    exclude-result-prefixes="#all">

  <xsl:template mode="mode-dcat2" match="*[name() = $editorConfig/editor/fields/for[@use = 'gn-date-picker']/@name]" priority="4000">
    <xsl:param name="schema" select="$schema" required="no"/>
    <xsl:param name="labels" select="$labels" required="no"/>
    <xsl:param name="overrideLabel" select="''" required="no"/>

    <xsl:variable name="xpath" select="gn-fn-metadata:getXPath(.)"/>
    <xsl:variable name="tooltip" select="concat($schema, '|', name(.), '|', name(..), '|', $xpath)"/>
    <xsl:variable name="labelConfig" select="gn-fn-metadata:getLabel($schema, name(), $labels, name(..), '', $xpath)"/>
    <xsl:variable name="elementRef" select="gn:element/@ref"/>
    <xsl:variable name="isRequired" select="gn:element/@min = 1"/>

    <div class="form-group gn-field gn-date {if ($isRequired) then 'gn-required' else ''}"
         id="gn-el-{$elementRef}"
         data-gn-field-highlight="">
      <label class="col-sm-2 control-label">
        <xsl:choose>
          <xsl:when test="$overrideLabel != ''">
            <xsl:value-of select="$overrideLabel"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$labelConfig/label"/>
          </xsl:otherwise>
        </xsl:choose>
      </label>
      <div class="col-sm-9 col-xs-11 gn-value nopadding-in-table">
        <xsl:variable name="value">
          <xsl:choose>
            <xsl:when test="$viewConfig/@hideTimeInCalendar = 'true' and contains(lower-case(text()), 't')">
              <xsl:value-of select="substring-before(lower-case(text()), 't')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="text()"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <div data-gn-date-picker="{$value}"
             data-gn-field-tooltip="{$tooltip}"
             data-label=""
             data-tag-name="{name()}"
             data-element-name="{name()}"
             data-element-ref="{concat('_X', gn:element/@ref)}"
             data-hide-time="{if ($viewConfig/@hideTimeInCalendar = 'true') then 'true' else 'false'}"
             data-hide-date-mode="{if ($viewConfig/@hideTimeInCalendar = 'true') then 'true' else 'false'}">
        </div>
      </div>
      <div class="col-sm-1 col-xs-1 gn-control">
        <xsl:call-template name="render-form-field-control-remove">
          <xsl:with-param name="editInfo" select="gn:element"/>
        </xsl:call-template>
      </div>

      <div class="col-sm-offset-2 col-sm-9">
        <xsl:call-template name="get-errors"/>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
