<!-- Converts the RDF/XML graph returned by CONSTRUCT or DESCRIBE into GeoNetwork records. -->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dcat="http://www.w3.org/ns/dcat#"
    xmlns:dcatap="http://data.europa.eu/r5r/"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:dqv="http://www.w3.org/ns/dqv#"
    xmlns:csvw="http://www.w3.org/ns/csvw#"
    xmlns:cv="http://data.europa.eu/m8g/"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:healthdcatap="http://healthdataportal.eu/ns/health#"
    xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
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
  <xsl:variable name="nestedSchemas" select="document(for $name in ('foaf', 'cv', 'vcard', 'csvw', 'skos', 'dcterms')
    return concat('../schema/', $name, '.xsd'))/xs:schema"/>

  <xsl:template match="/">
    <xsl:if test="not(rdf:RDF)">
      <xsl:message terminate="yes">The default DCAT transformation requires a CONSTRUCT or DESCRIBE result. Configure a stylesheet for SELECT results.</xsl:message>
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
              <xsl:copy-of select="$catalog/(@rdf:about | @rdf:nodeID)"/>
              <xsl:apply-templates select="$catalog/* except ($catalog/rdf:type | $catalog/dcat:record | $catalog/dcat:dataset | $catalog/dcat:service)" mode="property"/>
              <xsl:if test="not($catalog) and $catalogName != ''">
                <dct:title><xsl:value-of select="$catalogName"/></dct:title>
              </xsl:if>
              <dcat:record>
                <dcat:CatalogRecord>
                  <xsl:copy-of select="$record/(@rdf:about | @rdf:nodeID)"/>
                  <dct:identifier><xsl:value-of select="$id"/></dct:identifier>
                  <foaf:primaryTopic>
                    <xsl:choose>
                      <xsl:when test="@rdf:about"><xsl:attribute name="rdf:resource" select="@rdf:about"/></xsl:when>
                      <xsl:otherwise><xsl:copy-of select="@rdf:nodeID"/></xsl:otherwise>
                    </xsl:choose>
                  </foaf:primaryTopic>
                  <xsl:apply-templates select="$record/* except ($record/rdf:type | $record/dct:identifier | $record/foaf:primaryTopic)" mode="property"/>
                  <xsl:if test="not($record/dct:modified)">
                    <xsl:copy-of select="dct:modified[1]"/>
                  </xsl:if>
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

  <!-- These embedded classes have ordered children in the native XSD. -->
  <xsl:template match="foaf:Agent | cv:ContactPoint | vcard:Organization | vcard:Address | skos:Concept | dct:Standard |
                       csvw:TableGroup | csvw:Table | csvw:Column" mode="native-output">
    <xsl:variable name="node" select="."/>
    <xsl:variable name="schema" select="$nestedSchemas[@targetNamespace = namespace-uri($node)]"/>
    <xsl:variable name="elements" select="$schema/xs:complexType/xs:sequence/xs:element[@name = local-name($node)]
      /xs:complexType/xs:sequence/xs:element"/>
    <xsl:variable name="ordered" select="for $element in $elements return $node/*[
      node-name(.) = (if ($element/@ref) then resolve-QName($element/@ref, $element)
                      else QName(string($schema/@targetNamespace), $element/@name))]"/>
    <xsl:copy>
      <!-- CSVW nodes are anonymous in the native XML schema. -->
      <xsl:copy-of select="@*[namespace-uri($node) != 'http://www.w3.org/ns/csvw#']"/>
      <xsl:apply-templates select="($ordered, * except ($ordered | rdf:type))" mode="native-output"/>
    </xsl:copy>
  </xsl:template>

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
        <xsl:when test="$target and not(self::rdf:type | self::dcat:accessURL | self::dcat:downloadURL | self::dcat:accessService |
                                       self::dcatap:applicableLegislation | self::cv:contactPage |
                                       self::vcard:hasEmail | self::vcard:hasURL)
                        and not($target/rdf:type/@rdf:resource = ($resourceTypes, concat($dcat, 'Catalog'), concat($dcat, 'CatalogRecord')))">
          <xsl:apply-templates select="$target" mode="resource">
            <xsl:with-param name="type" select="if (self::dcat:contactPoint) then 'http://www.w3.org/2006/vcard/ns#Organization'
              else if (self::dct:publisher or self::dct:creator or self::healthdcatap:hdab) then 'http://xmlns.com/foaf/0.1/Agent'
              else $target/rdf:type/@rdf:resource[1]"/>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise><xsl:copy-of select="@* | node()"/></xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>

  <xsl:template match="dcat:theme[@rdf:resource][not(../rdf:type/@rdf:resource = 'http://www.w3.org/ns/dcat#Catalog')] |
                       dct:accessRights[@rdf:resource] | dct:type[@rdf:resource] |
                       healthdcatap:healthCategory[@rdf:resource] | healthdcatap:healthTheme[@rdf:resource]" mode="property">
    <xsl:variable name="concept" select="key('resources', @rdf:resource)[1]"/>
    <xsl:element name="{m:name(local-name(), namespace-uri())}" namespace="{namespace-uri()}">
      <skos:Concept rdf:about="{@rdf:resource}">
        <xsl:copy-of select="$concept/skos:prefLabel | $concept/skos:inScheme"/>
      </skos:Concept>
    </xsl:element>
  </xsl:template>

  <xsl:template match="dct:conformsTo[@rdf:resource]" mode="property">
    <xsl:variable name="standard" select="key('resources', @rdf:resource)[1]"/>
    <dct:conformsTo>
      <dct:Standard rdf:about="{@rdf:resource}">
        <dct:identifier><xsl:value-of select="($standard/dct:identifier[normalize-space(.) != ''], @rdf:resource)[1]"/></dct:identifier>
        <xsl:copy-of select="$standard/(dct:title | dct:description | dct:issued | owl:versionInfo)"/>
      </dct:Standard>
    </dct:conformsTo>
  </xsl:template>

  <xsl:function name="m:name" as="xs:string">
    <xsl:param name="local" as="xs:string"/>
    <xsl:param name="uri" as="xs:string"/>
    <xsl:variable name="prefix" select="(in-scope-prefixes($namespaces)[. != ''][namespace-uri-for-prefix(., $namespaces) = $uri])[1]"/>
    <xsl:sequence select="if ($prefix) then concat($prefix, ':', $local) else $local"/>
  </xsl:function>
</xsl:stylesheet>
