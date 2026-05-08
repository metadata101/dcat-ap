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
  <sch:ns prefix="geodcatap" uri="http://data.europa.eu/930/"/>
  <sch:ns prefix="geodcat-w3c" uri="http://www.w3.org/ns/geodcat#"/>
  <sch:ns prefix="generiek" uri="http://data.vlaanderen.be/ns/generiek#"/>
  <sch:ns prefix="rdfs" uri="http://www.w3.org/2000/01/rdf-schema#"/>
  <sch:ns prefix="sh" uri="http://www.w3.org/ns/shacl#"/>
  <sch:ns prefix="mobilitydcatap" uri="https://w3id.org/mobilitydcat-ap#"/>
  <sch:ns prefix="oa" uri="http://www.w3.org/ns/oa#"/>
  <sch:ns prefix="content" uri="http://www.w3.org/2011/content#"/>
  <sch:ns prefix="org" uri="http://www.w3.org/ns/org#"/>
  <sch:ns prefix="prov" uri="http://www.w3.org/ns/prov#"/>
  <sch:ns prefix="dcatap" uri="http://data.europa.eu/r5r/"/>
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
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_DataService_dcat_DatasetSeries_dct_publisher_nb197d44613ea4850a33e0687c6c79cb7b17">
    <sch:param name="context" value="//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_DataService_dcat_DatasetSeries_dct_relation_nb197d44613ea4850a33e0687c6c79cb7b18">
    <sch:param name="context" value="//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries"/>
    <sch:param name="element" value="dct:relation"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_dcat_hadRole_nb197d44613ea4850a33e0687c6c79cb7b115">
    <sch:param name="context" value="//dcat:Relationship"/>
    <sch:param name="element" value="dcat:hadRole"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_mdcat_RelatieQualificatie_catalogusResource_source_nb197d44613ea4850a33e0687c6c79cb7b116">
    <sch:param name="context" value="//dcat:Relationship"/>
    <sch:param name="element" value="mdcat:RelatieQualificatie.catalogusResource.source"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Relationship_mdcat_RelatieQualificatie_catalogusResource_target_nb197d44613ea4850a33e0687c6c79cb7b123">
    <sch:param name="context" value="//dcat:Relationship"/>
    <sch:param name="element" value="mdcat:RelatieQualificatie.catalogusResource.target"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="foaf_Agent_dct_Agent_foaf_name_nb197d44613ea4850a33e0687c6c79cb7b1">
    <sch:param name="context" value="//foaf:Agent|//dct:Agent"/>
    <sch:param name="element" value="foaf:name"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_version_nb197d44613ea4850a33e0687c6c79cb7b74">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dcat:version"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Dataset_dct_description_nb197d44613ea4850a33e0687c6c79cb7b75">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Dataset_dcat_keyword_nb197d44613ea4850a33e0687c6c79cb7b76">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dcat:keyword"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Dataset_dct_title_nb197d44613ea4850a33e0687c6c79cb7b77">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_identifier_nb197d44613ea4850a33e0687c6c79cb7b78">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_accessRights_nb197d44613ea4850a33e0687c6c79cb7b79">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:accessRights"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_adms_identifier_nb197d44613ea4850a33e0687c6c79cb7b80">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_conformsTo_nb197d44613ea4850a33e0687c6c79cb7b81">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:conformsTo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_adms_sample_nb197d44613ea4850a33e0687c6c79cb7b82">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="adms:sample"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_mdcat_statuut_nb197d44613ea4850a33e0687c6c79cb7b83">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="mdcat:statuut"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_theme_nb197d44613ea4850a33e0687c6c79cb7b84">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dcat:theme"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_landingPage_nb197d44613ea4850a33e0687c6c79cb7b85">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dcat:landingPage"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_issued_nb197d44613ea4850a33e0687c6c79cb7b86">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_provenance_nb197d44613ea4850a33e0687c6c79cb7b87">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:provenance"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_contactPoint_nb197d44613ea4850a33e0687c6c79cb7b88">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_modified_nb197d44613ea4850a33e0687c6c79cb7b89">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_created_nb197d44613ea4850a33e0687c6c79cb7b90">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:created"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_spatial_nb197d44613ea4850a33e0687c6c79cb7b91">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:spatial"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dcat_distribution_nb197d44613ea4850a33e0687c6c79cb7b92">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dcat:distribution"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Dataset_dct_rightsHolder_nb197d44613ea4850a33e0687c6c79cb7b93">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dct:rightsHolder"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Location_locn_geometry_nb197d44613ea4850a33e0687c6c79cb7b111">
    <sch:param name="context" value="//dct:Location"/>
    <sch:param name="element" value="locn:geometry"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Location_dcat_bbox_nb197d44613ea4850a33e0687c6c79cb7b112">
    <sch:param name="context" value="//dct:Location"/>
    <sch:param name="element" value="dcat:bbox"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Location_dcat_centroid_nb197d44613ea4850a33e0687c6c79cb7b113">
    <sch:param name="context" value="//dct:Location"/>
    <sch:param name="element" value="dcat:centroid"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dct_Location_rdfs_label_nb197d44613ea4850a33e0687c6c79cb7b114">
    <sch:param name="context" value="//dct:Location"/>
    <sch:param name="element" value="rdfs:label"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_identifier_nb197d44613ea4850a33e0687c6c79cb7b95">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Distribution_dct_title_nb197d44613ea4850a33e0687c6c79cb7b96">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_rights_nb197d44613ea4850a33e0687c6c79cb7b97">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:rights"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_adms_identifier_nb197d44613ea4850a33e0687c6c79cb7b98">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_format_nb197d44613ea4850a33e0687c6c79cb7b99">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:format"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_license_nb197d44613ea4850a33e0687c6c79cb7b100">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dct_conformsTo_nb197d44613ea4850a33e0687c6c79cb7b101">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:conformsTo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_downloadURL_nb197d44613ea4850a33e0687c6c79cb7b102">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcat:downloadURL"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_accessURL_nb197d44613ea4850a33e0687c6c79cb7b103">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcat:accessURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_accessService_nb197d44613ea4850a33e0687c6c79cb7b104">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcat:accessService"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_geodcatap_distributor_nb197d44613ea4850a33e0687c6c79cb7b105">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="geodcatap:distributor"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_vcard_hasEmail_nb197d44613ea4850a33e0687c6c79cb7b35">
    <sch:param name="context" value="//vcard:Organization|//vcard:Kind"/>
    <sch:param name="element" value="vcard:hasEmail"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="vcard_Organization_vcard_Kind_foaf_page_nb197d44613ea4850a33e0687c6c79cb7b36">
    <sch:param name="context" value="//vcard:Organization|//vcard:Kind"/>
    <sch:param name="element" value="foaf:page"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_identifier_nb197d44613ea4850a33e0687c6c79cb7b25">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Catalog_dct_title_nb197d44613ea4850a33e0687c6c79cb7b26">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Catalog_dct_description_nb197d44613ea4850a33e0687c6c79cb7b27">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_contactPoint_nb197d44613ea4850a33e0687c6c79cb7b28">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_license_nb197d44613ea4850a33e0687c6c79cb7b29">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_adms_identifier_nb197d44613ea4850a33e0687c6c79cb7b30">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_record_nb197d44613ea4850a33e0687c6c79cb7b31">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dcat:record"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dct_publisher_nb197d44613ea4850a33e0687c6c79cb7b32">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_dataset_nb197d44613ea4850a33e0687c6c79cb7b33">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dcat:dataset"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Catalog_dcat_service_nb197d44613ea4850a33e0687c6c79cb7b34">
    <sch:param name="context" value="//dcat:Catalog"/>
    <sch:param name="element" value="dcat:service"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Distribution_dct_title_nb197d44613ea4850a33e0687c6c79cb7b141">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_Distribution_dct_description_nb197d44613ea4850a33e0687c6c79cb7b142">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_downloadURL_nb197d44613ea4850a33e0687c6c79cb7b143">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcat:downloadURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_Distribution_dcat_mediatype_nb197d44613ea4850a33e0687c6c79cb7b144">
    <sch:param name="context" value="//dcat:Distribution"/>
    <sch:param name="element" value="dcat:mediatype"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_dcat_endDate_nb197d44613ea4850a33e0687c6c79cb7b137">
    <sch:param name="context" value="//dct:PeriodOfTime"/>
    <sch:param name="element" value="dcat:endDate"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_dcat_startDate_nb197d44613ea4850a33e0687c6c79cb7b138">
    <sch:param name="context" value="//dct:PeriodOfTime"/>
    <sch:param name="element" value="dcat:startDate"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_time_hasBeginning_nb197d44613ea4850a33e0687c6c79cb7b139">
    <sch:param name="context" value="//dct:PeriodOfTime"/>
    <sch:param name="element" value="time:hasBeginning"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_PeriodOfTime_time_hasEnd_nb197d44613ea4850a33e0687c6c79cb7b140">
    <sch:param name="context" value="//dct:PeriodOfTime"/>
    <sch:param name="element" value="time:hasEnd"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dct_Standard_dct_title_nb197d44613ea4850a33e0687c6c79cb7b130">
    <sch:param name="context" value="//dct:Standard"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dct_Standard_dct_description_nb197d44613ea4850a33e0687c6c79cb7b131">
    <sch:param name="context" value="//dct:Standard"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_owl_versionInfo_nb197d44613ea4850a33e0687c6c79cb7b132">
    <sch:param name="context" value="//dct:Standard"/>
    <sch:param name="element" value="owl:versionInfo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_skos_prefLabel_nb197d44613ea4850a33e0687c6c79cb7b133">
    <sch:param name="context" value="//dct:Standard"/>
    <sch:param name="element" value="skos:prefLabel"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_dct_type_nb197d44613ea4850a33e0687c6c79cb7b134">
    <sch:param name="context" value="//dct:Standard"/>
    <sch:param name="element" value="dct:type"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_rdfs_seeAlso_nb197d44613ea4850a33e0687c6c79cb7b135">
    <sch:param name="context" value="//dct:Standard"/>
    <sch:param name="element" value="rdfs:seeAlso"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dct_Standard_dct_issued_nb197d44613ea4850a33e0687c6c79cb7b136">
    <sch:param name="context" value="//dct:Standard"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_DataService_dct_description_nb197d44613ea4850a33e0687c6c79cb7b37">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_version_nb197d44613ea4850a33e0687c6c79cb7b38">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dcat:version"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_identifier_nb197d44613ea4850a33e0687c6c79cb7b39">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_DataService_dcat_keyword_nb197d44613ea4850a33e0687c6c79cb7b40">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dcat:keyword"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_DataService_dct_title_nb197d44613ea4850a33e0687c6c79cb7b41">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_contactPoint_nb197d44613ea4850a33e0687c6c79cb7b42">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_endpointURL_nb197d44613ea4850a33e0687c6c79cb7b43">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dcat:endpointURL"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_endpointDescription_nb197d44613ea4850a33e0687c6c79cb7b44">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dcat:endpointDescription"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_landingPage_nb197d44613ea4850a33e0687c6c79cb7b45">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dcat:landingPage"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_ontwikkelingstoestand_nb197d44613ea4850a33e0687c6c79cb7b46">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="mdcat:ontwikkelingstoestand"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_landingspaginaVoorAuthenticatie_nb197d44613ea4850a33e0687c6c79cb7b47">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="mdcat:landingspaginaVoorAuthenticatie"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_levensfase_nb197d44613ea4850a33e0687c6c79cb7b48">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="mdcat:levensfase"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_landingspaginaVoorStatusinformatie_nb197d44613ea4850a33e0687c6c79cb7b49">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="mdcat:landingspaginaVoorStatusinformatie"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_adms_identifier_nb197d44613ea4850a33e0687c6c79cb7b50">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_accessRights_nb197d44613ea4850a33e0687c6c79cb7b51">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:accessRights"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_conformsTo_nb197d44613ea4850a33e0687c6c79cb7b52">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:conformsTo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_statuut_nb197d44613ea4850a33e0687c6c79cb7b53">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="mdcat:statuut"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_mdcat_landingspaginaVoorGebruiksinformatie_nb197d44613ea4850a33e0687c6c79cb7b54">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="mdcat:landingspaginaVoorGebruiksinformatie"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_rights_nb197d44613ea4850a33e0687c6c79cb7b55">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:rights"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_theme_nb197d44613ea4850a33e0687c6c79cb7b56">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dcat:theme"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_license_nb197d44613ea4850a33e0687c6c79cb7b57">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:license"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_created_nb197d44613ea4850a33e0687c6c79cb7b58">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:created"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_modified_nb197d44613ea4850a33e0687c6c79cb7b59">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dct_issued_nb197d44613ea4850a33e0687c6c79cb7b60">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DataService_dcat_servesdataset_nb197d44613ea4850a33e0687c6c79cb7b61">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dcat:servesdataset"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_identifier_nb197d44613ea4850a33e0687c6c79cb7b2">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_issued_nb197d44613ea4850a33e0687c6c79cb7b3">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="MultilingualCardinalityCheck" id="dcat_CatalogRecord_dct_title_nb197d44613ea4850a33e0687c6c79cb7b4">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_modified_nb197d44613ea4850a33e0687c6c79cb7b5">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_mdcat_landingpageVoorBronMetadata_nb197d44613ea4850a33e0687c6c79cb7b6">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="mdcat:landingpageVoorBronMetadata"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_adms_identifier_nb197d44613ea4850a33e0687c6c79cb7b7">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_conformsTo_nb197d44613ea4850a33e0687c6c79cb7b8">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:conformsTo"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_dct_source_nb197d44613ea4850a33e0687c6c79cb7b9">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:source"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_CatalogRecord_foaf_primaryTopic_nb197d44613ea4850a33e0687c6c79cb7b10">
    <sch:param name="context" value="//dcat:CatalogRecord"/>
    <sch:param name="element" value="foaf:primaryTopic"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_description_nb197d44613ea4850a33e0687c6c79cb7b62">
    <sch:param name="context" value="//dcat:DatasetSeries"/>
    <sch:param name="element" value="dct:description"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_title_nb197d44613ea4850a33e0687c6c79cb7b63">
    <sch:param name="context" value="//dcat:DatasetSeries"/>
    <sch:param name="element" value="dct:title"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_identifier_nb197d44613ea4850a33e0687c6c79cb7b64">
    <sch:param name="context" value="//dcat:DatasetSeries"/>
    <sch:param name="element" value="dct:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dcat_contactPoint_nb197d44613ea4850a33e0687c6c79cb7b65">
    <sch:param name="context" value="//dcat:DatasetSeries"/>
    <sch:param name="element" value="dcat:contactPoint"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_accrualPeriodicity_nb197d44613ea4850a33e0687c6c79cb7b67">
    <sch:param name="context" value="//dcat:DatasetSeries"/>
    <sch:param name="element" value="dct:accrualPeriodicity"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_issued_nb197d44613ea4850a33e0687c6c79cb7b68">
    <sch:param name="context" value="//dcat:DatasetSeries"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_modified_nb197d44613ea4850a33e0687c6c79cb7b69">
    <sch:param name="context" value="//dcat:DatasetSeries"/>
    <sch:param name="element" value="dct:modified"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_adms_identifier_nb197d44613ea4850a33e0687c6c79cb7b72">
    <sch:param name="context" value="//dcat:DatasetSeries"/>
    <sch:param name="element" value="adms:identifier"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="dcat_DatasetSeries_dct_publisher_nb197d44613ea4850a33e0687c6c79cb7b73">
    <sch:param name="context" value="//dcat:DatasetSeries"/>
    <sch:param name="element" value="dct:publisher"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_skos_notation_nb197d44613ea4850a33e0687c6c79cb7b106">
    <sch:param name="context" value="//adms:Identifier"/>
    <sch:param name="element" value="skos:notation"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_adms_schemaAgency_nb197d44613ea4850a33e0687c6c79cb7b107">
    <sch:param name="context" value="//adms:Identifier"/>
    <sch:param name="element" value="adms:schemaAgency"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_dct_issued_nb197d44613ea4850a33e0687c6c79cb7b108">
    <sch:param name="context" value="//adms:Identifier"/>
    <sch:param name="element" value="dct:issued"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_generiek_gestructureerdeIdentificator_nb197d44613ea4850a33e0687c6c79cb7b109">
    <sch:param name="context" value="//adms:Identifier"/>
    <sch:param name="element" value="generiek:gestructureerdeIdentificator"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="adms_Identifier_dct_creator_nb197d44613ea4850a33e0687c6c79cb7b110">
    <sch:param name="context" value="//adms:Identifier"/>
    <sch:param name="element" value="dct:creator"/>
    <sch:param name="min" value="0"/>
    <sch:param name="max" value="1"/>
  </sch:pattern>
</sch:schema>