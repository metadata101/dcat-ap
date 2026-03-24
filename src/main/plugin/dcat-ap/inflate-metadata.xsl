<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:adms="http://www.w3.org/ns/adms#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                version="2.0"
                exclude-result-prefixes="#all">
  <!--
   Inflate mechanism applied when opening the editor.
   It adds missing dct:language elements in catalog record based on the xml:lang attributes found in the record
   to ensure at least one language is defined.
   -->

  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="languageAttributes"
                select="distinct-values(.//@*[name() = 'xml:lang'])"/>

  <!--
  TODO: Hardcoded mapping for now, but languages are encoded
  using skos:Concepts provided by thesaurus languages.rdf
  which does not contains the mapping with 2 letters ISO code.
  -->
  <xsl:variable name="languageCodeMapping" as="node()*">
    <entry key="nl">NLD</entry>
    <entry key="en">ENG</entry>
    <entry key="fr">FRA</entry>
    <entry key="de">DEU</entry>
  </xsl:variable>


  <xsl:template match="/root">
    <xsl:apply-templates select="*[1]"/>
  </xsl:template>

  <xsl:template match="dcat:record/dcat:CatalogRecord">
    <xsl:variable name="dcatSchema" select="doc('schema/dcat.xsd')"/>
    <xsl:variable name="preLanguage" select="string-join($dcatSchema//xs:complexType[@name='CatalogRecord_type']//xs:element[@ref='dct:language']//preceding-sibling::xs:element/@ref, '|')"/>
    <xsl:variable name="postLanguage" select="string-join($dcatSchema//xs:complexType[@name='CatalogRecord_type']//xs:element[@ref='dct:language']//following-sibling::xs:element/@ref, '|')"/>
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <!-- copy all elements that occur _before_ dct:language (necessary as otherwise we would not be respecting the schema ordering) -->
      <xsl:copy-of select="saxon:evaluate($preLanguage)"/>

      <!-- now process the languages, perhaps insert one if applicable -->
      <xsl:variable name="registeredLanguages"
                    select="dct:language"/>
      <xsl:choose>
        <xsl:when test="not($registeredLanguages)">
          <xsl:for-each select="$languageAttributes">
            <xsl:call-template name="add-language">
              <xsl:with-param name="language" select="."/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <!-- TODO: Add missing ones -->
          <xsl:copy-of select="$registeredLanguages"/>
        </xsl:otherwise>
      </xsl:choose>

      <!-- copy all elements _after_ dct:language -->
      <xsl:copy-of select="saxon:evaluate($postLanguage)"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="add-language">
    <xsl:param name="language"/>

    <xsl:variable name="languageCode"
                  select="$languageCodeMapping[@key = $language]"/>
    <xsl:if test="$languageCode">
      <dct:language>
        <skos:Concept rdf:about="http://publications.europa.eu/resource/authority/language/{$languageCode}">
          <rdf:type rdf:resource="http://purl.org/dc/terms/LinguisticSystem"/>
          <!-- Labels will be populated by the editor. -->
          <skos:inScheme rdf:resource="http://publications.europa.eu/resource/authority/language"/>
        </skos:Concept>
      </dct:language>
    </xsl:if>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
