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

  <sch:pattern is-a="CardinalityCheck" id="Dataset_hvdCategory">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dcatap:hvdCategory"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="Dataset_applicableLegislation">
    <sch:param name="context" value="//dcat:Dataset"/>
    <sch:param name="element" value="dcatap:applicableLegislation"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="DataService_hvdCategory">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dcatap:hvdCategory"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
  <sch:pattern is-a="CardinalityCheck" id="DataService_applicableLegislation">
    <sch:param name="context" value="//dcat:DataService"/>
    <sch:param name="element" value="dcatap:applicableLegislation"/>
    <sch:param name="min" value="1"/>
    <sch:param name="max" value="n"/>
  </sch:pattern>
</sch:schema>
