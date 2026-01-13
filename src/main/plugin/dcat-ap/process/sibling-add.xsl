<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:util="java:org.fao.geonet.util.XslUtil"
                xmlns:dcatutil="java:org.fao.geonet.schema.dcatap.util.XslUtil"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="#all"
                version="2.0">


  <!-- A list of uuids of the target records
  Each record is described by
  'uuid#associationType#initiativeType#title#remoteUrl,uuid#...'
  and are comma separated.
  title and remoteUrl may be empty for local record.
  -->
  <xsl:param name="uuids"/>
  <xsl:param name="associationType"/>
  <xsl:param name="initiativeType"/>

  <xsl:include href="../reorder-util.xsl"/>

  <xsl:variable name="nodeUrl" select="util:getSettingValue('nodeUrl')"/>

  <xsl:variable name="catalogUuid" select="/rdf:RDF/geonet:info/uuid"/>

  <xsl:function name="dcat:get-resource-iri" as="xs:string">
    <xsl:param name="record" as="node()"/>
    <xsl:param name="catalogUuid" as="xs:string"/>
    <xsl:param name="nodeUrl" as="xs:string"/>

    <xsl:sequence select="if(starts-with($record/url, 'http'))
                                                     then $record/url
                                                     else concat($nodeUrl, 'api/records/', $catalogUuid, '#',$record/uuid)"/>
  </xsl:function>

  <xsl:template match="dcat:Catalog[$associationType = 'isComposedOf']">
    <!-- All associated records and itself (to avoid linking to existing) -->
    <xsl:variable name="associatedUuids"
                  select="ancestor::rdf:RDF//dcat:CatalogRecord/dct:identifier/text()"/>

    <xsl:variable name="uuidsToAdd" as="node()*">
      <xsl:for-each select="tokenize($uuids, ',')">
        <xsl:variable name="uuidTypesTitleAndURL" select="tokenize(., '#')"/>
        <xsl:variable name="uuid" select="$uuidTypesTitleAndURL[1]"/>
        <xsl:if test="$uuids != '' and not($uuid = $associatedUuids)">
          <record>
            <uuid><xsl:value-of select="$uuid"/></uuid>
            <title><xsl:value-of select="$uuidTypesTitleAndURL[4]"/></title>
            <url><xsl:value-of select="$uuidTypesTitleAndURL[5]"/></url>
          </record>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <xsl:copy>
      <xsl:copy-of select="*"/>

      <xsl:for-each select="$uuidsToAdd">
        <dcat:record rdf:resource="{dcat:get-resource-iri(current(), $catalogUuid, $nodeUrl)}"/>
      </xsl:for-each>
    </xsl:copy>

    <xsl:for-each select="$uuidsToAdd">
      <xsl:variable name="datasetUri"
                          select="dcatutil:getRecordResourceURI(current())"
                          as="xs:string?"/>

      <dcat:CatalogRecord rdf:about="{dcat:get-resource-iri(current(), $catalogUuid, $nodeUrl)}">
        <dct:identifier><xsl:value-of select="current()/uuid"/></dct:identifier>
        <foaf:primaryTopic rdf:resource="{if ($datasetUri) then $datasetUri else dcat:get-resource-iri(current(), $catalogUuid, $nodeUrl)}"/>
        <xsl:if test="current()/title != ''">
          <dct:title><xsl:value-of select="current()/title"/></dct:title>
        </xsl:if>
        <dct:modified><xsl:value-of select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/></dct:modified>
      </dcat:CatalogRecord>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*[name() = ('dcat:Dataset', 'dcat:DataService', 'dcat:DatasetSeries') and $associationType = 'nextResource']">
    <xsl:variable name="resourceWithNext">
      <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="@*|*|text()"/>

        <xsl:variable name="existingNext" select="dcat:next"/>

        <xsl:variable name="uriToAdd" as="node()*">
          <xsl:for-each select="tokenize($uuids, ',')">
            <xsl:variable name="uuidTypesTitleAndURL" select="tokenize(., '#')"/>
            <xsl:variable name="uuid" select="$uuidTypesTitleAndURL[1]"/>
            <xsl:variable name="uri" select="util:getRecordResourceURI($uuid)"/>
            <xsl:if test="count($existingNext[@rdf:resource = $uri]) = 0">
              <record>
                <uuid><xsl:value-of select="$uuid"/></uuid>
                <uri><xsl:value-of select="$uri"/></uri>
              </record>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$uriToAdd">
          <dcat:next>
            <xsl:attribute name="rdf:resource" select="uri"/>
          </dcat:next>
        </xsl:for-each>
      </xsl:copy>
    </xsl:variable>
    <xsl:apply-templates mode="reorder" select="$resourceWithNext"/>
  </xsl:template>

  <xsl:template match="@*|*|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="geonet:*" priority="2"/>
</xsl:stylesheet>
