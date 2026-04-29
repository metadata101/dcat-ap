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
  <sch:pattern is-a="CardinalityCheck" id="foaf_Agent_dct_Agent_foaf_name_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_AgentShape_e9d8e42e8041e72c4534134d5a9044b03bed7ec5">
    <sch:param name="context" value="//foaf:Agent[$profile]|//dct:Agent[$profile]"/>
    <sch:param name="element" value="foaf:name"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_foaf_page_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_ContactinfoShape_376ba2894840068d71059e7be03bfaf8995aee90">
    <sch:param name="context" value="//vcard:Organization[$profile]|//vcard:Kind[$profile]"/>
    <sch:param name="element" value="foaf:page"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_vcard_hasEmail_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_ContactinfoShape_42ad698554950cda0098f1f04803fac8470af8ad">
    <sch:param name="context" value="//vcard:Organization[$profile]|//vcard:Kind[$profile]"/>
    <sch:param name="element" value="vcard:hasEmail"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_generiek_gestructureerdeIdentificator_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_IdentificatorShape_6789412851c92fe5eb8479182507dd72e28ab811">
    <sch:param name="context" value="//adms:Identifier[$profile]"/>
    <sch:param name="element" value="generiek:gestructureerdeIdentificator"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_skos_notation_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_IdentificatorShape_ccb2d543d17baa8b6b0ca2a42156eed6f23e3f6e">
    <sch:param name="context" value="//adms:Identifier[$profile]"/>
    <sch:param name="element" value="skos:notation"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_dct_creator_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_IdentificatorShape_f0a3fc099a35481d2891e1eac3a099feb6f942d8">
    <sch:param name="context" value="//adms:Identifier[$profile]"/>
    <sch:param name="element" value="dct:creator"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_adms_schemaAgency_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_IdentificatorShape_9f8532791e13c302ae6dcc70ef353c796f948c85">
    <sch:param name="context" value="//adms:Identifier[$profile]"/>
    <sch:param name="element" value="adms:schemaAgency"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_dct_issued_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_IdentificatorShape_3b5973d35f612c133f22e9f710f65db63d861b6b">
    <sch:param name="context" value="//adms:Identifier[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_description_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusShape_7521953addc62cf367ab3c8ec0dc63cb5981ea23">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_contactPoint_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusShape_19ee039173472235e539aea2aa961ff7d3b89f5a">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_contactPoint_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusShape_e332dbce5947de4314c3ed3fe5862f26d70a15c4">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_identifier_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusShape_972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_identifier_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusShape_bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_license_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusShape_cafd2e3e66044d8ba2c435a9353e6880952086c5">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_title_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusShape_25d18a6e2598024ea186cc7be4391bdfd1bca21f">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_publisher_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusShape_5334cf8edf5cc07e349524728fe4c9b076e4c45e">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_publisher_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusShape_e2d4034a0a398701f4257641ebcbc85e8683b29d">
    <sch:param name="context" value="//dcat:Catalog[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_issued_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusRecordShape_8172f8df2a73384c65fdb3332d8ee0c9ef574804">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_mdcat_landingpageVoorBronMetadata_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusRecordShape_0311d40d6c8081dc49766336ad753baee5d276f2">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="mdcat:landingpageVoorBronMetadata"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_source_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusRecordShape_c779d25f1f0ba872826b725cf9254a3bec5a82ce">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:source"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_foaf_primaryTopic_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusRecordShape_2a7abc3b7d6df32e4a340775a9e1522a0ac1c669">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="foaf:primaryTopic"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_foaf_primaryTopic_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusRecordShape_f806d2d1fd264df77aee55564a0a70eecd47ee2e">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="foaf:primaryTopic"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_identifier_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusRecordShape_972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_identifier_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusRecordShape_bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_modified_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusRecordShape_29906bf16cadf6d568c4da3e161ef38ba2f726fd">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_modified_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusRecordShape_6a51b2354ea38a815d6131b4e05f8587791de4e0">
    <sch:param name="context" value="//dcat:CatalogRecord[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_downloadURL_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DistributieShape_1ff94e5c0d35c7d1a7f2c4bd160a8c8e4eee6f97">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:downloadURL"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_format_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DistributieShape_c202c852e84ae0c736f1f6a8f8030db817602116">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:format"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_identifier_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DistributieShape_972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_identifier_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DistributieShape_bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_license_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DistributieShape_cafd2e3e66044d8ba2c435a9353e6880952086c5">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_accessURL_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DistributieShape_28a9b5a610271b2ad2cd6917763075560213ca20">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:accessURL"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_accessURL_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DistributieShape_bf4475984ce7d0eb4bade6e749e672a8efa7dd2d">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:accessURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_geodcat_distributor_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DistributieShape_97ed7a72fee66a4fd972d36d70822272beaf40ce">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="geodcat:distributor"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_contactPoint_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_19ee039173472235e539aea2aa961ff7d3b89f5a">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_contactPoint_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_e332dbce5947de4314c3ed3fe5862f26d70a15c4">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_created_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_6b0d5813153da700505d795c17d681878225c6d1">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:created"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_endpointURL_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_9978564bd5823785ddace8934e848c68e6e813e3">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:endpointURL"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_endpointDescription_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_66883b2795f003760d4bb617bd1f472da1e1524f">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:endpointDescription"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_endpointDescription_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_bd44e3e6c4317f226cd1124fbaf1d72e94e8f15e">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dcat:endpointDescription"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_identifier_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_identifier_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_landingspaginaVoorAuthenticatie_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_e9bf439f5272396af4486645c4dd4ae47c27c030">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="mdcat:landingspaginaVoorAuthenticatie"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_landingspaginaVoorGebruiksinformatie_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_b643cb8952d752ef63a2b25c7fcebd89d08fb015">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="mdcat:landingspaginaVoorGebruiksinformatie"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_landingspaginaVoorStatusinformatie_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_82e4f4e38a285ebeffb0f14c036b491b71a26200">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="mdcat:landingspaginaVoorStatusinformatie"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_levensfase_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_8a32a3e6b5ca4b68f8846b184e7faa4f48a0ee1d">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="mdcat:levensfase"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_license_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_cafd2e3e66044d8ba2c435a9353e6880952086c5">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_ontwikkelingstoestand_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_76f6cfca9a1964a539a879c911777c741a37cff0">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="mdcat:ontwikkelingstoestand"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_issued_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_fe9c62143da275c7458e0e71dedeb277670a016b">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_title_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_25d18a6e2598024ea186cc7be4391bdfd1bca21f">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_accessRights_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_7463895a2bb9e7e4c96cd9a2e7f83ce2cf787098">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:accessRights"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_accessRights_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_f9524ba86e28981345a2b84aea788460ad4e805e">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:accessRights"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_owl_versionInfo_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_302090a90a5755780bc8fe09be4bcd29193cfd6d">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="owl:versionInfo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_modified_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DataServiceShape_29906bf16cadf6d568c4da3e161ef38ba2f726fd">
    <sch:param name="context" value="//dcat:DataService[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_mdcat_RelatieQualificatie_catalogusResource_source_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_RelatieQualificatieShape_230fa664054f86199f30c98c6d4140bfb1437470">
    <sch:param name="context" value="//dcat:Relationship[$profile]"/>
    <sch:param name="element" value="mdcat:RelatieQualificatie.catalogusResource.source"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_mdcat_RelatieQualificatie_catalogusResource_source_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_RelatieQualificatieShape_f5a6aff37ed40db28a354dd68f524952b0433d4a">
    <sch:param name="context" value="//dcat:Relationship[$profile]"/>
    <sch:param name="element" value="mdcat:RelatieQualificatie.catalogusResource.source"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_mdcat_RelatieQualificatie_catalogusResource_target_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_RelatieQualificatieShape_78ce02089c3f0ee33902d0bc3cc0e00e7d26e097">
    <sch:param name="context" value="//dcat:Relationship[$profile]"/>
    <sch:param name="element" value="mdcat:RelatieQualificatie.catalogusResource.target"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_mdcat_RelatieQualificatie_catalogusResource_target_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_RelatieQualificatieShape_c883e705823614530bb3fd7b4046023772ea8807">
    <sch:param name="context" value="//dcat:Relationship[$profile]"/>
    <sch:param name="element" value="mdcat:RelatieQualificatie.catalogusResource.target"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_dcat_hadRole_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_RelatieQualificatieShape_68837b0eda962a941b0162e1ae4c5f0e471e0c51">
    <sch:param name="context" value="//dcat:Relationship[$profile]"/>
    <sch:param name="element" value="dcat:hadRole"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_dcat_hadRole_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_RelatieQualificatieShape_acb59b00c5c67fec8d3f0b2543d5259a09b17d18">
    <sch:param name="context" value="//dcat:Relationship[$profile]"/>
    <sch:param name="element" value="dcat:hadRole"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_dct_issued_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_StandaardShape_fe9c62143da275c7458e0e71dedeb277670a016b">
    <sch:param name="context" value="//dct:Standard[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_rdfs_seeAlso_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_StandaardShape_db7c74598f8807ba1cfdb8f62f771fb27d4dbbe7">
    <sch:param name="context" value="//dct:Standard[$profile]"/>
    <sch:param name="element" value="rdfs:seeAlso"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_owl_versionInfo_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_StandaardShape_302090a90a5755780bc8fe09be4bcd29193cfd6d">
    <sch:param name="context" value="//dct:Standard[$profile]"/>
    <sch:param name="element" value="owl:versionInfo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_skos_prefLabel_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_StandaardShape_dec1490408b1bea457bc40436431406882288252">
    <sch:param name="context" value="//dct:Standard[$profile]"/>
    <sch:param name="element" value="skos:prefLabel"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="mdcat_RelatieQualificatie_catalogusResource_target_dct_publisher_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusResourceShape_5334cf8edf5cc07e349524728fe4c9b076e4c45e">
    <sch:param name="context" value="//mdcat:RelatieQualificatie.catalogusResource.target[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="mdcat_RelatieQualificatie_catalogusResource_target_dct_publisher_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_CatalogusResourceShape_e2d4034a0a398701f4257641ebcbc85e8683b29d">
    <sch:param name="context" value="//mdcat:RelatieQualificatie.catalogusResource.target[$profile]"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_description_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DatasetShape_7521953addc62cf367ab3c8ec0dc63cb5981ea23">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_contactPoint_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DatasetShape_19ee039173472235e539aea2aa961ff7d3b89f5a">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_contactPoint_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DatasetShape_e332dbce5947de4314c3ed3fe5862f26d70a15c4">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_created_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DatasetShape_6b0d5813153da700505d795c17d681878225c6d1">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:created"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_identifier_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DatasetShape_972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_identifier_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DatasetShape_bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_issued_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DatasetShape_fe9c62143da275c7458e0e71dedeb277670a016b">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_title_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DatasetShape_25d18a6e2598024ea186cc7be4391bdfd1bca21f">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_accessRights_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DatasetShape_7463895a2bb9e7e4c96cd9a2e7f83ce2cf787098">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:accessRights"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_accessRights_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DatasetShape_f9524ba86e28981345a2b84aea788460ad4e805e">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:accessRights"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_owl_versionInfo_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DatasetShape_302090a90a5755780bc8fe09be4bcd29193cfd6d">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="owl:versionInfo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_modified_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_DatasetShape_29906bf16cadf6d568c4da3e161ef38ba2f726fd">
    <sch:param name="context" value="//dcat:Dataset[$profile]"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_downloadURL_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_VoorbeeldWeergaveShape_1ff94e5c0d35c7d1a7f2c4bd160a8c8e4eee6f97">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:downloadURL"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_downloadURL_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_VoorbeeldWeergaveShape_ad42d11500885f18c10b5ee1a87b5ceca761f903">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:downloadURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_mediatype_https___data_vlaanderen_be_doc_applicatieprofiel_metadata_dcat_erkendestandaard_2022_04_21_VoorbeeldWeergaveShape_06b127df99a6de2b3aef269b0d4b8746a5b78dcc">
    <sch:param name="context" value="//dcat:Distribution[$profile]"/>
    <sch:param name="element" value="dcat:mediatype"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
</sch:schema>