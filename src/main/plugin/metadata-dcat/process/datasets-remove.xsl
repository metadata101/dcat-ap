<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:mdcat="http://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:geonet="http://www.fao.org/geonetwork"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:param name="uuidref"/>
  <xsl:param name="idRef"/>

  <xsl:template match="dcat:DataService ">
    <xsl:copy>
      <xsl:copy-of select="@*"/>

      <!-- Copy elements before dcat:servesDataset -->
      <xsl:copy-of select="dct:identifier|
                           dct:title|
                           dct:description|
                           dct:publisher|
                           dcat:endpointUrl|
                           dcat:endpointDescription"/>

      <xsl:copy-of select="dcat:servesDataset[not(ends-with(normalize-space(@rdf:resource), $uuidref) or ends-with(normalize-space(@rdf:resource), $idRef))]"/>

      <!-- Copy elements after dcat:servesDataset -->
      <xsl:copy-of select="dcat:landingPage|
                           dcat:contactPoint|
                           dcat:keyword|
                           dct:language|
                           owl:versionInfo|
                           mdcat:authenticatie|
                           mdcat:dienstverleningsKwaliteit|
                           mdcat:gebruiksbepaling|
                           mdcat:statusVanGebruik|
                           mdcat:statusVanOntwikkeling"/>

      <xsl:copy-of select="dcat:qualifiedRelation|
                           dcat:theme|
                           dct:accessRights|
                           dct:conformsTo|
                           dct:creator|
                           dct:isReferencedBy|
                           dct:issued|
                           dct:license|
                           dct:modified|
                           dct:relation|
                           dct:rights|
                           dct:type"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="geonet:*"/>

  <xsl:template match="@*|*">
    <xsl:copy>
      <xsl:apply-templates select="@*|*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
