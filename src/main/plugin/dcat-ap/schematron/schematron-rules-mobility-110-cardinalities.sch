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
  <sch:pattern is-a="CardinalityCheck" id="spdx_Checksum_spdx_algorithm_n09c766334d33454f855f4cff0e6888f7b74">
    <sch:param name="context" value="//spdx:Checksum[$profile]"/>
    <sch:param name="element" value="spdx:algorithm"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="spdx_Checksum_spdx_checksumValue_n09c766334d33454f855f4cff0e6888f7b75">
    <sch:param name="context" value="//spdx:Checksum[$profile]"/>
    <sch:param name="element" value="spdx:checksumValue"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="mobilitydcatap_mobilityDataStandard_dct_conformsTo_n09c766334d33454f855f4cff0e6888f7b126">
    <sch:param name="context" value="//mobilitydcatap:mobilityDataStandard[$profile]"/>
    <sch:param name="element" value="dct:conformsTo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="mobilitydcatap_mobilityDataStandard_owl_versionInfo_n09c766334d33454f855f4cff0e6888f7b127">
    <sch:param name="context" value="//mobilitydcatap:mobilityDataStandard[$profile]"/>
    <sch:param name="element" value="owl:versionInfo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_created_n09c766334d33454f855f4cff0e6888f7b53">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:created"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_language_n09c766334d33454f855f4cff0e6888f7b58">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:language"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_foaf_primaryTopic_n09c766334d33454f855f4cff0e6888f7b63">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="foaf:primaryTopic"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_modified_n09c766334d33454f855f4cff0e6888f7b64">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_publisher_n09c766334d33454f855f4cff0e6888f7b69">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_mobilitydcatap_MobilityDataStandard_n09c766334d33454f855f4cff0e6888f7b91">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="mobilitydcatap:MobilityDataStandard"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_mobilitydcatap_applicationLayerProtocol_n09c766334d33454f855f4cff0e6888f7b96">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="mobilitydcatap:applicationLayerProtocol"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_content_characterEncoding_n09c766334d33454f855f4cff0e6888f7b97">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="content:characterEncoding"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_mobilitydcatap_communicationMethod_n09c766334d33454f855f4cff0e6888f7b98">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="mobilitydcatap:communicationMethod"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_mobilitydcatap_dataFormatNotes_n09c766334d33454f855f4cff0e6888f7b99">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="mobilitydcatap:dataFormatNotes"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_mobilitydcatap_grammar_n09c766334d33454f855f4cff0e6888f7b100">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="mobilitydcatap:grammar"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_temporal_n09c766334d33454f855f4cff0e6888f7b102">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:temporal"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_dataset_n09c766334d33454f855f4cff0e6888f7b25">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dcat:dataset"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_description_n09c766334d33454f855f4cff0e6888f7b26">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_foaf_homepage_n09c766334d33454f855f4cff0e6888f7b27">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="foaf:homepage"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_publisher_n09c766334d33454f855f4cff0e6888f7b28">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_record_n09c766334d33454f855f4cff0e6888f7b29">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dcat:record"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_spatial_n09c766334d33454f855f4cff0e6888f7b30">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:spatial"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_title_n09c766334d33454f855f4cff0e6888f7b31">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_license_n09c766334d33454f855f4cff0e6888f7b37">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_issued_n09c766334d33454f855f4cff0e6888f7b38">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_modified_n09c766334d33454f855f4cff0e6888f7b44">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_identifier_n09c766334d33454f855f4cff0e6888f7b50">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_isPartOf_n09c766334d33454f855f4cff0e6888f7b51">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:isPartOf"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_adms_identifier_n09c766334d33454f855f4cff0e6888f7b52">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dqv_QualityAnnotation_oa_hasBody_n09c766334d33454f855f4cff0e6888f7b129">
    <sch:param name="context" value="//dqv:QualityAnnotation[$profile]"/>
    <sch:param name="element" value="oa:hasBody"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dqv_QualityAnnotation_oa_hasTarget_n09c766334d33454f855f4cff0e6888f7b130">
    <sch:param name="context" value="//dqv:QualityAnnotation[$profile]"/>
    <sch:param name="element" value="oa:hasTarget"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="locn_Address_locn_adminUnitL2_n09c766334d33454f855f4cff0e6888f7b5">
    <sch:param name="context" value="//locn:Address[$profile]"/>
    <sch:param name="element" value="locn:adminUnitL2"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="locn_Address_locn_postName_n09c766334d33454f855f4cff0e6888f7b6">
    <sch:param name="context" value="//locn:Address[$profile]"/>
    <sch:param name="element" value="locn:postName"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="locn_Address_locn_adminUnitL1_n09c766334d33454f855f4cff0e6888f7b7">
    <sch:param name="context" value="//locn:Address[$profile]"/>
    <sch:param name="element" value="locn:adminUnitL1"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="locn_Address_locn_postCode_n09c766334d33454f855f4cff0e6888f7b8">
    <sch:param name="context" value="//locn:Address[$profile]"/>
    <sch:param name="element" value="locn:postCode"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="locn_Address_locn_thoroughfare_n09c766334d33454f855f4cff0e6888f7b9">
    <sch:param name="context" value="//locn:Address[$profile]"/>
    <sch:param name="element" value="locn:thoroughfare"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Location_skos_inScheme_n09c766334d33454f855f4cff0e6888f7b111">
    <sch:param name="context" value="//dct:Location[$profile]"/>
    <sch:param name="element" value="skos:inScheme"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_accrualPeriodicity_n09c766334d33454f855f4cff0e6888f7b76">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:accrualPeriodicity"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_mobilitydcatap_mobilityTheme_n09c766334d33454f855f4cff0e6888f7b81">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="mobilitydcatap:mobilityTheme"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_mobilitydcatap_assessmentResult_n09c766334d33454f855f4cff0e6888f7b88">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="mobilitydcatap:assessmentResult"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_vcard_hasEmail_n09c766334d33454f855f4cff0e6888f7b103">
    <sch:param name="context" value="//vcard:Organization[$profile]|//vcard:Kind[$profile]"/>
    <sch:param name="element" value="vcard:hasEmail"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_vcard_fn_n09c766334d33454f855f4cff0e6888f7b104">
    <sch:param name="context" value="//vcard:Organization[$profile]|//vcard:Kind[$profile]"/>
    <sch:param name="element" value="vcard:fn"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_vcard_hasURL_n09c766334d33454f855f4cff0e6888f7b105">
    <sch:param name="context" value="//vcard:Organization[$profile]|//vcard:Kind[$profile]"/>
    <sch:param name="element" value="vcard:hasURL"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_vcard_hasAddress_n09c766334d33454f855f4cff0e6888f7b106">
    <sch:param name="context" value="//vcard:Organization[$profile]|//vcard:Kind[$profile]"/>
    <sch:param name="element" value="vcard:hasAddress"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_vcard_organization_name_n09c766334d33454f855f4cff0e6888f7b107">
    <sch:param name="context" value="//vcard:Organization[$profile]|//vcard:Kind[$profile]"/>
    <sch:param name="element" value="vcard:organization-name"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_vcard_hasTelephone_n09c766334d33454f855f4cff0e6888f7b108">
    <sch:param name="context" value="//vcard:Organization[$profile]|//vcard:Kind[$profile]"/>
    <sch:param name="element" value="vcard:hasTelephone"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="foaf_Agent_dct_Agent_foaf_name_n09c766334d33454f855f4cff0e6888f7b10">
    <sch:param name="context" value="//foaf:Agent[$profile]|//dct:Agent[$profile]"/>
    <sch:param name="element" value="foaf:name"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="foaf_Agent_dct_Agent_dct_type_n09c766334d33454f855f4cff0e6888f7b11">
    <sch:param name="context" value="//foaf:Agent[$profile]|//dct:Agent[$profile]"/>
    <sch:param name="element" value="dct:type"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="foaf_Agent_dct_Agent_foaf_firstName_n09c766334d33454f855f4cff0e6888f7b15">
    <sch:param name="context" value="//foaf:Agent[$profile]|//dct:Agent[$profile]"/>
    <sch:param name="element" value="foaf:firstName"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="foaf_Agent_dct_Agent_foaf_surname_n09c766334d33454f855f4cff0e6888f7b17">
    <sch:param name="context" value="//foaf:Agent[$profile]|//dct:Agent[$profile]"/>
    <sch:param name="element" value="foaf:surname"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="foaf_Agent_dct_Agent_foaf_workplaceHomepage_n09c766334d33454f855f4cff0e6888f7b18">
    <sch:param name="context" value="//foaf:Agent[$profile]|//dct:Agent[$profile]"/>
    <sch:param name="element" value="foaf:workplaceHomepage"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_RightsStatement_dct_type_n09c766334d33454f855f4cff0e6888f7b131">
    <sch:param name="context" value="//dct:RightsStatement[$profile]"/>
    <sch:param name="element" value="dct:type"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="skos_ConceptScheme_dct_title_n09c766334d33454f855f4cff0e6888f7b73">
    <sch:param name="context" value="//skos:ConceptScheme[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="skos_Concept_skos_prefLabel_n09c766334d33454f855f4cff0e6888f7b71">
    <sch:param name="context" value="//skos:Concept[$profile]"/>
    <sch:param name="element" value="skos:prefLabel"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="skos_Concept_skos_inScheme_n09c766334d33454f855f4cff0e6888f7b72">
    <sch:param name="context" value="//skos:Concept[$profile]"/>
    <sch:param name="element" value="skos:inScheme"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="mobilitydcatap_Assessment_dct_issued_n09c766334d33454f855f4cff0e6888f7b19">
    <sch:param name="context" value="//mobilitydcatap:Assessment[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="mobilitydcatap_Assessment_oa_hasBody_n09c766334d33454f855f4cff0e6888f7b24">
    <sch:param name="context" value="//mobilitydcatap:Assessment[$profile]"/>
    <sch:param name="element" value="oa:hasBody"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_LicenseDocument_dct_identifier_n09c766334d33454f855f4cff0e6888f7b109">
    <sch:param name="context" value="//dct:LicenseDocument[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_LicenseDocument_rdfs_label_n09c766334d33454f855f4cff0e6888f7b110">
    <sch:param name="context" value="//dct:LicenseDocument[$profile]"/>
    <sch:param name="element" value="rdfs:label"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
</sch:schema>