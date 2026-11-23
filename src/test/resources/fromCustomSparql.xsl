<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sr="http://www.w3.org/2005/sparql-results#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dcat="http://www.w3.org/ns/dcat#" xmlns:dct="http://purl.org/dc/terms/">
  <xsl:template match="/">
    <rdf:RDF>
      <dcat:Catalog>
        <dcat:record><dcat:CatalogRecord>
          <dct:identifier>urn:record:example</dct:identifier>
        </dcat:CatalogRecord></dcat:record>
        <dcat:dataset><dcat:Dataset rdf:about="urn:dataset:example">
          <dct:title><xsl:value-of select="//sr:binding[@name='title']/sr:literal"/></dct:title>
        </dcat:Dataset></dcat:dataset>
      </dcat:Catalog>
    </rdf:RDF>
  </xsl:template>
</xsl:stylesheet>
