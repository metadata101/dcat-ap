<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
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
      <xsl:apply-templates select="*[name() != 'dct:identifier']"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
