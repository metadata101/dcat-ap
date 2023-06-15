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
                xmlns:mdcat="http://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:locn="http://www.w3.org/ns/locn#"
                xmlns:gn-fn-index="http://geonetwork-opensource.org/xsl/functions/index"
                xmlns:index="java:org.fao.geonet.kernel.search.EsSearchManager"
                xmlns:date-util="java:org.fao.geonet.utils.DateUtil"
                xmlns:util="java:org.fao.geonet.util.XslUtil"
                xmlns:saxon="http://saxon.sf.net/" xmlns:xls="http://www.w3.org/1999/XSL/Transform"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:import href="common/index-utils.xsl"/>
  <xsl:import href="../layout/utility-tpl-multilingual.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:output name="default-serialize-mode"
              indent="no"
              omit-xml-declaration="yes"
              encoding="utf-8"
              escape-uri-attributes="yes"/>

  <xsl:variable name="metadata"
                select="//rdf:RDF"/>

  <xsl:variable name="allLanguages">
    <xsl:variable name="listOfLanguages">
      <xsl:call-template name="get-dcat2-other-languages"/>
    </xsl:variable>

    <xsl:for-each select="$listOfLanguages/*">
      <lang value="{@code}">
        <xsl:if test="position() = 1">
          <xsl:attribute name="id"
                         select="'default'"/>
        </xsl:if>
      </lang>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="defaultMainLanguage3Char" select="'dut'"/>
  <xsl:variable name="defaultMainLanguage2Char" select="'nl'"/>
  <xsl:variable name="editorConfig"
                select="document('../layout/config-editor.xml')"/>

  <xsl:template match="/">

    <xsl:variable name="dateStamp" select=".//dcat:CatalogRecord/dct:modified"/>
    <xsl:variable name="identifier" as="xs:string" select=".//dcat:CatalogRecord/dct:identifier"/>
    <xsl:for-each select=".//(dcat:Dataset|dcat:DataService)">
      <doc>
        <xsl:copy-of select="gn-fn-index:add-field('docType', 'metadata')"/>
        <xsl:variable name="dateStamp"
                      select="date-util:convertToISOZuluDateTime(normalize-space($dateStamp))"/>
        <xsl:if test="$dateStamp != ''">
          <dateStamp>
            <xsl:value-of select="$dateStamp"/>
          </dateStamp>
        </xsl:if>

        <xsl:copy-of select="gn-fn-index:add-field('metadataIdentifier', $identifier)"/>

        <xsl:variable name="isService" as="xs:boolean" select="name() = 'dcat:DataService'"/>

        <!-- # Resource type -->
        <xsl:choose>
          <xsl:when test="$isService">
            <resourceType>service</resourceType>
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
            <indexingErrorMsg>Warning / Field resourceTemporalDateRange /
              Lower range bound '<xsl:value-of select="."/>' can not be
              greater than upper bound '<xsl:value-of select="$end"/>'.
              Date range not indexed.
            </indexingErrorMsg>
          </xsl:if>
        </xsl:for-each>

        <xsl:if test="dct:accrualPeriodicity/skos:Concept/skos:prefLabel">
          <xsl:element name="cl_maintenanceAndUpdateFrequency">
            <xsl:attribute name="type" select="'object'"/>
            <xsl:value-of select="gn-fn-index:add-multilingual-field-dcat2('accrualPeriodicity', dct:accrualPeriodicity/skos:Concept, $allLanguages, true())"/>
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

        <resourceIdentifier type="object">
          {
          "code": "<xsl:value-of select="@rdf:about"/>",
          "codeSpace": "",
          "link": ""
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

        <resourceLanguage type="object">
          <xsl:for-each-group select="dct:language/skos:Concept/@rdf:about|../../dct:language/skos:Concept/@rdf:about"
                              group-by=".">
            "<xsl:value-of select="gn-fn-index:langUriTo3Char(current-grouping-key())"/>"
          </xsl:for-each-group>
          <xsl:if test="position() != last()">,</xsl:if>
        </resourceLanguage>

        <xsl:apply-templates mode="index-keyword" select="."/>

        <xsl:apply-templates mode="index-concept" select="."/>
        <xsl:apply-templates mode="index-spatial" select="."/>
        <xsl:for-each-group select="dct:license|dcat:distribution/dcat:Distribution/dct:license" group-by="dct:LicenseDocument/@rdf:about">
          <xsl:apply-templates mode="index-license" select="current-group()[1]"/>
        </xsl:for-each-group>


        <xsl:apply-templates mode="index-distribution" select="."/>


        <xsl:for-each select="dcat:spatialResolutionInMeters[. castable as xs:decimal]">
          <resolutionScaleDenominator>
            <xsl:value-of select="."/>
          </resolutionScaleDenominator>
        </xsl:for-each>

        <!--        TODO check how to implement overviews in dcat-->
        <xsl:copy-of select="gn-fn-index:add-field('hasOverview', 'false')"/>

        <xsl:variable name="openKeywords" select="*[name() = ('dct:subject', 'mdcat:statuut') and
          skos:Concept/@rdf:about = ('https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATA', 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATASERVICE')
        ]"/>
        <xsl:variable name="isOpenData" select="if (count($openKeywords) > 0) then 'y' else 'n'"/>
        <xsl:copy-of select="gn-fn-index:add-field('isOpenData', $isOpenData)"/>

        <xsl:variable name="geoKeywords" select="*[name() = ('dct:subject', 'mdcat:statuut') and
          skos:Concept/@rdf:about = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/GEODATA'
        ]"/>
        <xsl:variable name="isGeoData" select="if (count($geoKeywords) > 0) then 'y' else 'n'"/>
        <xsl:copy-of select="gn-fn-index:add-field('isGeoData', $isGeoData)"/>

      </doc>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="index-license" match="dct:license">
    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat2('license', dct:LicenseDocument, $allLanguages, false(), false(), 'dct:title')"/>
  </xsl:template>

  <xsl:template mode="index-keyword" match="dcat:Dataset|dcat:DataService">
    <xsl:variable name="keywords" select="dcat:keyword|dct:subject|dcat:theme|mdcat:statuut|mdcat:MAGDA-categorie"/>
    <tagNumber>
      <xsl:value-of select="count($keywords)"/>
    </tagNumber>
    <tag type="object">
      [
      <xsl:for-each select="$keywords">
        <xsl:choose>
          <xsl:when test="skos:Concept">
            <xsl:value-of select="gn-fn-index:add-multilingual-field-dcat2('keyword', skos:Concept, $allLanguages, false(), true())/text()"/>
          </xsl:when>
          <xsl:otherwise>
            {
            <xsl:value-of select="concat($doubleQuote, 'default', $doubleQuote, ':', $doubleQuote, gn-fn-index:json-escape(.), $doubleQuote)"/>,
            <xsl:value-of select="concat($doubleQuote, 'lang', @xml:lang, $doubleQuote, ':', $doubleQuote, gn-fn-index:json-escape(.), $doubleQuote)"/>
            }
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="position() != last()">,</xsl:if>
      </xsl:for-each>
      ]
    </tag>

  </xsl:template>

  <xsl:template mode="index-concept" match="dcat:Dataset|dcat:DataService">

    <xsl:for-each-group select="dct:subject|dcat:theme|mdcat:statuut|mdcat:MAGDA-categorie"
                        group-by="skos:Concept/skos:inScheme/@rdf:resource">
      <xsl:variable name="thesaurusId"
                    select="$editorConfig/editor/fields/for[@name=name(current-group()[1])]/directiveAttributes/@thesaurus"/>
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
          <xsl:value-of select="gn-fn-index:add-multilingual-field-dcat2('keyword', ., $allLanguages)/text()"/>
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
                                             $doubleQuote, gn-fn-index:json-escape(.), $doubleQuote)"/>,
          <xsl:value-of select="concat($doubleQuote, 'lang', @xml:lang, $doubleQuote, ':',
                                             $doubleQuote, gn-fn-index:json-escape(.), $doubleQuote)"/>
          }
          <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>

        ]
      </th_otherKeywords>
    </xsl:if>
    <allKeywords type="object">{
      <xsl:if test="count(dcat:keyword) !=0">
        "th_otherKeywords":
        <xsl:value-of>
          {
          "title": "otherKeywords-",
          "theme": "",
          "keywords": [
          <xsl:for-each select="dcat:keyword">
            {
            <xsl:value-of select="concat($doubleQuote, 'default', $doubleQuote, ':',
                                             $doubleQuote, gn-fn-index:json-escape(.), $doubleQuote)"/>,
            <xsl:value-of select="concat($doubleQuote, 'lang', @xml:lang, $doubleQuote, ':',
                                             $doubleQuote, gn-fn-index:json-escape(.), $doubleQuote)"/>
            }
            <xsl:if test="position() != last()">,</xsl:if>
          </xsl:for-each>
          ]
          }
        </xsl:value-of>
        <xsl:if test="count((dct:subject|dcat:theme|mdcat:statuut|mdcat:MAGDA-categorie)/*)>0">
          ,
        </xsl:if>
      </xsl:if>

      <xsl:for-each-group select="dct:subject|dcat:theme|mdcat:statuut|mdcat:MAGDA-categorie"
                          group-by="skos:Concept/skos:inScheme/@rdf:resource">
        <xsl:variable name="thesaurusId"
                      select="$editorConfig/editor/fields/for[@name=name(current-group()[1])]/directiveAttributes/@thesaurus"/>
        <xsl:variable name="key">
          <xsl:if test="$thesaurusId != ''">
            <xsl:value-of select="tokenize($thesaurusId, '\.')[last()]"/>
          </xsl:if>
        </xsl:variable>
        <xsl:if test="normalize-space($key) != ''">
          <xsl:variable name="thesaurusField"
                        select="concat('th_',$key)"/>
          <xsl:variable name="thesaurusTitle" select="util:getThesaurusTitleByName($thesaurusId)"/>
          "<xsl:value-of select="$thesaurusField"/>": {
          "id": "<xsl:value-of select="gn-fn-index:json-escape($thesaurusId)"/>",
          <xsl:if test="$thesaurusTitle != ''">
            "title":
            "<xsl:value-of select="gn-fn-index:json-escape($thesaurusTitle)"/>",
          </xsl:if>
          "theme": "theme",
          "link": "<xsl:value-of
          select="gn-fn-index:json-escape((current-group()/skos:Concept/skos:inScheme/@rdf:resource)[1])"/>",
          "keywords": [
          <xsl:for-each select="current-group()/skos:Concept">
            <xsl:value-of select="gn-fn-index:add-multilingual-field-dcat2('keyword', ., $allLanguages)/text()"/>
            <xsl:if test="position() != last()">,</xsl:if>
          </xsl:for-each>
          ]}
          <xsl:if test="position() != last()">,</xsl:if>
        </xsl:if>
      </xsl:for-each-group>
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
      <xsl:if test="gn-fn-index:is-isoDate(.)">
        <xsl:value-of select="date-util:convertToISOZuluDateTime(normalize-space($date))"/>
      </xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$zuluDateTime != ''">
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
        <indexingErrorMsg>Warning / Date
          <xsl:value-of select="$dateType"/> with value '<xsl:value-of select="$date"/>' was not a valid date format.
        </indexingErrorMsg>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template mode="index-contact" match="*[foaf:Agent]">
    <xsl:param name="fieldSuffix" select="''" as="xs:string"/>
    <xsl:param name="role" select="''" as="xs:string"/>

    <xsl:variable name="organisationName" select="foaf:Agent/foaf:name"/>
    <xsl:variable name="email" select="foaf:Agent/foaf:mbox/@rdf:resource"/>
    <xsl:variable name="phone" select="foaf:Agent/foaf:phone/@rdf:resource"/>

    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat2(concat('Org', $fieldSuffix), foaf:Agent, $allLanguages, false(), false(), 'foaf:name')"/>
    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat2(concat(replace($role, '[^a-zA-Z0-9-]', ''), 'Org', $fieldSuffix), foaf:Agent, $allLanguages, false(), false(), 'foaf:name')"/>

    <xsl:element name="contact{$fieldSuffix}">
      <xsl:attribute name="type" select="'object'"/>{
      "organisation":"<xsl:value-of select="gn-fn-index:json-escape($organisationName)"/>",
      "role":"<xsl:value-of select="$role"/>",
      "email":"<xsl:value-of select="gn-fn-index:json-escape($email[1])"/>",
      "phone":"<xsl:value-of select="gn-fn-index:json-escape($phone[1])"/>"
      }
    </xsl:element>

  </xsl:template>

  <xsl:template mode="index-contact" match="*[vcard:Organization]">
    <xsl:param name="fieldSuffix" select="''" as="xs:string"/>
    <xsl:param name="role" select="''" as="xs:string"/>

    <xsl:variable name="organisationName" select="vcard:Organization/vcard:organization-name"/>
    <xsl:variable name="website" select="vcard:Organization/vcard:hasURL/@rdf:resource"/>
    <xsl:variable name="email" select="vcard:Organization/vcard:hasEmail/@rdf:resource"/>
    <xsl:variable name="phone" select="vcard:Organization/vcard:hasTelephone"/>
    <xsl:variable name="individualName" select="vcard:Organization/vcard:fn"/>
    <xsl:variable name="address">
      <xsl:choose>
        <xsl:when test="vcard:Organization/vcard:hasAddress/vcard:Address">
          <xsl:for-each select="vcard:Organization/vcard:hasAddress/vcard:Address">
            <xsl:value-of
              select="concat(vcard:street-address, ', ', vcard:locality, ', ', vcard:postal-code, ', ', vcard:country-name)"/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="''"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat2(concat('Org', $fieldSuffix), vcard:Organization, $allLanguages, false(), false(), 'vcard:organization-name')"/>
    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat2(concat(replace($role, '[^a-zA-Z0-9-]', ''), 'Org', $fieldSuffix), vcard:Organization, $allLanguages, false(), false(), 'vcard:organization-name')"/>

    <xsl:element name="contact{$fieldSuffix}">
      <xsl:attribute name="type" select="'object'"/>{
      "organisation":"<xsl:value-of select="gn-fn-index:json-escape($organisationName)"/>",
      "role":"<xsl:value-of select="$role"/>",
      "email":"<xsl:value-of select="gn-fn-index:json-escape($email[1])"/>",
      "website":"<xsl:value-of select="$website"/>",
      "individual":"<xsl:value-of select="gn-fn-index:json-escape($individualName)"/>",
      "phone":"<xsl:value-of select="gn-fn-index:json-escape($phone[1])"/>",
      "address":"<xsl:value-of select="gn-fn-index:json-escape($address)"/>"
      }
    </xsl:element>
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

    <xsl:for-each select="dcat:distribution/dcat:Distribution/dct:conformsTo/dct:Standard">
      <linkProtocol>
        <xsl:value-of select="normalize-space(tokenize(@rdf:about, '/')[last()])"/>
      </linkProtocol>
    </xsl:for-each>

    <xsl:for-each select="dcat:distribution/dcat:Distribution">
      <link type="object">
        {
        "protocol":
        <xsl:choose>
          <xsl:when test="dct:conformsTo/dct:Standard/@rdf:about">
            "<xsl:value-of
            select="normalize-space(tokenize(dct:conformsTo/dct:Standard/@rdf:about, '/')[last()])"/>"
          </xsl:when>
          <xsl:otherwise>
            ""
          </xsl:otherwise>
        </xsl:choose>
        ,
        "mimeType":
        "<xsl:value-of
        select="normalize-space(substring-after(dcat:mediaType/skos:Concept/@rdf:about, '/media-types/'))"/>" ,
        "url":"<xsl:value-of select="normalize-space(dcat:accessURL/@rdf:resource)"/>",
        "name":
        <xsl:choose>
          <xsl:when test="count(dct:title)= 1">
            "<xsl:value-of select="normalize-space(dct:title)"/>"
          </xsl:when>
          <xsl:when test="count(dct:title)>1">
            <xsl:for-each select="dct:title">
              {
              <xsl:value-of select="normalize-space(.)"/>
              }
              <xsl:if test="position() != last()">,</xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            ""
          </xsl:otherwise>
        </xsl:choose>
        ,
        "description":
        "<xsl:value-of select="normalize-space(dct:description)"/>",
        "function":"",
        "applicationProfile":"",
        "group":0
        }
      </link>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="index-distribution" match="*[dcat:endpointURL|dcat:endpointDescription]">
    <xsl:for-each select="dcat:endpointURL|dcat:endpointDescription">
      <linkUrl>
        <xsl:value-of select="string(@rdf:resource)"/>
      </linkUrl>
    </xsl:for-each>

    <xsl:for-each select="dct:conformsTo/dct:Standard">
      <linkProtocol>
        <xsl:value-of select="normalize-space(tokenize(@rdf:about, '/')[last()])"/>
      </linkProtocol>
    </xsl:for-each>

    <link type="object">
      {
      "protocol":
      <xsl:choose>
        <xsl:when test="dct:conformsTo/dct:Standard/@rdf:about">
          "<xsl:value-of
          select="normalize-space(tokenize(dct:conformsTo/dct:Standard/@rdf:about, '/')[last()])"/>"
        </xsl:when>
        <xsl:otherwise>
          ""
        </xsl:otherwise>
      </xsl:choose>
      ,
      "mimeType": "" ,
      "url":"<xsl:value-of select="normalize-space((dcat:endpointURL|dcat:endpointDescription)[1]/@rdf:resource)"/>",
      "name": "",
      "description": "",
      "function":"",
      "applicationProfile":"",
      "group":0
      }
    </link>
  </xsl:template>

  <xsl:function name="gn-fn-index:add-multilingual-field-dcat2" as="node()*">
    <xsl:param name="fieldName" as="xs:string"/>
    <xsl:param name="elements" as="node()*"/>
    <xsl:param name="languages" as="node()?"/>
    <xsl:copy-of select="gn-fn-index:add-multilingual-field-dcat2($fieldName, $elements, $languages, false())"/>
  </xsl:function>

  <xsl:function name="gn-fn-index:add-multilingual-field-dcat2" as="node()*">
    <xsl:param name="fieldName" as="xs:string"/>
    <xsl:param name="elements" as="node()*"/>
    <xsl:param name="languages" as="node()?"/>
    <xsl:param name="asJson" as="xs:boolean?"/>
    <xsl:copy-of
      select="gn-fn-index:add-multilingual-field-dcat2($fieldName, $elements, $languages, $asJson, false())"/>
  </xsl:function>

  <xsl:function name="gn-fn-index:add-multilingual-field-dcat2" as="node()*">
    <xsl:param name="fieldName" as="xs:string"/>
    <xsl:param name="elements" as="node()*"/>
    <xsl:param name="languages" as="node()?"/>
    <xsl:param name="asJson" as="xs:boolean?"/>
    <xsl:param name="withKey" as="xs:boolean?"/>
    <xsl:copy-of
      select="gn-fn-index:add-multilingual-field-dcat2($fieldName, $elements, $languages, $asJson, $withKey, 'skos:prefLabel')"/>
  </xsl:function>

  <xsl:function name="gn-fn-index:add-multilingual-field-dcat2" as="node()*">
    <xsl:param name="fieldName" as="xs:string"/>
    <xsl:param name="elements" as="node()*"/>
    <xsl:param name="languages" as="node()?"/>
    <xsl:param name="asJson" as="xs:boolean?"/>
    <xsl:param name="withKey" as="xs:boolean?"/>
    <xsl:param name="lookupElement" as="xs:string?"/>

    <xsl:variable name="mainLanguage"
                  select="$languages/lang[@id='default']/@value"/>

    <xsl:variable name="isArray"
                  select="count($elements[not(@xml:lang)]) > 1"/>

    <xsl:variable name="url"
                  select="distinct-values($elements/@rdf:about)"/>
    <xsl:for-each select="$elements/*[name() = $lookupElement]">
      <xsl:variable name="element" select="."/>
      <xsl:variable name="textObject" as="node()*">
        <xsl:if test="position() = 1">
          <value>
            <xsl:value-of select="concat($doubleQuote, 'default', $doubleQuote, ':',
                                             $doubleQuote, gn-fn-index:json-escape(.), $doubleQuote)"/>
          </value>
          <xsl:for-each select="$elements/*[name() = $lookupElement]">
            <xsl:if test="gn-fn-index:json-escape(.) != ''">
              <value>
                <xsl:value-of select="concat($doubleQuote, 'lang', @xml:lang, $doubleQuote, ':',
                                             $doubleQuote, gn-fn-index:json-escape(.), $doubleQuote)"/>
              </value>
            </xsl:if>
          </xsl:for-each>
          <xsl:if test="$url != ''">
            <value>
              <xsl:value-of
                select="concat($doubleQuote, 'link', $doubleQuote, ':', $doubleQuote,
                gn-fn-index:json-escape($url), $doubleQuote)"/>
            </value>
          </xsl:if>
          <xsl:if test="$withKey and $url != ''">
            <value>
              <xsl:value-of
                select="concat($doubleQuote, 'key', $doubleQuote, ':', $doubleQuote,
                gn-fn-index:json-escape($url), $doubleQuote)"/>
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
        <xsl:value-of select="'end'"/>
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
