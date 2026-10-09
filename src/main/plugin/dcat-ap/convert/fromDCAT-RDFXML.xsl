<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0"
                exclude-result-prefixes="#all">

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:variable name="dcatSchema" select="document('../schema/dcat.xsd')"/>
  <xsl:variable name="dcatSchemaRoot" select="$dcatSchema/xs:schema"/>

  <!--
  DCAT-AP plugin expect a specific structure of the RDF XML document as input.
  Here we check that this structure is as expected and reorganize the elements if necessary.

  For example, we know that ISO formatter generate particular encoding that needs adaptation:
  * Does not describe catalog.
  * all `rdf:Description` elements are used instead of the specific DCAT classes (e.g. dcat:Dataset, dcat:CatalogRecord, etc.)
  eg.
  ```
  <rdf:Description ...
    <rdf:type rdf:resource="http://www.w3.org/ns/dcat#Dataset"/>
  ```
  should be converted to
  ```
  <dcat:Dataset ...
  ```
  * The main classes should be organized as follows:
  ```
  <rdf:RDF> MUST contain a dcat:Catalog
    <dcat:Catalog> MUST contain dcat:record, dcat:dataset, dcat:service elements
      <dcat:record>
      <dcat:dataset>
      <dcat:service>
  ```
  * Avoid having multiple reference to CatalogRecord with isPrimaryTopicOf.

  -->
  <xsl:template match="/rdf:RDF">
    <xsl:variable name="normalizedChildren">
      <xsl:apply-templates mode="reorganize" select="*|text()"/>
    </xsl:variable>

    <xsl:variable name="catalog" select="$normalizedChildren//dcat:Catalog[1]"/>

    <xsl:copy copy-namespaces="yes">
      <xsl:apply-templates mode="reorganize" select="@*"/>

      <dcat:Catalog>
        <xsl:if test="$catalog">
          <xsl:copy-of select="$catalog/@*"/>
          <xsl:copy-of select="$catalog/*[not(self::dcat:record or self::dcat:dataset or self::dcat:service)]"/>
        </xsl:if>
        <xsl:for-each select="$normalizedChildren//dcat:CatalogRecord|
                              $normalizedChildren//dcat:Dataset|
                              $normalizedChildren//dcat:DataService[not(ancestor::dcat:Distribution)]|
                              $normalizedChildren//dcat:DatasetSeries">
          <xsl:variable name="className" select="local-name()"/>
          <xsl:variable name="elementName"
                        select="if ($className = 'CatalogRecord') then 'record'
                                else if ($className = 'Dataset') then 'dataset'
                                else if ($className = 'DataService') then 'service'
                                else if ($className = 'DatasetSeries') then 'dataset'
                                else ''"/>
          <xsl:if test="$elementName != ''">
            <xsl:element name="dcat:{$elementName}">
              <xsl:copy-of select="current()"/>
            </xsl:element>
          </xsl:if>
        </xsl:for-each>
      </dcat:Catalog>
    </xsl:copy>
  </xsl:template>

  <xsl:template mode="reorganize" match="rdf:Description[rdf:type/@rdf:resource]">
    <xsl:variable name="rdfType" select="normalize-space(rdf:type[1]/@rdf:resource)"/>
    <xsl:variable name="typeNamespace" select="replace($rdfType, '^(.*[#/])[^#/]+$', '$1')"/>
    <xsl:variable name="typeLocalName" select="replace($rdfType, '^.*[#/]([^#/]+)$', '$1')"/>
    <xsl:variable name="typePrefix" as="xs:string?"
                  select="(for $p in in-scope-prefixes($dcatSchemaRoot)
                           return if ($p != '' and string(namespace-uri-for-prefix($p, $dcatSchemaRoot)) = $typeNamespace)
                                  then $p
                                  else ())[1]"/>

    <xsl:choose>
      <xsl:when test="$typePrefix and normalize-space($typeLocalName) != '' and $typeNamespace != $rdfType">
        <xsl:element name="{$typePrefix}:{$typeLocalName}" namespace="{$typeNamespace}">
          <xsl:apply-templates mode="reorganize" select="@*|node()[not(self::rdf:type)]"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy copy-namespaces="no">
          <xsl:apply-templates mode="reorganize" select="@*|node()"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template mode="reorganize" match="foaf:isPrimaryTopicOf"/>

  <xsl:template mode="reorganize" match="*|@*|text()">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates mode="reorganize" select="*|@*|text()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
