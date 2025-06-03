<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright (C) 2001-2016 Food and Agriculture Organization of the
  ~ United Nations (FAO-UN), United Nations World Food Programme (WFP)
  ~ and United Nations Environment Programme (UNEP)
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or (at
  ~ your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful, but
  ~ WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  ~ General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  ~
  ~ Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
  ~ Rome - Italy. email: geonetwork@osgeo.org
  -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:spdx="http://spdx.org/rdf/terms#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:adms="http://www.w3.org/ns/adms#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:schema="http://schema.org/"
                xmlns:cnt="http://www.w3.org/2011/content#"
                xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:java="java:org.fao.geonet.util.XslUtil"
                xmlns:gn="http://www.fao.org/geonetwork"
                xmlns:gn-fn-metadata="http://geonetwork-opensource.org/xsl/functions/metadata"
                xmlns:gn-fn-dcat-ap="http://geonetwork-opensource.org/xsl/functions/profiles/dcat-ap"
                xmlns:saxon="http://saxon.sf.net/"
                version="2.0"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all">

  <xsl:include href="utility-fn.xsl"/>
  <xsl:include href="utility-tpl.xsl"/>
  <xsl:include href="layout-custom-fields.xsl"/>
  <xsl:include href="layout-custom-tpl.xsl"/>
  <xsl:include href="layout-profile.xsl"/>

  <xsl:variable name="isDcatService" select="count($metadata/dcat:Catalog/dcat:service/dcat:DataService) > 0"/>

  <!-- Ignore all gn element -->
  <xsl:template mode="mode-dcat-ap" match="gn:*|@gn:*" priority="1000"/>

  <!-- Template to display non existing element ie. geonet:child element
  of the metadocument. Display in editing mode only and if
  the editor mode is not flat mode. -->
  <xsl:template mode="mode-dcat-ap" match="gn:child" priority="2000">
    <xsl:param name="schema" select="$schema" required="no"/>
    <xsl:param name="labels" select="$labels" required="no"/>

    <xsl:variable name="name" select="concat(@prefix, ':', @name)"/>
    <xsl:variable name="xpath">
      <xsl:choose>
        <xsl:when test="starts-with(concat(gn-fn-metadata:getXPath(..),'/',$name), '/dcat:Dataset/')">
          <xsl:value-of select="concat('/rdf:RDF/dcat:Catalog/dcat:dataset', gn-fn-metadata:getXPath(..),'/',$name)"/>
        </xsl:when>
        <xsl:when test="starts-with(concat(gn-fn-metadata:getXPath(..),'/',$name), '/dcat:DataService/')">
          <xsl:value-of select="concat('/rdf:RDF/dcat:Catalog/dcat:service', gn-fn-metadata:getXPath(..),'/',$name)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(gn-fn-metadata:getXPath(..),'/',$name)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="flatModeException"
                  select="gn-fn-metadata:isFieldFlatModeException($viewConfig, $name, $xpath) or gn-fn-metadata:isFieldFlatModeException($viewConfig, concat(name(..), '/', $name), $xpath)"/>

    <!-- TODO: this should be common to all schemas -->
    <xsl:if test="$isEditing and (not($isFlatMode) or $flatModeException)">

      <xsl:variable name="directive" select="gn-fn-metadata:getFieldAddDirective($editorConfig, $name)"/>

      <xsl:variable name="labelConfig" select="gn-fn-metadata:getLabel($schema, $name, $labels, name(..), '', $xpath)"/>
      <xsl:call-template name="render-element-to-add">
        <!-- TODO: add xpath and isoType to get label ? -->
        <xsl:with-param name="label" select="$labelConfig/label"/>
        <xsl:with-param name="btnLabel" select="$labelConfig/btnLabel"/>
        <xsl:with-param name="btnClass" select="if ($labelConfig/btnClass) then $labelConfig/btnClass else ''"/>
        <xsl:with-param name="directive" select="$directive"/>
        <xsl:with-param name="childEditInfo" select="."/>
        <xsl:with-param name="parentEditInfo" select="../gn:element"/>
        <xsl:with-param name="isFirst" select="count(preceding-sibling::*[name() = $name]) = 0"/>
        <!-- <xsl:with-param name="isForceLabel" select="true()"/> -->
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template mode="mode-dcat-ap" match="*[name() = $editorConfig/editor/fieldsWithFieldset/name]" priority="200">
    <xsl:param name="schema" select="$schema" required="no"/>
    <xsl:param name="labels" select="$labels" required="no"/>
    <xsl:param name="refToDelete" required="no"/>
    <xsl:variable name="name" select="name(.)"/>
    <xsl:variable name="isSupportingSlideToggle" select="$editorConfig/editor/fieldsWithFieldset/name[.=$name]/@isSupportingSlideToggle='true'"/>
    <xsl:variable name="xpath" select="gn-fn-metadata:getXPath(.)"/>
    <xsl:variable name="isoType" select="''"/>

    <xsl:variable name="errors">
      <xsl:if test="$showValidationErrors">
        <xsl:call-template name="get-errors"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="labelConfig" select="gn-fn-metadata:getLabel($schema, name(), $labels, name(..), $isoType, $xpath)"/>
    <xsl:call-template name="render-boxed-element">
      <xsl:with-param name="label" select="$labelConfig/label"/>
      <xsl:with-param name="editInfo" select="if ($refToDelete) then $refToDelete else gn:element"/>
      <xsl:with-param name="errors" select="$errors"/>
      <xsl:with-param name="cls" select="local-name()"/>
      <xsl:with-param name="xpath" select="$xpath"/>
      <!-- <xsl:with-param name="isSlideToggle" select="if ($isSupportingSlideToggle and $isDisplayingSections = false()) then 'true' else 'false'"/> -->
      <xsl:with-param name="subTreeSnippet">

        <xsl:if test="$isEditing">
          <!-- Render attributes as fields and overwrite the normal behavior -->
          <xsl:apply-templates mode="render-for-field-for-attribute-dcat-ap"
                               select="@*|gn:attribute[not(@name = parent::node()/@*/name())]">
            <xsl:with-param name="ref" select="gn:element/@ref"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:apply-templates mode="mode-dcat-ap" select="*">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="labels" select="$labels"/>
        </xsl:apply-templates>
      </xsl:with-param>
      <xsl:with-param name="isDisabled" select="name() = 'spdx:Checksum' or
                                                name() = 'vcard:Organization' or
                                                name() = 'adms:Identifier' or
                                                name() = 'vcard:Address' or
                                                name() = 'dct:PeriodOfTime' or
                                                name() = 'dct:ProvenanceStatement' or
                                                name() = 'foaf:Document' or
                                                name() = 'dct:Standard' or
                                                name() = 'dcat:Distribution' or
                                                name() = 'dct:LicenseDocument' or
                                                name() = 'dct:RightsStatement' or
                                                name() = 'foaf:Agent'"/>
    </xsl:call-template>

  </xsl:template>

  <!--
    ... but not the one proposing the list of elements to add in DC schema

    Template to display non existing element ie. geonet:child element
    of the metadocument. Display in editing mode only and if
  the editor mode is not flat mode. -->
  <xsl:template mode="mode-dcat-ap" match="gn:child[contains(@name, 'CHOICE_ELEMENT')]"  priority="3000">
    <xsl:if test="$isEditing and
      not($isFlatMode)">

      <!-- Create a new configuration to only create
            a add action for non existing node. The add action for
            the existing one is below the last element. -->
      <xsl:variable name="newElementConfig">
        <xsl:variable name="dcConfig" select="ancestor::node()/gn:child[contains(@name, 'CHOICE_ELEMENT')]"/>
        <xsl:variable name="existingElementNames" select="string-join(../descendant::*/name(), ',')"/>

        <gn:child>
          <xsl:copy-of select="$dcConfig/@*"/>
          <xsl:copy-of select="$dcConfig/gn:choose[not(contains($existingElementNames, @name))]"/>
        </gn:child>
      </xsl:variable>

      <xsl:call-template name="render-element-to-add">
        <xsl:with-param name="childEditInfo" select="$newElementConfig/gn:child"/>
        <xsl:with-param name="parentEditInfo" select="../gn:element"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Hide from the editor the dct:references pointing to uploaded files -->
  <xsl:template mode="mode-dcat-ap" priority="101"
                match="*[(name(.) = 'dct:references' or
                          name(.) = 'dc:relation') and
                         (starts-with(., 'http') or
                          contains(. , 'resources.get') or
                          contains(., 'file.disclaimer'))]" />


  <!-- the other elements in DC. -->
  <xsl:template mode="mode-dcat-ap" priority="100" match="dc:*|dct:*|dcat:*|vcard:*|foaf:*|spdx:*|adms:*|owl:*|schema:*|skos:*|mdcat:*|cnt:*">
    <xsl:param name="schema" select="$schema" required="no"/>
    <xsl:param name="labels" select="$labels" required="no"/>
    <xsl:param name="overrideLabel" select="''" required="no"/>
    <xsl:param name="refToDelete" required="no"/>

    <!-- Unify language code to use 3 letter code -->
    <xsl:variable name="elementLang">
      <xsl:choose>
        <xsl:when test="string-length(@xml:lang) = 3">
          <xsl:value-of select="java:twoCharLangCode(@xml:lang)"/>
        </xsl:when>
        <xsl:when test="string-length(@xml:lang) = 2">
          <xsl:value-of select="@xml:lang"/>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Skip translations. update-fixed-info takes care of having
    at least one element define in the main language. -->
    <xsl:if test="$metadataLanguage = ''
                         or not(@xml:lang)
                         or $elementLang = ('', $metadataLanguage)">

      <xsl:variable name="name" select="name(.)"/>
      <xsl:variable name="ref" select="gn:element/@ref"/>
      <xsl:variable name="labelConfig" as="node()" select="gn-fn-metadata:getLabel($schema, $name, $labels, name(..), '', gn-fn-metadata:getXPath(.))"/>
      <xsl:variable name="helper" select="gn-fn-metadata:getHelper($labelConfig/helper, .)"/>
      <xsl:variable name="added" select="parent::node()/parent::node()/@gn:addedObj"/>
      <xsl:variable name="container" select="parent::node()/parent::node()"/>


      <xsl:variable name="theElement"
                    select="."/>

      <xsl:variable name="attributes">
        <!-- Create form for all existing attribute (not in gn namespace)
        and all non existing attributes not already present for the
        current element and its children (eg. @uom in gco:Distance).
        A list of exception is defined in form-builder.xsl#render-for-field-for-attribute. -->
        <xsl:apply-templates mode="render-for-field-for-attribute-dcat-ap"
                             select="@*[name() != 'xml:lang']">
          <xsl:with-param name="ref" select="gn:element/@ref"/>
          <xsl:with-param name="insertRef" select="$theElement/gn:element/@ref"/>
        </xsl:apply-templates>
        <xsl:apply-templates mode="render-for-field-for-attribute"
                             select="gn:attribute[not(@name = parent::node()/@*/name())
                                                  and not(@name = 'xml:lang')]">
          <xsl:with-param name="ref" select="gn:element/@ref"/>
          <xsl:with-param name="insertRef" select="$theElement/gn:element/@ref"/>
        </xsl:apply-templates>
      </xsl:variable>


      <xsl:variable name="excluded"
                    select="gn-fn-dcat-ap:isNotMultilingualField(., $editorConfig)"/>
      <xsl:variable name="isMultilingualElement"
                    select="$metadataIsMultilingual and $excluded = false()"/>
      <xsl:variable name="isMultilingualElementExpanded"
                    select="$isMultilingualElement and count($editorConfig/editor/multilingualFields/expanded[name = $name]) > 0"/>
      <!--
      If main language is eng.
      Other language fre.

      <dcat:keyword xml:lang="eng">Water</dcat:keyword>
      <dcat:keyword xml:lang="fre">Eau</dcat:keyword>
      <dcat:keyword xml:lang="eng">Management plan</dcat:keyword>
      <dcat:keyword xml:lang="fre">Plan de gestion</dcat:keyword>
      <dcat:keyword xml:lang="eng">Well</dcat:keyword>
      fre is missing. Empty field is available.
      <dcat:keyword xml:lang="spa">Cuenca</dcat:keyword>
      main language eng is missing and spa not declared has other language. This is not supported.

      To retrieve multilingual element by group we assume that an
      element in the main language is defined and then
      we collect element by group.
      -->
      <xsl:variable name="numberOfElementWithMainLanguage"
                    select="count(preceding-sibling::*[name() = $name and @xml:lang = $metadataLanguage])"/>
      <xsl:variable name="elementId"
                    select="generate-id()"/>
      <xsl:variable name="translations"
                    select="following-sibling::*[
                                name() = $name
                                and @xml:lang != $metadataLanguage
                                and count(preceding-sibling::*[name() = $name and @xml:lang = $metadataLanguage]) = ($numberOfElementWithMainLanguage + 1)]"/>
      <xsl:variable name="hasTranslations"
                    select="count($translations) > 0"/>
      <!-- Skip following siblings -->

      <xsl:variable name="values">
        <xsl:if test="$isMultilingualElement">
          <values>
            <xsl:for-each select="$metadataOtherLanguages/lang">
              <xsl:variable name="code" select="@code"/>
              <xsl:variable name="currentLanguageId" select="@id"/>
              <xsl:variable name="translation"
                            select="$translations[@xml:lang = $code]"/>

              <!-- TODO: non existing element ? lang_{@code}_
              Should not happen. Update fixed info create empty element
              if required for all languages. -->
              <xsl:variable name="refForExistingElement"
                            select="if (@code = $metadataLanguage)
                                    then $ref
                                    else $translation/gn:element/@ref"/>
              <value ref="{$refForExistingElement}"
                     lang="{upper-case(@code)}">
                <xsl:value-of select="if (@code = $metadataLanguage)
                                      then $theElement/text()
                                      else $translation/text()"/>
              </value>
            </xsl:for-each>
          </values>
        </xsl:if>
      </xsl:variable>

      <!-- Add view and edit template-->
      <xsl:variable name="contextXpath" select="gn-fn-metadata:getXPath(.)"/>
      <xsl:variable name="fieldNode" select="$editorConfig/editor/fields/for[@name = $name and @templateModeOnly and (not(@xpath) or @xpath = $contextXpath)]"/>

      <xsl:variable name="catalogRecordUri"
                    select="ancestor::dcat:CatalogRecord/@rdf:about"/>
      <xsl:variable name="isVirtualCatalogAssociatedRecord"
                    select="$catalogRecordUri = ancestor::rdf:RDF/dcat:Catalog/dcat:record/@rdf:resource"/>

      <xsl:variable name="isDisabled" select="
            (name(.) = 'dct:identifier' and count(preceding-sibling::*[name(.) = 'dct:identifier']) = 0 and name(..) = ('dcat:Dataset', 'dcat:DataService')) or
            (name(..) = 'dcat:Distribution' and name(.) = ('dct:identifier')) or
            (name(.) = 'dct:identifier' and $isVirtualCatalogAssociatedRecord) or
            (name(..) = 'dcat:CatalogRecord' and not($isVirtualCatalogAssociatedRecord)) or
            (name(../../..) = 'dcat:CatalogRecord' and name(..) = 'dct:Standard')"/>

      <xsl:choose>
        <xsl:when test="count($fieldNode/*)>0 and $fieldNode/@templateModeOnly and not($isDisabled)">
          <xsl:variable name="del" select="'.'"/>
          <xsl:variable name="template" select="$fieldNode/template"/>
          <xsl:variable name="currentNode" select="." />
          <xsl:variable name="readonly">
            <xsl:choose>
              <xsl:when test="$template/values/@readonlyIf">
                <saxon:call-template name="{concat('evaluate-', $schema, '-boolean')}">
                  <xsl:with-param name="base" select="$currentNode"/>
                  <xsl:with-param name="in" select="concat('/', $template/values/@readonlyIf)"/>
                </saxon:call-template>
              </xsl:when>
            </xsl:choose>
          </xsl:variable>

          <xsl:variable name="templateCombinedWithNode" as="node()">
            <template>
              <xsl:copy-of select="$template/values"/>
              <snippet>
                <xsl:apply-templates mode="gn-merge" select="$template/snippet/*|$editorConfig/editor/snippets/list[@name = $template/snippets/@name]/snippet/*">
                  <xsl:with-param name="node-to-merge" select="$currentNode"/>
                </xsl:apply-templates>
              </snippet>
            </template>
          </xsl:variable>

          <xsl:variable name="keyValues">
            <xsl:call-template name="build-key-value-configuration">
              <xsl:with-param name="template" select="$template"/>
              <xsl:with-param name="currentNode" select="$currentNode"/>
              <xsl:with-param name="readonly" select="$readonly"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="originalNode"
                        select="gn-fn-metadata:getOriginalNode($metadata, .)"/>

          <xsl:variable name="refToDelete">
            <xsl:call-template name="get-ref-element-to-delete">
              <xsl:with-param name="node" select="$originalNode"/>
              <xsl:with-param name="delXpath" select="$del"/>
            </xsl:call-template>
          </xsl:variable>


          <!-- If the element exist, use the _X<ref> mode which
                insert the snippet for the element if not use the
                XPATH mode which will create the new element at the
                correct location. -->
          <xsl:variable name="id" select="concat('_X', gn:element/@ref, '_replace')"/>
          <xsl:call-template name="render-element-template-field">
            <xsl:with-param name="name" select="$labelConfig/label"/>
            <!--xsl:with-param name="name" select="$strings/*[name() = $name]" /-->
            <xsl:with-param name="btnLabel" select="$labelConfig/btnLabel"/>
            <xsl:with-param name="btnClass" select="if ($labelConfig/btnClass) then $labelConfig/btnClass else ''"/>
            <xsl:with-param name="id" select="$id"/>
            <xsl:with-param name="isExisting" select="true()"/>
            <xsl:with-param name="template" select="$templateCombinedWithNode"/>
            <xsl:with-param name="keyValues" select="$keyValues"/>
            <xsl:with-param name="refToDelete" select="$refToDelete/gn:element"/>
            <xsl:with-param name="isFirst" select="count(preceding-sibling::*[name() = $name]) = 0"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="xpath" select="gn-fn-metadata:getXPath(.)"/>
          <xsl:variable name="renderedElement">
            <xsl:call-template name="render-element">
              <xsl:with-param name="label" select="$labelConfig"/>
              <xsl:with-param name="value" select="if ($isMultilingualElement) then $values else ."/>
              <xsl:with-param name="cls" select="local-name()"/>
              <xsl:with-param name="xpath" select="$xpath"/>
              <xsl:with-param name="type" select="gn-fn-metadata:getFieldType($editorConfig, name(), '', $xpath)"/>
              <xsl:with-param name="name" select="if ($isEditing) then $ref else ''"/>
              <xsl:with-param name="editInfo" select="if ($refToDelete) then $refToDelete else gn:element"/>
              <xsl:with-param name="parentEditInfo" select="if ($added) then $container/gn:element else element()"/>
              <xsl:with-param name="listOfValues" select="$helper"/>
              <xsl:with-param name="toggleLang" select="$isMultilingualElementExpanded"/>
              <!-- When adding an element, the element container contains
              information about cardinality. -->
              <xsl:with-param name="isFirst"
                              select="if ($added) then
                            ($container/gn:element/@down = 'true' and not($container/gn:element/@up)) or
                            (not($container/gn:element/@down) and not($container/gn:element/@up))
                          else
                            (gn:element/@down = 'true' and not(gn:element/@up)) or
                            (not(gn:element/@down) and not(gn:element/@up))"/>
              <xsl:with-param name="isDisabled" select="$isDisabled"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="renderedAttribute">
            <xsl:if test="$isEditing">
              <!-- Render attributes as fields and overwrite the normal behavior -->
              <xsl:apply-templates mode="render-for-field-for-attribute-dcat-ap" select="@*|gn:attribute[not(@name = parent::node()/@*/name())]">
                <xsl:with-param name="ref" select="gn:element/@ref"/>
              </xsl:apply-templates>
            </xsl:if>
          </xsl:variable>

          <xsl:for-each select="$renderedElement/*">
            <xsl:copy copy-namespaces="no">
              <xsl:copy-of select="@*"/>
              <xsl:copy-of select="*"/>
              <xsl:copy-of select="$renderedAttribute"/>
            </xsl:copy>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:if test="name(.) = 'dct:identifier' and $isVirtualCatalogAssociatedRecord">
        <xsl:variable name="recordTitle"
                      select="java:getIndexField(
                                '',
                                normalize-space(text()),
                                'resourceTitleObject',
                                '')"/>

        <xsl:choose>
          <xsl:when test="$recordTitle != ''">
            <div class="col-sm-9 col-xs-11">
              <input type="text" readonly="readonly" value="{$recordTitle}" class="form-control"/>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <div class="col-sm-9 col-xs-11">
              <div class="alert alert-danger">
                <strong><xsl:value-of select="$strings/virtualCatalogAssociatedRecordNotFound"/></strong><br/>
                <xsl:value-of select="$strings/virtualCatalogAssociatedRecordNotFound-help"/>
              </div>
            </div>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <!-- Hide from the editor in default view -->
  <xsl:template mode="mode-dcat-ap" priority="2001"
                match="*[((name(.) = 'dcat:downloadURL' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'dct:issued' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'dct:identifier' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'dct:modified' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'dct:language' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'dcat:byteSize' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'spdx:checksum' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'dct:accessRights' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'foaf:page' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'adms:status' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'dcat:compressFormat' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'dcat:packageFormat' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'dcat:spatialResolutionInMeters' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'dcat:accessService' and name(..) = 'dcat:Distribution') or
                          (name(.) = 'dct:identifier' and name(..) = 'dct:LicenseDocument') or
                          (name(.) = 'dcat:temporalResolution' and name(..) = 'dcat:Distribution')) and
                          $isFlatMode]" />

  <!-- Ignore the following attributes in flatMode -->
  <xsl:template mode="render-for-field-for-attribute-dcat-ap" match="@*[$isFlatMode and name() != 'rdf:about']|@xml:lang|@gn:xsderror|@gn:addedObj" priority="101"/>

  <xsl:template mode="render-for-field-for-attribute-dcat-ap" match="@*" priority="100">
    <xsl:variable name="attributeName" select="name(.)"/>
    <xsl:variable name="ref" select="concat(../gn:element/@ref, '_', replace($attributeName, ':', 'COLON'))"/>
    <xsl:variable name="attribute" as="node()">
      <gn:attribute>
        <xsl:attribute name="ref" select="$ref"/>
        <xsl:copy-of select="../gn:attribute[@name = local-name()]/@*"/>
      </gn:attribute>
    </xsl:variable>
    <xsl:variable name="labelConfig" select="gn-fn-metadata:getLabel($schema, $attributeName, $labels, name(..), '', if (name(.)='xml:lang') then '' else gn-fn-metadata:getXPath(.))"/>
    <xsl:variable name="helper" select="gn-fn-metadata:getHelper($labelConfig/helper, .)"/>
    <xsl:variable name="xpath" select="gn-fn-metadata:getXPath(.)"/>

    <xsl:call-template name="render-element">
      <xsl:with-param name="label" select="$labelConfig"/>
      <xsl:with-param name="value" select="."/>
      <xsl:with-param name="cls" select="local-name()"/>
      <xsl:with-param name="xpath" select="$xpath"/>
      <xsl:with-param name="type" select="gn-fn-metadata:getFieldType($editorConfig, $attributeName, '', $xpath)"/>
      <xsl:with-param name="name" select="$ref"/>
      <xsl:with-param name="editInfo" select="$attribute"/>
      <xsl:with-param name="listOfValues" select="$helper"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="render-for-field-for-attribute-dcat-ap"
                match="gn:attribute[@name = ('rdf:nodeID', 'rdf:resource')]"
                priority="101"/>

  <xsl:template mode="render-for-field-for-attribute-dcat-ap"
                match="gn:attribute[not(@name = ('ref', 'parent', 'id', 'uuid', 'type', 'uuidref', 'xlink:show', 'xlink:actuate', 'xlink:arcrole', 'xlink:role', 'xlink:title', 'xlink:href')) and @add = 'true']"
                priority="100">
    <xsl:param name="ref"/>
    <xsl:variable name="xpath" select="gn-fn-metadata:getXPath(..)"/>
    <xsl:variable name="name" select="concat(@prefix, @name)"/>
    <xsl:if test="not($isFlatMode) or gn-fn-metadata:isFieldFlatModeException($viewConfig, $name, $xpath)">
      <xsl:if test="not(gn-fn-dcat-ap:isNotMultilingualField(.., $editorConfig))">
        <xsl:variable name="attributeLabel" select="gn-fn-metadata:getLabel($schema, @name, $labels, name(..), '', concat(gn-fn-metadata:getXPath(..),'/@',@name))"/>
        <div class="form-group gn-field gn-lang" id="gn-el-{$ref}_{replace(@name, ':', 'COLON')}">
          <label class="col-sm-2 control-label"/>
          <div class="col-sm-9 btn-group nopadding-in-table" style="float: none;">
            <button type="button" class="btn btn-default btn-xs"
                    data-gn-click-and-spin="add('{$ref}', '{@name}', '{$ref}', null, true)"
                    title="{$attributeLabel/description}">
              <i class="fa fa-plus fa-fw"/>
              <xsl:value-of select="$attributeLabel/label"/>
            </button>
          </div>
        </div>
      </xsl:if>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
