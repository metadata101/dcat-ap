<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:xslutil="java:org.fao.geonet.util.XslUtil"
                version="2.0"
                exclude-result-prefixes="#all">
  <!-- Tell the XSL processor to output XML. -->
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>


  <xsl:template match="dcat:Dataset[not(@rdf:about)]|dcat:DataService[not(@rdf:about)]">
    <xsl:copy copy-namespaces="no">
      <xsl:choose>
        <xsl:when test="dct:identifier[matches(., '^http(s)://.*$')]">
          <xsl:attribute name="rdf:about" select="dct:identifier[matches(., '^http(s)://.*$')][1]" />
        </xsl:when>
        <xsl:when test="dct:identifier[normalize-space() != '']">
          <xsl:attribute name="rdf:about" select="concat('urn:uuid:', xslutil:uuidFromString(dct:identifier[normalize-space() != ''][1]))" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="rdf:about" select="concat('urn:uuid:', xslutil:uuidFromString(string(.)))" />
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|*|text()">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>