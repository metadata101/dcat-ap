<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:util="java:org.fao.geonet.util.XslUtil"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:spdx="http://spdx.org/rdf/terms#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:adms="http://www.w3.org/ns/adms#"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:param name="uuidref"/>

  <xsl:template match="dcat:DataService">
    <xsl:copy>
      <xsl:copy-of select="@*"/>

      <!-- Copy elements before dcat:servesDataset -->
      <xsl:copy-of select="dct:identifier|
                           dct:title|
                           dct:description|
                           dct:publisher|
                           dct:rightsHolder|
                           dcat:endpointURL|
                           dcat:endpointDescription"/>

      <!-- Copy previous dcat:servesDataset -->
      <xsl:variable name="datasetURI" select="util:getRecordResourceURI($uuidref)"/>
      <xsl:copy-of select="dcat:servesDataset[normalize-space(@rdf:resource) != '' and normalize-space(@rdf:resource) != $datasetURI]"/>

      <!-- Add new link to dataset -->
      <xsl:if test="normalize-space($datasetURI) != ''">
        <xsl:element name="dcat:servesDataset">
          <xsl:attribute name="rdf:resource" select="$datasetURI"/>
        </xsl:element>
      </xsl:if>


      <!-- Copy elements after dcat:servesDataset -->
      <xsl:copy-of select="dcat:landingPage|
                           dcat:contactPoint|
                           dcat:keyword|
                           dct:language|
                           dcat:version|
                           adms:identifier|
                           mdcat:landingspaginaVoorAuthenticatie|
                           mdcat:landingspaginaVoorStatusinformatie|
                           mdcat:landingspaginaVoorGebruiksinformatie|
                           mdcat:levensfase|
                           mdcat:ontwikkelingstoestand|
                           dcat:qualifiedRelation|
                           dct:subject|
                           mdcat:MAGDA-categorie|
                           mdcat:statuut|
                           dcat:theme|
                           dct:accessRights|
                           dct:conformsTo|
                           dct:creator|
                           dct:isReferencedBy|
                           dct:created|
                           dct:issued|
                           dct:license|
                           dct:modified|
                           dct:relation|
                           dct:rights|
                           dct:type|
                           owl:versionInfo"/> <!-- DCAT-AP v2 compatibility -->
    </xsl:copy>
  </xsl:template>


  <xsl:template match="dcat:Dataset/dcat:distribution[dcat:Distribution][1]/dcat:Distribution">
    <xsl:copy>
      <xsl:copy-of select="@*"/>

      <!-- Copy elements before dcat:servesDataset -->
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
                           adms:status"/>

      <!-- Copy previous dcat:accessService -->
      <xsl:variable name="serviceURI" select="util:getRecordResourceURI($uuidref)"/>
      <xsl:copy-of select="dcat:accessService[normalize-space(@rdf:resource) != '' and normalize-space(@rdf:resource) != $serviceURI]"/>

      <!-- Add new link to dataset -->
      <xsl:if test="normalize-space($serviceURI) != ''">
        <xsl:element name="dcat:accessService">
          <xsl:attribute name="rdf:resource" select="$serviceURI"/>
        </xsl:element>
      </xsl:if>

      <xsl:copy-of select="dcat:compressFormat|
                           dcat:packageFormat|
                           dcat:spatialResolutionInMeters|
                           dcat:temporalResolution|
                           dct:accessRights"/>
    </xsl:copy>

  </xsl:template>


  <xsl:template match="@*|*|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Always remove geonet:* elements. -->
  <xsl:template match="geonet:*" priority="2"/>
</xsl:stylesheet>
