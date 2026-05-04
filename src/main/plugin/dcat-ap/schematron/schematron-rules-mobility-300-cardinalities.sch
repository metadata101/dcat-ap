<?xml version="1.0" encoding="utf-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
  <sch:ns prefix="spdx" uri="http://spdx.org/rdf/terms#"/>
  <sch:ns prefix="owl" uri="http://www.w3.org/2002/07/owl#"/>
  <sch:ns prefix="adms" uri="http://www.w3.org/ns/adms#"/>
  <sch:ns prefix="locn" uri="http://www.w3.org/ns/locn#"/>
  <sch:ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
  <sch:ns prefix="foaf" uri="http://xmlns.com/foaf/0.1/"/>
  <sch:ns prefix="dct" uri="http://purl.org/dc/terms/"/>
  <sch:ns prefix="vcard" uri="http://www.w3.org/2006/vcard/ns#"/>
  <sch:ns prefix="dcat" uri="http://www.w3.org/ns/dcat#"/>
  <sch:ns prefix="schema" uri="http://schema.org/"/>
  <sch:ns prefix="rdf" uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
  <sch:ns prefix="shacl" uri="https://purl.eu/ns/shacl#"/>
  <sch:ns prefix="skos" uri="http://www.w3.org/2004/02/skos/core#"/>
  <sch:ns prefix="xml" uri="http://www.w3.org/XML/1998/namespace"/>
  <sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
  <sch:ns prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
  <sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>
  <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
  <sch:ns prefix="mdcat" uri="https://data.vlaanderen.be/ns/metadata-dcat#"/>
  <sch:ns prefix="geodcat" uri="http://data.europa.eu/930/"/>
  <sch:ns prefix="geodcat-w3c" uri="http://www.w3.org/ns/geodcat#"/>
  <sch:ns prefix="generiek" uri="http://data.vlaanderen.be/ns/generiek#"/>
  <sch:ns prefix="rdfs" uri="http://www.w3.org/2000/01/rdf-schema#"/>
  <sch:ns prefix="sh" uri="http://www.w3.org/ns/shacl#"/>
  <sch:ns prefix="mobilitydcatap" uri="https://w3id.org/mobilitydcat-ap#"/>
  <sch:ns prefix="oa" uri="http://www.w3.org/ns/oa#"/>
  <sch:ns prefix="content" uri="http://www.w3.org/2011/content#"/>
  <sch:ns prefix="org" uri="http://www.w3.org/ns/org#"/>
  <sch:ns prefix="prov" uri="http://www.w3.org/ns/prov#"/>
  <sch:ns prefix="dcat-ap" uri="http://data.europa.eu/r5r/"/>
  <sch:ns prefix="odrl" uri="http://www.w3.org/ns/odrl/2/"/>
  <sch:ns prefix="dqv" uri="http://www.w3.org/ns/dqv#"/>
  <sch:ns prefix="eli" uri="http://data.europa.eu/eli/ontology#"/>
  <sch:ns prefix="time" uri="http://www.w3.org/2006/time#"/>
  <sch:title xmlns="http://www.w3.org/2001/XMLSchema">{$loc/strings/schematron.title}</sch:title>
  <sch:let name="profile" value="true()"/>
  <sch:pattern abstract="true" id="CardinalityCheck">
    <sch:title>geonet:replacePlaceholders($loc/strings/cardinality.title, ('#context', '#element'), ('$context', '$element'))</sch:title>
    <sch:rule context="$context">
      <sch:assert test="count($element) &gt;= $min and ('$max' = 'n' or count($element) &lt;= $max)">
        <sch:value-of select="geonet:replacePlaceholders($loc/strings/cardinality.assert, ('#context', '#element', '#min', '#max', '#nodecount'), ('$context', '$element', '$min', '$max', string(count($element))))"/>
      </sch:assert>
      <sch:report test="count($element) &gt;= $min and ('$max' = 'n' or count($element) &lt;= $max)">
        <sch:value-of select="geonet:replacePlaceholders($loc/strings/cardinality.report, ('#context', '#element', '#min', '#max', '#nodecount'), ('$context', '$element', '$min', '$max', string(count($element))))"/>
      </sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern abstract="true" id="MultilingualCardinalityCheck">
    <sch:title>geonet:replacePlaceholders($loc/strings/multilingual.cardinality.title, ('#context', '#element'), ('$context', '$element'))</sch:title>
    <sch:rule context="$context">
      <sch:assert test="(count($element[@xml:lang]) = 0 or count($element[not(@xml:lang)]) = 0) and ((count(distinct-values($element/@xml:lang)) = count($element[@xml:lang])) or '$max' = 'n') and ((count($element[not(@xml:lang)]) &lt;= 1) or '$max' = 'n') and (count(distinct-values($element/@xml:lang)) &gt;= $min or (count($element[not(@xml:lang)]) &gt;= $min))">
        <sch:value-of select="geonet:replacePlaceholders($loc/strings/multilingual.cardinality.assert, ('#min'), ('$min'))"/>
      </sch:assert>
      <sch:report test="(count($element[@xml:lang]) = 0 or count($element[not(@xml:lang)]) = 0) and ((count(distinct-values($element/@xml:lang)) = count($element[@xml:lang])) or '$max' = 'n') and ((count($element[not(@xml:lang)]) &lt;= 1) or '$max' = 'n') and (count(distinct-values($element/@xml:lang)) &gt;= $min or (count($element[not(@xml:lang)]) &gt;= $min))">
        <sch:value-of select="geonet:replacePlaceholders($loc/strings/multilingual.cardinality.report, ('#min'), ('$min'))"/>
      </sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_accessURL_https___w3id_org_mobilitydcat_ap_drafts_latest_Distribution_Shape_accessURL">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:accessURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_mobilitydcatap_mobilityDataStandard_https___w3id_org_mobilitydcat_ap_drafts_latest_Distribution_Shape_mobilityDataStandard">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="mobilitydcatap:mobilityDataStandard"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_format_https___w3id_org_mobilitydcat_ap_drafts_latest_Distribution_Shape_format">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:format"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_rights_https___w3id_org_mobilitydcat_ap_drafts_latest_Distribution_Shape_rights">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:rights"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_vcard_hasEmail_https___w3id_org_mobilitydcat_ap_drafts_latest_Kind_Shape_email">
    <sch:param name="context" value="//vcard:Organization[$profile]|//vcard:Kind[$profile]"/>
    <sch:param name="element" value="vcard:hasEmail"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_vcard_fn_https___w3id_org_mobilitydcat_ap_drafts_latest_Kind_Shape_name">
    <sch:param name="context" value="//vcard:Organization[$profile]|//vcard:Kind[$profile]"/>
    <sch:param name="element" value="vcard:fn"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="skos_Concept_skos_prefLabel_https___w3id_org_mobilitydcat_ap_drafts_latest_Category_Shape_prefLabel">
    <sch:param name="context" value="//skos:Concept[$profile]"/>
    <sch:param name="element" value="skos:prefLabel"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="skos_Concept_skos_inScheme_https___w3id_org_mobilitydcat_ap_drafts_latest_Category_Shape_inScheme">
    <sch:param name="context" value="//skos:Concept[$profile]"/>
    <sch:param name="element" value="skos:inScheme"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_description_https___w3id_org_mobilitydcat_ap_drafts_latest_DatasetSeries_Shape_description">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_publisher_https___w3id_org_mobilitydcat_ap_drafts_latest_DatasetSeries_Shape_publisher">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_title_https___w3id_org_mobilitydcat_ap_drafts_latest_DatasetSeries_Shape_title">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_RightsStatement_dct_type_https___w3id_org_mobilitydcat_ap_drafts_latest_RightsStatement_Shape_type">
    <sch:param name="context" value="//dct:RightsStatement[$profile]"/>
    <sch:param name="element" value="dct:type"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_foaf_homepage_https___w3id_org_mobilitydcat_ap_drafts_latest_Catalogue_Shape_homepage_mandatory">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="foaf:homepage"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_record_https___w3id_org_mobilitydcat_ap_drafts_latest_Catalogue_Shape_record_mandatory">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dcat:record"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_spatial_https___w3id_org_mobilitydcat_ap_drafts_latest_Catalogue_Shape_spatial_mandatory">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:spatial"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_title_https___w3id_org_mobilitydcat_ap_drafts_latest_Catalogue_Shape_title">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_description_https___w3id_org_mobilitydcat_ap_drafts_latest_Catalogue_Shape_description">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="skos_ConceptScheme_dct_title_https___w3id_org_mobilitydcat_ap_drafts_latest_CategoryScheme_Shape_title">
    <sch:param name="context" value="//skos:ConceptScheme[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_description_https___w3id_org_mobilitydcat_ap_drafts_latest_Dataset_Shape_description">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_distribution_https___w3id_org_mobilitydcat_ap_drafts_latest_Dataset_Shape_distribution">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:distribution"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_accrualPeriodicity_https___w3id_org_mobilitydcat_ap_drafts_latest_Dataset_Shape_accrualPeriodicity">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:accrualPeriodicity"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_mobilitydcatap_mobilityTheme_https___w3id_org_mobilitydcat_ap_drafts_latest_Dataset_Shape_mobilityTheme">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="mobilitydcatap:mobilityTheme"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_spatial_https___w3id_org_mobilitydcat_ap_drafts_latest_Dataset_Shape_spatial">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:spatial"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_title_https___w3id_org_mobilitydcat_ap_drafts_latest_Dataset_Shape_title">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_publisher_https___w3id_org_mobilitydcat_ap_drafts_latest_Dataset_Shape_publisher">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_language_https___w3id_org_mobilitydcat_ap_drafts_latest_CatalogueRecord_Shape_language_mandatory">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:language"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_created_https___w3id_org_mobilitydcat_ap_drafts_latest_CatalogueRecord_Shape_creationDate">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:created"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
</sch:schema>