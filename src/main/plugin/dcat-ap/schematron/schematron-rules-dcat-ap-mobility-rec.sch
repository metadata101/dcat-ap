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
  <sch:ns prefix="odrl" uri="http://www.w3.org/ns/odrl/2/"/>
  <sch:ns prefix="prov" uri="http://www.w3.org/ns/prov#"/>
  <sch:ns prefix="geodcat" uri="http://data.europa.eu/930/"/>
  <sch:ns prefix="generiek" uri="https://data.vlaanderen.be/ns/generiek#"/>
  <sch:ns prefix="rdfs" uri="http://www.w3.org/2000/01/rdf-schema#"/>

  <sch:title xmlns="http://www.w3.org/2001/XMLSchema">{$loc/strings/schematron.title}</sch:title>

  <sch:pattern id="recommended_theme">
    <sch:title>$loc/strings/recommended.dcat_theme_tran.title</sch:title>
    <sch:rule context="//dcat:Dataset|//dcat:DataService">
      <sch:let name="tranDcatTheme" value="dcat:theme[skos:Concept/@rdf:about='http://vocab.belgif.be/auth/datatheme/TRAN' or skos:Concept/@rdf:about='http://publications.europa.eu/resource/authority/data-theme/TRAN']"/>
      <sch:assert test="count($tranDcatTheme) = 1">$loc/strings/recommended.dcat_theme_tran.assert</sch:assert>
      <sch:report test="count($tranDcatTheme) = 1">$loc/strings/recommended.dcat_theme_tran.report</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- "Mandatory" properties in BE (NAP). These are not defined in a standard so they are highlighted in the recommendation section instead. -->
  <sch:pattern id="distribution_issued_mandatory_be">
    <sch:title>$loc/strings/distribution.issued.mandatory.be.title</sch:title>
    <sch:rule context="dcat:Distribution">
      <sch:assert test="count(dct:issued) = 1">$loc/strings/distribution.issued.mandatory.be.assert</sch:assert>
      <sch:report test="count(dct:issued) = 1">$loc/strings/distribution.issued.mandatory.be.report</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="distribution_modified_mandatory_be">
    <sch:title>$loc/strings/distribution.modified.mandatory.be.title</sch:title>
    <sch:rule context="dcat:Distribution">
      <sch:assert test="count(dct:modified) = 1">$loc/strings/distribution.modified.mandatory.be.assert</sch:assert>
      <sch:report test="count(dct:modified) = 1">$loc/strings/distribution.modified.mandatory.be.report</sch:report>
    </sch:rule>
  </sch:pattern>


  <!-- "Removed" properties in mobility are mentioned separately from the cardinalities as there is no consensus yet on whether these need to be dealt with as a strict removal. -->
  <sch:pattern abstract="true" id="PropertyRemovedCheck">
    <sch:title>geonet:replacePlaceholders($loc/strings/property.removed.title, ('#context', '#element'), ('$context', '$element'))</sch:title>
    <sch:rule context="$context">
      <sch:assert test="count($element) = 0">
        <sch:value-of select="geonet:replacePlaceholders($loc/strings/property.removed.assert, ('#context', '#element'), ('$context', '$element'))"/>
      </sch:assert>
      <sch:report test="count($element) = 0">
        <sch:value-of select="geonet:replacePlaceholders($loc/strings/property.removed.report, ('#context', '#element'), ('$context', '$element'))"/>
      </sch:report>
    </sch:rule>
  </sch:pattern>

  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_Modified">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dct:modified"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Catalog_catalog">
    <sch:param name="context" value="dcat:Catalog"/>
    <sch:param name="element" value="dcat:catalog"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Catalog_service">
    <sch:param name="context" value="dcat:Catalog"/>
    <sch:param name="element" value="dcat:service"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Catalog_creator">
    <sch:param name="context" value="dcat:Catalog"/>
    <sch:param name="element" value="dct:creator"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Catalog_rights">
    <sch:param name="context" value="dcat:Catalog"/>
    <sch:param name="element" value="dct:rights"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="CatalogRecord_status">
    <sch:param name="context" value="dcat:CatalogRecord"/>
    <sch:param name="element" value="adms:status"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="CatalogRecord_conformsTo">
    <sch:param name="context" value="dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:conformsTo"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="CatalogRecord_description">
    <sch:param name="context" value="dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:description"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="CatalogRecord_issued">
    <sch:param name="context" value="dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:issued"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="CatalogRecord_title">
    <sch:param name="context" value="dcat:CatalogRecord"/>
    <sch:param name="element" value="dct:title"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_sample ">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="adms:sample "/>
  </sch:pattern>"
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_landingPage ">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="dcat:landingPage "/>
  </sch:pattern>"
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_qualifiedRelation ">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="dcat:qualifiedRelation "/>
  </sch:pattern>"
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_spatialResolutionInMeters">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="dcat:spatialResolutionInMeters"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_temporalResolution">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="dcat:temporalResolution"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_accessRights">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="dct:accessRights"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_conformsTo">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="dct:conformsTo"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_creator">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="dct:creator"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_provenance ">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="dct:provenance "/>
  </sch:pattern>"
  <sch:pattern Dataseta="PropertyRemovedCheck" id="Dataset_source ">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="dct:source "/>
  </sch:pattern>"
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_type">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="dct:type"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_page">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="foaf:page"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_qualifiedAttribution ">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="prov:qualifiedAttribution "/>
  </sch:pattern>"
  <sch:pattern is-a="PropertyRemovedCheck" id="Dataset_wasGeneratedBy">
    <sch:param name="context" value="dcat:Dataset"/>
    <sch:param name="element" value="prov:wasGeneratedBy"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_status">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="adms:status"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_byteSize">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dcat:byteSize"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_compressFormat">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dcat:compressFormat"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_mediaType">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dcat:mediaType"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_packageFormat">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dcat:packageFormat"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_spatialResolutionInMeters">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dcat:spatialResolutionInMeters"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_temporalResolution">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dcat:temporalResolution"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_availability">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dcatap:availability"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_conformsTo">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dct:conformsTo"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_issued">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dct:issued"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_language">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dct:language"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_modified">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="dct:modified"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_page">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="foaf:page"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_hasPolicy">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="odrl:hasPolicy"/>
  </sch:pattern>
  <sch:pattern is-a="PropertyRemovedCheck" id="Distribution_checksum">
    <sch:param name="context" value="dcat:Distribution"/>
    <sch:param name="element" value="spdx:checksum"/>
  </sch:pattern>

</sch:schema>
