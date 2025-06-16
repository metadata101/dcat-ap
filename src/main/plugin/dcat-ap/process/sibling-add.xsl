<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:util="java:org.fao.geonet.util.XslUtil"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
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

  <xsl:variable name="catalogUuid" select="/rdf:RDF/geonet:info/uuid"/>

  <xsl:template match="dcat:Catalog">
    <xsl:variable name="associatedUuids"
                  select="ancestor::rdf:RDF/dcat:CatalogRecord/dct:identifier/text()"/>

    <xsl:variable name="uuidsToAdd" as="node()*">
      <xsl:for-each select="tokenize($uuids, ',')">
        <xsl:variable name="uuid" select="tokenize(., '#')[1]"/>
        <xsl:if test="$uuids != '' and not($uuid = $associatedUuids)">
          <uuid><xsl:value-of select="$uuid"/></uuid>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <xsl:copy>
      <xsl:copy-of select="*"/>

      <xsl:for-each select="$uuidsToAdd">
        <dcat:record rdf:resource="{concat($nodeUrl, 'api/records/', $catalogUuid, '/', current())}"/>
      </xsl:for-each>
    </xsl:copy>

    <xsl:for-each select="$uuidsToAdd">
      <dcat:CatalogRecord rdf:about="{concat($nodeUrl, 'api/records/', $catalogUuid, '/', current())}">
        <dct:identifier><xsl:value-of select="current()"/></dct:identifier>
        <foaf:primaryTopic rdf:resource="{concat($nodeUrl, 'api/records/', current())}"/>
      </dcat:CatalogRecord>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="@*|*|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="geonet:*" priority="2"/>
</xsl:stylesheet>
