<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:mdcat="http://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                version="2.0">

  <xsl:include href="set-uuid-helper.xsl"/>

  <xsl:template match="/">
    <xsl:apply-templates select="root/rdf:RDF"/>
  </xsl:template>

  <xsl:template match="dcat:Dataset|dcat:DataService">
    <xsl:copy>
      <xsl:apply-templates select="@*[not(name(.) = 'rdf:about')]"/>
      <xsl:attribute name="rdf:about" select="$resourceAbout"/>
      <xsl:element name="dct:identifier">
        <xsl:value-of select="$resourceUUID"/>
      </xsl:element>
      <dct:title xml:lang="nl"/>
      <xsl:apply-templates select="dct:title[position() > 1]"/>
      <xsl:apply-templates select="*[name() != 'dct:identifier' and name() != 'dct:title']"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="dct:subject" priority="10">
    <mdcat:statuut>
      <xsl:apply-templates select="@*|*"/>
    </mdcat:statuut>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
