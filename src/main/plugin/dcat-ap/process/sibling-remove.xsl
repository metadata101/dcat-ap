<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:util="java:org.fao.geonet.util.XslUtil"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:param name="uuidref"/>
  <xsl:variable name="catalogUuid" select="/rdf:RDF/geonet:info/uuid"/>

  <xsl:variable name="nodeUrl" select="util:getSettingValue('nodeUrl')"/>

  <xsl:template match="dcat:Catalog/dcat:record[@rdf:resource = concat($nodeUrl, 'api/records/', $catalogUuid, '#', $uuidref)]|
                                     dcat:CatalogRecord[@rdf:about = concat($nodeUrl, 'api/records/', $catalogUuid, '#', $uuidref)]|
                                     dcat:Catalog/dcat:record[starts-with(@rdf:resource, 'http') and @rdf:resource = $uuidref]|
                                     dcat:CatalogRecord[starts-with(@rdf:about, 'http') and @rdf:about = $uuidref]"/>

  <xsl:template match="@*|*|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="geonet:*" priority="2"/>
</xsl:stylesheet>
