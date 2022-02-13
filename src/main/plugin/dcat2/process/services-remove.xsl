<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:geonet="http://www.fao.org/geonetwork"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:param name="uuidref"/>
  <xsl:param name="currentEdit"/>
  <xsl:param name="idRef"/>
  <xsl:param name="siteUrl"/>

  <xsl:variable name="uuidrefUrl" select="concat($siteUrl, 'catalog.search#/metadata/', $uuidref)"/>
  <xsl:variable name="idRefUrl" select="concat($siteUrl, 'catalog.search#/metadata/', $idRef)"/>
  <xsl:variable name="currentEditUrl" select="concat($siteUrl, 'catalog.search#/metadata/', $currentEdit)"/>

  <xsl:template match="dcat:servesDataset [
    @rdf:resource = $uuidrefUrl or
    @rdf:resource = $idRefUrl or
    @rdf:resource = $currentEditUrl
  ]"/>

  <xsl:template match="geonet:*"/>

  <xsl:template match="@*|*|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="extra" priority="2"/>
</xsl:stylesheet>
