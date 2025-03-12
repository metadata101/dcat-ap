<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="UTF-8" />
    <xsl:template match="/">
        <labels xmlns:dct="http://purl.org/dc/terms/"
                xmlns:spdx="http://spdx.org/rdf/terms#"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:adms="http://www.w3.org/ns/adms#"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:locn="http://www.w3.org/ns/locn#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:schema="http://schema.org/">
            <xsl:for-each select="resources/string-array">
                <element>
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                    <xsl:if test="not(normalize-space(@product)='')">
                        <xsl:attribute name="context">
                            <xsl:value-of select="@product"/>
                        </xsl:attribute>
                    </xsl:if>
                    <label>
                        <xsl:value-of select="item[1]"/>
                    </label>
                    <description>
                        <xsl:value-of select="item[2]"/>
                    </description>
                    <btnLabel>
                        <xsl:value-of select="item[3]"/>
                    </btnLabel>
                </element>
            </xsl:for-each>
        </labels>
    </xsl:template>
</xsl:stylesheet>