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

  <xsl:variable name="nodeUrl" select="util:getSettingValue('nodeUrl')"/>

  <xsl:template match="dcat:Catalog/dcat:record[@rdf:resource = concat($nodeUrl, 'api/records/', $uuidref)]|
                                     dcat:CatalogRecord[@rdf:about = concat($nodeUrl, 'api/records/', $uuidref)]"/>

  <xsl:template match="@*|*|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Always remove geonet:* elements. -->
  <xsl:template match="geonet:*" priority="2"/>
</xsl:stylesheet>
