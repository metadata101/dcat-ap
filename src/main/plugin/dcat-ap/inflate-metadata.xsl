<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:dct="http://purl.org/dc/terms/"
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
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:copy-of select="* except dct:language"/>

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
