<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="common.xsl"/>
  <xsl:template match="*" mode="site">
    <url><xsl:value-of select="url/value"/></url>
    <query><xsl:value-of select="query/value"/></query>
    <icon><xsl:value-of select="icon/value"/></icon>
    <apiKeyHeader><xsl:value-of select="apiKeyHeader/value"/></apiKeyHeader>
    <apiKey><xsl:value-of select="apiKey/value"/></apiKey>
  </xsl:template>
  <xsl:template match="*" mode="options"/>
</xsl:stylesheet>
