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
  <xsl:param name="uuidDS"/>
  <xsl:param name="scopedName"/>
  <xsl:param name="siteUrl"/>
  <xsl:param name="url"/>
  <xsl:param name="desc"/>

  <xsl:template match="dcat:DataService ">
    <xsl:copy>
      <xsl:copy-of select="@*"/>

      <xsl:copy-of select="dct:identifier|
                           dct:title|
                           dct:description|
                           dcat:endpointUrl|
                           dcat:endpointDescription"/>

      <xsl:copy-of select="dcat:landingPage[normalize-space(@rdf:resource) != '']"/>

      <!-- Add link to dataset -->
      <xsl:element name="dcat:landingPage">
        <xsl:attribute name="rdf:resource" select="concat($siteUrl, 'catalog.search#/metadata/', $uuidDS)"/>
      </xsl:element>

      <!-- Copy others elements -->
      <xsl:copy-of select="dcat:contactPoint|
                           dcat:keyword|
                           dct:language|
                           dct:hasVersion|
                           dct:isVersionOf"/>

    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|*">
    <xsl:copy>
      <xsl:apply-templates select="@*|*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
