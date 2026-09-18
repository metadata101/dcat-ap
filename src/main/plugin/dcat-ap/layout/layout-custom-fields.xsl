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
    xmlns:dqv="http://www.w3.org/ns/dqv#"
    xmlns:locn="http://www.w3.org/ns/locn#"
    xmlns:gml="http://www.opengis.net/gml"
    xmlns:gn="http://www.fao.org/geonetwork"
    xmlns:gn-fn-metadata="http://geonetwork-opensource.org/xsl/functions/metadata"
    xmlns:gn-fn-dcat-ap="http://geonetwork-opensource.org/xsl/functions/profiles/dcat-ap"
    xmlns:saxon="http://saxon.sf.net/"
    extension-element-prefixes="saxon"
    version="2.0"
    exclude-result-prefixes="#all">

  <xsl:include href="layout-custom-fields-concepts.xsl"/>
  <xsl:include href="layout-custom-fields-date.xsl"/>

  <xsl:template mode="mode-dcat-ap" match="dct:spatial" priority="2000">
    <xsl:param name="schema" select="$schema" required="no"/>
    <xsl:param name="labels" select="$labels" required="no"/>
    <xsl:param name="refToDelete" required="no"/>

    <xsl:variable name="xpath" select="gn-fn-metadata:getXPath(.)"/>
    <xsl:variable name="labelConfig" select="gn-fn-metadata:getLabel($schema, name(), $labels, name(..), '', $xpath)"/>

    <xsl:call-template name="render-boxed-element">
      <xsl:with-param name="label" select="$labelConfig/label"/>
      <xsl:with-param name="editInfo" select="$refToDelete"/>
      <xsl:with-param name="cls" select="local-name()"/>
      <xsl:with-param name="subTreeSnippet">

        <xsl:variable name="identifier"
                      select="./dct:Location/@rdf:about"/>
        <xsl:variable name="description"
                      select="./dct:Location/skos:prefLabel[1]"/>
        <xsl:variable name="readonly" select="false()"/>
        <xsl:variable name="geometry" as="node()">
          <xsl:choose>
            <xsl:when test="count(./dct:Location/locn:geometry[ends-with(./dct:Location/@rdf:datatype,'#wktLiteral')])>0">
              <xsl:copy-of select="node()[name(./dct:Location)='locn:geometry' and ends-with(./dct:Location/@rdf:datatype,'#wktLiteral')][1]" />
            </xsl:when>
            <xsl:when test="count(./dct:Location/locn:geometry[ends-with(./dct:Location/@rdf:datatype,'#gmlLiteral')])>0">
              <xsl:copy-of select="node()[name(./dct:Location)='locn:geometry' and ends-with(./dct:Location/@rdf:datatype,'#gmlLiteral')][1]" />
            </xsl:when>
            <xsl:when test="dct:Location and dct:Location/locn:geometry">
              <xsl:copy-of select="./dct:Location/locn:geometry[1]"/>
            </xsl:when>
            <xsl:otherwise>
              <!-- Return empty nodes to trigger error later -->
              <xsl:copy-of select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="cleanedGeometry" as="node()">
          <xsl:apply-templates select="$geometry" mode="gn-element-cleaner"/>
        </xsl:variable>
        <xsl:variable name="bbox" select="gn-fn-dcat-ap:getBboxCoordinates($cleanedGeometry)"/>
        <xsl:variable name="bboxCoordinates" select="tokenize(replace($bbox,',','.'), '\|')"/>
        <xsl:if test="count($bboxCoordinates)>4">
          <div class="alert alert-danger">
            <p data-translate="invalidGeometryValue"/>
          </div>
        </xsl:if>
         <div gn-draw-bbox=""
              data-dc-ref="{concat('_',$geometry/gn:element/@ref)}"
              data-lang="lang"
              data-read-only="{$readonly}">
          <xsl:if test="$bbox != ''">
            <xsl:attribute name="data-hleft"
                           select="$bboxCoordinates[1]"/>
            <xsl:attribute name="data-hright"
                           select="$bboxCoordinates[3]"/>
            <xsl:attribute name="data-hbottom"
                           select="$bboxCoordinates[2]"/>
            <xsl:attribute name="data-htop"
                           select="$bboxCoordinates[4]"/>
          </xsl:if>
          <xsl:variable name="identifier">
            <xsl:choose>
              <xsl:when test="count($bboxCoordinates)>5"><xsl:value-of select="$bboxCoordinates[6]"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="./dct:Location/@rdf:about"/></xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="description">
            <xsl:choose>
              <xsl:when test="count($bboxCoordinates)>4"><xsl:value-of select="$bboxCoordinates[5]"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="./dct:Location/skos:prefLabel[1]"/></xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:attribute name="data-identifier" select="$identifier"/>
          <xsl:attribute name="data-identifier-ref" select="concat('_', ./dct:Location/gn:element/@ref,'_rdfCOLONabout')"/>
          <xsl:attribute name="data-identifier-tooltip" select="concat($schema, '|rdf:about|dct:Location|', $xpath, '/dct:Location/@rdf:about')"/>
          <xsl:attribute name="data-description" select="$description"/>
          <xsl:attribute name="data-description-ref" select="concat('_', ./dct:Location/skos:prefLabel[1]/gn:element/@ref)"/>
          <xsl:attribute name="data-description-tooltip" select="concat($schema, '|', 'skos:prefLabel|dcat:Dataset|', $xpath, '/dct:Location/skos:prefLabel')"/>
        </div>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>


  <xsl:template name="health-dcat-ap">

    <xsl:variable name="helper" as="node()*">
      <list key="Availability of a data access &amp; usage policy at the time of release of the dataset">
        <option value="0">No policy available</option>
        <option value="1">Basic policy available</option>
        <option value="2">Comprehensive policy available</option>
      </list>
      <list key="Average time from data access application to data release for a specific dataset">
        <option value="0">
          More than 6 months
        </option>
        <option value="1">
          3 to 6 months
        </option>
        <option value="2">
          1 to 3 months
        </option>
        <option value="3">
          Less than 1 month
        </option>
      </list>
      <list key="Coverage Rate (percentage of the eligible population represented in the dataset)">
        <option value="0">
          &lt;80%: Limited coverage
        </option>
        <option value="1">
          80-90%: Good coverage
        </option>
        <option value="2">
          90-95%: Very good coverage
        </option>
        <option value="3">
          95-100%: Near-universal or universal coverage
        </option>
      </list>
      <list key="How closely does the observed population represent the expected population?">
        <option value="0">
          No information on sampling methodology
        </option>
        <option value="1">
          Sampling information does not demonstrate the sample representativity
        </option>
        <option value="2">
          Sampling information demonstrates the sample representativity
        </option>
        <option value="3">
          Dataset contains all expected population
        </option>
      </list>
      <list key="Is there documentation of compliance with ethical standards, conventions, protocols or regulations?">
        <option value="0">
          No.
        </option>
        <option value="1">
          Documentation of applicable ethical standards, conventions, protocols or regulations, but no documentation of deviations or compliance.
        </option>
        <option value="2">
          Documentation of applicable ethical standards, conventions, protocols or regulations, as well as documentation of deviations or compliance.
        </option>
      </list>
      <list key="Is the source of the dataset documented?">
        <option value="0">
          No source is documented
        </option>
        <option value="1">
          Source is documented
        </option>
      </list>
      <list key="Are the processes and operations on the data documented?">
        <option value="0">
          No documentation on data processes and operations
        </option>
        <option value="1">
          Some documentation on data processes and operations but not complying with PROV-O standards
        </option>
        <option value="2">
          Full documentation on data processes and operations complying with PROV-O standards
        </option>
      </list>
      <list key="Existence of comprehensive standardised metadata">
        <option value="0">
          Non-standardised metadata
        </option>
        <option value="1">
          Partially complying with standardised metadata model (e.g. HealthDCAT-AP)
        </option>
        <option value="2">
          Fully complying with standardised metadata model (e.g. HealthDCAT-AP)
        </option>
      </list>
      <list key="Existence of an exhaustive data dictionary at variable level">
        <option value="0">
          No data dictionary
        </option>
        <option value="1">
          Partial data dictionary: some variables described with basic information (i.e., names and brief definitions)
        </option>
        <option value="2">
          Complete data dictionary: all variables described with detailed information (i.e., names, definitions, units, allowed values, etc.)
        </option>
      </list>
      <list key="Is accuracy of the dataset documented?">
        <option value="0">
          Accuracy not documented
        </option>
        <option value="1">
          Information on the efforts to ensure accuracy is provided (non statistical information provided)
        </option>
        <option value="2">
          Statistical information on accuracy is provided at variable and/or individual level
        </option>
      </list>
      <list key="Is coherence of the dataset documented?">
        <option value="0">
          Coherence not documented
        </option>
        <option value="1">
          Coherence documented for some entities, attributes and relations in the dataset
        </option>
        <option value="2">
          Coherence documented for all entities, attributes and relations in the dataset
        </option>
      </list>
      <list key="Is completeness of the dataset documented?">
        <option value="0">
          Completeness not documented
        </option>
        <option value="1">
          Some variables are analysed for completeness
        </option>
        <option value="2">
          All variables are analysed for completeness
        </option>
      </list>
      <list key="Is consistency of the dataset documented?">
        <option value="0">
          Consistency not documented
        </option>
        <option value="1">
          Consistency of some variables is documented
        </option>
        <option value="2">
          Consistency of all variables is documented
        </option>
      </list>
      <list key="Is precision of the dataset documented?">
        <option value="0">
          Precision not documented
        </option>
        <option value="1">
          Precision of some variables is documented
        </option>
        <option value="2">
          Precision of all variables is documented
        </option>
      </list>
      <list key="Availability of a conformance report for the data model">
        <option value="0">
          No report available
        </option>
        <option value="1">
          Report available for validity of some variables
        </option>
        <option value="2">
          Report available for validity of all variables
        </option>
      </list>
    </xsl:variable>


    <div class="row">
      <div class="col-md-12">
        <table class="table table-striped">
          <xsl:for-each select="../dqv:hasQualityMeasurement">
            <xsl:variable name="measure"
                          select="normalize-space(dqv:QualityMeasurement/dqv:isMeasurementOf/dqv:Metric/skos:definition)"/>
            <xsl:variable name="id" select="dqv:QualityMeasurement/dqv:value/gn:element/@ref"/>
            <xsl:variable name="value" select="dqv:QualityMeasurement/dqv:value"/>
            <tr>
              <td>
                <xsl:value-of select="$measure"/>
              </td>
              <td>
                <xsl:apply-templates select="dqv:QualityMeasurement/dqv:value" mode="mode-dcat-ap"/>
              </td>
              <td>
                <select onChange="$('#gn-field-{$id}').val(this.value)">
                  <option></option>
                  <xsl:for-each select="$helper[@key = $measure]/option">
                    <option>
                      <xsl:copy-of select="@*"/>
                      <xsl:if test="@value = $value">
                        <xsl:attribute name="selected" select="'selected'"/>
                      </xsl:if>
                      <xsl:value-of select="."/>
                    </option>
                  </xsl:for-each>
                </select>
              </td>
              <td>
                <xsl:call-template name="render-form-field-control-remove">
                  <xsl:with-param name="editInfo" select="gn:element"/>
                </xsl:call-template>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>
