<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:adms="http://www.w3.org/ns/adms#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all">
  <!--
    Create reference block to metadata record and dataset to be added in dcat:Catalog usually.
  -->
  <xsl:variable name="recordPrefix"
                select="concat(/root/gui/systemConfig/metadata/resourceIdentifierPrefix, '/records/')"/>

  <xsl:template mode="record-reference" match="rdf:RDF">
    <xsl:if test="dcat:Catalog/dcat:record/dcat:CatalogRecord/@rdf:about">
      <dcat:record rdf:resource="{dcat:Catalog/dcat:record/dcat:CatalogRecord/@rdf:about}"/>
    </xsl:if>
    <xsl:if test="dcat:Catalog/dcat:dataset/dcat:Dataset/@rdf:about">
      <dcat:dataset rdf:resource="{dcat:Catalog/dcat:dataset/dcat:Dataset/@rdf:about}"/>
    </xsl:if>
    <xsl:if test="dcat:Catalog/dcat:service/dcat:DataService/@rdf:about">
      <dcat:service rdf:resource="{dcat:Catalog/dcat:service/dcat:DataService/@rdf:about}"/>
    </xsl:if>
  </xsl:template>

  <xsl:template mode="references" match="rdf:RDF"/>
  <xsl:template mode="rdf:RDF" match="gui|request|metadata"/>


  <xsl:template mode="to-dcat" match="rdf:RDF">
    <xsl:apply-templates mode="dcat-ap-rdf-export" select="dcat:Catalog/dcat:record/dcat:CatalogRecord"/>
    <xsl:apply-templates mode="dcat-ap-rdf-export" select="dcat:Catalog/dcat:dataset/dcat:Dataset|dcat:Catalog/dcat:service/dcat:DataService"/>
  </xsl:template>

  <!-- Remove empty rdf:about from export -->
  <xsl:template mode="dcat-ap-rdf-export" match="*[@rdf:about and normalize-space(@rdf:about) = '']">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates mode="dcat-ap-rdf-export" select="*|@*[name() != 'rdf:about']"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template mode="dcat-ap-rdf-export" match="dcat:CatalogRecord[normalize-space(@rdf:about) = '']" priority="10">
    <xsl:copy copy-namespaces="no">
      <xsl:variable name="recordURI" select="concat($recordPrefix, dct:identifier[1])"/>
      <xsl:attribute name="rdf:about" select="$recordURI"/>
      <xsl:call-template name="alternative-identifier">
        <xsl:with-param name="identifier" select="$recordURI"/>
      </xsl:call-template>
      <xsl:apply-templates mode="dcat-ap-rdf-export" select="*|@*[name() != 'rdf:about']"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template mode="dcat-ap-rdf-export" match="dcat:CatalogRecord[normalize-space(@rdf:about) != '']" priority="10">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates mode="dcat-ap-rdf-export" select="@*"/>
      <xsl:call-template name="alternative-identifier"/>
      <xsl:apply-templates mode="dcat-ap-rdf-export" select="*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template mode="dcat-ap-rdf-export" match="dcat:Dataset|dcat:DataService" priority="10">
    <xsl:copy copy-namespaces="no">
      <xsl:choose>
        <xsl:when test="normalize-space(@rdf:about) != ''">
          <xsl:apply-templates mode="dcat-ap-rdf-export" select="@rdf:about"/>
          <xsl:call-template name="alternative-identifier"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="primaryTopic" select="normalize-space(//foaf:primaryTopic[1]/@rdf:resource)"/>
          <xsl:if test="$primaryTopic != ''">
            <xsl:attribute name="rdf:about" select="$primaryTopic"/>
            <xsl:call-template name="alternative-identifier">
              <xsl:with-param name="identifier" select="$primaryTopic"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="dcat-ap-rdf-export" select="@*[name() != 'rdf:about']|*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template mode="dcat-ap-rdf-export" match="*[@rdf:resource and contains(@rdf:resource, ' ')]">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates mode="dcat-ap-rdf-export" select="@*[name() != 'rdf:resource']"/>
      <xsl:choose>
        <xsl:when test="normalize-space(@rdf:resource) = ''">
          <xsl:attribute name="rdf:resource" select="''"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="rdf:resource" select="replace(@rdf:resource, ' ', '%20')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <xsl:template mode="dcat-ap-rdf-export" match="@*|*">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates mode="dcat-ap-rdf-export" select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="alternative-identifier">
    <xsl:param name="identifier" select="@rdf:about" as="xs:string"/>
    <xsl:if test="not(adms:identifier)">
      <adms:identifier>
        <adms:Identifier>
          <skos:notation>
            <xsl:value-of select="$identifier"/>
          </skos:notation>
        </adms:Identifier>
      </adms:identifier>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
