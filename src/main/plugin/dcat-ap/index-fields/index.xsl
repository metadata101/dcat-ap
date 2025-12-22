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
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:locn="http://www.w3.org/ns/locn#"
                xmlns:gn-fn-index="http://geonetwork-opensource.org/xsl/functions/index"
                xmlns:index="java:org.fao.geonet.kernel.search.EsSearchManager"
                xmlns:date-util="java:org.fao.geonet.utils.DateUtil"
                xmlns:util="java:org.fao.geonet.util.XslUtil"
                xmlns:dcatutil="java:org.fao.geonet.schema.dcatap.util.XslUtil"
                xmlns:geodcat="http://data.europa.eu/930/"
                xmlns:saxon="http://saxon.sf.net/" xmlns:xls="http://www.w3.org/1999/XSL/Transform"
                xmlns:java="java:org.fao.geonet.util.XslUtil"
                xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:import href="common/index-utils.xsl"/>
  <xsl:import href="index-variables.xsl"/>
  <xsl:import href="../layout/utility-tpl-multilingual.xsl"/>
  <xsl:import href="index-dcat-ap-vl.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:output name="default-serialize-mode"
              indent="no"
              omit-xml-declaration="yes"
              encoding="utf-8"
              escape-uri-attributes="yes"/>

  <xsl:template match="/">

    <xsl:variable name="virtualCatalog"
                  select="rdf:RDF[not(//(dcat:Dataset|dcat:DataService|dcat:DatasetSeries))]/dcat:Catalog"
                  as="node()*"/>

    <xsl:variable name="isVirtualCatalog"
                  select="exists($virtualCatalog)"
                  as="xs:boolean"/>

    <!-- Record associated in virtual catalog -->
    <xsl:variable name="associatedRecords" as="node()*" select="rdf:RDF/dcat:Catalog/dcat:record/@rdf:resource"/>

    <!-- When record is not a catalog, it should have only one CatalogRecord (cf. update-fixed-info). -->
    <xsl:variable name="catalogRecord" as="node()?" select="(.//dcat:CatalogRecord[not(@rdf:about = $associatedRecords)])[1]"/>

    <xsl:variable name="identifier" as="xs:string*" select="$catalogRecord/dct:identifier"/>
    <xsl:variable name="dateStamp" select="$catalogRecord/dct:modified"/>

    <xsl:for-each select="(.//(dcat:Dataset|dcat:DataService|dcat:DatasetSeries)|$virtualCatalog)">
      <doc>
        <xsl:copy-of select="gn-fn-index:add-field('docType', 'metadata')"/>
        <xsl:variable name="dateStamp" select="date-util:convertToISOZuluDateTime(normalize-space($dateStamp))"/>
        <xsl:if test="$dateStamp != ''">
          <dateStamp>
            <xsl:value-of select="$dateStamp"/>
          </dateStamp>
        </xsl:if>

        <xsl:copy-of select="gn-fn-index:add-field('metadataIdentifier', $identifier)"/>

        <xsl:apply-templates mode="index-catalog-contacts" select="../../../dcat:Catalog"/>

        <xsl:variable name="isService" as="xs:boolean" select="name() = 'dcat:DataService'"/>
        <xsl:variable name="isDatasetSeries" as="xs:boolean" select="name() = 'dcat:DatasetSeries'"/>

        <!-- # Resource type -->
        <xsl:choose>
          <xsl:when test="$isService">
            <resourceType>service</resourceType>
          </xsl:when>
          <xsl:when test="$isVirtualCatalog">
            <resourceType>catalog</resourceType>
          </xsl:when>
          <xsl:when test="$isDatasetSeries">
            <resourceType>series</resourceType>
          </xsl:when>
          <xsl:otherwise>
            <resourceType>dataset</resourceType>
          </xsl:otherwise>
        </xsl:choose>


        <xsl:copy-of
          select="gn-fn-index:add-multilingual-field('standardName', ../../dcat:record/dcat:CatalogRecord/dct:conformsTo/dct:Standard/dct:title, $allLanguages)"/>
        <xsl:copy-of select="gn-fn-index:add-multilingual-field('resourceTitle', dct:title, $allLanguages)"/>
        <xsl:copy-of select="gn-fn-index:add-multilingual-field('resourceAbstract', dct:description, $allLanguages)"/>

        <indexingDate>
          <xsl:value-of select="format-dateTime(current-dateTime(), $dateFormat)"/>
        </indexingDate>

        <xsl:apply-templates mode="index-date" select="dct:created"/>
        <xsl:apply-templates mode="index-date" select="dct:issued"/>
        <xsl:apply-templates mode="index-date" select="dct:modified"/>

        <xsl:for-each select="dct:temporal/dct:PeriodOfTime">
          <xsl:variable name="start"
                        select="schema:startDate"/>
          <xsl:variable name="end"
                        select="schema:endDate"/>

          <xsl:variable name="zuluStartDate"
                        select="date-util:convertToISOZuluDateTime($start)"/>
          <xsl:variable name="zuluEndDate"
                        select="date-util:convertToISOZuluDateTime($end)"/>

          <xsl:if test="$zuluStartDate != '' and $zuluEndDate != ''">
            <resourceTemporalDateRange type="object">{
              "gte": "<xsl:value-of select="$zuluStartDate"/>"
              <xsl:if test="$start &lt; $end">
                ,"lte": "<xsl:value-of select="$zuluEndDate"/>"
              </xsl:if>
              }
            </resourceTemporalDateRange>
            <resourceTemporalExtentDateRange type="object">{
              "gte": "<xsl:value-of select="$zuluStartDate"/>"
              <xsl:if test="$start &lt; $end">
                ,"lte": "<xsl:value-of select="$zuluEndDate"/>"
              </xsl:if>
              }
            </resourceTemporalExtentDateRange>
          </xsl:if>
          <xsl:if test="$start &gt; $end">
            <indexingErrorMsg type="object">
              {
              "string": "indexingErrorMsg-temporalDateRangeLowerGreaterThanUpper",
              "type": "warning",
              "values": {
              "lowerBound": "<xsl:value-of select="util:escapeForJson(.)"/>",
              "upperBound": "<xsl:value-of select="util:escapeForJson($end)"/>"
              }
              }
            </indexingErrorMsg>
          </xsl:if>
        </xsl:for-each>

        <xsl:if test="dct:accrualPeriodicity/skos:Concept/skos:prefLabel">
          <xsl:element name="cl_maintenanceAndUpdateFrequency">
            <xsl:attribute name="type" select="'object'"/>
            <xsl:value-of select="gn-fn-index:add-multilingual-field-dcat-ap('accrualPeriodicity', dct:accrualPeriodicity/skos:Concept, $allLanguages, true())"/>
          </xsl:element>
        </xsl:if>

        <xsl:apply-templates mode="index-contact" select="dct:creator">
          <xsl:with-param name="fieldSuffix" select="'ForResource'"/>
          <xsl:with-param name="role" select="'author'"/>
        </xsl:apply-templates>

        <xsl:apply-templates mode="index-contact" select="dct:publisher">
          <xsl:with-param name="fieldSuffix" select="'ForResource'"/>
          <xsl:with-param name="role" select="'publisher'"/>
        </xsl:apply-templates>

        <xsl:for-each select="dcat:contactPoint">
          <xsl:apply-templates mode="index-contact" select=".">
            <xsl:with-param name="fieldSuffix" select="'ForResource'"/>
            <xsl:with-param name="role" select="'pointOfContact'"/>
          </xsl:apply-templates>
        </xsl:for-each>

        <xsl:for-each select="dct:rightsHolder">
          <xsl:apply-templates mode="index-contact" select=".">
            <xsl:with-param name="fieldSuffix" select="'ForResource'"/>
            <xsl:with-param name="role" select="'owner'"/>
          </xsl:apply-templates>
        </xsl:for-each>

        <xsl:for-each select="geodcat:distributor">
          <xsl:apply-templates mode="index-contact" select=".">
            <xsl:with-param name="fieldSuffix" select="'ForResource'"/>
            <xsl:with-param name="role" select="'distributor'"/>
          </xsl:apply-templates>
        </xsl:for-each>

        <rdfResourceIdentifier>
          <xsl:value-of select="@rdf:about"/>
        </rdfResourceIdentifier>

        <resourceIdentifier type="object">
          {
          "code": "<xsl:value-of select="dct:identifier[1]/string()"/>",
          "codeSpace": "",
          "link": "<xsl:value-of select="@rdf:about"/>"
          }
        </resourceIdentifier>

        <xsl:choose>
          <xsl:when test="(dct:language/skos:Concept/@rdf:about|../../dct:language/skos:Concept/@rdf:about)[1]">
            <xsl:copy-of
              select="gn-fn-index:add-field('mainLanguage', gn-fn-index:langUriTo3Char((dct:language/skos:Concept/@rdf:about|../../dct:language/skos:Concept/@rdf:about)[1]))"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:copy-of
              select="gn-fn-index:add-field('mainLanguage', $defaultMainLanguage3Char)"/>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:for-each select="$allLanguages/*[not(@default)]">
          <xsl:copy-of select="gn-fn-index:add-field('otherLanguage', @code)"/>
        </xsl:for-each>

        <xsl:variable name="resourceLanguages"
                      select="dct:language/skos:Concept/@rdf:about|../../dct:language/skos:Concept/@rdf:about"/>

        <xsl:if test="$resourceLanguages">
          <resourceLanguage type="object">
            <xsl:for-each-group select="$resourceLanguages"
                                group-by=".">
              "<xsl:value-of select="gn-fn-index:langUriTo3Char(current-grouping-key())"/>"
            </xsl:for-each-group>
            <xsl:if test="position() != last()">,</xsl:if>
          </resourceLanguage>
        </xsl:if>

        <xsl:apply-templates mode="index-keyword" select="."/>

        <xsl:apply-templates mode="index-concept" select="."/>
        <xsl:apply-templates mode="index-reference" select="."/>
        <xsl:apply-templates mode="index-spatial" select="."/>

        <xsl:apply-templates mode="index-constraints" select="."/>

        <xsl:apply-templates mode="index-distribution" select="."/>

        <xsl:for-each select="dcat:spatialResolutionInMeters[. castable as xs:decimal]">
          <resolutionScaleDenominator>
            <xsl:value-of select="."/>
          </resolutionScaleDenominator>
        </xsl:for-each>


        <!-- Overviews -->
        <xsl:variable name="overviews"
                      select="foaf:page/foaf:Document[matches(@rdf:about, '.*(.gif|.png|.jpeg|.jpg)$', 'i')]"/>
        <xsl:copy-of select="gn-fn-index:add-field('hasOverview', if (count($overviews) > 0) then 'true' else 'false')"/>

        <xsl:for-each select="$overviews">
          <overview type="object">{
            "url": "<xsl:value-of select="util:escapeForJson(normalize-space(@rdf:about))"/>"
            <xsl:if test="normalize-space(dct:description) != ''">,
              "nameObject": <xsl:value-of select="gn-fn-index:add-multilingual-field('name', dct:description, $allLanguages, true())"/>
            </xsl:if>
            }</overview>
        </xsl:for-each>


        <xsl:apply-templates mode="index-reference-date" select="."/>

        <xsl:if test="$isVirtualCatalog">
          <xsl:for-each select="../dcat:CatalogRecord[@rdf:about = ../dcat:Catalog/dcat:record/@rdf:resource]/dct:identifier">
            <agg_associated><xsl:value-of select="."/></agg_associated>
          </xsl:for-each>

          <virtualCatalogRecords type="object">[
          <xsl:for-each select="../dcat:CatalogRecord[@rdf:about = ../dcat:Catalog/dcat:record/@rdf:resource]">
            {
              "uuid": "<xsl:value-of select="dct:identifier"/>"
              <xsl:if test="dct:title">
                ,"resourceTitleObject": <xsl:value-of select="gn-fn-index:add-multilingual-field('resourceTitle', dct:title, $allLanguages, true())"/>
              </xsl:if>
              <xsl:if test="mdcat:stars">
                ,"stars": <xsl:value-of select="mdcat:stars"/>
              </xsl:if>
            }<xsl:if test="position() != last()">,</xsl:if>
          </xsl:for-each>
          ]</virtualCatalogRecords>
        </xsl:if>

        <xsl:for-each select="dcat:inSeries[normalize-space(@rdf:resource) != '']">
          <parentUuid>
            <xsl:value-of select="dcatutil:getUUIDByURI(normalize-space(@rdf:resource))"/>
          </parentUuid>
        </xsl:for-each>
        <xsl:for-each select="dcat:next[normalize-space(@rdf:resource) != '']">
          <nextUUIDInSeries>
            <xsl:value-of select="dcatutil:getUUIDByURI(normalize-space(@rdf:resource))"/>
          </nextUUIDInSeries>
        </xsl:for-each>
        <!-- Index more fields in this element -->
        <xsl:apply-templates mode="index-extra-fields" select="."/>
      </doc>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="index-constraints" match="dcat:Dataset|dcat:DataService|dcat:DatasetSeries">
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
  </xsl:template>

  <xsl:template mode="index-license" match="dct:license">
    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat-ap('license', dct:LicenseDocument, $allLanguages, false(), false(), 'dct:title')"/>
    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat-ap('modelLicentie', dct:LicenseDocument, $allLanguages, false(), false(), 'dct:title')"/>
  </xsl:template>

  <xsl:template mode="index-keyword" match="dcat:Dataset|dcat:DataService|dcat:DatasetSeries|dcat:Catalog">
    <xsl:variable name="keywords">
      <xsl:copy-of select="dcat:keyword[normalize-space() != '']"/>/>
      <xsl:copy-of select="(dct:subject|dcat:theme)[skos:Concept/skos:prefLabel[normalize-space() != '']]/skos:Concept"/>
      <xsl:apply-templates mode="index-extra-keywords" select="."/>
    </xsl:variable>
    <tagNumber>
      <xsl:value-of select="count($keywords/*)"/>
    </tagNumber>
    <tag type="object">
      [
      <xsl:for-each select="$keywords/*">
        <xsl:choose>
          <xsl:when test="name(.) = 'skos:Concept'">
            <xsl:value-of select="gn-fn-index:add-multilingual-field-dcat-ap('keyword', ., $allLanguages, false(), true())/text()"/>
          </xsl:when>
          <xsl:otherwise>
            {
            <xsl:value-of select="concat($doubleQuote, 'default', $doubleQuote, ':', $doubleQuote, util:escapeForJson(.), $doubleQuote)"/>,
            <xsl:value-of select="concat($doubleQuote, 'lang', gn-fn-index:lang-2char-to-3char(@xml:lang), $doubleQuote, ':', $doubleQuote,  util:escapeForJson(.), $doubleQuote)"/>
            }
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="position() != last()">,</xsl:if>
      </xsl:for-each>
      ]
    </tag>
  </xsl:template>

  <!--
    Mirror of mode `index-concept`, but for empty elements that only define @rdf:resource. Example: HVD's dcatap:applicableLegislation
    Keyword values are pulled from the thesaurus defined in the editor.
   -->
  <xsl:template mode="index-reference" match="dcat:Dataset|dcat:DataService|dcat:DatasetSeries|dcat:Catalog">
    <xsl:for-each-group select="*[not(skos:Concept) and name() = $editorConfig/editor/fields/for[@use='thesaurus-list-picker']/@name]" group-by="name()">
      <xsl:variable name="thesaurusId" select="$editorConfig/editor/fields/for[@name = name(current-group()[1])]/directiveAttributes/@thesaurus"/>
      <xsl:variable name="key">
        <xsl:if test="$thesaurusId != ''">
          <xsl:value-of select="tokenize($thesaurusId[1], '\.')[last()]"/>
        </xsl:if>
      </xsl:variable>
      <xsl:element name="th_{$key}Number">
        <xsl:value-of select="count(current-group())"/>
      </xsl:element>
      <xsl:element name="th_{$key}">
        <xsl:attribute name="type" select="'object'"/>
        [
        <xsl:for-each select="current-group()">
          <xsl:variable name="resourceUri" select="@rdf:resource"/>
          <xsl:variable name="defaultLabel" select="java:getKeywordValueByUri($resourceUri, $thesaurusId, $defaultMainLanguage2Char)"/>
          {
            "default": "<xsl:value-of select="util:escapeForJson($defaultLabel)"/>",
            <xsl:for-each select="$allLanguages/lang">
              <xsl:variable name="translatedLabel" select="util:escapeForJson(java:getKeywordValueByUri($resourceUri, $thesaurusId, @code))"/>
              <xsl:if test="$translatedLabel!=''">
                "lang<xsl:value-of select="@code"/>": "<xsl:value-of select="$translatedLabel"/>",
              </xsl:if>
            </xsl:for-each>
            "link": "<xsl:value-of select="util:escapeForJson($resourceUri)"/>"
          }
          <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ]
      </xsl:element>
      <xsl:element name="th_{$key}_tree">
        <xsl:attribute name="type" select="'object'"/>
        [
        <xsl:for-each select="current-group()">
          <xsl:variable name="resourceUri" select="@rdf:resource"/>
          <xsl:variable name="defaultLabel" select="java:getKeywordValueByUri($resourceUri, $thesaurusId, $defaultMainLanguage2Char)"/>
          {
            "key": [
              "<xsl:value-of select="util:escapeForJson($resourceUri)"/>"
            ],
            "default": [
              "<xsl:value-of select="util:escapeForJson($defaultLabel)"/>"
            ]
          }
          <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ]
      </xsl:element>
    </xsl:for-each-group>
  </xsl:template>

  <xsl:template mode="index-concept" match="dcat:Dataset|dcat:DataService|dcat:DatasetSeries|dcat:Catalog">
    <xsl:for-each-group select="*[skos:Concept and name() = $editorConfig/editor/fields/for[@use='thesaurus-list-picker']/@name]"
                        group-by="skos:Concept/skos:inScheme/@rdf:resource">
      <xsl:variable name="thesaurusId" select="$editorConfig/editor/fields/for[@name = name(current-group()[1])]/directiveAttributes/@thesaurus"/>
      <xsl:variable name="key">
        <xsl:if test="$thesaurusId != ''">
          <xsl:value-of select="tokenize($thesaurusId[1], '\.')[last()]"/>
        </xsl:if>
      </xsl:variable>
      <xsl:element name="th_{$key}Number">
        <xsl:value-of select="count(current-group())"/>
      </xsl:element>
      <xsl:element name="th_{$key}">
        <xsl:attribute name="type" select="'object'"/>
        [
        <xsl:for-each select="current-group()/skos:Concept">
          <xsl:value-of select="gn-fn-index:add-multilingual-field-dcat-ap('keyword', ., $allLanguages)/text()"/>
          <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ]
      </xsl:element>
      <xsl:element name="th_{$key}_tree">
        <xsl:attribute name="type" select="'object'"/>
        [
        <xsl:for-each select="current-group()/skos:Concept">
          {
          "key": [
          "<xsl:value-of select="util:escapeForJson(./@rdf:about)"/>"
          ],
          "default": [
          "<xsl:value-of select="./skos:prefLabel[@xml:lang='nl']"/>"
          ]
          }
          <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ]
      </xsl:element>
    </xsl:for-each-group>
    <xsl:if test="count(dcat:keyword) !=0">
      <th_otherKeywords-Number type="object">
        <xsl:value-of select="count(dcat:keyword)"/>
      </th_otherKeywords-Number>
      <th_otherKeywords type="object">
        [
        <xsl:for-each select="dcat:keyword">
          {
          <xsl:value-of select="concat($doubleQuote, 'default', $doubleQuote, ':',
                                             $doubleQuote, util:escapeForJson(.), $doubleQuote)"/>,
          <xsl:value-of select="concat($doubleQuote, 'lang', gn-fn-index:lang-2char-to-3char(@xml:lang), $doubleQuote, ':',
                                             $doubleQuote, util:escapeForJson(.), $doubleQuote)"/>
          }
          <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>

        ]
      </th_otherKeywords>
    </xsl:if>
    <allKeywords type="object">{
      <xsl:if test="count(dcat:keyword[normalize-space() != '']) != 0">
        "th_otherKeywords":
        <xsl:value-of>
          {
          "title": "otherKeywords-",
          "theme": "",
          "keywords": [
          <xsl:for-each select="dcat:keyword[normalize-space() != '']">
            {
            <xsl:value-of select="concat($doubleQuote, 'default', $doubleQuote, ':',
                                             $doubleQuote, util:escapeForJson(.), $doubleQuote)"/>,
            <xsl:value-of select="concat($doubleQuote, 'lang', gn-fn-index:lang-2char-to-3char(@xml:lang), $doubleQuote, ':',
                                             $doubleQuote, util:escapeForJson(.), $doubleQuote)"/>
            }
            <xsl:if test="position() != last()">,</xsl:if>
          </xsl:for-each>
          ]}
        </xsl:value-of>
      </xsl:if>

      <xsl:variable name="conceptKeywords">
        <xsl:for-each-group select="*[skos:Concept and name() = $editorConfig/editor/fields/for[@use='thesaurus-list-picker']/@name]"
                            group-by="skos:Concept/skos:inScheme/@rdf:resource">
          <xsl:variable name="thesaurusId" select="$editorConfig/editor/fields/for[@name=name(current-group()[1])]/directiveAttributes/@thesaurus"/>

          <xsl:variable name="key">
            <xsl:if test="$thesaurusId != ''">
              <xsl:value-of select="tokenize($thesaurusId[1], '\.')[last()]"/>
              <xsl:if test="count($thesaurusId) > 1">
                <xsl:message>WARNING: Concept scheme is used in more than one thesaurus <xsl:value-of select="string-join($thesaurusId, ', ')"/>. Only first one is used.</xsl:message>
              </xsl:if>
            </xsl:if>
          </xsl:variable>
          <xsl:if test="normalize-space($key) != ''">
            <value>
              <xsl:variable name="thesaurusField" select="concat('th_',$key)"/>
              <xsl:variable name="thesaurusTitle" select="util:getThesaurusTitleByKey($thesaurusId[1])"/>
              "<xsl:value-of select="$thesaurusField"/>": {
              "id": "<xsl:value-of select="util:escapeForJson($thesaurusId[1])"/>",
              <xsl:if test="$thesaurusTitle != ''">
                "title": "<xsl:value-of select="util:escapeForJson($thesaurusTitle)"/>",
              </xsl:if>
              "theme": "theme",
              "link": "<xsl:value-of select="util:escapeForJson((current-group()/skos:Concept/skos:inScheme/@rdf:resource)[1])"/>",
              "keywords": [
              <xsl:for-each select="current-group()/skos:Concept">
                <xsl:value-of select="gn-fn-index:add-multilingual-field-dcat-ap('keyword', ., $allLanguages)/text()"/>
                <xsl:if test="position() != last()">,</xsl:if>
              </xsl:for-each>
              ]}
            </value>
          </xsl:if>
        </xsl:for-each-group>
      </xsl:variable>

      <xsl:variable name="hasKeywords" select="count(dcat:keyword[normalize-space() != '']) > 0"/>
      <xsl:if test="$hasKeywords and count($conceptKeywords/value) > 0">,</xsl:if>
      <xsl:for-each select="$conceptKeywords/value">
        <xsl:copy-of select="string()"/>
        <xsl:if test="position() != last()">,</xsl:if>
      </xsl:for-each>
      }
    </allKeywords>

  </xsl:template>

  <xsl:template mode="index-spatial" match="dct:spatial">
    <xsl:variable name="wkt"
                  select="dct:Location/locn:geometry[@rdf:datatype='http://www.opengis.net/ont/geosparql#wktLiteral']/string()"/>
    <xsl:if test="normalize-space($wkt) != ''">
      <geom type="object">
        <xsl:text>{"type": "Polygon",</xsl:text>
        <xsl:text>"coordinates": [[</xsl:text>
        <xsl:for-each select="tokenize(substring-before(substring-after($wkt, '(('),'))'), ',')">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="replace(., ' ', ',')"/>
          <xsl:text>]</xsl:text>
          <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        <xsl:text>]]}</xsl:text>
      </geom>
    </xsl:if>
  </xsl:template>

  <xsl:template mode="index-date" match="dct:modified|dct:issued|dct:created">
    <xsl:variable name="dateType">
      <xsl:choose>
        <xsl:when test="name() = 'dct:issued'">
          <xsl:value-of select="'publication'"/>
        </xsl:when>
        <xsl:when test="name() = 'dct:created'">
          <xsl:value-of select="'creation'"/>
        </xsl:when>
        <xsl:when test="name() = 'dct:modified'">
          <xsl:value-of select="'revision'"/>
        </xsl:when>
      </xsl:choose>

    </xsl:variable>

    <xsl:variable name="date"
                  select="string(.)"/>

    <xsl:variable name="zuluDateTime" as="xs:string?">
      <xsl:if test="normalize-space($date) != '' and gn-fn-index:is-isoDate($date)">
        <xsl:value-of select="date-util:convertToISOZuluDateTime(normalize-space($date))"/>
      </xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="normalize-space($zuluDateTime) != ''">
        <xsl:element name="{$dateType}DateForResource">
          <xsl:value-of select="$zuluDateTime"/>
        </xsl:element>

        <resourceDate type="object">
          {"type": "<xsl:value-of select="$dateType"/>", "date": "<xsl:value-of select="$zuluDateTime"/>"}
        </resourceDate>

        <xsl:element name="{$dateType}YearForResource">
          <xsl:value-of select="substring($zuluDateTime, 0, 5)"/>
        </xsl:element>
        <xsl:element name="{$dateType}MonthForResource">
          <xsl:value-of select="substring($zuluDateTime, 0, 8)"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <indexingErrorMsg type="object">
          {
          "string": "indexingErrorMsg-invalidDateFormat",
          "type": "warning",
          "values": {
          "dateType": "<xsl:value-of select="util:escapeForJson($dateType)"/>",
          "date": "<xsl:value-of select="util:escapeForJson($date)"/>"
          }
          }
        </indexingErrorMsg>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template mode="index-catalog-contacts" match="dcat:Catalog">
    <xsl:for-each select="dct:creator">
      <xsl:apply-templates mode="index-contact" select=".">
        <xsl:with-param name="fieldSuffix" select="''"/>
        <xsl:with-param name="role" select="'author'"/>
      </xsl:apply-templates>
    </xsl:for-each>

    <xsl:for-each select="dct:publisher">
      <xsl:apply-templates mode="index-contact" select=".">
        <xsl:with-param name="fieldSuffix" select="''"/>
        <xsl:with-param name="role" select="'publisher'"/>
      </xsl:apply-templates>
    </xsl:for-each>

    <xsl:for-each select="dcat:contactPoint">
      <xsl:apply-templates mode="index-contact" select=".">
        <xsl:with-param name="fieldSuffix" select="''"/>
        <xsl:with-param name="role" select="'pointOfContact'"/>
      </xsl:apply-templates>
    </xsl:for-each>

    <xsl:for-each select="dct:rightsHolder">
      <xsl:apply-templates mode="index-contact" select=".">
        <xsl:with-param name="fieldSuffix" select="''"/>
        <xsl:with-param name="role" select="'owner'"/>
      </xsl:apply-templates>
    </xsl:for-each>

    <xsl:for-each select="geodcat:distributor">
      <xsl:apply-templates mode="index-contact" select=".">
        <xsl:with-param name="fieldSuffix" select="''"/>
        <xsl:with-param name="role" select="'distributor'"/>
      </xsl:apply-templates>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="index-contact" match="*[foaf:Agent]">
    <xsl:param name="fieldSuffix" select="''" as="xs:string"/>
    <xsl:param name="role" select="''" as="xs:string"/>

    <xsl:variable name="organisationName" select="if (foaf:Agent/foaf:name[$defaultMainLanguage2Char]) then foaf:Agent/foaf:name[$defaultMainLanguage2Char][1] else foaf:Agent/foaf:name[1]"/>
    <xsl:variable name="email" select="foaf:Agent/foaf:mbox/@rdf:resource"/>
    <xsl:variable name="phone" select="foaf:Agent/foaf:phone/@rdf:resource"/>

    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat-ap(concat('Org', $fieldSuffix), foaf:Agent, $allLanguages, false(), false(), 'foaf:name')"/>
    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat-ap(concat(replace($role, '[^a-zA-Z0-9-]', ''), 'Org', $fieldSuffix), foaf:Agent, $allLanguages, false(), false(), 'foaf:name')"/>

    <xsl:variable name="organisationObject" select="gn-fn-index:add-multilingual-field-dcat-ap('organisationObject', foaf:Agent, $allLanguages, false(), false(), 'foaf:name')" />

    <xsl:element name="contact{$fieldSuffix}">
      <xsl:attribute name="type" select="'object'"/>{
      <xsl:if test="$organisationObject">
        "organisationObject": <xsl:value-of select="$organisationObject" />,
      </xsl:if>
      "role":"<xsl:value-of select="$role"/>",
      "email":"<xsl:value-of select="util:escapeForJson($email[1])"/>",
      "phone":"<xsl:value-of select="util:escapeForJson($phone[1])"/>"
      }
    </xsl:element>

  </xsl:template>

  <xsl:template mode="index-contact" match="*[vcard:Organization]">
    <xsl:param name="fieldSuffix" select="''" as="xs:string"/>
    <xsl:param name="role" select="''" as="xs:string"/>

    <xsl:variable name="website" select="vcard:Organization/vcard:hasURL/@rdf:resource"/>
    <xsl:variable name="email" select="vcard:Organization/vcard:hasEmail/@rdf:resource"/>
    <xsl:variable name="phone" select="vcard:Organization/vcard:hasTelephone"/>
    <xsl:variable name="individualName" select="vcard:Organization/vcard:fn"/>
    <xsl:variable name="address">
      <xsl:choose>
        <xsl:when test="vcard:Organization/vcard:hasAddress/vcard:Address">
          <xsl:for-each select="vcard:Organization/vcard:hasAddress/vcard:Address">
            <xsl:value-of
              select="concat(vcard:street-address[1], ', ', vcard:locality[1], ', ', vcard:postal-code[1], ', ', vcard:country-name[1])"/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="''"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat-ap(concat('Org', $fieldSuffix), vcard:Organization, $allLanguages, false(), false(), 'vcard:organization-name')"/>
    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat-ap(concat(replace($role, '[^a-zA-Z0-9-]', ''), 'Org', $fieldSuffix), vcard:Organization, $allLanguages, false(), false(), 'vcard:organization-name')"/>

    <xsl:variable name="organisationObject" select="gn-fn-index:add-multilingual-field-dcat-ap('organisationObject', vcard:Organization, $allLanguages, false(), false(), 'vcard:organization-name')" />

    <xsl:element name="contact{$fieldSuffix}">
      <xsl:attribute name="type" select="'object'"/>{
      <xsl:if test="$organisationObject">
        "organisationObject": <xsl:value-of select="$organisationObject" />,
      </xsl:if>
      "role":"<xsl:value-of select="$role"/>",
      "email":"<xsl:value-of select="util:escapeForJson($email[1])"/>",
      "website":"<xsl:value-of select="$website"/>",
      "individual":"<xsl:value-of select="util:escapeForJson($individualName)"/>",
      "phone":"<xsl:value-of select="util:escapeForJson($phone[1])"/>",
      "address":"<xsl:value-of select="util:escapeForJson($address[1])"/>"
      }
    </xsl:element>
  </xsl:template>

  <xsl:template mode="index-protocol" match="dct:conformsTo/dct:Standard">
    <xsl:variable name="conceptURI" select="string(@rdf:about)"/>
    <xsl:variable name="concept" select="$protocolConcepts/skos:Concept[@rdf:about = $conceptURI]"/>

    <linkProtocol>
      <xsl:value-of select="normalize-space(tokenize(@rdf:about, '/')[last()])"/>
    </linkProtocol>

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
            <xsl:when test="$topProtocol/skos:prefLabel[@xml:lang = 'nl']">
              <xsl:value-of select="$topProtocol/skos:prefLabel[@xml:lang = 'nl']"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$topProtocol/skos:prefLabel[1]"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="$concept/skos:prefLabel[@xml:lang = 'nl']">
              <xsl:value-of select="$concept/skos:prefLabel[@xml:lang = 'nl']"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$concept/skos:prefLabel[1]"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:if test="normalize-space($topLevelProtocol) != ''">
      <topLevelProtocol>
        <xsl:value-of select="util:escapeForJson($topLevelProtocol)"/>
      </topLevelProtocol>
    </xsl:if>
  </xsl:template>

  <xsl:template mode="index-distribution" match="*[dcat:distribution]">
    <xsl:for-each-group select="dcat:distribution/dcat:Distribution/dct:format" group-by="skos:Concept/@rdf:about">
      <xsl:copy-of select="gn-fn-index:add-field('format', tokenize(current-grouping-key(), '/')[last()])"/>
    </xsl:for-each-group>

    <xsl:for-each select="dcat:distribution/dcat:Distribution/dcat:accessURL">
      <linkUrl>
        <xsl:value-of select="string(@rdf:resource)"/>
      </linkUrl>
    </xsl:for-each>

    <xsl:apply-templates mode="index-protocol" select="dcat:distribution/dcat:Distribution/dct:conformsTo/dct:Standard"/>

    <xsl:for-each select="dcat:distribution/dcat:Distribution">
      <link type="object">
        {
        "protocol":
        <xsl:choose>
          <xsl:when test="dct:conformsTo/dct:Standard/@rdf:about">
            "<xsl:value-of select="normalize-space(tokenize(dct:conformsTo/dct:Standard/@rdf:about, '/')[last()])"/>"
          </xsl:when>
          <xsl:otherwise>
            ""
          </xsl:otherwise>
        </xsl:choose>
        ,
        "mimeType":
        "<xsl:value-of
        select="normalize-space(substring-after(dcat:mediaType/skos:Concept/@rdf:about, '/media-types/'))"/>" ,
        "url":"<xsl:value-of select="normalize-space(dcat:accessURL[1]/@rdf:resource)"/>",
        "name":
        <xsl:choose>
          <xsl:when test="count(dct:title)= 1">
            "<xsl:value-of select="normalize-space(dct:title)"/>"
          </xsl:when>
          <!--<xsl:when test="count(dct:title)>1">
            <xsl:for-each select="dct:title">
              {
              <xsl:value-of select="normalize-space(.)"/>
              }
              <xsl:if test="position() != last()">,</xsl:if>
            </xsl:for-each>
          </xsl:when>-->
          <xsl:otherwise>
            ""
          </xsl:otherwise>
        </xsl:choose>
        ,
        "description":
        "<xsl:value-of select="util:escapeForJson(normalize-space(dct:description[1]))"/>",
        "function":"",
        "applicationProfile":"",
        "group":0
        }
      </link>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="index-distribution" match="*[dcat:endpointURL|dcat:endpointDescription|dcat:landingPage]">
    <xsl:for-each select="dcat:endpointURL|dcat:endpointDescription">
      <linkUrl>
        <xsl:value-of select="string(@rdf:resource)"/>
      </linkUrl>
    </xsl:for-each>


    <xsl:apply-templates mode="index-protocol" select="dct:conformsTo/dct:Standard"/>

    <xsl:if test="normalize-space((dcat:endpointURL|dcat:endpointDescription)[1]/@rdf:resource) != ''">
      <xsl:variable name="linkProtocol">
        <xsl:choose>
          <xsl:when test="dct:conformsTo/dct:Standard/@rdf:about[starts-with(., 'https://data.vlaanderen.be/id/concept/dataserviceprotocol/')]">
            <xsl:value-of select="normalize-space(tokenize((dct:conformsTo/dct:Standard/@rdf:about[starts-with(., 'https://data.vlaanderen.be/id/concept/dataserviceprotocol/')])[1], '/')[last()])"/>
          </xsl:when>
          <xsl:when test="dct:conformsTo/dct:Standard/@rdf:about[normalize-space() != '']">
            <xsl:value-of select="normalize-space((dct:conformsTo/dct:Standard/@rdf:about[normalize-space() != ''])[1])"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="''"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <link type="object">
        {
        "protocol": "<xsl:value-of select="$linkProtocol"/>",
        "mimeType": "" ,
        "url":"<xsl:value-of select="normalize-space((dcat:endpointURL|dcat:endpointDescription)[1]/@rdf:resource)"/>",
        "name": "",
        "description": "",
        "function":"",
        "applicationProfile":"",
        "group":0
        }
      </link>
    </xsl:if>

    <xsl:for-each select="dcat:landingPage[normalize-space(@rdf:resource) != '']">
      <link type="object">
        {
        "protocol": "",
        "mimeType": "" ,
        "url":"<xsl:value-of select="normalize-space(@rdf:resource)"/>",
        "name": "",
        "description": "",
        "function":"",
        "applicationProfile":"",
        "group":0
        }
      </link>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="index-reference-date" match="dcat:Dataset|dcat:DataService|dcat:DatasetSeries">
    <xsl:variable name="refDate">
      <xsl:for-each select="dct:*[name()=('dct:modified','dct:created','dct:issued') and .!='' and not(contains(.,'1900') or contains(.,'1753'))]">
        <xsl:sort select="date-util:convertToISOZuluDateTime(normalize-space(.))" order="descending"/>
        <xsl:if test="position() = 1">
          <xsl:value-of select="date-util:convertToISOZuluDateTime(normalize-space(.))"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <referenceDate>
      <xsl:choose>
        <xsl:when test="string-length(normalize-space($refDate)) > 0">
          <xsl:value-of select="$refDate"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'0000-01-01T00:00:00.000Z'"/>
        </xsl:otherwise>
      </xsl:choose>
    </referenceDate>
  </xsl:template>

  <xsl:function name="gn-fn-index:add-multilingual-field-dcat-ap" as="node()*">
    <xsl:param name="fieldName" as="xs:string"/>
    <xsl:param name="elements" as="node()*"/>
    <xsl:param name="languages" as="node()?"/>
    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat-ap($fieldName, $elements, $languages, false())"/>
  </xsl:function>

  <xsl:function name="gn-fn-index:add-multilingual-field-dcat-ap" as="node()*">
    <xsl:param name="fieldName" as="xs:string"/>
    <xsl:param name="elements" as="node()*"/>
    <xsl:param name="languages" as="node()?"/>
    <xsl:param name="asJson" as="xs:boolean?"/>
    <xsl:copy-of
      select="gn-fn-index:add-multilingual-field-dcat-ap($fieldName, $elements, $languages, $asJson, false())"/>
  </xsl:function>

  <xsl:function name="gn-fn-index:add-multilingual-field-dcat-ap" as="node()*">
    <xsl:param name="fieldName" as="xs:string"/>
    <xsl:param name="elements" as="node()*"/>
    <xsl:param name="languages" as="node()?"/>
    <xsl:param name="asJson" as="xs:boolean?"/>
    <xsl:param name="withKey" as="xs:boolean?"/>
    <xsl:copy-of
      select="gn-fn-index:add-multilingual-field-dcat-ap($fieldName, $elements, $languages, $asJson, $withKey, 'skos:prefLabel')"/>
  </xsl:function>

  <xsl:function name="gn-fn-index:lang-2char-to-3char" as="xs:string">
    <xsl:param name="lang2Char" as="xs:string?"/>
    <xsl:choose>
      <xsl:when test="$lang2Char = 'nl'">dut</xsl:when>
      <xsl:when test="$lang2Char = 'fr'">fre</xsl:when>
      <xsl:when test="$lang2Char = 'de'">ger</xsl:when>
      <xsl:when test="$lang2Char = 'en'">eng</xsl:when>
      <xsl:otherwise>dut</xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="gn-fn-index:add-multilingual-field-dcat-ap" as="node()*">
    <xsl:param name="fieldName" as="xs:string"/>
    <xsl:param name="elements" as="node()*"/>
    <xsl:param name="languages" as="node()?"/>
    <xsl:param name="asJson" as="xs:boolean?"/>
    <xsl:param name="withKey" as="xs:boolean?"/>
    <xsl:param name="lookupElement" as="xs:string?"/>

    <xsl:variable name="mainLanguage" select="$languages/lang[@id='default']/@value"/>

    <xsl:variable name="isArray" select="count($elements[not(@xml:lang)]) > 1"/>

    <xsl:variable name="url" select="distinct-values($elements/@rdf:about)"/>
    <xsl:for-each select="$elements/*[name() = $lookupElement]">
      <xsl:variable name="element" select="."/>
      <xsl:variable name="textObject" as="node()*">
        <xsl:if test="position() = 1">
          <value>
            <xsl:value-of select="concat($doubleQuote, 'default', $doubleQuote, ':',
                                    $doubleQuote, util:escapeForJson(.), $doubleQuote)"/>
          </value>
          <xsl:for-each select="$elements/*[name() = $lookupElement]">
            <xsl:if test="util:escapeForJson(.) != ''">
              <value>
                <xsl:value-of select="concat($doubleQuote, 'lang', gn-fn-index:lang-2char-to-3char(@xml:lang), $doubleQuote, ':',
                                        $doubleQuote, util:escapeForJson(.), $doubleQuote)"/>
              </value>
            </xsl:if>
          </xsl:for-each>
          <xsl:if test="$url != ''">
            <value>
              <xsl:value-of select="concat($doubleQuote, 'link', $doubleQuote, ':', $doubleQuote,
                                      util:escapeForJson($url), $doubleQuote)"/>
            </value>
          </xsl:if>
          <xsl:if test="$withKey and $url != ''">
            <value>
              <xsl:value-of select="concat($doubleQuote, 'key', $doubleQuote, ':', $doubleQuote,
                                      util:escapeForJson($url), $doubleQuote)"/>
            </value>
          </xsl:if>
        </xsl:if>
      </xsl:variable>


      <xsl:if test="$textObject != ''">
        <xsl:choose>
          <xsl:when test="$asJson">
            <xsl:if test="$isArray and position() = 1">[</xsl:if>
            {<xsl:value-of select="string-join($textObject/text(), ', ')"/>}
            <xsl:if test="$isArray and position() != last()">,</xsl:if>
            <xsl:if test="$isArray and position() = last()">]</xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="{$fieldName}Object">
              <xsl:attribute name="type" select="'object'"/>
              {<xsl:value-of select="string-join($textObject/text(), ', ')"/>}
            </xsl:element>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:for-each>

    <xsl:if test="count($elements/*[name() = $lookupElement]) = 0 and $url != ''">
      <xsl:variable name="textObject">
        <value>
          <xsl:value-of select="concat($doubleQuote, 'link', $doubleQuote, ':', $doubleQuote,
                                      util:escapeForJson($url), $doubleQuote)"/>
        </value>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$asJson">
          [{<xsl:value-of select="$textObject/string()"/>}]
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="{$fieldName}Object">
            <xsl:attribute name="type" select="'object'"/>
            {<xsl:value-of select="$textObject/string()"/>}
          </xsl:element>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:function>

  <xsl:function name="gn-fn-index:langUriTo3Char">
    <xsl:param name="langUri" as="xs:string"/>
    <xsl:choose>
      <xsl:when test="$langUri = 'http://publications.europa.eu/resource/authority/language/NLD'">
        <xsl:value-of select="'dut'"/>
      </xsl:when>
      <xsl:when test="$langUri = 'http://publications.europa.eu/resource/authority/language/FRA'">
        <xsl:value-of select="'fra'"/>
      </xsl:when>
      <xsl:when test="$langUri = 'http://publications.europa.eu/resource/authority/language/ENG'">
        <xsl:value-of select="'eng'"/>
      </xsl:when>
      <xsl:when test="$langUri = 'http://publications.europa.eu/resource/authority/language/DEU'">
        <xsl:value-of select="'ger'"/>
      </xsl:when>
      <xsl:otherwise>
        <!--        <xsl:message select="concat('Unsupported langUri ', $langUri)"/>-->
        <xsl:value-of select="''"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>
