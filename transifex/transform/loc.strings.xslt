<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="UTF-8" />
    <xsl:template match="/">
        <strings>
            <xsl:for-each select="resources/string">
                <xsl:element name="{@name}">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
        </strings>
    </xsl:template>
</xsl:stylesheet>