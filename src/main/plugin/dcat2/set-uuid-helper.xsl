<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:uuid="java:java.util.UUID">

  <xsl:variable name="record" select="/root/rdf:RDF/dcat:Catalog/dcat:record/dcat:CatalogRecord"/>

  <xsl:variable name="resource" select="/root/rdf:RDF/dcat:Catalog/dcat:dataset/dcat:Dataset|
                                        /root/rdf:RDF/dcat:Catalog/dcat:service/dcat:DataService"/>

  <xsl:variable name="uuidRegex"
                select="'([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}'"/>

  <xsl:variable name="resourceType">
    <xsl:choose>
      <xsl:when test="/root/rdf:RDF/dcat:Catalog/dcat:dataset/dcat:Dataset">
        <xsl:value-of select="'dataset'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'service'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="recordUUID" select="string(/root/env/uuid)"/>
  <xsl:variable name="recordAbout">
    <xsl:choose>
      <xsl:when test="matches($record/@rdf:about, $uuidRegex)">
        <xsl:value-of select="replace($record/@rdf:about, $uuidRegex, $recordUUID)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat(/root/env/nodeURL, 'api/records/', $recordUUID)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="resourceUUID" select="uuid:toString(uuid:randomUUID())"/>
  <xsl:variable name="resourceAbout">
    <xsl:choose>
      <xsl:when test="matches($resource/@rdf:about, $uuidRegex)">
        <xsl:value-of select="replace($resource/@rdf:about, $uuidRegex, $resourceUUID)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat(/root/env/nodeURL, 'doc/', $resourceType, '/', $resourceUUID)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- ============================================== -->

  <xsl:template name="generate-record">
    <xsl:element name="dcat:record">
      <xsl:element name="dcat:CatalogRecord">
        <xsl:attribute name="rdf:about" select="$recordAbout"/>
        <dct:identifier>
          <xsl:value-of select="$recordUUID"/>
        </dct:identifier>
        <xsl:call-template name="generate-primaryTopic"/>
        <dct:modified>
          <xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01]')"/>
        </dct:modified>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template name="generate-primaryTopic">
    <xsl:element name="foaf:primaryTopic">
      <xsl:attribute name="rdf:resource" select="$resourceAbout"/>
    </xsl:element>
  </xsl:template>

  <!-- ============================================== -->

  <xsl:template match="dcat:Catalog[not(dcat:record)]">
    <xsl:copy>
      <xsl:apply-templates select="@*|dct:title|dct:description|dct:publisher|dct:rightsHolder|foaf:homepage|dct:license|dct:language|
                                   dct:issued|dct:modified|dcat:themeTaxonomy|dct:hasPart|dct:isPartOf"/>

      <xsl:call-template name="generate-record"/>

      <xsl:apply-templates select="dct:rights|dct:spatial|dcat:dataset|dcat:service|dcat:contactPoint|dcat:keyword|
                                   dcat:landingPage|dcat:qualifiedRelation|dct:subject|mdcat:MAGDA-categorie|mdcat:statuut|
                                   dcat:theme|dct:accessRights|dct:conformsTo|dct:creator|dct:identifier|dct:isReferencedBy|
                                   dct:relation|dct:type"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="dcat:record[not(dcat:CatalogRecord)]">
    <xsl:call-template name="generate-record"/>
  </xsl:template>

  <xsl:template match="dcat:CatalogRecord">
    <xsl:copy>
      <xsl:apply-templates select="@*[not(name(.) = 'rdf:about')]"/>
      <xsl:attribute name="rdf:about" select="$recordAbout"/>
      <xsl:element name="dct:identifier">
        <xsl:value-of select="$recordUUID"/>
      </xsl:element>
      <xsl:call-template name="generate-primaryTopic"/>
      <xsl:if test="not(dct:modified)">
        <xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01]')"/>
      </xsl:if>
      <xsl:apply-templates select="*[name(.) != 'dct:identifier' and name(.) != 'foaf:primaryTopic']"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
