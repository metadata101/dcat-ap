<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:om="https://open-metadata.org/ontology/"
    xmlns:m="urn:geonetwork:openmetadata-mapping"
    xmlns:object="java:org.json.JSONObject"
    xmlns:array="java:org.json.JSONArray"
    xmlns:dcat="http://www.w3.org/ns/dcat#"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:dcatap="http://data.europa.eu/r5r/"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
    xmlns:cv="http://data.europa.eu/m8g/"
    xmlns:healthdcatap="http://healthdataportal.eu/ns/health#"
    xmlns:csvw="http://www.w3.org/ns/csvw#"
    exclude-result-prefixes="#all">

  <xsl:include href="../reorder-util.xsl"/>
  <xsl:param name="catalogName" select="'OpenMetadata'"/>
  <xsl:variable name="profile" select="'https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-8/'"/>
  <xsl:key name="resource" match="rdf:RDF/rdf:Description" use="@rdf:about"/>
  <xsl:key name="assets" match="rdf:RDF/rdf:Description" use="om:hasDataProduct/@rdf:resource"/>

  <xsl:template match="/">
    <records>
      <xsl:for-each select="rdf:RDF/rdf:Description[rdf:type/@rdf:resource = 'https://open-metadata.org/ontology/DataProduct']">
        <xsl:sort select="@rdf:about"/>
        <xsl:variable name="record">
          <xsl:call-template name="product"/>
        </xsl:variable>
        <xsl:call-template name="dcat-reorder-elements">
          <xsl:with-param name="rdfRoot" select="$record"/>
        </xsl:call-template>
      </xsl:for-each>
    </records>
  </xsl:template>

  <xsl:template match="@rdf:about"><xsl:copy/></xsl:template>

  <xsl:template name="product">
    <xsl:variable name="iri" select="string(@rdf:about)"/>
    <xsl:variable name="id" select="(replace($iri, '^.*/', '')[. != ''], $iri)[1]"/>
    <!-- The endpoint can also return a malformed xsd:dateTime literal carrying epoch milliseconds. -->
    <xsl:variable name="modified" select="dct:modified[. castable as xs:dateTime][1]"/>
    <xsl:variable name="extensions" select="m:extensions(.)"/>
    <xsl:variable name="assets" as="element()*">
      <xsl:perform-sort select="key('assets', $iri)">
        <xsl:sort select="@rdf:about"/>
      </xsl:perform-sort>
    </xsl:variable>
    <rdf:RDF>
      <dcat:Catalog>
        <xsl:if test="contains($iri, '/entity/')">
          <xsl:attribute name="rdf:about" select="concat(substring-before($iri, '/entity/'), '/catalog')"/>
        </xsl:if>
        <dct:title><xsl:value-of select="$catalogName"/></dct:title>
        <dcat:record>
          <dcat:CatalogRecord rdf:about="{$iri}/record">
            <dct:identifier><xsl:value-of select="$id"/></dct:identifier>
            <xsl:if test="$modified">
              <dct:modified rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="$modified"/></dct:modified>
            </xsl:if>
            <dct:conformsTo>
              <dct:Standard rdf:about="{$profile}">
                <dct:identifier><xsl:value-of select="$profile"/></dct:identifier>
                <dct:title>HealthDCAT-AP</dct:title>
              </dct:Standard>
            </dct:conformsTo>
            <foaf:primaryTopic rdf:resource="{$iri}"/>
          </dcat:CatalogRecord>
        </dcat:record>
        <dcat:dataset>
          <dcat:Dataset rdf:about="{$iri}">
            <xsl:if test="m:label(.) != ''">
              <dct:title><xsl:value-of select="m:label(.)"/></dct:title>
            </xsl:if>
            <xsl:copy-of select="dct:description"/>
            <dct:identifier><xsl:value-of select="$id"/></dct:identifier>
            <xsl:if test="$modified">
              <dct:modified rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="$modified"/></dct:modified>
            </xsl:if>
            <xsl:for-each select="m:linked(om:hasTag)">
              <xsl:call-template name="tag"/>
            </xsl:for-each>
            <xsl:for-each-group select="m:linked(om:hasOwner | om:hasExpert | om:hasReviewer)" group-by="@rdf:about">
              <xsl:variable name="email" select="m:value(foaf:mbox[1])"/>
              <xsl:variable name="page" select="m:property(m:extensions(.), 'contactPage')"/>
              <dcat:contactPoint>
                <vcard:Organization rdf:about="{@rdf:about}/contact">
                  <vcard:fn><xsl:value-of select="m:label(.)"/></vcard:fn>
                  <xsl:if test="$email != ''">
                    <vcard:hasEmail rdf:resource="{if (starts-with($email, 'mailto:')) then $email else concat('mailto:', $email)}"/>
                  </xsl:if>
                  <xsl:if test="$page != ''"><vcard:hasURL rdf:resource="{$page}"/></xsl:if>
                </vcard:Organization>
              </dcat:contactPoint>
            </xsl:for-each-group>
            <xsl:for-each select="m:strings(m:property($extensions, 'healthKeywords'))">
              <dcat:keyword><xsl:value-of select="."/></dcat:keyword>
            </xsl:for-each>
            <xsl:variable name="provenance" select="m:property($extensions, 'healthProvenance')"/>
            <xsl:if test="normalize-space($provenance) != ''">
              <dct:provenance>
                <dct:ProvenanceStatement><dct:description><xsl:value-of select="$provenance"/></dct:description></dct:ProvenanceStatement>
              </dct:provenance>
            </xsl:if>
            <xsl:for-each select="m:members(m:property($extensions, 'healthHdab'), 'rows')">
              <xsl:variable name="name" select="m:field(., 'name')"/>
              <xsl:variable name="email" select="m:field(., 'email')"/>
              <xsl:variable name="page" select="m:field(., 'contactpage')"/>
              <healthdcatap:hdab>
                <foaf:Agent>
                  <xsl:if test="$name != ''"><foaf:name><xsl:value-of select="$name"/></foaf:name></xsl:if>
                  <xsl:if test="$email != '' or $page != ''">
                    <cv:contactPoint>
                      <cv:ContactPoint>
                        <xsl:if test="$email != ''"><cv:email><xsl:value-of select="$email"/></cv:email></xsl:if>
                        <xsl:if test="$page != ''"><cv:contactPage rdf:resource="{$page}"/></xsl:if>
                      </cv:ContactPoint>
                    </cv:contactPoint>
                  </xsl:if>
                </foaf:Agent>
              </healthdcatap:hdab>
            </xsl:for-each>
            <xsl:call-template name="distributions">
              <xsl:with-param name="iri" select="$iri"/>
              <xsl:with-param name="assets" select="$assets"/>
              <xsl:with-param name="rows" select="m:members(m:property($extensions, 'healthDistributions'), 'rows')"/>
            </xsl:call-template>
            <xsl:variable name="structured" select="normalize-space(m:property($extensions, 'healthHasStructuredData'))"/>
            <xsl:variable name="values" select="if (starts-with($structured, '[')) then m:strings($structured)
              else replace($structured, '^&quot;(.*)&quot;$', '$1')[. != '']"/>
            <xsl:for-each select="$values">
              <healthdcatap:hasStructuredData><xsl:value-of select="."/></healthdcatap:hasStructuredData>
            </xsl:for-each>
            <xsl:if test="$values = 'true'">
              <xsl:call-template name="variables">
                <xsl:with-param name="assets" select="$assets"/>
                <xsl:with-param name="title" select="m:label(.)"/>
              </xsl:call-template>
            </xsl:if>
          </dcat:Dataset>
        </dcat:dataset>
      </dcat:Catalog>
    </rdf:RDF>
  </xsl:template>

  <xsl:template name="tag">
    <xsl:variable name="iri" select="m:tag-uri(.)"/>
    <xsl:variable name="kind" select="substring-before(om:tagFQN, '.')"/>
    <xsl:variable name="predicate" select="if ($kind = 'dcat_theme') then 'dcat:theme'
      else if ($kind = 'dct_accessRights') then 'dct:accessRights'
      else if ($kind = 'dct_type') then 'dct:type'
      else if ($kind = 'healthdcatap_healthCategory') then 'healthdcatap:healthCategory' else ''"/>
    <xsl:if test="$iri != ''">
      <xsl:choose>
        <xsl:when test="$kind = 'dcatap_applicableLegislation'">
          <dcatap:applicableLegislation rdf:resource="{$iri}"/>
        </xsl:when>
        <xsl:when test="$predicate != ''">
          <xsl:element name="{$predicate}">
            <skos:Concept rdf:about="{$iri}"><skos:prefLabel><xsl:value-of select="m:label(.)"/></skos:prefLabel></skos:Concept>
          </xsl:element>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <xsl:template name="distributions">
    <xsl:param name="iri"/>
    <xsl:param name="assets"/>
    <xsl:param name="rows"/>
    <xsl:variable name="covered" as="xs:string*"
                  select="for $row in $rows return m:strings(m:field($row, 'accessURLs'))"/>
    <xsl:for-each select="$rows">
      <xsl:variable name="urls" as="xs:string*">
        <xsl:perform-sort select="m:strings(m:field(., 'accessURLs'))"><xsl:sort/></xsl:perform-sort>
      </xsl:variable>
      <xsl:variable name="asset" select="$assets[m:access-url(.) = $urls][1]"/>
      <xsl:variable name="id" select="if ($asset) then replace($asset/@rdf:about, '^.*/', '')
        else if (exists($urls)) then encode-for-uri(string-join($urls, '&#10;')) else concat('row-', position())"/>
      <dcat:distribution>
        <dcat:Distribution rdf:about="{$iri}/distribution/{$id}">
          <xsl:for-each select="$urls"><dcat:accessURL rdf:resource="{.}"/></xsl:for-each>
          <xsl:for-each select="m:strings(m:field(., 'applicableLegislation'))">
            <dcatap:applicableLegislation rdf:resource="{.}"/>
          </xsl:for-each>
          <xsl:apply-templates select="$asset" mode="asset"/>
        </dcat:Distribution>
      </dcat:distribution>
    </xsl:for-each>
    <!-- Without projected URLs there is no reliable join to the configured rows. -->
    <xsl:for-each select="$assets[not(m:access-url(.) = $covered)][m:access-url(.) != '' or empty($rows)]">
      <dcat:distribution>
        <dcat:Distribution rdf:about="{$iri}/distribution/{replace(@rdf:about, '^.*/', '')}">
          <xsl:variable name="url" select="m:access-url(.)"/>
          <xsl:if test="$url != ''"><dcat:accessURL rdf:resource="{$url}"/></xsl:if>
          <xsl:apply-templates select="." mode="asset"/>
        </dcat:Distribution>
      </dcat:distribution>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="rdf:Description" mode="asset">
    <dct:title><xsl:value-of select="m:label(.)"/></dct:title>
    <xsl:copy-of select="dct:description"/>
    <xsl:apply-templates select="om:belongsToService/@rdf:resource" mode="service"/>
    <xsl:for-each select="m:linked(om:hasTag)[starts-with(om:tagFQN, 'dcatap_applicableLegislation.')]">
      <xsl:call-template name="tag"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="@rdf:resource" mode="service">
    <dcat:accessService rdf:resource="{.}"/>
  </xsl:template>

  <xsl:template name="variables">
    <xsl:param name="assets"/>
    <xsl:param name="title"/>
    <xsl:variable name="tables" as="element()*">
      <xsl:for-each select="$assets">
        <xsl:variable name="fields" select="m:members(string(om:hasResponseSchema[1]), 'schemaFields')"/>
        <xsl:if test="exists($fields)">
          <csvw:table>
            <csvw:Table>
              <dct:title><xsl:value-of select="m:label(.)"/></dct:title>
              <xsl:for-each select="$fields">
                <xsl:variable name="name" select="m:field(., 'name')"/>
                <csvw:column>
                  <csvw:Column>
                    <csvw:name><xsl:value-of select="$name"/></csvw:name>
                    <csvw:title><xsl:value-of select="(m:field(., 'displayName')[. != ''], $name)[1]"/></csvw:title>
                    <dct:description><xsl:value-of select="m:field(., 'description')"/></dct:description>
                    <csvw:datatype><xsl:value-of select="m:datatype(m:field(., 'dataType'))"/></csvw:datatype>
                  </csvw:Column>
                </csvw:column>
              </xsl:for-each>
            </csvw:Table>
          </csvw:table>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="exists($tables)">
      <healthdcatap:hasVariables>
        <csvw:TableGroup>
          <dct:title><xsl:value-of select="$title"/> variables</dct:title>
          <xsl:sequence select="$tables"/>
        </csvw:TableGroup>
      </healthdcatap:hasVariables>
    </xsl:if>
  </xsl:template>

  <xsl:function name="m:linked" as="element()*">
    <xsl:param name="properties" as="element()*"/>
    <xsl:sequence select="for $ref in $properties/@rdf:resource return key('resource', $ref, root($ref))"/>
  </xsl:function>

  <xsl:function name="m:extensions" as="element()*">
    <xsl:param name="resource"/>
    <xsl:sequence select="m:linked(m:linked($resource/om:hasExtension)/om:hasExtensionProperty)"/>
  </xsl:function>

  <xsl:function name="m:property" as="xs:string">
    <xsl:param name="extensions"/>
    <xsl:param name="key"/>
    <xsl:sequence select="m:value(($extensions[om:extensionKey = $key]/om:extensionValue)[1])"/>
  </xsl:function>

  <xsl:function name="m:value" as="xs:string">
    <xsl:param name="property" as="element()?"/>
    <xsl:sequence select="string(($property/@rdf:resource, $property)[1])"/>
  </xsl:function>

  <xsl:function name="m:label" as="xs:string">
    <xsl:param name="resource"/>
    <xsl:sequence select="string(($resource/skos:prefLabel[normalize-space(.) != ''], $resource/rdfs:label)[1])"/>
  </xsl:function>

  <xsl:function name="m:access-url" as="xs:string">
    <xsl:param name="asset"/>
    <xsl:sequence select="string((for $p in ($asset/om:hasEndpointURL, $asset/om:downloadLink, $asset/om:webViewLink, $asset/dct:source)
                          return m:value($p))[normalize-space(.) != ''][1])"/>
  </xsl:function>

  <xsl:function name="m:tag-uri" as="xs:string">
    <xsl:param name="tag"/>
    <xsl:variable name="description" select="string($tag/dct:description[1])"/>
    <xsl:variable name="pattern" select="'^.*?\[Source\]\((https?://[^\s)]+)\).*$'"/>
    <xsl:sequence select="if (matches($description, $pattern, 's')) then replace($description, $pattern, '$1', 's') else ''"/>
  </xsl:function>

  <xsl:function name="m:members">
    <xsl:param name="text" as="xs:string"/>
    <xsl:param name="field" as="xs:string"/>
    <xsl:if test="normalize-space($text) != ''">
      <xsl:variable name="values" select="object:optJSONArray(object:new($text), $field)"/>
      <xsl:sequence select="if (exists($values)) then
        (for $i in 0 to (array:length($values) - 1) return array:get($values, $i)) else ()"/>
    </xsl:if>
  </xsl:function>

  <xsl:function name="m:field" as="xs:string">
    <xsl:param name="object"/>
    <xsl:param name="key" as="xs:string"/>
    <xsl:sequence select="object:optString($object, $key)"/>
  </xsl:function>

  <xsl:function name="m:strings" as="xs:string*">
    <xsl:param name="text" as="xs:string"/>
    <xsl:if test="normalize-space($text) != ''">
      <xsl:variable name="values" select="array:new($text)"/>
      <xsl:for-each select="0 to (array:length($values) - 1)">
        <xsl:sequence select="string(array:optString($values, .))[. != '']"/>
      </xsl:for-each>
    </xsl:if>
  </xsl:function>

  <xsl:function name="m:datatype" as="xs:string">
    <xsl:param name="type"/>
    <xsl:sequence select="if ($type = ('INT', 'BIGINT', 'SMALLINT', 'TINYINT')) then 'integer'
      else if ($type = ('DOUBLE', 'FLOAT')) then 'double'
      else if ($type = ('DECIMAL', 'NUMERIC')) then 'decimal'
      else if ($type = ('TIMESTAMP', 'DATETIME')) then 'dateTime'
      else if ($type = ('BOOLEAN', 'DATE', 'STRING', 'VARCHAR')) then lower-case(replace($type, '^VARCHAR$', 'STRING'))
      else $type"/>
  </xsl:function>
</xsl:stylesheet>
