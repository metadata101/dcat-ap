<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:mobilitydcatap="https://w3id.org/mobilitydcat-ap"
                xmlns:gn="http://www.fao.org/geonetwork"
                xmlns:gn-fn-dcat-ap="http://geonetwork-opensource.org/xsl/functions/profiles/dcat-ap"
                xmlns:java="java:org.fao.geonet.util.XslUtil"
                xmlns:gn-fn-metadata="http://geonetwork-opensource.org/xsl/functions/metadata"
                version="2.0"
                exclude-result-prefixes="#all">

  <xsl:include href="../process/process-utility.xsl"/>

  <xsl:variable name="dcatKeywordConfig">
    <xsl:for-each select="$editorConfig/editor/fields/for[@use='thesaurus-list-picker']">
      <xsl:copy-of select="gn-fn-dcat-ap:buildThesaurusConfiguration(.)"/>
    </xsl:for-each>
  </xsl:variable>

  <xsl:function name="gn-fn-dcat-ap:buildThesaurusConfiguration" as="node()?">
    <xsl:param name="config" as="node()?"/>

    <xsl:if test="$config">
      <element>
        <xsl:attribute name="name" select="$config/@name"/>
        <xsl:if test="$config/@xpath">
          <xsl:attribute name="parent" select="$config/@xpath"/>
        </xsl:if>
        <thesaurus>
          <xsl:value-of select="$config/directiveAttributes/@thesaurus"/>
        </thesaurus>
        <xpath>
          <xsl:value-of select="$config/directiveAttributes/@xpath"/>
        </xpath>
        <max>
          <xsl:value-of select="$config/directiveAttributes/@max"/>
        </max>
        <labelKey>
          <xsl:value-of select="$config/directiveAttributes/@labelKey"/>
        </labelKey>
        <useReference>
          <xsl:value-of select="$config/directiveAttributes/@useReference"/>
        </useReference>
        <profile>
          <xsl:value-of select="string($config/@profile)"/>
        </profile>
      </element>
    </xsl:if>
  </xsl:function>


  <!-- Element using a thesaurus .-->
  <xsl:template mode="mode-dcat-ap"
                         priority="4000"
                        match="*[(skos:Concept or @rdf:resource) and gn-fn-dcat-ap:getThesaurusConfig(name(), name(..))]|dcat:theme">
    <xsl:param name="config" required="no"/>

    <xsl:if test="not(preceding-sibling::*[1]) or preceding-sibling::*[1]/name() != current()/name()">
      <xsl:variable name="xpath" select="concat('/', name(../..), '/', name(..), '/', name())"/>

      <xsl:variable name="globalEditorConfig" select="gn-fn-dcat-ap:getThesaurusConfig(name(), name(..), $xpath)"/>
      <xsl:variable name="fieldEditorConfig" select="if ($config) then gn-fn-dcat-ap:buildThesaurusConfiguration($config) else null"/>

      <xsl:variable name="applicableConfig"
                    select="if ($fieldEditorConfig/thesaurus != '') then $fieldEditorConfig else $globalEditorConfig"/>
      <xsl:call-template name="thesaurus-picker-list">
        <xsl:with-param name="config" select="$applicableConfig"/>
        <xsl:with-param name="ref" select="../gn:element/@ref"/>
        <xsl:with-param name="keywords" select="../*[name() = $applicableConfig/@name]"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Element not present in current document and using a thesaurus. -->
  <xsl:template mode="mode-dcat-ap"
                        priority="4000"
                        match="gn:child[(not(preceding-sibling::*[1]) or preceding-sibling::*[1]/name() != concat(@prefix, ':', @name))
                                        and gn-fn-dcat-ap:getThesaurusConfig(concat(@prefix, ':', @name), name(..))]">
    <xsl:param name="config" required="no"/>

    <xsl:variable name="xpath" select="concat('/', name(../..), '/', name(..), '/', concat(@prefix, ':', @name))"/>
    <xsl:variable name="globalEditorConfig" select="gn-fn-dcat-ap:getThesaurusConfig(concat(@prefix, ':', @name), name(..), $xpath)"/>
    <xsl:variable name="fieldEditorConfig" select="if ($config) then gn-fn-dcat-ap:buildThesaurusConfiguration($config) else null"/>

    <xsl:call-template name="thesaurus-picker-list">
      <xsl:with-param name="config" select="if ($fieldEditorConfig/thesaurus != '') then $fieldEditorConfig else $globalEditorConfig"/>
      <xsl:with-param name="ref" select="../gn:element/@ref"/>
      <xsl:with-param name="keywords" select="null"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="mode-dcat-ap" match="*[skos:Concept]">
    <xsl:message>WARNING: Element <xsl:value-of select="name()"/> using skos:concept without the associated thesaurus.
      Add the vocabulary in the catalog and check config-editor.xml and add configuration eg.
      <for name="{name()}" use="thesaurus-list-picker">
        <directiveAttributes
          thesaurus="external.theme.{local-name()}"
          xpath="/{name()}"
          labelKey="{name()}"/>
      </for>
      or create a dedicated XSL template to handle that element.
    </xsl:message>
  </xsl:template>

  <xsl:template mode="mode-dcat-ap"
                priority="4000"
                match="gn:child[preceding-sibling::*[1]/name() = concat(@prefix, ':', @name)
                                        and gn-fn-dcat-ap:getThesaurusConfig(concat(@prefix, ':', @name), name(..))]">
    <!-- Do not create a default add button for all fields using a thesaurus
    and which are already defined in the current record.
    The thesaurus picker takes care of adding one or more keywords for that field. -->
  </xsl:template>

  <xsl:template name="thesaurus-picker-list">
    <xsl:param name="config" as="node()"/>
    <xsl:param name="ref" as="xs:string"/>
    <xsl:param name="keywords" as="node()*"/>

    <xsl:if test="gn-fn-dcat-ap:shouldShow($config)">
      <xsl:variable name="values">
        <xsl:choose>
          <xsl:when test="$config/useReference = 'true' and $keywords/@rdf:resource">
            <xsl:for-each select="$keywords">
              <xsl:variable name="v" select="replace(java:getKeywordValueByUri(@rdf:resource, $config/thesaurus, $lang), ',', ',,')"/>
              <xsl:variable name="vfallback" select="replace(java:getKeywordValueByUri(@rdf:resource, $config/thesaurus, 'eng'), ',', ',,')"/>
              <xsl:choose>
                <xsl:when test="$v">
                  <xsl:value-of select="$v"/>
                  <xsl:if test="position() != last()">,</xsl:if>
                </xsl:when>
                <xsl:when test="$vfallback">
                  <xsl:value-of select="$vfallback"/>
                  <xsl:if test="position() != last()">,</xsl:if>
                </xsl:when>
              </xsl:choose>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="$keywords//(skos:prefLabel[text() != ''])[1]">
            <xsl:value-of select="string-join($keywords//(skos:prefLabel[text() != ''])[1]/replace(text(), ',', ',,'), ',')"/>
          </xsl:when>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="keywordIds"
                    select="string-join($keywords/(@rdf:resource|*/@rdf:about), ',')"/>

      <xsl:variable name="transformation" select="if ($config/useReference = 'true')
                                                then 'to-dcat-ap-concept-reference'
                                                else 'to-dcat-ap-concept'"/>
      <xsl:variable name="elemXpath">
        <xsl:call-template name="GetThesaurusElementXpath">
          <xsl:with-param name="config" select="$config"/>
        </xsl:call-template>
      </xsl:variable>

      <div data-gn-keyword-selector="tagsinput"
           data-metadata-id=""
           data-element-ref="{concat('_P', $ref, '_', replace($config/@name, ':', 'COLON'))}"
           data-element-xpath="{$elemXpath}"
           data-wrapper="{$config/@name}"
           data-thesaurus-title="{($strings/*[name() = $config/labelKey], $labels/element[@name = $config/@name]/label)[1]}"
           data-thesaurus-key="{$config/thesaurus}"
           data-keywords="{$values}"
           data-keyword-ids="{$keywordIds}"
           data-transformations="{$transformation}"
           data-current-transformation="{$transformation}"
           data-max-tags="{$config/max}"
           data-lang="{$metadataOtherLanguagesAsJson}"
           data-textgroup-only="false"
           data-alt-save="true"
           data-max-searched="{if ($config/@name = 'dct:language') then 400 else 200}"
           class=""/>
    </xsl:if>
  </xsl:template>


  <xsl:template name="GetThesaurusElementXpath">
    <xsl:param name="config" as="node()"/>
    <xsl:variable name="resourcePath"
                  select="concat('./dcat:Catalog',
                                  if (ancestor::*[1]/name() = 'dcat:Catalog') then ''
                                  else if (ancestor::*[1]/name() = 'dcat:CatalogRecord') then '/dcat:record/dcat:CatalogRecord'
                                  else if ($isDcatService) then '/dcat:service/dcat:DataService'
                                  else '/dcat:dataset/dcat:Dataset')"/>

    <xsl:choose>
      <xsl:when test="starts-with($config/xpath, '/dcat:Distribution')">
        <xsl:value-of select="concat('(', $resourcePath, '/dcat:distribution)[dcat:Distribution/@rdf:about=''', ../@rdf:about ,''']', $config/xpath)"/>
      </xsl:when>
      <xsl:when test="starts-with($config/xpath, '/dct:license') and not($isDcatService)">
        <xsl:value-of select="concat(
          '(',
          $resourcePath,
          '/dcat:distribution)[dcat:Distribution/@rdf:about=''',
          gn-fn-metadata:getOriginalNode($metadata, ..)/ancestor::dcat:Distribution/@rdf:about ,''']',
          '/dcat:Distribution',
          $config/xpath
        )"/>
      </xsl:when>
      <xsl:when test="starts-with($config/xpath, '/foaf:Agent')">
        <xsl:variable name="wrapper" select="name(../..)"/>
        <xsl:variable name="index" select="count(../../preceding-sibling::*[name() = $wrapper]) + 1"/>
        <xsl:value-of select="concat('(', $resourcePath, '/', name(../..), ')[', $index, ']', $config/xpath)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($resourcePath, $config/xpath)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:function name="gn-fn-dcat-ap:getThesaurusConfig">
    <xsl:param name="name" as="xs:string"/>
    <xsl:param name="parent" as="xs:string"/>
    <xsl:copy-of select="gn-fn-dcat-ap:getThesaurusConfig($name, $parent, '')"/>
  </xsl:function>

  <xsl:function name="gn-fn-dcat-ap:getThesaurusConfig">
    <xsl:param name="name" as="xs:string"/>
    <xsl:param name="parent" as="xs:string"/>
    <xsl:param name="xpath" as="xs:string"/>
    <xsl:variable name="config" select="if ($dcatKeywordConfig/*[@name = $name and @parent = $parent])
                         then $dcatKeywordConfig/*[@name = $name and @parent = $parent]
                         else $dcatKeywordConfig/*[@name = $name and not(@parent)]"/>

    <xsl:choose>
      <xsl:when test="count($config) = 1">
        <xsl:copy-of select="$config"/>
      </xsl:when>
      <xsl:when test="$config[xpath = $xpath]">
        <xsl:copy-of select="$config[xpath = $xpath]"/>
      </xsl:when>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="gn-fn-dcat-ap:shouldShow" as="xs:boolean">
    <xsl:param name="config"/>

    <xsl:value-of select="not($isFlatMode) or not(
      ($config/@name = 'dct:accessRights' and $config/@parent = 'dcat:Distribution') or
      ($config/@name = 'dcat:compressFormat') or
      ($config/@name = 'dcat:packageFormat') or
      (normalize-space($config/profile) != '' and $config/profile != $profile)
    )"/>
  </xsl:function>

</xsl:stylesheet>
