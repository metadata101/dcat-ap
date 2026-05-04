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
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dcat_contactPoint_ndeb878b1f9374c21919885b0354af9a5b37">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_publisher_ndeb878b1f9374c21919885b0354af9a5b38">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_description_ndeb878b1f9374c21919885b0354af9a5b51">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_ap_availability_ndeb878b1f9374c21919885b0354af9a5b52">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat-ap:availability"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_format_ndeb878b1f9374c21919885b0354af9a5b53">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:format"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_license_ndeb878b1f9374c21919885b0354af9a5b54">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="foaf_Agent_dct_Agent_dct_type_ndeb878b1f9374c21919885b0354af9a5b8">
    <sch:param name="context" value="//foaf:Agent[$profile]|//dct:Agent[$profile]"/>
    <sch:param name="element" value="dct:type"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_servesDataset_ndeb878b1f9374c21919885b0354af9a5b23">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:servesDataset"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_endpointDescription_ndeb878b1f9374c21919885b0354af9a5b24">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:endpointDescription"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_contactPoint_ndeb878b1f9374c21919885b0354af9a5b25">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_publisher_ndeb878b1f9374c21919885b0354af9a5b26">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_theme_ndeb878b1f9374c21919885b0354af9a5b27">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:theme"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_conformsTo_ndeb878b1f9374c21919885b0354af9a5b28">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:conformsTo"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_keyword_ndeb878b1f9374c21919885b0354af9a5b29">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:keyword"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_language_ndeb878b1f9374c21919885b0354af9a5b12">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:language"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_issued_ndeb878b1f9374c21919885b0354af9a5b13">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_license_ndeb878b1f9374c21919885b0354af9a5b14">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_spatial_ndeb878b1f9374c21919885b0354af9a5b15">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:spatial"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_modified_ndeb878b1f9374c21919885b0354af9a5b16">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_themeTaxonomy_ndeb878b1f9374c21919885b0354af9a5b17">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dcat:themeTaxonomy"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_foaf_homepage_ndeb878b1f9374c21919885b0354af9a5b18">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="foaf:homepage"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_contactPoint_ndeb878b1f9374c21919885b0354af9a5b30">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_distribution_ndeb878b1f9374c21919885b0354af9a5b31">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:distribution"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_keyword_ndeb878b1f9374c21919885b0354af9a5b32">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:keyword"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_publisher_ndeb878b1f9374c21919885b0354af9a5b33">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_spatial_ndeb878b1f9374c21919885b0354af9a5b34">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:spatial"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_temporal_ndeb878b1f9374c21919885b0354af9a5b35">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:temporal"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_theme_ndeb878b1f9374c21919885b0354af9a5b36">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:theme"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_dcat_endDate_ndeb878b1f9374c21919885b0354af9a5b58">
    <sch:param name="context" value="//dct:PeriodOfTime[$profile]"/>
    <sch:param name="element" value="dcat:endDate"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_dcat_startDate_ndeb878b1f9374c21919885b0354af9a5b59">
    <sch:param name="context" value="//dct:PeriodOfTime[$profile]"/>
    <sch:param name="element" value="dcat:startDate"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Location_dcat_bbox_ndeb878b1f9374c21919885b0354af9a5b56">
    <sch:param name="context" value="//dct:Location[$profile]"/>
    <sch:param name="element" value="dcat:bbox"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Location_dcat_centroid_ndeb878b1f9374c21919885b0354af9a5b57">
    <sch:param name="context" value="//dct:Location[$profile]"/>
    <sch:param name="element" value="dcat:centroid"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_conformsTo_ndeb878b1f9374c21919885b0354af9a5b9">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:conformsTo"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_issued_ndeb878b1f9374c21919885b0354af9a5b10">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_adms_status_ndeb878b1f9374c21919885b0354af9a5b11">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="adms:status"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_LicenseDocument_dct_type_ndeb878b1f9374c21919885b0354af9a5b55">
    <sch:param name="context" value="//dct:LicenseDocument[$profile]"/>
    <sch:param name="element" value="dct:type"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
</sch:schema>