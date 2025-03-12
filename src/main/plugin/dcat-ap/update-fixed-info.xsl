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
                xmlns:spdx="http://spdx.org/rdf/terms#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:adms="http://www.w3.org/ns/adms#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:dcatap="http://data.europa.eu/r5r/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:schema="http://schema.org/"
                xmlns:locn="http://www.w3.org/ns/locn#"
                xmlns:gml="http://www.opengis.net/gml"
                xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
                xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:mobilitydcatap="https://w3id.org/mobilitydcat-ap"
                xmlns:gn-fn-dcat-ap="http://geonetwork-opensource.org/xsl/functions/profiles/dcat-ap"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:uuid="java:java.util.UUID"
                extension-element-prefixes="saxon"
                version="2.0"
                exclude-result-prefixes="#all">

  <!-- Tell the XSL processor to output XML. -->
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:output name="default-serialize-mode" indent="no"
              omit-xml-declaration="yes"/>

  <xsl:include href="reorder-util.xsl"/>
  <xsl:include href="layout/utility-fn.xsl"/>
  <xsl:include href="update-fixed-info-variables.xsl"/>
  <xsl:include href="update-fixed-info-dcat-ap-vl.xsl"/>


  <!-- Ignore element not in main language (they are handled in dcat2-translations-builder. -->
  <xsl:template match="*[
                          count(*) = 0
                          and not(name() = $nonMultilingualElements)
                          and $isLanguageSet
                          and @xml:lang != $mainLanguage]"
                        priority="100">
  </xsl:template>

  <!-- Expand element which may not contain xml:lang attribute
  eg. when clicking + -->
  <xsl:template match="*[
                          count(*) = 0
                          and not(name() = $nonMultilingualElements)
                          and $isLanguageSet
                          and not(@rdf:resource)
                          and (not(@xml:lang) or not(string(@xml:lang)))]"
                        priority="105">
    <xsl:variable name="name"
                  select="name()"/>
    <xsl:variable name="value"
                  select="."/>
    <xsl:for-each select="$locales/lang/@code">
      <xsl:element name="{$name}">
        <xsl:attribute name="xml:lang"
                       select="current()"/>
        <xsl:value-of select="if (current() = $mainLanguage)
                              then $value else ''"/>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*[
                          count(*) = 0
                          and not(name() = $nonMultilingualElements)
                          and $isLanguageSet
                         and @xml:lang = $mainLanguage]"
                priority="100">
    <!-- Then we copy translations of following siblings
    or create empty elements. -->
    <xsl:variable name="name"
                  select="name(.)"/>
    <xsl:variable name="excluded"
                  select="gn-fn-dcat-ap:isNotMultilingualField(., $editorConfig)"/>
    <xsl:variable name="isMultilingualElement"
                  select="$isMultilingual and $excluded = false()"/>

    <xsl:choose>
      <xsl:when test="$isMultilingualElement">
        <xsl:call-template name="rdf-translations-builder"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- Copy existing translation
  and add empty elements for other languages -->
  <xsl:template name="rdf-translations-builder">
    <xsl:variable name="name"
                  select="name(.)"/>
    <xsl:variable name="value"
                  select="text()"/>

    <xsl:variable name="followingSiblings"
                         select="following-sibling::*[name() = $name and position() &lt;= count($locales/lang)]"/>

    <xsl:variable name="nextSiblingInMainLanguage"
                        select="($followingSiblings[@xml:lang = $mainLanguage])[1]"/>

    <xsl:variable name="nextSiblingId"
                        select="generate-id($nextSiblingInMainLanguage)"/>

    <xsl:variable name="nextSiblingPosition">
      <xsl:for-each select="$followingSiblings">
        <xsl:if test="generate-id() = $nextSiblingId">
          <xsl:value-of select="position()"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <!-- Select element with same name and different xml:lang attribute
    until the next one with the main language. -->
    <xsl:variable name="currentGroup" as="node()*"
                  select="if ($nextSiblingPosition castable as xs:integer)
                               then $followingSiblings[position() &lt; $nextSiblingPosition]
                               else $followingSiblings"/>

    <xsl:for-each select="$locales/lang/@code">
      <xsl:element name="{$name}">
        <xsl:attribute name="xml:lang"
                       select="current()"/>
        <xsl:value-of select="if (current() = $mainLanguage)
                              then $value else $currentGroup[@xml:lang = current()]"/>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="/root">

    <xsl:variable name="updated">
      <xsl:apply-templates select="//rdf:RDF"/>
    </xsl:variable>

    <xsl:variable name="profileUpdated">
      <xsl:apply-templates mode="update-fixed-info-profile" select="$updated"/>
    </xsl:variable>

    <xsl:call-template name="dcat-reorder-elements">
      <xsl:with-param name="rdfRoot" select="$profileUpdated"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="update-fixed-info-profile" match="@*|*" priority="-1">
    <xsl:copy copy-namespaces="yes">
      <xsl:apply-templates mode="update-fixed-info-profile" select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|*[name(.) != 'root']">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="rdf:RDF" priority="10">
    <xsl:copy copy-namespaces="no">
      <xsl:call-template name="add-namespaces"/>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="dcat:Catalog" priority="10">
    <dcat:Catalog>
      <xsl:attribute name="rdf:about">
        <xsl:value-of select="concat($resourcePrefix, '/catalogs/', $env/system/site/siteId)"/>
      </xsl:attribute>
      <dct:title xml:lang="{$mainLanguage}">
        <xsl:value-of select="concat('Open Data Catalogus van ', $env/system/site/organization)"/>
      </dct:title>
      <dct:description xml:lang="{$mainLanguage}">
        <xsl:value-of select="concat('Deze catalogus bevat datasets ontsloten door ', $env/system/site/organization)"/>
      </dct:description>
      <dct:identifier>
        <xsl:value-of select="$env/system/site/siteId"/>
      </dct:identifier>
      <dct:publisher>
        <!-- Organization in charge of the catalogue defined in the administration > system configuration -->
        <foaf:Agent rdf:about="{$resourcePrefix}/organizations/{encode-for-uri($env/system/site/organization)}">
          <foaf:name xml:lang="{$mainLanguage}">
            <xsl:value-of select="$env/system/site/organization"/>
          </foaf:name>
          <dct:type>
            <skos:Concept rdf:about="http://purl.org/adms/publishertype/LocalAuthority">
              <xsl:for-each select="$locales/lang/@code">
                <skos:prefLabel xml:lang="{.}">Lokaal bestuur</skos:prefLabel>
              </xsl:for-each>
              <skos:inScheme rdf:resource="http://purl.org/adms/publishertype/1.0"/>
            </skos:Concept>
          </dct:type>
        </foaf:Agent>
      </dct:publisher>
      <foaf:homepage>
        <foaf:Document>
          <xsl:if test="normalize-space($serviceUrl) != ''">
            <xsl:attribute name="rdf:about" select="$serviceUrl"/>
          </xsl:if>
          <foaf:name xml:lang="{$mainLanguage}"><xsl:value-of select="$env/system/site/name"/></foaf:name>
        </foaf:Document>
      </foaf:homepage>
      <dct:license>
        <dct:LicenseDocument rdf:about="https://data.vlaanderen.be/id/licentie/creative-commons-zero-verklaring/v1.0">
          <dct:type>
            <skos:Concept rdf:about="http://purl.org/adms/licencetype/PublicDomain">
              <xsl:for-each select="$locales/lang/@code">
                <skos:prefLabel xml:lang="{.}">Werk in het publiek domein</skos:prefLabel>
              </xsl:for-each>
              <skos:inScheme rdf:resource="http://purl.org/adms/licencetype/1.0"/>
            </skos:Concept>
          </dct:type>
          <dct:title xml:lang="{$mainLanguage}">Creative Commons Zero verklaring</dct:title>
          <dct:description xml:lang="{$mainLanguage}">De instantie doet afstand van haar intellectuele eigendomsrechten voor zover dit wettelijk mogelijk is. Hierdoor kan de gebruiker de data hergebruiken voor eender welk doel, zonder een verplichting op naamsvermelding. Deze is de welbekende CC0 licentie.</dct:description>
          <dct:identifier>https://data.vlaanderen.be/id/licentie/creative-commons-zero-verklaring/v1.0</dct:identifier>
        </dct:LicenseDocument>
      </dct:license>
      <dct:language>
        <skos:Concept rdf:about="http://publications.europa.eu/resource/authority/language/NLD">
          <rdf:type rdf:resource="http://purl.org/dc/terms/LinguisticSystem"/>
          <xsl:for-each select="$locales/lang/@code">
            <skos:prefLabel xml:lang="{.}">Nederlands</skos:prefLabel>
          </xsl:for-each>
          <skos:inScheme rdf:resource="http://publications.europa.eu/resource/authority/language"/>
        </skos:Concept>
      </dct:language>
      <dct:issued>
        <xsl:value-of select="'2019-09-01'"/>
      </dct:issued>
      <dct:modified>
        <xsl:value-of select="'2019-09-01'"/>
      </dct:modified>
      <xsl:for-each select="/root/gui/thesaurus/thesauri/thesaurus">
        <dcat:themeTaxonomy>
          <skos:ConceptScheme rdf:about="{$resourcePrefix}/registries/vocabularies/{key}">
            <dct:title xml:lang="{$iso2letterLanguageCode}">
              <xsl:value-of select="title"/>
            </dct:title>
            <foaf:isPrimaryTopicOf><xsl:value-of select="$serviceUrl"/>thesaurus.download?ref=<xsl:value-of
              select="key"/>
            </foaf:isPrimaryTopicOf>
          </skos:ConceptScheme>
        </dcat:themeTaxonomy>
      </xsl:for-each>
      <dcat:contactPoint>
        <vcard:Organization>
          <vcard:organization-name>
            <xsl:value-of select="$env/system/site/organization"/>
          </vcard:organization-name>
          <xsl:if test="normalize-space($env/system/site/organizationMail) != ''">
            <vcard:hasEmail rdf:resource="mailto:{normalize-space($env/system/site/organizationMail)}" />
          </xsl:if>
          <xsl:if test="normalize-space($env/system/site/organizationUrl) != ''">
            <vcard:hasURL rdf:resource="{normalize-space($env/system/site/organizationUrl)}" />
          </xsl:if>
        </vcard:Organization>
      </dcat:contactPoint>
      <xsl:choose>
        <xsl:when test="dcat:record/dcat:CatalogRecord">
          <xsl:apply-templates select="dcat:record"/>
        </xsl:when>
        <xsl:otherwise>
          <dcat:record>
            <dcat:CatalogRecord>
              <xsl:call-template name="handle-record-id"/>
              <dct:modified>
                <xsl:value-of select="if (matches(/root/env/changeDate, '^\d{4}-\d{2}-\d{2}$')) then format-date(/root/env/changeDate,'[Y0001]-[M01]-[D01]')
                  else if(/root/env/changeDate) then format-dateTime(/root/env/changeDate,'[Y0001]-[M01]-[D01]')
                  else dct:modified"/>
              </dct:modified>
            </dcat:CatalogRecord>
          </dcat:record>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="dcat:dataset|dcat:service"/>
    </dcat:Catalog>
  </xsl:template>


  <xsl:template match="dcat:CatalogRecord" priority="2">
    <xsl:copy copy-namespaces="no">
      <xsl:call-template name="handle-record-id"/>
      <dct:modified>
        <xsl:value-of select="if (matches(/root/env/changeDate, '^\d{4}-\d{2}-\d{2}$')) then format-date(/root/env/changeDate,'[Y0001]-[M01]-[D01]')
          else if(/root/env/changeDate) then format-dateTime(/root/env/changeDate,'[Y0001]-[M01]-[D01]')
          else dct:modified"/>
      </dct:modified>
      <xsl:apply-templates select="* except (dct:identifier|dct:modified|foaf:primaryTopic)"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="dcat:Dataset|dcat:DataService" priority="10">
     <xsl:copy copy-namespaces="no">
       <xsl:call-template name="handle-resource-id"/>
       <xsl:apply-templates select="* except dct:identifier"/>
     </xsl:copy>
  </xsl:template>

  <!-- Ensure Distribution has rdf:about and dct:identifier -->
  <xsl:template match="dcat:Distribution[name(..)='dcat:distribution'][count(dct:identifier[normalize-space() != '']) = 0 or normalize-space(@rdf:about) = '']" priority="10">
    <dcat:Distribution>
      <xsl:apply-templates select="@*"/>

      <xsl:variable name="distroUUID" select="uuid:randomUUID()"/>
      <xsl:if test="normalize-space(@rdf:about) = ''">
        <xsl:attribute name="rdf:about" select="concat(/root/env/nodeURL, 'resources/distributions/', $distroUUID)"/>
      </xsl:if>
      <xsl:if test="count(dct:identifier[normalize-space() != '']) = 0">
        <dct:identifier>
          <xsl:value-of select="$distroUUID"/>
        </dct:identifier>
      </xsl:if>

      <xsl:apply-templates select="* except dct:identifier"/>
    </dcat:Distribution>
  </xsl:template>

  <!-- Remove empty concepts -->
  <xsl:template match="*[skos:Concept and name() = $editorConfig/editor/fields/for[@use='thesaurus-list-picker']/@name]" priority="10">
    <xsl:choose>
      <xsl:when test="count(skos:Concept) = 1">
        <xsl:copy copy-namespaces="no">
          <xsl:apply-templates select="skos:Concept"/>
        </xsl:copy>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates select="*"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Fill concepts with resourceType -->
  <xsl:template match="skos:Concept" priority="10">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="@*"/>
      <xsl:variable name="rdfType" select="gn-fn-dcat-ap:getRdfTypeByElementName(name(..), name(../..))"/>
      <xsl:if test="normalize-space($rdfType) != ''">
        <rdf:type rdf:resource="{$rdfType}"/>
      </xsl:if>
      <xsl:apply-templates select="*[not(name() = 'rdf:type')]"/>
    </xsl:copy>
  </xsl:template>

  <!-- Fix value for attribute -->
  <xsl:template match="rdf:Statement/rdf:object" priority="10">
    <xsl:copy copy-namespaces="no">
      <xsl:copy-of select="@*[name() != 'rdf:datatype']"/>
      <xsl:attribute name="rdf:datatype">xs:dateTime</xsl:attribute>
    </xsl:copy>
  </xsl:template>

  <!-- Fix value for attribute -->
  <xsl:template match="dct:created|dct:issued|dct:modified|schema:startDate|schema:endDate" priority="10">
    <xsl:copy copy-namespaces="no">
      <xsl:copy-of select="@*[name() != 'rdf:datatype']"/>
      <xsl:attribute name="rdf:datatype">
        <xsl:if test="not(contains(lower-case(.),'t'))">http://www.w3.org/2001/XMLSchema#date</xsl:if>
        <xsl:if test="contains(lower-case(.),'t')">http://www.w3.org/2001/XMLSchema#dateTime</xsl:if>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:copy>
  </xsl:template>

  <!-- Normalize bbox -->
  <xsl:template match="dct:Location" priority="10">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="@*"/>
      <xsl:variable name="coverage">
        <xsl:choose>
          <xsl:when test="count(locn:geometry[ends-with(@rdf:datatype, '#wktLiteral')])>0">
            <xsl:value-of select="locn:geometry[ends-with(@rdf:datatype, '#wktLiteral')][1]"/>
          </xsl:when>
          <xsl:when test="count(locn:geometry[ends-with(@rdf:datatype, '#gmlLiteral')])>0">
            <xsl:value-of select="locn:geometry[ends-with(@rdf:datatype, '#gmlLiteral')][1]"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="locn:geometry[1]"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="n" select="substring-after($coverage, 'North ')"/>
      <xsl:if test="string-length($n)=0">
        <xsl:copy-of select="node()"/>
      </xsl:if>
      <xsl:if test="string-length($n)>0">
        <xsl:variable name="north" select="substring-before($n, ',')"/>
        <xsl:variable name="s" select="substring-after($coverage, 'South ')"/>
        <xsl:variable name="south" select="substring-before($s, ',')"/>
        <xsl:variable name="e" select="substring-after($coverage, 'East ')"/>
        <xsl:variable name="east" select="substring-before($e, ',')"/>
        <xsl:variable name="w" select="substring-after($coverage, 'West ')"/>
        <xsl:variable name="west" select="if (contains($w, '. ')) then substring-before($w, '. ') else $w"/>
        <xsl:variable name="isValid" select="number($west) and number($east) and number($south) and number($north)"/>
        <xsl:if test="$isValid">
          <xsl:variable name="wktLiteral" select="concat('POLYGON ((',$west,' ',$south,',',$west,' ',$north,',',$east,' ',$north,',', $east,' ', $south,',', $west,' ',$south,'))')"/>
          <xsl:variable name="gmlLiteral" select="concat('&lt;gml:Polygon&gt;&lt;gml:exterior&gt;&lt;gml:LinearRing&gt;&lt;gml:posList&gt;',$south,' ',$west,' ',$north,' ', $west, ' ', $north, ' ', $east, ' ', $south, ' ', $east,' ', $south, ' ', $west, '&lt;/gml:posList&gt;&lt;/gml:LinearRing&gt;&lt;/gml:exterior&gt;&lt;/gml:Polygon&gt;')"/>
          <xsl:element name="locn:geometry">
            <xsl:attribute name="rdf:datatype">http://www.opengis.net/ont/geosparql#wktLiteral</xsl:attribute>
            <xsl:value-of select="$wktLiteral"/>
          </xsl:element>
          <xsl:element name="locn:geometry">
            <xsl:attribute name="rdf:datatype">http://www.opengis.net/ont/geosparql#gmlLiteral</xsl:attribute>
            <xsl:value-of select="$gmlLiteral"/>
          </xsl:element>
        </xsl:if>
        <xsl:if test="not($isValid)">
          <xsl:element name="locn:geometry">
            <xsl:attribute name="rdf:datatype">http://www.opengis.net/ont/geosparql#wktLiteral</xsl:attribute>
          </xsl:element>
          <xsl:element name="locn:geometry">
            <xsl:attribute name="rdf:datatype">http://www.opengis.net/ont/geosparql#gmlLiteral</xsl:attribute>
          </xsl:element>
        </xsl:if>
        <xsl:apply-templates select="node()[name(.) != 'locn:geometry']"/>
      </xsl:if>
    </xsl:copy>
  </xsl:template>

  <!-- Remove all empty rdf:about to avoid invalid RDF syntax -->
  <xsl:template match="@rdf:about[normalize-space() = '']|@rdf:datatype[normalize-space() = '']"
                priority="10"/>

  <xsl:template match="dct:format[count(@*|*) = 0]|dcat:theme[count(@rdf:*|*) = 0]"
                priority="100"/>

  <!-- Fix value for attribute -->
  <xsl:template match="spdx:checksumValue" priority="10">
    <xsl:copy copy-namespaces="no">
      <xsl:copy-of select="@*[name() != 'rdf:datatype']"/>
      <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#hexBinary</xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:copy>
  </xsl:template>

  <!-- Fix value for attribute -->
  <xsl:template match="spdx:algorithm" priority="10">
    <spdx:algorithm rdf:resource="http://spdx.org/rdf/terms#checksumAlgorithm_sha1"/>
  </xsl:template>

  <!-- Add "mailto:" prefix on mail adresses -->
  <xsl:template match="vcard:hasEmail[not(starts-with(@rdf:resource, 'mailto:')) and normalize-space(@rdf:resource) != '']" priority="10">
    <xsl:copy copy-namespaces="no">
      <xsl:attribute name="rdf:resource" select="concat('mailto:', @rdf:resource)"/>
    </xsl:copy>
  </xsl:template>

  <!-- Automatically set license identifier based on license URL -->
  <xsl:template match="dct:LicenseDocument" priority="10">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="@*|*[name() != 'dct:identifier']"/>

      <xsl:element name="dct:identifier">
        <xsl:value-of select="@rdf:about"/>
      </xsl:element>
    </xsl:copy>
  </xsl:template>

  <!-- Force dct:Standard dct:identifier value -->
  <xsl:template match="dct:Standard[not(dct:identifier)]" priority="9">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="@*"/>
      <dct:identifier>
        <xsl:value-of select="@rdf:about"/>
      </dct:identifier>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="dcat:CatalogRecord/dct:conformsTo/dct:Standard/dct:title" priority="10">
    <dct:title>
      <xsl:apply-templates select="@*"/>
      <xsl:value-of select="concat(upper-case(substring(., 1, 1)), lower-case(substring(., 2)))"/>
    </dct:title>
  </xsl:template>

  <xsl:template name="handle-record-id">
    <xsl:apply-templates select="@*[name() != 'rdf:about']"/>
    <xsl:attribute name="rdf:about" select="$recordAbout"/>
    <xsl:element name="dct:identifier">
      <xsl:value-of select="$recordUUID"/>
    </xsl:element>
    <xsl:element name="foaf:primaryTopic">
      <xsl:attribute name="rdf:resource" select="$resourceAbout"/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="handle-resource-id">
    <xsl:apply-templates select="@*[name() != 'rdf:about']"/>
    <xsl:attribute name="rdf:about" select="$resourceAbout"/>
    <xsl:element name="dct:identifier">
      <xsl:value-of select="$resourceUUID"/>
    </xsl:element>
    <xsl:apply-templates select="dct:identifier[string() != $resourceUUID]"/>
  </xsl:template>


  <xsl:template name="add-namespaces">
    <xsl:namespace name="rdf" select="'http://www.w3.org/1999/02/22-rdf-syntax-ns#'"/>
    <xsl:namespace name="skos" select="'http://www.w3.org/2004/02/skos/core#'"/>
    <xsl:namespace name="spdx" select="'http://spdx.org/rdf/terms#'"/>
    <xsl:namespace name="owl" select="'http://www.w3.org/2002/07/owl#'"/>
    <xsl:namespace name="adms" select="'http://www.w3.org/ns/adms#'"/>
    <xsl:namespace name="locn" select="'http://www.w3.org/ns/locn#'"/>
    <xsl:namespace name="xsi" select="'http://www.w3.org/2001/XMLSchema-instance'"/>
    <xsl:namespace name="foaf" select="'http://xmlns.com/foaf/0.1/'"/>
    <xsl:namespace name="dct" select="'http://purl.org/dc/terms/'"/>
    <xsl:namespace name="vcard" select="'http://www.w3.org/2006/vcard/ns#'"/>
    <xsl:namespace name="dcat" select="'http://www.w3.org/ns/dcat#'"/>
    <xsl:namespace name="schema" select="'http://schema.org/'"/>
    <xsl:namespace name="dc" select="'http://purl.org/dc/elements/1.1/'"/>
    <xsl:namespace name="dcatap" select="'http://data.europa.eu/r5r/'"/>
    <xsl:namespace name="mdcat" select="'https://data.vlaanderen.be/ns/metadata-dcat#'"/>
    <xsl:namespace name="mobilitydcatap" select="'https://w3id.org/mobilitydcat-ap'"/>
  </xsl:template>
</xsl:stylesheet>
