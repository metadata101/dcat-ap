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


  <!-- A list of uuids of the target records
  Each record is described by
  'uuid#associationType#initiativeType#title#remoteUrl,uuid#...'
  and are comma separated.
  title and remoteUrl may be empty for local record.
  -->
  <xsl:param name="uuids"/>
  <xsl:param name="associationType"/>
  <xsl:param name="initiativeType"/>

  <xsl:variable name="nodeUrl" select="util:getSettingValue('nodeUrl')"/>

  <xsl:template match="dcat:Catalog">
    <xsl:copy>
      <xsl:copy-of select="*"/>

      <xsl:if test="$uuids != ''">
        <xsl:for-each select="tokenize($uuids, ',')">
          <xsl:choose>
            <xsl:when test="contains(., '#')">
              <xsl:variable name="tokens" select="tokenize(., '#')"/>
              <dcat:record rdf:resource="{concat($nodeUrl, 'api/records/', $tokens[1])}"/>
            </xsl:when>
            <xsl:otherwise>
              <dcat:record rdf:resource="{concat($nodeUrl, 'api/records/', .)}"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:if>
    </xsl:copy>

    <!--
     <dcat:CatalogRecord rdf:about="https://metadata.vlaanderen.be/srv/resources/records/record1">
        <foaf:primaryTopic rdf:resource="https://metadata.vlaanderen.be/srv/resources/datasets/uri1"/>
        <mdcat:stars>5</mdcat:stars>
        <mdcat:customkeyword>
        </mdcat:customkeyword>
        <dct:subject>
        </dct:subject>
    </dcat:CatalogRecord>
    -->
  </xsl:template>


  <xsl:template match="@*|*|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Always remove geonet:* elements. -->
  <xsl:template match="geonet:*" priority="2"/>
</xsl:stylesheet>
