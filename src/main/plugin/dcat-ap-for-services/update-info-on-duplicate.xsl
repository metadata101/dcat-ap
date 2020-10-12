<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:java="java:org.fao.geonet.util.XslUtil"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:template match="/">
    <xsl:apply-templates select="root/rdf:RDF"/>
  </xsl:template>

  <xsl:template match="dcat:Dataset|dcat:DataService">
    <xsl:copy>
      <dct:identifier><xsl:value-of select="/root/env/uuid"/></dct:identifier>
      <xsl:apply-templates select="*[name(.) != 'dct:identifier']"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|*">
    <xsl:copy>
      <xsl:apply-templates select="@*|*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
