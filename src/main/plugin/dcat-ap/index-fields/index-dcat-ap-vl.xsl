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
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:schema="http://schema.org/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
                xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:locn="http://www.w3.org/ns/locn#"
                xmlns:gn-fn-index="http://geonetwork-opensource.org/xsl/functions/index"
                xmlns:index="java:org.fao.geonet.kernel.search.EsSearchManager"
                xmlns:date-util="java:org.fao.geonet.utils.DateUtil"
                xmlns:util="java:org.fao.geonet.util.XslUtil"
                xmlns:geodcat="http://data.europa.eu/930/"
                xmlns:saxon="http://saxon.sf.net/" xmlns:xls="http://www.w3.org/1999/XSL/Transform"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all"
                version="2.0">


  <xsl:template mode="index-extra-fields"
                match="rdf:RDF[dcat:Catalog/dcat:record/dcat:CatalogRecord/dct:conformsTo/dct:Standard/@rdf:about='https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03']">

    <xsl:call-template name="index-dcat-ap-vl-license"/>

    <xsl:apply-templates mode="index-dcat-ap-vl" select="descendant::dcat:DataService"/>
  </xsl:template>


  <xsl:template name="index-dcat-ap-vl-license">
    <xsl:for-each select="descendant::dcat:Dataset|descendant::dcat:DataService">
      <xsl:variable name="constraints">
        <xsl:for-each-group select="dct:license|dcat:distribution/dcat:Distribution/dct:license"
                            group-by="dct:LicenseDocument/@rdf:about">
          <xsl:apply-templates mode="index-license" select="current-group()[1]"/>
        </xsl:for-each-group>
        <xsl:for-each select="dct:accessRights">
          <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat-ap('MD_LegalConstraintsOtherConstraints', skos:Concept, $allLanguages, false())"/>
        </xsl:for-each>
      </xsl:variable>
      <xsl:copy-of select="$constraints"/>
      <vlResourceConstraintsObject type="object">
        [{
        "type": "MD_LegalConstraints",
        "otherConstraintsObject": [
        <xsl:for-each select="$constraints/*[name() = ('licenseObject', 'MD_LegalConstraintsOtherConstraintsObject')]">
          <xsl:copy-of select="string()"/>
          <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ]
        }]
      </vlResourceConstraintsObject>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="index-dcat-ap-vl" match="dcat:DataService">
    <xsl:for-each select="(dcat:servesDataset/@rdf:resource|dcat:servesDataset/dcat:Dataset/@rdf:about)[normalize-space() != '']">
      <recordOperateOn>
        <xsl:value-of select="string()"/>
      </recordOperateOn>
    </xsl:for-each>

    <xsl:for-each select="./mdcat:levensfase">
      <lifeCycle type="object">
        <xsl:value-of select="gn-fn-index:add-multilingual-field-dcat-ap('lifeCycle', skos:Concept, $allLanguages, false(), true())/text()"/>
      </lifeCycle>
    </xsl:for-each>

    <xsl:for-each select="./mdcat:ontwikkelingstoestand">
      <developmentState type="object">
        <xsl:value-of select="gn-fn-index:add-multilingual-field-dcat-ap('developmentState', skos:Concept, $allLanguages, false(), true())/text()"/>
      </developmentState>
    </xsl:for-each>
  </xsl:template>


</xsl:stylesheet>
