<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) 2001-2007 Food and Agriculture Organization of the
United Nations (FAO-UN), United Nations World Food Programme (WFP)
and United Nations Environment Programme (UNEP)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA

Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
Rome - Italy. email: geonetwork@osgeo.org
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <!-- Tell the XSL processor to output XML. -->
  <xsl:output method="text" omit-xml-declaration="yes" indent="no" encoding="UTF-8"/>
  <xsl:param name="uuid"/>
  <xsl:variable name="separator">|</xsl:variable>
  <xsl:template match="/">
    <xsl:for-each select="reports/report">
      <xsl:variable name="label">
        <xsl:if test="normalize-space(label/text())!=''">
          <xsl:value-of select="label/text()"/>
        </xsl:if>
        <xsl:if test="not(normalize-space(label/text())!='')">DCAT-AP XML Schema Validation</xsl:if>
      </xsl:variable>
      <xsl:for-each select="patterns/pattern[rules/rule/@type='error']">
        <xsl:variable name="patternTitle" select="replace(title/text(),'\s',' ')"/>
        <xsl:for-each select="rules/rule[@group='xsd' or (@type='error' and not(@group='xsd'))]">
          <xsl:variable name="msg">
            <xsl:if test="@group='xsd'">
              <xsl:value-of select="replace(details/text(),'\s',' ')"/>
            </xsl:if>
            <xsl:if test="@type='error' and not(@group='xsd')">
              <xsl:value-of select="replace(msg/text(),'\s',' ')"/>
            </xsl:if>
          </xsl:variable>
          <xsl:variable name="firstPartMsg"><xsl:if test="contains($msg,':')"><xsl:value-of select="substring-before($msg,':')"/></xsl:if></xsl:variable>
          <xsl:variable name="lastPartMsg">
            <xsl:if test="contains($msg,':')"><xsl:value-of select="substring-after($msg,':')"/></xsl:if>
            <xsl:if test="not(contains($msg,':'))"><xsl:value-of select="$msg"/></xsl:if>
          </xsl:variable>
          <xsl:value-of select="concat($uuid, $separator, $label, $separator, $patternTitle, $separator, $firstPartMsg, $separator, $lastPartMsg, '&#xA;')" />
        </xsl:for-each>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
