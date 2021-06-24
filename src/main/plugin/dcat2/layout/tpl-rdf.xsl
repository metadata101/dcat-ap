<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all">
  <!--
    Create reference block to metadata record and dataset to be added in dcat:Catalog usually.
  -->
  <xsl:variable name="recordPrefix" select="concat(/root/gui/systemConfig/metadata/resourceIdentifierPrefix, '/records/')"/>

  <xsl:template mode="record-reference" match="rdf:RDF">
    <xsl:copy-of select="dcat:Catalog/dcat:record"/>
    <dcat:dataset rdf:resource="{dcat:Catalog/dcat:record/dcat:CatalogRecord/foaf:primaryTopic/@rdf:about}"/>
  </xsl:template>

  <xsl:template mode="references" match="rdf:RDF"/>
  <xsl:template mode="rdf:RDF" match="gui|request|metadata"/>


  <xsl:template mode="to-dcat" match="rdf:RDF">
    <xsl:apply-templates select="dcat:Catalog/dcat:record"/>
    <xsl:copy-of select="dcat:Catalog/dcat:dataset|dcat:Catalog/dcat:service"/>
  </xsl:template>

  <!-- Remove empty rdf:about from export -->
  <xsl:template match="*[@rdf:about and normalize-space(@rdf:about) = '']">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="*|@*[name() != 'rdf:about']"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="dcat:CatalogRecord[normalize-space(@rdf:about) = '']" priority="10">
      <xsl:copy copy-namespaces="no">
        <xsl:attribute name="rdf:about" select="concat($recordPrefix, dct:identifier[1])"/>
        <xsl:apply-templates select="*|@*[name() != 'rdf:about']"/>
      </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|*">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
