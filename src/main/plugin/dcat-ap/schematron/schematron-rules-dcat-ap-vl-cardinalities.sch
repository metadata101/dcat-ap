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
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_identifier_n19f0654cc0c94ae4b723bfc3b31c6f76b95">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Distribution_dct_title_n19f0654cc0c94ae4b723bfc3b31c6f76b96">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_rights_n19f0654cc0c94ae4b723bfc3b31c6f76b97">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:rights"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_adms_identifier_n19f0654cc0c94ae4b723bfc3b31c6f76b98">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_format_n19f0654cc0c94ae4b723bfc3b31c6f76b99">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:format"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_license_n19f0654cc0c94ae4b723bfc3b31c6f76b100">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_conformsTo_n19f0654cc0c94ae4b723bfc3b31c6f76b101">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:conformsTo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_downloadURL_n19f0654cc0c94ae4b723bfc3b31c6f76b102">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:downloadURL"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_accessURL_n19f0654cc0c94ae4b723bfc3b31c6f76b103">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:accessURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_accessService_n19f0654cc0c94ae4b723bfc3b31c6f76b104">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:accessService"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_geodcat_distributor_n19f0654cc0c94ae4b723bfc3b31c6f76b105">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="geodcat:distributor"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_identifier_n19f0654cc0c94ae4b723bfc3b31c6f76b2">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_issued_n19f0654cc0c94ae4b723bfc3b31c6f76b3">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_CatalogRecord_dct_title_n19f0654cc0c94ae4b723bfc3b31c6f76b4">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_modified_n19f0654cc0c94ae4b723bfc3b31c6f76b5">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_mdcat_landingpageVoorBronMetadata_n19f0654cc0c94ae4b723bfc3b31c6f76b6">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="mdcat:landingpageVoorBronMetadata"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_adms_identifier_n19f0654cc0c94ae4b723bfc3b31c6f76b7">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_conformsTo_n19f0654cc0c94ae4b723bfc3b31c6f76b8">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:conformsTo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_source_n19f0654cc0c94ae4b723bfc3b31c6f76b9">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:source"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_foaf_primaryTopic_n19f0654cc0c94ae4b723bfc3b31c6f76b10">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="foaf:primaryTopic"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_version_n19f0654cc0c94ae4b723bfc3b31c6f76b74">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:version"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Dataset_dct_description_n19f0654cc0c94ae4b723bfc3b31c6f76b75">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Dataset_dcat_keyword_n19f0654cc0c94ae4b723bfc3b31c6f76b76">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:keyword"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Dataset_dct_title_n19f0654cc0c94ae4b723bfc3b31c6f76b77">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_identifier_n19f0654cc0c94ae4b723bfc3b31c6f76b78">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_accessRights_n19f0654cc0c94ae4b723bfc3b31c6f76b79">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:accessRights"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_adms_identifier_n19f0654cc0c94ae4b723bfc3b31c6f76b80">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_conformsTo_n19f0654cc0c94ae4b723bfc3b31c6f76b81">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:conformsTo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_adms_sample_n19f0654cc0c94ae4b723bfc3b31c6f76b82">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="adms:sample"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_mdcat_statuut_n19f0654cc0c94ae4b723bfc3b31c6f76b83">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="mdcat:statuut"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_theme_n19f0654cc0c94ae4b723bfc3b31c6f76b84">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:theme"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_landingPage_n19f0654cc0c94ae4b723bfc3b31c6f76b85">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:landingPage"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_issued_n19f0654cc0c94ae4b723bfc3b31c6f76b86">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_provenance_n19f0654cc0c94ae4b723bfc3b31c6f76b87">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:provenance"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_contactPoint_n19f0654cc0c94ae4b723bfc3b31c6f76b88">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_modified_n19f0654cc0c94ae4b723bfc3b31c6f76b89">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_created_n19f0654cc0c94ae4b723bfc3b31c6f76b90">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:created"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_spatial_n19f0654cc0c94ae4b723bfc3b31c6f76b91">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:spatial"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_distribution_n19f0654cc0c94ae4b723bfc3b31c6f76b92">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:distribution"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_rightsHolder_n19f0654cc0c94ae4b723bfc3b31c6f76b93">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:rightsHolder"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="foaf_Agent_dct_Agent_foaf_name_n19f0654cc0c94ae4b723bfc3b31c6f76b1">
    <sch:param name="context" value="//foaf:Agent[$profile]|//dct:Agent[$profile]"/>
    <sch:param name="element" value="foaf:name"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_dcat_endDate_n19f0654cc0c94ae4b723bfc3b31c6f76b137">
    <sch:param name="context" value="//dct:PeriodOfTime[$profile]"/>
    <sch:param name="element" value="dcat:endDate"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_dcat_startDate_n19f0654cc0c94ae4b723bfc3b31c6f76b138">
    <sch:param name="context" value="//dct:PeriodOfTime[$profile]"/>
    <sch:param name="element" value="dcat:startDate"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_time_hasBeginning_n19f0654cc0c94ae4b723bfc3b31c6f76b139">
    <sch:param name="context" value="//dct:PeriodOfTime[$profile]"/>
    <sch:param name="element" value="time:hasBeginning"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_time_hasEnd_n19f0654cc0c94ae4b723bfc3b31c6f76b140">
    <sch:param name="context" value="//dct:PeriodOfTime[$profile]"/>
    <sch:param name="element" value="time:hasEnd"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dct_Standard_dct_title_n19f0654cc0c94ae4b723bfc3b31c6f76b130">
    <sch:param name="context" value="//dct:Standard[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dct_Standard_dct_description_n19f0654cc0c94ae4b723bfc3b31c6f76b131">
    <sch:param name="context" value="//dct:Standard[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_owl_versionInfo_n19f0654cc0c94ae4b723bfc3b31c6f76b132">
    <sch:param name="context" value="//dct:Standard[$profile]"/>
    <sch:param name="element" value="owl:versionInfo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_skos_prefLabel_n19f0654cc0c94ae4b723bfc3b31c6f76b133">
    <sch:param name="context" value="//dct:Standard[$profile]"/>
    <sch:param name="element" value="skos:prefLabel"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_dct_type_n19f0654cc0c94ae4b723bfc3b31c6f76b134">
    <sch:param name="context" value="//dct:Standard[$profile]"/>
    <sch:param name="element" value="dct:type"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_rdfs_seeAlso_n19f0654cc0c94ae4b723bfc3b31c6f76b135">
    <sch:param name="context" value="//dct:Standard[$profile]"/>
    <sch:param name="element" value="rdfs:seeAlso"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_dct_issued_n19f0654cc0c94ae4b723bfc3b31c6f76b136">
    <sch:param name="context" value="//dct:Standard[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_identifier_n19f0654cc0c94ae4b723bfc3b31c6f76b25">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Catalog_dct_title_n19f0654cc0c94ae4b723bfc3b31c6f76b26">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Catalog_dct_description_n19f0654cc0c94ae4b723bfc3b31c6f76b27">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_contactPoint_n19f0654cc0c94ae4b723bfc3b31c6f76b28">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_license_n19f0654cc0c94ae4b723bfc3b31c6f76b29">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_adms_identifier_n19f0654cc0c94ae4b723bfc3b31c6f76b30">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_record_n19f0654cc0c94ae4b723bfc3b31c6f76b31">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dcat:record"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_publisher_n19f0654cc0c94ae4b723bfc3b31c6f76b32">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_dataset_n19f0654cc0c94ae4b723bfc3b31c6f76b33">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dcat:dataset"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_service_n19f0654cc0c94ae4b723bfc3b31c6f76b34">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dcat:service"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Location_locn_geometry_n19f0654cc0c94ae4b723bfc3b31c6f76b111">
    <sch:param name="context" value="//dct:Location[$profile]"/>
    <sch:param name="element" value="locn:geometry"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Location_dcat_bbox_n19f0654cc0c94ae4b723bfc3b31c6f76b112">
    <sch:param name="context" value="//dct:Location[$profile]"/>
    <sch:param name="element" value="dcat:bbox"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Location_dcat_centroid_n19f0654cc0c94ae4b723bfc3b31c6f76b113">
    <sch:param name="context" value="//dct:Location[$profile]"/>
    <sch:param name="element" value="dcat:centroid"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dct_Location_rdfs_label_n19f0654cc0c94ae4b723bfc3b31c6f76b114">
    <sch:param name="context" value="//dct:Location[$profile]"/>
    <sch:param name="element" value="rdfs:label"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_DataService_dcat_DatasetSeries_dct_publisher_n19f0654cc0c94ae4b723bfc3b31c6f76b17">
    <sch:param name="context" value="//dcat:Dataset[$profile]|//dcat:DataService[$profile]|//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_DataService_dcat_DatasetSeries_dct_relation_n19f0654cc0c94ae4b723bfc3b31c6f76b18">
    <sch:param name="context" value="//dcat:Dataset[$profile]|//dcat:DataService[$profile]|//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:relation"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_dcat_hadRole_n19f0654cc0c94ae4b723bfc3b31c6f76b115">
    <sch:param name="context" value="//dcat:Relationship[$profile]"/>
    <sch:param name="element" value="dcat:hadRole"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_mdcat_RelatieQualificatie_catalogusResource_source_n19f0654cc0c94ae4b723bfc3b31c6f76b116">
    <sch:param name="context" value="//dcat:Relationship[$profile]"/>
    <sch:param name="element" value="mdcat:RelatieQualificatie.catalogusResource.source"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_mdcat_RelatieQualificatie_catalogusResource_target_n19f0654cc0c94ae4b723bfc3b31c6f76b123">
    <sch:param name="context" value="//dcat:Relationship[$profile]"/>
    <sch:param name="element" value="mdcat:RelatieQualificatie.catalogusResource.target"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_skos_notation_n19f0654cc0c94ae4b723bfc3b31c6f76b106">
    <sch:param name="context" value="//adms:Identifier[$profile]"/>
    <sch:param name="element" value="skos:notation"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_adms_schemaAgency_n19f0654cc0c94ae4b723bfc3b31c6f76b107">
    <sch:param name="context" value="//adms:Identifier[$profile]"/>
    <sch:param name="element" value="adms:schemaAgency"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_dct_issued_n19f0654cc0c94ae4b723bfc3b31c6f76b108">
    <sch:param name="context" value="//adms:Identifier[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_generiek_gestructureerdeIdentificator_n19f0654cc0c94ae4b723bfc3b31c6f76b109">
    <sch:param name="context" value="//adms:Identifier[$profile]"/>
    <sch:param name="element" value="generiek:gestructureerdeIdentificator"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_dct_creator_n19f0654cc0c94ae4b723bfc3b31c6f76b110">
    <sch:param name="context" value="//adms:Identifier[$profile]"/>
    <sch:param name="element" value="dct:creator"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_DataService_dct_description_n19f0654cc0c94ae4b723bfc3b31c6f76b37">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_version_n19f0654cc0c94ae4b723bfc3b31c6f76b38">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:version"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_identifier_n19f0654cc0c94ae4b723bfc3b31c6f76b39">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_DataService_dcat_keyword_n19f0654cc0c94ae4b723bfc3b31c6f76b40">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:keyword"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_DataService_dct_title_n19f0654cc0c94ae4b723bfc3b31c6f76b41">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_contactPoint_n19f0654cc0c94ae4b723bfc3b31c6f76b42">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_endpointURL_n19f0654cc0c94ae4b723bfc3b31c6f76b43">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:endpointURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_endpointDescription_n19f0654cc0c94ae4b723bfc3b31c6f76b44">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:endpointDescription"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_landingPage_n19f0654cc0c94ae4b723bfc3b31c6f76b45">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:landingPage"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_ontwikkelingstoestand_n19f0654cc0c94ae4b723bfc3b31c6f76b46">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="mdcat:ontwikkelingstoestand"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_landingspaginaVoorAuthenticatie_n19f0654cc0c94ae4b723bfc3b31c6f76b47">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="mdcat:landingspaginaVoorAuthenticatie"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_levensfase_n19f0654cc0c94ae4b723bfc3b31c6f76b48">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="mdcat:levensfase"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_landingspaginaVoorStatusinformatie_n19f0654cc0c94ae4b723bfc3b31c6f76b49">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="mdcat:landingspaginaVoorStatusinformatie"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_adms_identifier_n19f0654cc0c94ae4b723bfc3b31c6f76b50">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_accessRights_n19f0654cc0c94ae4b723bfc3b31c6f76b51">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:accessRights"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_conformsTo_n19f0654cc0c94ae4b723bfc3b31c6f76b52">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:conformsTo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_statuut_n19f0654cc0c94ae4b723bfc3b31c6f76b53">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="mdcat:statuut"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_landingspaginaVoorGebruiksinformatie_n19f0654cc0c94ae4b723bfc3b31c6f76b54">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="mdcat:landingspaginaVoorGebruiksinformatie"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_rights_n19f0654cc0c94ae4b723bfc3b31c6f76b55">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:rights"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_theme_n19f0654cc0c94ae4b723bfc3b31c6f76b56">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:theme"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_license_n19f0654cc0c94ae4b723bfc3b31c6f76b57">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_created_n19f0654cc0c94ae4b723bfc3b31c6f76b58">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:created"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_modified_n19f0654cc0c94ae4b723bfc3b31c6f76b59">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_issued_n19f0654cc0c94ae4b723bfc3b31c6f76b60">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_servesdataset_n19f0654cc0c94ae4b723bfc3b31c6f76b61">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:servesdataset"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_description_n19f0654cc0c94ae4b723bfc3b31c6f76b62">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_title_n19f0654cc0c94ae4b723bfc3b31c6f76b63">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_identifier_n19f0654cc0c94ae4b723bfc3b31c6f76b64">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dcat_contactPoint_n19f0654cc0c94ae4b723bfc3b31c6f76b65">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_accrualPeriodicity_n19f0654cc0c94ae4b723bfc3b31c6f76b67">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:accrualPeriodicity"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_issued_n19f0654cc0c94ae4b723bfc3b31c6f76b68">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_modified_n19f0654cc0c94ae4b723bfc3b31c6f76b69">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_adms_identifier_n19f0654cc0c94ae4b723bfc3b31c6f76b72">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_publisher_n19f0654cc0c94ae4b723bfc3b31c6f76b73">
    <sch:param name="context" value="//dcat:DatasetSeries[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_vcard_hasEmail_n19f0654cc0c94ae4b723bfc3b31c6f76b35">
    <sch:param name="context" value="//vcard:Organization[$profile]|//vcard:Kind[$profile]"/>
    <sch:param name="element" value="vcard:hasEmail"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_foaf_page_n19f0654cc0c94ae4b723bfc3b31c6f76b36">
    <sch:param name="context" value="//vcard:Organization[$profile]|//vcard:Kind[$profile]"/>
    <sch:param name="element" value="foaf:page"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Distribution_dct_title_n19f0654cc0c94ae4b723bfc3b31c6f76b141">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Distribution_dct_description_n19f0654cc0c94ae4b723bfc3b31c6f76b142">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_downloadURL_n19f0654cc0c94ae4b723bfc3b31c6f76b143">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:downloadURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_mediatype_n19f0654cc0c94ae4b723bfc3b31c6f76b144">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:mediatype"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
</sch:schema>