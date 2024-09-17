<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#">

  <xsl:template match="/">
    <identifier>
      <xsl:value-of select="(rdf:RDF/dcat:Catalog/dcat:dataset/dcat:Dataset/dct:identifier|rdf:RDF/dcat:Catalog/dcat:service/dcat:DataService/dct:identifier)[1]"/>
    </identifier>
  </xsl:template>

</xsl:stylesheet>
