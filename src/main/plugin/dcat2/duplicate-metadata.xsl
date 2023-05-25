<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:uuid="java:java.util.UUID"
                version="2.0">

  <xsl:variable name="uuidRegex" select="'([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}'"/>
  <xsl:variable name="resource" select="/root/rdf:RDF/dcat:Catalog/dcat:dataset/dcat:Dataset|/root/rdf:RDF/dcat:Catalog/dcat:service/dcat:DataService"/>
  <xsl:variable name="resourceUUID" select="uuid:toString(uuid:randomUUID())"/>
  <xsl:variable name="resourceType">
    <xsl:message select="name($resource)"/>
    <xsl:choose>
      <xsl:when test="name($resource) = 'dcat:Dataset'">
        <xsl:value-of select="'datasets'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'services'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="resourceAbout" select="concat(/root/env/nodeURL, 'resources/', $resourceType, '/', $resourceUUID)"/>
  <!-- <xsl:variable name="resourceAbout"> -->
  <!--   <xsl:choose> -->
  <!--     <xsl:when test="matches($resource/@rdf:about, $uuidRegex)"> -->
  <!--       <xsl:value-of select="replace($resource/@rdf:about, $uuidRegex, $resourceUUID)"/> -->
  <!--     </xsl:when> -->
  <!--     <xsl:otherwise> -->
  <!--       <xsl:value-of select="concat(/root/env/nodeURL, 'resources/', $resourceType, '/', $resourceUUID)"/> -->
  <!--     </xsl:otherwise> -->
  <!--   </xsl:choose> -->
  <!-- </xsl:variable> -->

  <xsl:template match="/">
    <xsl:message select="/root/env"/>
    <xsl:apply-templates select="root/rdf:RDF"/>
  </xsl:template>

  <xsl:template match="foaf:primaryTopic">
    <xsl:element name="foaf:primaryTopic">
      <xsl:attribute name="rdf:resource" select="$resourceAbout"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="dcat:Dataset|dcat:DataService">
    <xsl:copy>
      <xsl:apply-templates select="@*[not(name() = 'rdf:about')]"/>

      <xsl:attribute name="rdf:about" select="$resourceAbout"/>
      <dct:identifier>
        <xsl:value-of select="$resourceUUID"/>
      </dct:identifier>
      <dct:title xml:lang="nl"/>

      <xsl:apply-templates select="dct:title[position() > 1]"/>

      <xsl:apply-templates select="*[name() != 'dct:identifier' and name() != 'dct:title']"/>
    </xsl:copy>
  </xsl:template>

  <!-- Migate old dct:subject to mdcat:statuut subclass -->
  <xsl:template match="dct:subject" priority="10">
    <mdcat:statuut>
      <xsl:apply-templates select="@*|*"/>
    </mdcat:statuut>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
