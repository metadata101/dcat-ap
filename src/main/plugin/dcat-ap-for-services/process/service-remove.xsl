<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:geonet="http://www.fao.org/geonetwork"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:param name="uuidSrv"/>
  <xsl:param name="siteUrl"/>

  <xsl:variable name="serviceUrl" select="concat($siteUrl, 'catalog.search#/metadata/', $uuidSrv)"/>

  <xsl:template match="dcat:accessService[@rdf:resource = $serviceUrl]"/>

  <xsl:template match="geonet:*"/>

  <xsl:template match="@*|*|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
