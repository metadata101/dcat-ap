<?xml version="1.0" encoding="utf-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
  <sch:title xmlns="http://www.w3.org/2001/XMLSchema">{$loc/strings/schematron.title}</sch:title>
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
  <sch:ns prefix="skos" uri="http://www.w3.org/2004/02/skos/core#"/>
  <sch:ns prefix="xml" uri="http://www.w3.org/XML/1998/namespace"/>
  <sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
  <sch:ns prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
  <sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>
  <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
  <sch:ns prefix="mdcat" uri="http://data.vlaanderen.be/ns/metadata-dcat#"/>
  <sch:let name="profile" value="boolean(/*[starts-with(//dcat:CatalogRecord//dct:Standard/@rdf:about, 'https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat')])"/>
  <sch:pattern name="levensfase" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/0aea9e8a54457ca50f1b00c07872cb7c7b39e8ba">
    <sch:title>Levensfase - De levensfase waarin de dataservice zich bevindt. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alevensfase)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:levensfase[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://data.vlaanderen.be/id/conceptscheme/levensfase'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://data.vlaanderen.be/id/conceptscheme/levensfase&gt; verwacht voor levensfase (mdcat:levensfase)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://data.vlaanderen.be/id/conceptscheme/levensfase&gt; verwacht voor levensfase (mdcat:levensfase)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/f9862087b9d1ec8465f46ee21e166c45776cf8bd">
    <sch:title>Ontwikkelingstoestand - De ontwikkelingstoestand waarin de dataservice is gedeployed. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aontwikkelingstoestand)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:ontwikkelingstoestand[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://data.vlaanderen.be/id/conceptscheme/ontwikkelingstoestand'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://data.vlaanderen.be/id/conceptscheme/ontwikkelingstoestand&gt; verwacht voor ontwikkelingstoestand (mdcat:ontwikkelingstoestand)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://data.vlaanderen.be/id/conceptscheme/ontwikkelingstoestand&gt; verwacht voor ontwikkelingstoestand (mdcat:ontwikkelingstoestand)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/48290800138d735a1909018da1426a5d120eedf0">
    <sch:title>Thema - De hoofdcategorie waartoe de dataservice behoort. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Athema)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:theme[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://vocab.belgif.be/auth/datatheme'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://vocab.belgif.be/auth/datatheme&gt; verwacht voor thema (dcat:theme)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://vocab.belgif.be/auth/datatheme&gt; verwacht voor thema (dcat:theme)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/c5f6c428a4ae32239d9662d58fa65ae4f0cf49e6">
    <sch:title>Toegankelijkheid - De toegankelijkheid voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:DataService/dct:accessRights[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://publications.europa.eu/resource/authority/access-right/PUBLIC'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;http://publications.europa.eu/resource/authority/access-right/PUBLIC&gt; verwacht voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;http://publications.europa.eu/resource/authority/access-right/PUBLIC&gt; verwacht voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/48290800138d735a1909018da1426a5d120eedf0">
    <sch:title>Thema - De hoofdcategorie waartoe de dataset behoort. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Athema)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:theme[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://vocab.belgif.be/auth/datatheme'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://vocab.belgif.be/auth/datatheme&gt; verwacht voor thema (dcat:theme)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://vocab.belgif.be/auth/datatheme&gt; verwacht voor thema (dcat:theme)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/c5f6c428a4ae32239d9662d58fa65ae4f0cf49e6">
    <sch:title>Toegankelijkheid - De toegankelijkheid voor de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accessRights[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://publications.europa.eu/resource/authority/access-right'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;http://publications.europa.eu/resource/authority/access-right&gt; verwacht voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;http://publications.europa.eu/resource/authority/access-right&gt; verwacht voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>