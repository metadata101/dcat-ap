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
                xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:geonet="http://www.fao.org/geonetwork">

  <xsl:param name="thesauriDir"/>

  <xsl:variable name="uuidRegex" select="'^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$'"/>
  <xsl:variable name="protocolConcepts" select="document('../thesauri/theme/protocol.rdf')/rdf:RDF"/>

  <!-- The main metadata language -->
  <xsl:variable name="isoDocLangId">
    <xsl:call-template name="langId-dcat2"/>
  </xsl:variable>

  <xsl:template name="document">
    <xsl:param name="catalogRecord"/>
    <xsl:param name="datasetOrDataservice"/>
    <xsl:param name="isoLangId"/>

    <Document locale="{$isoLangId}">

      <xsl:variable name="langId">
        <xsl:call-template name="langId3to2">
          <xsl:with-param name="langId-3char" select="$isoLangId" />
        </xsl:call-template>
      </xsl:variable>
      <Field name="_locale" string="{$isoLangId}" store="true" index="true"/>
      <Field name="_docLocale" string="{$isoLangId}" store="true" index="true"/>
      <Field name="_locale2" string="{$langId}" store="true" index="true"/>
      <xsl:apply-templates select="$catalogRecord">
        <xsl:with-param name="langId" select="$langId"/>
        <xsl:with-param name="isoLangId" select="$isoLangId"/>
      </xsl:apply-templates>
      <xsl:for-each select="$datasetOrDataservice">
        <xsl:apply-templates select=".">
          <xsl:with-param name="langId" select="$langId"/>
          <xsl:with-param name="isoLangId" select="$isoLangId"/>
        </xsl:apply-templates>
      </xsl:for-each>
    </Document>

  </xsl:template>

  <xsl:template mode="index" match="*|@*">
    <xsl:param name="isoLangId"/>
    <xsl:param name="langId"/>
    <xsl:apply-templates mode="index" select="*|@*">
      <xsl:with-param name="langId" select="$langId"/>
      <xsl:with-param name="isoLangId" select="$isoLangId"/>
    </xsl:apply-templates>
  </xsl:template>


  <xsl:template match="dcat:CatalogRecord">
    <xsl:param name="isoLangId"/>
    <xsl:param name="langId"/>
    <xsl:for-each select="dct:conformsTo/dct:Standard">
      <xsl:variable name="title">
        <xsl:call-template name="index-lang-tag-oneval">
          <xsl:with-param name="tag" select="dct:title[normalize-space() != ''][1]"/>
          <xsl:with-param name="langId" select="$langId"/>
          <xsl:with-param name="isoLangId" select="$isoLangId"/>
        </xsl:call-template>
      </xsl:variable>
      <Field name="standardName" string="{string($title)}"
             store="true" index="true"/>
    </xsl:for-each>

    <xsl:for-each select="dct:identifier">
      <Field name="fileId" string="{string(.)}" store="false" index="true"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="dcat:Dataset|dcat:DataService">
    <xsl:param name="isoLangId"/>
    <xsl:param name="langId"/>

    <!-- === Free text search === -->
    <Field name="any" store="false" index="true">
      <xsl:attribute name="string">
        <xsl:value-of select="normalize-space(concat(string(../../dcat:record/dcat:CatalogRecord), ' ', string(.)))"/>
      </xsl:attribute>
    </Field>

    <Field name="anylight" store="false" index="true">
      <xsl:attribute name="string">
        <xsl:for-each select=".//dct:title|
                              .//dct:description|
                              .//dcat:keyword|
                              .//foaf:name">
          <xsl:variable name="value">
            <xsl:call-template name="index-lang-tag-oneval">
              <xsl:with-param name="tag" select="."/>
              <xsl:with-param name="langId" select="$langId"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="$value!=''">
            <xsl:value-of select="concat($value, ' ')"/>
          </xsl:if>
        </xsl:for-each>
        <xsl:for-each select=".//vcard:organization-name">
          <xsl:value-of select="concat(., ' ')"/>
        </xsl:for-each>
        <xsl:for-each select=".//dct:type[name(..)='foaf:Agent']|
                              .//dcat:theme|
                              .//dct:accrualPeriodicity|
                              .//dct:language|
                              .//dct:type[name(..)='dcat:Dataset']|
                              .//dct:type[name(..)='dcat:DataService']|
                              .//dct:format|
                              .//dcat:mediaType|
                              .//adms:status|
                              .//dct:accessRights|
                              .//dct:type[name(..)='dct:LicenseDocument']">
          <xsl:if test="skos:Concept/skos:prefLabel/@xml:lang=$langId">
            <xsl:variable name="prefLabel">
              <xsl:call-template name="index-lang-tag-oneval">
                <xsl:with-param name="tag" select="."/>
                <xsl:with-param name="langId" select="$langId"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:if test="$prefLabel!=''">
              <xsl:value-of select="concat($prefLabel, ' ')"/>
            </xsl:if>
          </xsl:if>
        </xsl:for-each>
      </xsl:attribute>

    </Field>

    <xsl:for-each select="distinct-values(//dcat:dataset/dcat:Dataset/dct:title/@xml:lang|//dcat:service/dcat:DataService/dct:title/@xml:lang)">
      <xsl:variable name="mdLanguage">
        <xsl:call-template name="langId2to3">
          <xsl:with-param name="langId-2char" select="."/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="not($mdLanguage='')">
        <Field name="language" string="{string($mdLanguage)}" store="true" index="true"/>
        <Field name="mdLanguage" string="{string($mdLanguage)}" store="true" index="true"/>
      </xsl:if>
    </xsl:for-each>

    <xsl:choose>
      <xsl:when test="name() = 'dcat:Dataset'">
        <Field name="type" string="dataset" store="true" index="true"/>
      </xsl:when>
      <xsl:when test="name() = 'dcat:DataService'">
        <Field name="type" string="service" store="true" index="true" />

        <xsl:for-each select="dct:conformsTo/dct:Standard">
          <xsl:choose>
            <xsl:when test="dct:title[@xml:lang = $langId]">
              <Field name="serviceProtocol" string="{dct:title[@xml:lang = $langId][1]}" store="true" index="true"/>
            </xsl:when>
            <xsl:when test="dct:title[not(@xml:lang)]">
              <Field name="serviceProtocol" string="{dct:title[not(@xml:lang)][1]}" store="true" index="true"/>
            </xsl:when>
            <xsl:otherwise>
              <Field name="serviceProtocol" string="{dct:title[1]}" store="true" index="true"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates mode="index-protocol" select="."/>
        </xsl:for-each>
      </xsl:when>
    </xsl:choose>

    <xsl:variable name="_defaultTitle">
      <xsl:call-template name="defaultTitle">
        <xsl:with-param name="isoDocLangId" select="$isoLangId"/>
      </xsl:call-template>
    </xsl:variable>
    <Field name="_defaultTitle" string="{string($_defaultTitle)}" store="true" index="true"/>

    <xsl:variable name="_defaultAbstract">
      <xsl:call-template name="defaultAbstract">
        <xsl:with-param name="isoDocLangId" select="$isoLangId"/>
      </xsl:call-template>
    </xsl:variable>
    <Field name="_defaultAbstract" string="{string($_defaultAbstract)}" store="true" index="true"/>

    <!-- This is needed by the CITE test script to look for strings like 'a
            b*' strings that contain spaces -->
    <xsl:variable name="tmp_title">
      <xsl:call-template name="index-lang-tag-oneval">
        <xsl:with-param name="tag" select="dct:title"/>
        <xsl:with-param name="langId" select="$langId"/>
        <xsl:with-param name="isoLangId" select="$isoLangId"/>
      </xsl:call-template>
    </xsl:variable>
    <Field name="title" string="{string($tmp_title)}" store="true" index="true"/>
    <!-- not tokenized title for sorting -->
    <Field name="_title" string="{string($tmp_title)}" store="false" index="true"/>

    <xsl:variable name="tmp_abstract">
      <xsl:call-template name="index-lang-tag-oneval">
        <xsl:with-param name="tag" select="dct:description"/>
        <xsl:with-param name="langId" select="$langId"/>
        <xsl:with-param name="isoLangId" select="$isoLangId"/>
      </xsl:call-template>
    </xsl:variable>
    <Field name="abstract" string="{string($tmp_abstract)}" store="true" index="true"/>
    <Field name="_abstract" string="{string($tmp_abstract)}" store="false" index="true"/>

    <xsl:for-each select="dct:identifier">
      <Field name="identifier" string="{string(.)}" store="true" index="true"/>
      <Field name="fileId" string="{string(.)}" store="false" index="true" />
    </xsl:for-each>

    <xsl:variable name="sortDate">
      <xsl:for-each select="dct:*[name()=('dct:modified','dct:created','dct:issued') and .!='' and not(contains(.,'1900') or contains(.,'1753'))]">
        <xsl:sort select="gn-fn-index:formatDateTime(string(.))" order="descending"/>
        <xsl:if test="position()=1">
          <xsl:value-of select="gn-fn-index:formatDateTime(string(.))"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <xsl:if test="string-length(normalize-space($sortDate))>0">
      <Field name="sortDate" string="{$sortDate}" store="true" index="true"/>
      <Field name="_sortDate" string="{$sortDate}" store="true" index="true"/>
    </xsl:if>

    <xsl:if test="string-length(normalize-space($sortDate))=0">
      <Field name="sortDate" string="-1" store="true" index="true"/>
      <Field name="_sortDate" string="-1" store="true" index="true"/>
    </xsl:if>

    <xsl:for-each select="dct:modified[.!='' and not(contains(.,'1900') or contains(.,'1753'))]">
      <Field name="revisionDate" string="{string(.)}" store="true"
             index="true"/>
      <Field name="createDateMonth"
             string="{substring(., 0, 8)}" store="true"
             index="true"/>
      <Field name="createDateYear" string="{substring(., 0, 5)}" store="true"
             index="true"/>
    </xsl:for-each>

    <xsl:for-each select="dct:created[.!='' and not(contains(.,'1900') or contains(.,'1753'))]">
      <Field name="createDate" string="{string(.)}" store="true"
             index="true"/>
      <Field name="createDateMonth"
             string="{substring(., 0, 8)}" store="true"
             index="true"/>
      <Field name="createDateYear" string="{substring(., 0, 5)}" store="true"
             index="true"/>
    </xsl:for-each>

    <xsl:for-each select="dct:issued[.!='' and not(contains(.,'1900') or contains(.,'1753'))]">
      <Field name="publicationDate" string="{string(.)}" store="true"
             index="true"/>
    </xsl:for-each>

    <xsl:for-each select="distinct-values(dct:language/skos:Concept/@rdf:about)">
      <xsl:variable name="datasetLanguage">
        <xsl:call-template name="interpretLanguage">
          <xsl:with-param name="input" select="."/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="not($datasetLanguage='')">
        <Field name="datasetLang" string="{$datasetLanguage}" store="true" index="true"/>
      </xsl:if>
    </xsl:for-each>

    <xsl:for-each select="dct:type">
      <Field name="type" string="{string(.)}" store="true" index="true"/>
    </xsl:for-each>
    <xsl:for-each select="dct:source">
      <Field name="lineage" string="{string(.)}" store="true" index="true"/>
    </xsl:for-each>
    <xsl:for-each select="dct:relation">
      <Field name="relation" string="{string(.)}" store="false"
             index="true"/>
    </xsl:for-each>

    <xsl:for-each select="dcat:landingPage/@rdf:resource">
      <Field name="groupWebsite" string="{string(.)}"
             store="true" index="true"/>
    </xsl:for-each>


    <xsl:for-each select="dct:rights">
      <Field name="MD_LegalConstraintsUseLimitation" string="{string(.)}"
             store="true" index="true"/>
    </xsl:for-each>
    <xsl:for-each select="dct:spatial">
      <xsl:if test="count(dct:Location/locn:geometry) &gt; 0">
        <xsl:apply-templates
          select="dct:Location"
          mode="latLon"/>
        <xsl:call-template name="index-lang-tag">
          <xsl:with-param name="tag" select="dct:Location/skos:prefLabel"/>
          <xsl:with-param name="field" select="'extentDesc'"/>
          <xsl:with-param name="langId" select="$langId"/>
        </xsl:call-template>
      </xsl:if>
      <Field name="geoDescCode" string="{string(dct:Location/@rdf:about)}" store="true" index="true"/>
    </xsl:for-each>


    <xsl:variable name="startDate" select="dct:temporal/dct:PeriodOfTime/schema:startDate"/>
    <xsl:variable name="endDate" select="dct:temporal/dct:PeriodOfTime/schema:endDate"/>
    <xsl:if test="$startDate">
      <Field name="tempExtentBegin"
             string="{string($startDate[1])}"
             store="true" index="true"/>
    </xsl:if>
    <xsl:if test="$endDate">
      <Field name="tempExtentEnd"
             string="{string($endDate[last()])}"
             store="true" index="true"/>
    </xsl:if>

    <xsl:call-template name="index-lang-tag">
      <xsl:with-param name="tag" select="dct:accessRights"/>
      <xsl:with-param name="field" select="'MD_ConstraintsUseLimitation'"/>
      <xsl:with-param name="langId" select="$langId"/>
    </xsl:call-template>

    <xsl:for-each select="dcat:keyword">
      <Field name="keyword" string="{.}" store="true" index="true"/>
    </xsl:for-each>

    <xsl:for-each select="dct:subject|mdcat:MAGDA-categorie|mdcat:statuut|dcat:theme">
      <xsl:variable name="scheme" select="skos:Concept/skos:inScheme/@rdf:resource"/>
      <xsl:variable name="theme" select="if (skos:Concept/skos:prefLabel[@xml:lang='nl']) then skos:Concept/skos:prefLabel[@xml:lang='nl'] else skos:Concept/skos:prefLabel[@xml:lang=$langId]"/>
      <Field name="keyword" string="{$theme}" store="true" index="true"/>
      <xsl:if test="normalize-space($theme) != ''">
        <xsl:choose>
          <xsl:when test="$scheme = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden' or name() = 'mdcat:statuut'">
            <Field name="flanderskeyword" string="{$theme}" store="true" index="true"/>
            <xsl:if test="lower-case($theme) = ('vlaamse open data', 'vlaamse open data service', 'lijst m&amp;r inspire', 'toegevoegd gdi-vl')">
              <Field name="statute" string="{$theme}" store="true" index="true"/>
            </xsl:if>
          </xsl:when>
          <xsl:when test="$scheme = 'http://vocab.belgif.be/auth/datatheme'">
            <Field name="dataGovKeyword" string="{$theme}" store="true" index="true"/>
          </xsl:when>
        </xsl:choose>
      </xsl:if>
    </xsl:for-each>

    <xsl:variable name="openKeywords" select="*[name() = ('dct:subject', 'mdcat:statuut') and
      skos:Concept/@rdf:about = ('https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATA', 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATASERVICE')
    ]"/>
    <xsl:variable name="isOpenData" select="if (count($openKeywords) > 0) then 'y' else 'n'"/>
    <Field name="isOpenData" string="{$isOpenData}" store="true" index="true"/>
    <xsl:if test="$isOpenData = 'y'">
      <Field name="domain" string="Open data" store="true" index="true" />
    </xsl:if>

    <xsl:variable name="geoKeywords" select="*[name() = ('dct:subject', 'mdcat:statuut') and
      skos:Concept/@rdf:about = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/GEODATA'
    ]"/>
    <xsl:variable name="isGeoData" select="if (count($geoKeywords) > 0) then 'y' else 'n'"/>
    <Field name="isGeoData" string="{$isGeoData}" store="true" index="true"/>
    <xsl:if test="$isGeoData = 'y'">
      <Field name="domain" string="Geografisch" store="true" index="true" />
    </xsl:if>

    <xsl:variable name="listOfKeywords">{
      <xsl:variable name="keywordWithNoThesaurus"
                    select="dcat:keyword[@xml:lang=$langId]"/>
      <xsl:variable name="themes"
                    select="dcat:theme/skos:Concept"/>
      <xsl:if test="count($keywordWithNoThesaurus) > 0">
        'keywords': [
        <xsl:for-each select="$keywordWithNoThesaurus">
          {'value': <xsl:value-of select="concat('''', replace(., '''', '\\'''), '''')"/>,
          'link': ''}
          <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ]
        <xsl:if test="count($themes) > 0">,</xsl:if>
      </xsl:if>
      <xsl:if test="count($themes) > 0">
        'theme': [
        <xsl:for-each select="$themes">
          {'value': <xsl:value-of select="concat('''', replace(skos:prefLabel[@xml:lang=$langId][1], '''', '\\'''), '''')"/>,
          'link': ''}
          <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ]
      </xsl:if>
      }
    </xsl:variable>

    <Field name="keywordGroup"
           string="{normalize-space($listOfKeywords)}"
           store="true"
           index="false"/>

    <xsl:for-each select="dcat:distribution/dcat:Distribution">
      <xsl:variable name="tPosition" select="position()"/>

      <xsl:variable name="title">
        <xsl:call-template name="index-lang-tag-oneval">
          <xsl:with-param name="tag" select="dct:title"/>
          <xsl:with-param name="langId" select="$langId"/>
          <xsl:with-param name="isoLangId" select="$isoLangId"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="desc">
        <xsl:call-template name="index-lang-tag-oneval">
          <xsl:with-param name="tag" select="dct:description"/>
          <xsl:with-param name="langId" select="$langId"/>
          <xsl:with-param name="isoLangId" select="$isoLangId"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="format">
        <xsl:call-template name="index-lang-tag-oneval">
          <xsl:with-param name="tag" select="dct:format"/>
          <xsl:with-param name="langId" select="$langId"/>
          <xsl:with-param name="isoLangId" select="$isoLangId"/>
        </xsl:call-template>
      </xsl:variable>
      <Field name="format" string="{string($format)}" store="true" index="true"/>

      <xsl:for-each select="dcat:downloadURL">
        <xsl:variable name="downloadURLlinkage" select="string(@rdf:resource)"/>

        <Field name="link"
               string="{concat($title, '|', $desc, '|', $downloadURLlinkage,'|WWW:DOWNLOAD-1.0-http--download|WWW:DOWNLOAD-1.0-http--download|', $tPosition, '1', position())}"
               store="true" index="true"/>
      </xsl:for-each>

      <xsl:for-each select="dcat:accessURL">
        <xsl:variable name="accessURLlinkage" select="string(@rdf:resource)"/>

        <Field name="link"
               string="{concat($title, '|', $desc, '|', $accessURLlinkage,'|WWW:DOWNLOAD-1.0-http--download|WWW:DOWNLOAD-1.0-http--download|', $tPosition, '2', position())}"
               store="true" index="true"/>
      </xsl:for-each>

      <xsl:for-each select="dct:license/dct:LicenseDocument">
        <xsl:variable name="title">
          <xsl:if test="dct:title">
            <xsl:value-of select="normalize-space(dct:title)"/>
          </xsl:if>
        </xsl:variable>
        <xsl:variable name="tag">
          <xsl:choose>
            <xsl:when test="$title != ''">
              <xsl:value-of select="$title"/>
            </xsl:when>
            <xsl:when test="@rdf:about and @rdf:about!=''">
              <xsl:call-template name="getLicenseDocumentTitle">
                <xsl:with-param name="rdfAbout" select="lower-case(@rdf:about)"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="tmp_license">
          <xsl:call-template name="index-lang-tag-oneval">
            <xsl:with-param name="tag" select="$tag"/>
            <xsl:with-param name="langId" select="$langId"/>
            <xsl:with-param name="isoLangId" select="$isoLangId"/>
          </xsl:call-template>
        </xsl:variable>
        <Field name="MD_LegalConstraintsUseLimitation" string="{string($tmp_license)}" store="true" index="true"/>
        <xsl:if test="$title != ''">
          <Field name="license" string="{$title}" store="true" index="true"/>
        </xsl:if>
      </xsl:for-each>
      <xsl:apply-templates mode="index-protocol" select="dct:conformsTo/dct:Standard"/>

    </xsl:for-each>

    <xsl:for-each
      select="adms:sample[normalize-space(dcat:Distribution/dcat:downloadURL/@rdf:resource) != '']">
      <xsl:variable name="fileName" select="dcat:Distribution/dcat:downloadURL/@rdf:resource"/>
      <xsl:variable name="fileDescr" select="dct:title"/>
      <xsl:variable name="thumbnailType"
                    select="if (position() = 1) then 'thumbnail' else 'overview'"/>
      <!-- First thumbnail is flagged as thumbnail and could be considered the main one -->
      <Field name="image"
             string="{concat($thumbnailType, '|', $fileName, '|', $fileDescr)}"
             store="true" index="false"/>
    </xsl:for-each>

    <xsl:for-each select="dcat:contactPoint">
      <xsl:apply-templates mode="index-contact" select="vcard:Organization">
        <xsl:with-param name="type" select="'resource'"/>
        <xsl:with-param name="fieldPrefix" select="'responsibleParty'"/>
        <xsl:with-param name="position" select="position()"/>
      </xsl:apply-templates>
    </xsl:for-each>

    <xsl:for-each select="dct:isPartOf">
      <Field name="parentUuid" string="{string(.)}" store="true" index="true"/>
    </xsl:for-each>

    <xsl:for-each select="dcat:landingPage[normalize-space(@rdf:resource) != '' and not(matches(@rdf:resource, '.*(.gif|.png.|.jpeg|.jpg)$', 'i'))]">
      <xsl:variable name="name" select="tokenize(@rdf:resource, '/')[last()]" />
      <xsl:variable name="tPosition" select="position()" />
      <!-- Index link where last token after the last / is the link name. -->
      <Field name="link"
             string="{concat($name, '|description|', @rdf:resource, '|WWW:DOWNLOAD|WWW-DOWNLOAD|',$tPosition)}"
             store="true" index="false" />
    </xsl:for-each>

    <xsl:for-each select="dcat:landingPage[normalize-space(@rdf:resource) != '' and matches(@rdf:resource, '.*(.gif|.png.|.jpeg|.jpg)$', 'i')]">
      <xsl:variable name="thumbnailType"
                    select="if (position() = 1) then 'thumbnail' else 'overview'"/>
      <!-- First thumbnail is flagged as thumbnail and could be considered the
                main one -->
      <Field name="image" string="{concat($thumbnailType, '|', @rdf:resource, '|')}"
             store="true" index="false" />
    </xsl:for-each>

    <xsl:for-each select="dct:publisher/foaf:Agent">
      <xsl:variable name="tmp_dcat_publisher">
        <xsl:call-template name="index-lang-tag-oneval">
          <xsl:with-param name="tag" select="foaf:name"/>
          <xsl:with-param name="langId" select="$langId"/>
          <xsl:with-param name="isoLangId" select="$isoLangId"/>
        </xsl:call-template>
      </xsl:variable>
      <Field name="orgName" string="{string($tmp_dcat_publisher)}" store="true" index="true"/>
    </xsl:for-each>

    <xsl:for-each select="dcat:servesDataset">
      <Field name="operatesOn" string="{string(@rdf:resource)}" store="true" index="true"/>
      <xsl:variable name="fileIdentifier" select="substring-after(@rdf:resource, '/metadata/')"/>
      <xsl:if test="matches($fileIdentifier, $uuidRegex)">
        <Field name="operatesOn" string="{string($fileIdentifier)}" store="true" index="true"/>
      </xsl:if>
    </xsl:for-each>


    <xsl:for-each select="dcat:endpointUrl">
      <xsl:variable name="descr">
        <xsl:choose>
          <xsl:when test="../dcat:endpointDescription[position()]/@rdf:resource">
            <xsl:value-of select="../dcat:endpointDescription[position()]/@rdf:resource"/>
          </xsl:when>
          <xsl:when test="../dcat:endpointDescription[1]/@rdf:resource">
            <xsl:value-of select="../dcat:endpointDescription[1]/@rdf:resource"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'description'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="name">
        <xsl:choose>
          <xsl:when test="normalize-space(tokenize(@rdf:resource, '/')[last()]) != ''">
            <xsl:value-of select="normalize-space(tokenize(@rdf:resource, '/')[last()])"/>
          </xsl:when>
          <xsl:when test="../dct:title[position()]">
            <xsl:value-of select="../dct:title[position()]"/>
          </xsl:when>
          <xsl:when test="../dct:title[1]">
            <xsl:value-of select="../dct:title[1]"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="''"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <!---->
      <Field name="link"
             string="{concat($name, '|',$descr, '|', @rdf:resource, '|WWW:LINK-1.0-http--link|WWW:LINK-1.0-http--link|', position())}"
             store="true" index="false" />
    </xsl:for-each>

    <xsl:for-each select="dct:license/dct:LicenseDocument/dct:title[normalize-space(.) != '']">
      <Field name="license" string="{.}" store="true" index="true"/>
    </xsl:for-each>

    <xsl:for-each select="dct:accessRights">
      <xsl:if test="contains(skos:Concept/@rdf:about, 'http://publications.europa.eu/resource/authority/access-right/NON_PUBLIC') or
                    contains(skos:Concept/@rdf:about, 'http://publications.europa.eu/resource/authority/access-right/PUBLIC')">
        <Field name="accessRights" string="{skos:Concept/skos:prefLabel[@xml:lang = 'nl']}" store="true" index="true"/>
      </xsl:if>
    </xsl:for-each>

    <xsl:for-each select="dct:rightsHolder|geodcat:distributor|dcat:contactPoint|dct:publisher">
      <xsl:variable name="indexKey">
        <xsl:choose>
          <xsl:when test="name() = 'dct:rightsHolder'"><xsl:value-of select="'dataOwner'"/></xsl:when>
          <xsl:when test="name() = 'geodcat:distributor'"><xsl:value-of select="'dataDistributor'"/></xsl:when>
          <xsl:when test="name() = 'dcat:contactPoint'"><xsl:value-of select="'dataContactPoint'"/></xsl:when>
          <xsl:when test="name() = 'dct:publisher'"><xsl:value-of select="'dataPublisher'"/></xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="fieldValue">
        <xsl:choose>
          <xsl:when test="./foaf:Agent/foaf:name[normalize-space() != '']">
            <xsl:value-of select="./foaf:Agent/foaf:name[normalize-space() != ''][1]"/>
          </xsl:when>
          <xsl:when test="./vcard:Organization/vcard:fn[normalize-space() != '']">
            <xsl:value-of select="./vcard:Organization/vcard:fn[normalize-space() != ''][1]"/>
          </xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:if test="$fieldValue != ''">
        <Field name="{$indexKey}" string="{$fieldValue}" store="true" index="true"/>
      </xsl:if>

      <xsl:for-each select="./vcard:Organization/vcard:organization-name[normalize-space() != '']">
        <Field name="dataOrgName" string="{normalize-space(.)}" store="true" index="true"/>
      </xsl:for-each>
    </xsl:for-each>

    <xsl:for-each select="./mdcat:levensfase">
      <xsl:variable name="lifeCycleLabel">
        <xsl:choose>
          <xsl:when test="./skos:Concept/skos:prefLabel[@xml:lang = 'en']">
            <xsl:value-of select="string(./skos:Concept/skos:prefLabel[@xml:lang = 'en'][1])"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="string(./skos:Concept/skos:prefLabel[1])"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <Field name="lifeCycle" string="{$lifeCycleLabel}" store="true" index="true"/>
    </xsl:for-each>

    <xsl:for-each select="./mdcat:ontwikkelingstoestand">
      <xsl:variable name="devStateLabel">
        <xsl:choose>
          <xsl:when test="./skos:Concept/skos:prefLabel[@xml:lang = 'en']">
            <xsl:value-of select="string(./skos:Concept/skos:prefLabel[@xml:lang = 'en'][1])"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="string(./skos:Concept/skos:prefLabel[1])"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <Field name="developmentState" string="{$devStateLabel}" store="true" index="true"/>
    </xsl:for-each>

  </xsl:template>

  <xsl:template name="getLicenseDocumentTitle">
    <xsl:param name="rdfAbout"/>
    <xsl:choose>
      <xsl:when test="contains($rdfAbout,'modellicentie-gratis-hergebruik')">modellicentie voor gratis hergebruik</xsl:when>
      <xsl:when test="contains($rdfAbout,'creative-commons-zero-verklaring')">Creative Commons Zero verklaring</xsl:when>
      <xsl:when test="contains($rdfAbout,'modellicentie-hergebruik-tegen-vergoeding')">Modellicentie voor hergebruik tegen vergoeding</xsl:when>
      <xsl:when test="contains($rdfAbout,'onvoorwaardelijk-hergebruik')">Onvoorwaardelijk hergebruik</xsl:when>
      <xsl:otherwise><xsl:value-of select="$rdfAbout"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template mode="index-contact" match="vcard:Organization">
    <xsl:param name="type"/>
    <xsl:param name="fieldPrefix"/>
    <xsl:param name="position" select="'0'"/>
    <xsl:variable name="orgName" select="vcard:organization-name"/>
    <Field name="orgName" string="{string($orgName)}" store="true"
           index="true"/>
    <Field name="orgNameTree" string="{string($orgName)}" store="true"
           index="true"/>
    <xsl:variable name="role" select="'Contact'"/>
    <!--<xsl:variable name="roleTranslation" select="util:getCodelistTranslation('gmd:CI_RoleCode',
            string($role), string($isoLangId))"/> -->
    <xsl:variable name="email" select="vcard:hasEmail/@rdf:resource"/>
    <xsl:variable name="url" select="vcard:hasURL/@rdf:resource"/>
    <xsl:variable name="phone"
                  select="vcard:hasTelephone/text()"/>
    <xsl:variable name="individualName" select="vcard:fn/text()"/>
    <xsl:variable name="address"
                  select="string-join(vcard:hasAddress/vcard:Address/(
                                        vcard:street-address|vcard:postal-code|vcard:locality|
                                        vcard:locality|vcard:country-name)/text(), ', ')"/>
    <Field name="{$fieldPrefix}"
           string="{concat('contact', '|', $type,'|',
                             $orgName, '|',
               '', '|',
                             string-join($email, ','), '|',
                             $individualName, '|',
                             'contactpersoon', '|',
                             $address, '|',
                             string-join($phone, ','), '|',
                             'uuid', '|',
                             $position, '|', $url)}"
           store="true" index="false"/>
    <xsl:for-each select="$email">
      <Field name="{$fieldPrefix}Email" string="{string(.)}" store="true"
             index="true"/>
      <!-- <Field name="{$fieldPrefix}RoleAndEmail" string="{$role}|{string(.)}"
                store="true" index="true"/> -->
    </xsl:for-each>
  </xsl:template>


  <xsl:template mode="index-protocol" match="dct:conformsTo/dct:Standard">
    <xsl:variable name="conceptURI" select="string(@rdf:about)"/>
    <xsl:variable name="concept" select="$protocolConcepts/skos:Concept[@rdf:about = $conceptURI]"/>
    <xsl:variable name="isoDocLangId">
      <xsl:call-template name="langId-dcat2"/>
    </xsl:variable>

    <xsl:variable name="topLevelProtocol">
      <xsl:choose>
        <xsl:when test="starts-with($concept/skos:notation, 'WWW:DOWNLOAD-1.0') or $concept/skos:notation = 'LINK download-store'">
          <xsl:value-of select="'download'"/>
        </xsl:when>
        <xsl:when test="starts-with($concept/skos:notation, 'WWW:LINK-1.0') or $concept/skos:notation = 'ESRI:AIMS-http-configuration'">
          <xsl:value-of select="'link'"/>
        </xsl:when>
        <xsl:when test="$concept/skos:hasTopConcept">
          <xsl:variable name="topProtocol" select="$protocolConcepts/skos:Concept[@rdf:about = $concept/skos:hasTopConcept]"/>
          <xsl:choose>
            <xsl:when test="$topProtocol/skos:prefLabel[@xml:lang = $isoDocLangId]">
              <xsl:value-of select="$topProtocol/skos:prefLabel[@xml:lang = $isoDocLangId]"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$topProtocol/skos:prefLabel[1]"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="$concept/skos:prefLabel[@xml:lang = $isoDocLangId]">
              <xsl:value-of select="$concept/skos:prefLabel[@xml:lang = $isoDocLangId]"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$concept/skos:prefLabel[1]"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="normalize-space($topLevelProtocol) != ''">
      <Field name="protocol" string="{normalize-space($topLevelProtocol)}" store="true" index="true"/>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
