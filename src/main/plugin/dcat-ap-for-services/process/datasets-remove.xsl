<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:adms="http://www.w3.org/ns/adms#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:param name="uuidref"/>
  <xsl:param name="idRef"/>

  <xsl:template match="dcat:DataService ">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:copy-of select="dct:identifier|
                           dct:title|
                           dct:description|
                           dcat:endpointUrl|
                           dcat:endpointDescription"/>

      <xsl:copy-of select="dcat:servesDataset[not(ends-with(normalize-space(@rdf:resource), $uuidref) or ends-with(normalize-space(@rdf:resource), $idRef))]"/>

      <!-- Copy others elements -->
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|*">
    <xsl:copy>
      <xsl:apply-templates select="@*|*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
