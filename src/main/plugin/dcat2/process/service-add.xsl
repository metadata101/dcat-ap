<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:adms="http://www.w3.org/ns/adms#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:spdx="http://spdx.org/rdf/terms#"
                xmlns:geonet="http://www.fao.org/geonetwork"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:param name="uuidSrv"/>
  <xsl:param name="siteUrl"/>

  <xsl:variable name="serviceUrl" select="concat($siteUrl, 'catalog.search#/metadata/', $uuidSrv)"/>

  <xsl:template match="dcat:Dataset">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:copy-of select="dct:title|
                           dct:description|
                           dcat:contactPoint|
                           dct:issued|
                           dct:modified|
                           dct:publisher|
                           dct:rightsHolder|
                           dcat:keyword|
                           dct:subject|
                           dcat:theme|
                           dct:accessRights|
                           dct:conformsTo|
                           foaf:page|
                           dct:accrualPeriodicity|
                           dct:hasVersion|
                           dct:isVersionOf|
                           dcat:landingPage|
                           dct:language|
                           adms:identifier|
                           dct:provenance|
                           dct:relation|
                           dct:source|
                           dct:spatial|
                           dct:temporal|
                           dct:type|
                           owl:versionInfo|
                           adms:versionNotes|
                           dcat:extension"/>

      <xsl:choose>
        <xsl:when test="dcat:distribution/dcat:Distribution/dcat:accessService/@rdf:resource = $serviceUrl">
          <xsl:copy-of select="dcat:distribution"/>
        </xsl:when>
        <xsl:when test="count(dcat:distribution/dcat:Distribution) > 0">
          <dcat:distribution>
            <xsl:apply-templates select="dcat:distribution[1]/dcat:Distribution"/>
          </dcat:distribution>
          <xsl:copy-of select="dcat:distribution[position() > 1]"/>
        </xsl:when>
        <xsl:otherwise>
          <dcat:distribution>
            <dcat:Distribution>
              <dct:title xml:lang="nl">Service distributie</dct:title>
              <dcat:accessService rdf:resource="{$serviceUrl}"/>
            </dcat:Distribution>
          </dcat:distribution>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:copy-of select="adms:sample"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="dcat:Distribution">
    <xsl:copy>
      <xsl:copy-of select="dct:identifier|
                           dct:title|
                           dct:description|
                           dcat:accessURL|
                           dcat:downloadURL|
                           dct:issued|
                           dct:modified|
                           dct:format|
                           dcat:mediaType|
                           dct:language|
                           dct:license|
                           dct:rights|
                           dcat:byteSize|
                           spdx:checksum|
                           foaf:page|
                           dct:conformsTo|
                           adms:status|
                           dcat:accessService"/>
      <dcat:accessService rdf:resource="{$serviceUrl}"/>
      <xsl:copy-of select="dcat:compressFormat|
                           dcat:packageFormat|
                           dcat:spatialResolutionInMeters|
                           dcat:temporalResolution|
                           adms:identifier"/>

    </xsl:copy>
  </xsl:template>

  <xsl:template match="geonet:*"/>

  <xsl:template match="@*|*|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
