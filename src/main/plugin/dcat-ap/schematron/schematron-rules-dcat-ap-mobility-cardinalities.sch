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
  <sch:ns prefix="dcatap" uri="http://data.europa.eu/r5r/"/>
  <sch:ns prefix="schema" uri="http://schema.org/"/>
  <sch:ns prefix="rdf" uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
  <sch:ns prefix="skos" uri="http://www.w3.org/2004/02/skos/core#"/>
  <sch:ns prefix="xml" uri="http://www.w3.org/XML/1998/namespace"/>
  <sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
  <sch:ns prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
  <sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>
  <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
  <sch:ns prefix="mdcat" uri="https://data.vlaanderen.be/ns/metadata-dcat#"/>
  <sch:ns prefix="geodcat" uri="http://data.europa.eu/930/"/>
  <sch:ns prefix="generiek" uri="https://data.vlaanderen.be/ns/generiek#"/>
  <sch:ns prefix="rdfs" uri="http://www.w3.org/2000/01/rdf-schema#"/>
  <sch:ns prefix="prov" uri="http://www.w3.org/ns/prov#"/>
  <sch:ns prefix="mobilitydcatap" uri="https://w3id.org/mobilitydcat-ap"/>
  <sch:ns prefix="cnt" uri="http://www.w3.org/2011/content#"/>
  <sch:ns prefix="odrl" uri="http://www.w3.org/ns/odrl/2/"/>

  <sch:title xmlns="http://www.w3.org/2001/XMLSchema">{$loc/strings/schematron.title}</sch:title>

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

  <sch:pattern is-a="CardinalityCheck" id="Dataset_mobilityTheme">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="mobilitydcatap:mobilityTheme"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_transportMode">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="mobilitydcatap:transportMode"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_applicableLegislation">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dcatap:applicableLegislation"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_temporal">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:temporal"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_spatial">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:spatial"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_publisher">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_versionInfo">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="owl:versionInfo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>

  <sch:pattern is-a="CardinalityCheck" id="DataService_endpointURL">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dcat:endpointURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="DataService_accessRights">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:accessRights"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="DataService_license">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="DataService_title">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>

  <sch:pattern is-a="CardinalityCheck" id="CatalogRecord_created">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:created"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="CatalogRecord_modified">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="CatalogRecord_language">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:language"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="CatalogRecord_primaryTopic">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="foaf:primaryTopic"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>

  <sch:pattern is-a="CardinalityCheck" id="Catalog_title">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Catalog_record">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dcat:record"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Catalog_identifier">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Catalog_homepage">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="foaf:homepage"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Catalog_publisher">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Catalog_spatial">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dct:spatial"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Catalog_issued">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Catalog_modified">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>

  <sch:pattern is-a="CardinalityCheck" id="Distribution_mobilityDataStandard">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="mobilitydcatap:mobilityDataStandard"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_applicationLayerProtocol">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="mobilitydcatap:applicationLayerProtocol"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_grammar">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="mobilitydcatap:grammar"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_communicationMethod">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="mobilitydcatap:communicationMethod"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_dataFormatNotes">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="mobilitydcatap:dataFormatNotes"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_characterEncoding">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="cnt:characterEncoding"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_downloadURL">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcat:downloadURL"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_temporal">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:temporal"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_license">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>

  <!-- Overwrite DCAT-AP generic cardinalities -->
  <sch:pattern is-a="CardinalityCheck" id="Dataset_accrualPeriodicity">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:accrualPeriodicity"/>
    <sch:param name="min" value="1"/><!-- Optional in DCAT AP -->
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_contactPoint">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_PeriodOfTime">
    <sch:param name="context" value="//dcat:Dataset/dct:temporal/dct:PeriodOfTime"/>
    <sch:param name="element" value="schema:startDate"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_identifier">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_language">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:language"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_modified">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_issued">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_title">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>


  <sch:pattern is-a="CardinalityCheck" id="Distribution_accessURL">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dcat:accessURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/><!-- n in DCAT-AP -->
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="Distribution_title">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="0"/><!-- 0 in DCAT-AP -->
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_format">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dct:format"/>
    <sch:param name="min" value="1"/><!-- 0 in DCAT-AP -->
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_rights">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dct:rights"/>
    <sch:param name="min" value="1"/><!-- 0 in DCAT-AP -->
    <sch:param name="max" value="1"/>
  </sch:pattern>

  <sch:pattern is-a="CardinalityCheck" id="Agent_name">
    <sch:param name="context" value="foaf:Agent"/>
    <sch:param name="element" value="foaf:name"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Agent_mbox">
    <sch:param name="context" value="foaf:Agent"/>
    <sch:param name="element" value="foaf:mbox"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Agent_address">
    <sch:param name="context" value="foaf:Agent"/>
    <sch:param name="element" value="locn:address"/>
    <sch:param name="min" value="0"/><!-- Not in DCAT-AP -->
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Agent_address_adminUnitL1">
    <sch:param name="context" value="locn:address"/>
    <sch:param name="element" value="locn:adminUnitL1"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Agent_address_adminUnitL2">
    <sch:param name="context" value="locn:address"/>
    <sch:param name="element" value="locn:adminUnitL2"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Agent_address_postName">
    <sch:param name="context" value="locn:address"/>
    <sch:param name="element" value="locn:postName"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Agent_address_postCode">
    <sch:param name="context" value="locn:address"/>
    <sch:param name="element" value="locn:postCode"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Agent_address_thoroughfare">
    <sch:param name="context" value="locn:address"/>
    <sch:param name="element" value="locn:thoroughfare"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>

  <!-- Removed in mobilityDCAT-AP 1.1.0 -->
  <sch:pattern is-a="CardinalityCheck" id="Distribution_issued">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/><!-- 0 in DCAT-AP, in mobility 1.1.0 -->
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_modified">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_creator">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:creator"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_sample">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:sample"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_qualifiedAttribution">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="prov:qualifiedAttribution"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_wasGeneratedBy">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="prov:wasGeneratedBy"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>

  <sch:pattern is-a="CardinalityCheck" id="Distribution_byteSize">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcat:byteSize"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_compressFormat">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcat:compressFormat"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_mediaType">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcat:mediaType"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_packageFormat">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcat:packageFormat"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_spatialResolutionInMeters">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcat:spatialResolutionInMeters"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_temporalResolution">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcat:temporalResolution"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_availability">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcatap:availability"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_issued">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_modified">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_language">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:language"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_documentation">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="foaf:page"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_hasPolicy">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="odrl:hasPolicy"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Distribution_checksum">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="spdx:checksum"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="0"/>
  </sch:pattern>
</sch:schema>
