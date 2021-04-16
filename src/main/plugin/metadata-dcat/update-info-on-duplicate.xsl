<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:java="java:org.fao.geonet.util.XslUtil"
                exclude-result-prefixes="#all"
                version="2.0">


  <xsl:template match="/">
    <xsl:apply-templates select="root/rdf:RDF"/>
  </xsl:template>

  <xsl:template match="dcat:Dataset|dcat:DataService">
    <xsl:copy>
      <xsl:apply-templates select="@*[not(name(.) = 'rdf:about')]"/>
      <xsl:attribute name="rdf:about"
                     select="replace(@rdf:about,'([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}',/root/env/mduuid)"/>
      <dct:identifier>
        <xsl:value-of select="/root/env/mduuid"/>
      </dct:identifier>
      <dct:title xml:lang="nl"/>
      <xsl:apply-templates select="*[name() != 'dct:identifier' and name() != 'dct:title']"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|*|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
