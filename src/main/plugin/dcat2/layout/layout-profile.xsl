<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:java="java:org.fao.geonet.util.XslUtil"
                xmlns:saxon="http://saxon.sf.net/"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all">

  <xsl:variable name="profile">
    <xsl:variable name="std"
                  select="string(/root/rdf:RDF/dcat:Catalog/dcat:record/dcat:CatalogRecord/dct:conformsTo/dct:Standard/@rdf:about)"/>
    <xsl:choose>
      <xsl:when test="starts-with($std, 'https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat')">
        <xsl:value-of select="'metadata-dcat'"/>
      </xsl:when>
      <xsl:when test="starts-with($std, 'https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL')">
        <xsl:value-of select="'dcat-ap-vl'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="false()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Filter out all editor form elements when profile constraint is set and doesn't match current record profile -->
  <xsl:template mode="form-builder" match="*[@profile and @profile != $profile]" priority="2001"/>
</xsl:stylesheet>
