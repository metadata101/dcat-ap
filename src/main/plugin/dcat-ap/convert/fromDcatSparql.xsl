<!-- Converts the RDF/XML graph returned by CONSTRUCT or DESCRIBE into GeoNetwork records. -->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dcat="http://www.w3.org/ns/dcat#"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:dqv="http://www.w3.org/ns/dqv#"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:healthdcatap="http://healthdataportal.eu/ns/health#"
    xmlns:m="urn:geonetwork:dcat-mapping"
    exclude-result-prefixes="#all">

  <xsl:include href="../reorder-util.xsl"/>
  <xsl:param name="catalogName" select="''"/>
  <xsl:key name="resources" match="rdf:RDF/rdf:Description" use="(@rdf:about, @rdf:nodeID)"/>
  <xsl:key name="records" match="rdf:RDF/rdf:Description[rdf:type/@rdf:resource = 'http://www.w3.org/ns/dcat#CatalogRecord']"
           use="foaf:primaryTopic/(@rdf:resource, @rdf:nodeID)"/>
  <xsl:key name="catalogs" match="rdf:RDF/rdf:Description[rdf:type/@rdf:resource = 'http://www.w3.org/ns/dcat#Catalog']"
           use="(dcat:record | dcat:dataset | dcat:service)/(@rdf:resource, @rdf:nodeID)"/>

  <xsl:variable name="dcat" select="'http://www.w3.org/ns/dcat#'"/>
  <xsl:variable name="resourceTypes" select="for $type in ('Dataset', 'DatasetSeries', 'DataService') return concat($dcat, $type)"/>
  <!-- Use the plugin schema's prefixes when reordering its catalog and resource properties. -->
  <xsl:variable name="namespaces" select="document('../schema/dcat.xsd')/*"/>

  <xsl:template match="/">
    <xsl:if test="not(rdf:RDF)">
      <xsl:message terminate="yes">The DCAT graph mapping requires a CONSTRUCT or DESCRIBE result.</xsl:message>
    </xsl:if>
    <records>
      <xsl:for-each select="rdf:RDF/rdf:Description[rdf:type/@rdf:resource = $resourceTypes]">
        <xsl:variable name="resource" select="."/>
        <xsl:variable name="type" select="(rdf:type/@rdf:resource[. = $resourceTypes])[1]"/>
        <xsl:variable name="record" select="key('records', (@rdf:about, @rdf:nodeID))[1]"/>
        <xsl:variable name="catalog" select="(key('catalogs', ($record/@rdf:about, $record/@rdf:nodeID))[1],
                                             key('catalogs', (@rdf:about, @rdf:nodeID))[1])[1]"/>
        <xsl:variable name="id" select="($record/dct:identifier[normalize-space(.) != ''], $record/@rdf:about,
                                        @rdf:about, dct:identifier[normalize-space(.) != ''])[1]"/>
        <xsl:variable name="document">
          <rdf:RDF>
            <dcat:Catalog>
              <xsl:copy-of select="$catalog/@rdf:about"/>
              <xsl:apply-templates select="$catalog/* except ($catalog/rdf:type | $catalog/dcat:record | $catalog/dcat:dataset | $catalog/dcat:service)" mode="property"/>
              <xsl:if test="not($catalog) and $catalogName != ''">
                <dct:title><xsl:value-of select="$catalogName"/></dct:title>
              </xsl:if>
              <dcat:record>
                <dcat:CatalogRecord>
                  <xsl:copy-of select="$record/@rdf:about"/>
                  <dct:identifier><xsl:value-of select="$id"/></dct:identifier>
                  <foaf:primaryTopic>
                    <xsl:choose>
                      <xsl:when test="@rdf:about"><xsl:attribute name="rdf:resource" select="@rdf:about"/></xsl:when>
                      <xsl:otherwise><xsl:copy-of select="@rdf:nodeID"/></xsl:otherwise>
                    </xsl:choose>
                  </foaf:primaryTopic>
                  <xsl:apply-templates select="$record/* except ($record/rdf:type | $record/dct:identifier | $record/foaf:primaryTopic)" mode="property"/>
                </dcat:CatalogRecord>
              </dcat:record>
              <xsl:element name="{if ($type = concat($dcat, 'DataService')) then 'dcat:service' else 'dcat:dataset'}">
                <xsl:apply-templates select="$resource" mode="resource">
                  <xsl:with-param name="type" select="$type"/>
                </xsl:apply-templates>
              </xsl:element>
            </dcat:Catalog>
          </rdf:RDF>
        </xsl:variable>
        <xsl:variable name="ordered" as="element(rdf:RDF)">
          <xsl:call-template name="dcat-reorder-elements">
            <xsl:with-param name="rdfRoot" select="$document"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:apply-templates select="$ordered" mode="native-output"/>
      </xsl:for-each>
    </records>
  </xsl:template>

  <xsl:template match="@rdf:about"><xsl:copy/></xsl:template>

  <!-- The schema permits annotations in two positions. Reordering copies them to both. -->
  <xsl:template match="dcat:Dataset/dqv:hasQualityAnnotation[preceding-sibling::healthdcatap:hasStructuredData]" mode="native-output"/>

  <xsl:template match="dqv:QualityAnnotation/@rdf:nodeID | dqv:QualityAnnotation/@rdf:about" mode="native-output"/>

  <xsl:template match="@* | node()" mode="native-output">
    <xsl:copy><xsl:apply-templates select="@* | node()" mode="native-output"/></xsl:copy>
  </xsl:template>

  <xsl:template match="rdf:Description" mode="resource">
    <xsl:param name="type" select="rdf:type/@rdf:resource[1]"/>
    <xsl:param name="visited" as="xs:string*" select="()" tunnel="yes"/>
    <xsl:variable name="uri" select="replace(string($type), '^(.*[/#])[^/#]*$', '$1')"/>
    <xsl:variable name="local" select="substring-after($type, $uri)"/>
    <xsl:variable name="name" select="if (matches($local, '^[\i-[:]][\c-[:]]*$')) then m:name($local, $uri) else 'rdf:Description'"/>
    <xsl:variable name="isDataset" select="$type = concat($dcat, 'Dataset')"/>
    <xsl:variable name="properties" select="if ($name = 'rdf:Description') then * else * except rdf:type[@rdf:resource = $type]"/>
    <xsl:element name="{$name}" namespace="{if ($name = 'rdf:Description') then namespace-uri(.) else $uri}">
      <xsl:copy-of select="@rdf:about | @rdf:nodeID"/>
      <xsl:apply-templates select="$properties except healthdcatap:hasStructuredData[$isDataset]" mode="property">
        <xsl:with-param name="visited" select="($visited, @rdf:about/string(), @rdf:nodeID/string())" tunnel="yes"/>
      </xsl:apply-templates>
      <xsl:if test="$isDataset">
        <healthdcatap:hasStructuredData>
          <xsl:value-of select="if (healthdcatap:hasStructuredData) then xs:boolean(healthdcatap:hasStructuredData)
                                else exists(healthdcatap:hasVariables)"/>
        </healthdcatap:hasStructuredData>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*" mode="property">
    <xsl:param name="visited" as="xs:string*" select="()" tunnel="yes"/>
    <xsl:variable name="target" select="key('resources', (@rdf:resource, @rdf:nodeID)[not(. = $visited)])[1]"/>
    <xsl:element name="{m:name(local-name(), namespace-uri())}" namespace="{namespace-uri()}">
      <xsl:choose>
        <!-- Keep links between records as references so each resource is imported once. -->
        <xsl:when test="$target and not(self::rdf:type | self::dcat:accessURL | self::dcat:downloadURL | self::dcat:accessService)
                        and not($target/rdf:type/@rdf:resource = ($resourceTypes, concat($dcat, 'Catalog'), concat($dcat, 'CatalogRecord')))">
          <xsl:apply-templates select="$target" mode="resource"/>
        </xsl:when>
        <xsl:otherwise><xsl:copy-of select="@* | node()"/></xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>

  <xsl:function name="m:name" as="xs:string">
    <xsl:param name="local" as="xs:string"/>
    <xsl:param name="uri" as="xs:string"/>
    <xsl:variable name="prefix" select="(in-scope-prefixes($namespaces)[. != ''][namespace-uri-for-prefix(., $namespaces) = $uri])[1]"/>
    <xsl:sequence select="if ($prefix) then concat($prefix, ':', $local) else $local"/>
  </xsl:function>
</xsl:stylesheet>
