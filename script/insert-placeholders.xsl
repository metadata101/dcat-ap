<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://purl.oclc.org/dsdl/schematron">
  <xsl:output encoding="UTF-8"/>

  <!-- Replace strings in the given schematron file by placeholders, to be used by a corresponding schematron localisation file. -->
  <!-- example usage: xsltproc insert-placeholders.xsl schematron-rules-dcat-ap-vl.sch | xmllint &#45;&#45;format - > output-placeholders.xml -->

  <!-- Identity template : copy all text nodes, elements and attributes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Override the strings themselves, replace them by the placeholders -->
  <xsl:template match="//sch:pattern/sch:title">
    <sch:title>$loc/strings/pattern.title.<xsl:value-of select="count(../preceding-sibling::sch:pattern)+1"/></sch:title>
  </xsl:template>

  <xsl:template match="//sch:pattern/sch:rule/sch:assert/text()">$loc/strings/pattern.assert.<xsl:value-of select="count(../../../preceding-sibling::sch:pattern)+1"/></xsl:template>
  <xsl:template match="//sch:pattern/sch:rule/sch:report/text()">$loc/strings/pattern.report.<xsl:value-of select="count(../../../preceding-sibling::sch:pattern)+1"/></xsl:template>
</xsl:stylesheet>
