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
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_license_n26435fa9cbad42478bfbf8a6666a8687b14">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_issued_n26435fa9cbad42478bfbf8a6666a8687b15">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_modified_n26435fa9cbad42478bfbf8a6666a8687b18">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_rights_n26435fa9cbad42478bfbf8a6666a8687b19">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:rights"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_creator_n26435fa9cbad42478bfbf8a6666a8687b24">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:creator"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_description_n26435fa9cbad42478bfbf8a6666a8687b26">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_publisher_n26435fa9cbad42478bfbf8a6666a8687b27">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_title_n26435fa9cbad42478bfbf8a6666a8687b28">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_foaf_homepage_n26435fa9cbad42478bfbf8a6666a8687b29">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="foaf:homepage"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Location_dcat_bbox_n26435fa9cbad42478bfbf8a6666a8687b127">
    <sch:param name="context" value="//dct:Location[$profile]"/>
    <sch:param name="element" value="dcat:bbox"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Location_dcat_centroid_n26435fa9cbad42478bfbf8a6666a8687b128">
    <sch:param name="context" value="//dct:Location[$profile]"/>
    <sch:param name="element" value="dcat:centroid"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Location_locn_geometry_n26435fa9cbad42478bfbf8a6666a8687b129">
    <sch:param name="context" value="//dct:Location[$profile]"/>
    <sch:param name="element" value="locn:geometry"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_foaf_primaryTopic_n26435fa9cbad42478bfbf8a6666a8687b3">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="foaf:primaryTopic"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_modified_n26435fa9cbad42478bfbf8a6666a8687b4">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_conformsTo_n26435fa9cbad42478bfbf8a6666a8687b5">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:conformsTo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_issued_n26435fa9cbad42478bfbf8a6666a8687b6">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_adms_status_n26435fa9cbad42478bfbf8a6666a8687b7">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="adms:status"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_source_n26435fa9cbad42478bfbf8a6666a8687b9">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:source"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_skos_notation_n26435fa9cbad42478bfbf8a6666a8687b125">
    <sch:param name="context" value="//adms:Identifier[$profile]"/>
    <sch:param name="element" value="skos:notation"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="skos_Concept_skos_prefLabel_n26435fa9cbad42478bfbf8a6666a8687b31">
    <sch:param name="context" value="//skos:Concept[$profile]"/>
    <sch:param name="element" value="skos:prefLabel"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="skos_ConceptScheme_dct_title_n26435fa9cbad42478bfbf8a6666a8687b30">
    <sch:param name="context" value="//skos:ConceptScheme[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_description_n26435fa9cbad42478bfbf8a6666a8687b140">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_accrualPeriodicity_n26435fa9cbad42478bfbf8a6666a8687b141">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:accrualPeriodicity"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_modified_n26435fa9cbad42478bfbf8a6666a8687b143">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_publisher_n26435fa9cbad42478bfbf8a6666a8687b144">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_issued_n26435fa9cbad42478bfbf8a6666a8687b145">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_title_n26435fa9cbad42478bfbf8a6666a8687b147">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_accessRights_n26435fa9cbad42478bfbf8a6666a8687b34">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:accessRights"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_endpointURL_n26435fa9cbad42478bfbf8a6666a8687b39">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:endpointURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_license_n26435fa9cbad42478bfbf8a6666a8687b44">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_publisher_n26435fa9cbad42478bfbf8a6666a8687b45">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_title_n26435fa9cbad42478bfbf8a6666a8687b48">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_dcat_endDate_n26435fa9cbad42478bfbf8a6666a8687b130">
    <sch:param name="context" value="//dct:PeriodOfTime[$profile]"/>
    <sch:param name="element" value="dcat:endDate"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_time_hasBeginning_n26435fa9cbad42478bfbf8a6666a8687b131">
    <sch:param name="context" value="//dct:PeriodOfTime[$profile]"/>
    <sch:param name="element" value="time:hasBeginning"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_time_hasEnd_n26435fa9cbad42478bfbf8a6666a8687b132">
    <sch:param name="context" value="//dct:PeriodOfTime[$profile]"/>
    <sch:param name="element" value="time:hasEnd"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_dcat_startDate_n26435fa9cbad42478bfbf8a6666a8687b133">
    <sch:param name="context" value="//dct:PeriodOfTime[$profile]"/>
    <sch:param name="element" value="dcat:startDate"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="spdx_Checksum_spdx_algorithm_n26435fa9cbad42478bfbf8a6666a8687b32">
    <sch:param name="context" value="//spdx:Checksum[$profile]"/>
    <sch:param name="element" value="spdx:algorithm"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="spdx_Checksum_spdx_checksumValue_n26435fa9cbad42478bfbf8a6666a8687b33">
    <sch:param name="context" value="//spdx:Checksum[$profile]"/>
    <sch:param name="element" value="spdx:checksumValue"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_accessURL_n26435fa9cbad42478bfbf8a6666a8687b102">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:accessURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_ap_availability_n26435fa9cbad42478bfbf8a6666a8687b104">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat-ap:availability"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_byteSize_n26435fa9cbad42478bfbf8a6666a8687b105">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:byteSize"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_spdx_checksum_n26435fa9cbad42478bfbf8a6666a8687b106">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="spdx:checksum"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_compressFormat_n26435fa9cbad42478bfbf8a6666a8687b107">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:compressFormat"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_format_n26435fa9cbad42478bfbf8a6666a8687b111">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:format"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_odrl_hasPolicy_n26435fa9cbad42478bfbf8a6666a8687b112">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="odrl:hasPolicy"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_license_n26435fa9cbad42478bfbf8a6666a8687b114">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_mediaType_n26435fa9cbad42478bfbf8a6666a8687b116">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:mediaType"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_modified_n26435fa9cbad42478bfbf8a6666a8687b117">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_packageFormat_n26435fa9cbad42478bfbf8a6666a8687b118">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:packageFormat"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_issued_n26435fa9cbad42478bfbf8a6666a8687b119">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_rights_n26435fa9cbad42478bfbf8a6666a8687b120">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:rights"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_spatialResolutionInMeters_n26435fa9cbad42478bfbf8a6666a8687b121">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:spatialResolutionInMeters"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_adms_status_n26435fa9cbad42478bfbf8a6666a8687b122">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="adms:status"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_temporalResolution_n26435fa9cbad42478bfbf8a6666a8687b123">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:temporalResolution"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_dct_relation_n26435fa9cbad42478bfbf8a6666a8687b134">
    <sch:param name="context" value="//dcat:Relationship[$profile]"/>
    <sch:param name="element" value="dct:relation"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_dcat_hadRole_n26435fa9cbad42478bfbf8a6666a8687b135">
    <sch:param name="context" value="//dcat:Relationship[$profile]"/>
    <sch:param name="element" value="dcat:hadRole"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_accessRights_n26435fa9cbad42478bfbf8a6666a8687b49">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:accessRights"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_description_n26435fa9cbad42478bfbf8a6666a8687b55">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_accrualPeriodicity_n26435fa9cbad42478bfbf8a6666a8687b57">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:accrualPeriodicity"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_modified_n26435fa9cbad42478bfbf8a6666a8687b66">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_publisher_n26435fa9cbad42478bfbf8a6666a8687b69">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_issued_n26435fa9cbad42478bfbf8a6666a8687b73">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_spatialResolutionInMeters_n26435fa9cbad42478bfbf8a6666a8687b76">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:spatialResolutionInMeters"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_temporalResolution_n26435fa9cbad42478bfbf8a6666a8687b78">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:temporalResolution"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_title_n26435fa9cbad42478bfbf8a6666a8687b80">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_version_n26435fa9cbad42478bfbf8a6666a8687b82">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:version"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="foaf_Agent_dct_Agent_foaf_name_n26435fa9cbad42478bfbf8a6666a8687b1">
    <sch:param name="context" value="//foaf:Agent[$profile]|//dct:Agent[$profile]"/>
    <sch:param name="element" value="foaf:name"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="foaf_Agent_dct_Agent_dct_type_n26435fa9cbad42478bfbf8a6666a8687b2">
    <sch:param name="context" value="//foaf:Agent[$profile]|//dct:Agent[$profile]"/>
    <sch:param name="element" value="dct:type"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
</sch:schema>