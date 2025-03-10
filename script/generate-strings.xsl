<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://purl.oclc.org/dsdl/schematron">
  <xsl:output encoding="UTF-8"/>

  <!-- Extract strings from a given XML schematron file, to be used in a localisation file -->
  <!-- example usage: xsltproc generate-strings.xsl schematron-rules-dcat-ap-vl.sch | xmllint &#45;&#45;format - > output-strings.xml -->

  <xsl:template match="/">
    <strings>
      <xsl:apply-templates select="//sch:pattern"/>
    </strings>
  </xsl:template>

  <!-- Override the strings themselves, replace them by the placeholders -->
  <xsl:template match="sch:pattern">
    <xsl:element name="{concat('pattern.title.', position())}"><xsl:value-of select="sch:title/text()"/></xsl:element>
    <xsl:element name="{concat('pattern.assert.', position())}"><xsl:value-of select="sch:rule/sch:assert/text()"/></xsl:element>
    <xsl:element name="{concat('pattern.report.', position())}"><xsl:value-of select="sch:rule/sch:report/text()"/></xsl:element>
  </xsl:template>
</xsl:stylesheet>
