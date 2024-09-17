<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:util="java:org.fao.geonet.util.XslUtil"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:schema="http://schema.org/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:param name="uuidref"/>

  <xsl:variable name="datasetURI" select="util:getRecordResourceURI($uuidref)"/>

  <xsl:template match="dcat:servesDataset[normalize-space(@rdf:resource) = ('', $datasetURI)]" priority="2"/>

  <xsl:template match="@*|*|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Always remove geonet:* elements. -->
  <xsl:template match="geonet:*" priority="2"/>
</xsl:stylesheet>
