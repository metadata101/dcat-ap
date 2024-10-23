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

  <sch:title xmlns="http://www.w3.org/2001/XMLSchema">{$loc/strings/schematron.title}</sch:title>

  <sch:let name="profile" value="boolean(/*[starts-with(//dcat:CatalogRecord//dct:Standard/@rdf:about, 'https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL')])"/>
  <sch:pattern>
    <sch:title>At least one theme from the data.gov.be vocabulary is required</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]|//dcat:DataService[$profile]">
      <sch:let name="dataThemes" value="count(dcat:theme[starts-with(skos:Concept/@rdf:about, 'http://vocab.belgif.be/auth/datatheme')])"/>
      <sch:assert test="$dataThemes &gt; 0">The dcat:Resource doesn't have a data.gov.be theme</sch:assert>
      <sch:report test="$dataThemes &gt; 0">The dcat:Resource have a data.gov.be theme</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="levensfase" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/0aea9e8a54457ca50f1b00c07872cb7c7b39e8ba">
    <sch:title>1337. Levensfase - De levensfase waarin de dataservice zich bevindt. (https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/ontwerpstandaard/2021-06-27#DataService%3Alevensfase)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:levensfase[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://data.vlaanderen.be/id/conceptscheme/levensfase'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://github.com/Informatievlaanderen/OSLOthema-metadataVoorServices/raw/master/codelijsten/levensfase.ttl&gt; verwacht voor levensfase (mdcat:levensfase)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://github.com/Informatievlaanderen/OSLOthema-metadataVoorServices/raw/master/codelijsten/levensfase.ttl&gt; verwacht voor levensfase (mdcat:levensfase)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/f9862087b9d1ec8465f46ee21e166c45776cf8bd">
    <sch:title>1348. Ontwikkelingstoestand - De ontwikkelingstoestand waarin de dataservice is gedeployed. (https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/ontwerpstandaard/2021-06-27#DataService%3Aontwikkelingstoestand)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:ontwikkelingstoestand[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://data.vlaanderen.be/id/conceptscheme/ontwikkelingstoestand'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://github.com/Informatievlaanderen/OSLOthema-metadataVoorServices/raw/master/codelijsten/ontwikkelingstoestand.ttl&gt; verwacht voor ontwikkelingstoestand (mdcat:ontwikkelingstoestand)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://github.com/Informatievlaanderen/OSLOthema-metadataVoorServices/raw/master/codelijsten/ontwikkelingstoestand.ttl&gt; verwacht voor ontwikkelingstoestand (mdcat:ontwikkelingstoestand)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/48290800138d735a1909018da1426a5d120eedf0">
    <sch:title>1352. Thema - De hoofdcategorie waartoe de dataservice behoort. (https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/ontwerpstandaard/2021-06-27#DataService%3Athema)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:theme[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://vocab.belgif.be/auth/datatheme'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://vocab.belgif.be/auth/datatheme&gt; verwacht voor thema (dcat:theme)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://vocab.belgif.be/auth/datatheme&gt; verwacht voor thema (dcat:theme)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/c5f6c428a4ae32239d9662d58fa65ae4f0cf49e6">
    <sch:title>1362. Toegankelijkheid - De toegankelijkheid voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/ontwerpstandaard/2021-06-27#DataService%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:DataService/dct:accessRights[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://publications.europa.eu/resource/authority/access-right'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;http://publications.europa.eu/resource/authority/access-right&gt; verwacht voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;http://publications.europa.eu/resource/authority/access-right&gt; verwacht voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/48290800138d735a1909018da1426a5d120eedf0">
    <sch:title>1713. Thema - De hoofdcategorie waartoe de dataset behoort. (https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/ontwerpstandaard/2021-06-27#Dataset%3Athema)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:theme[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://vocab.belgif.be/auth/datatheme'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://vocab.belgif.be/auth/datatheme&gt; verwacht voor thema (dcat:theme)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://vocab.belgif.be/auth/datatheme&gt; verwacht voor thema (dcat:theme)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/c5f6c428a4ae32239d9662d58fa65ae4f0cf49e6">
    <sch:title>1718. Toegankelijkheid - De toegankelijkheid voor de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/ontwerpstandaard/2021-06-27#Dataset%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accessRights[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://publications.europa.eu/resource/authority/access-right'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://publications.europa.eu/en/web/eu-vocabularies/at-dataset/-/resource/dataset/access-right&gt; verwacht voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://publications.europa.eu/en/web/eu-vocabularies/at-dataset/-/resource/dataset/access-right&gt; verwacht voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusResourceShape/67325124afc7d6eac4402056620665f7348ef62a">
    <sch:title>2006. Statuut - Een aanduiding van op welke basis de catalogusresource beschikbaar is. (https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/ontwerpstandaard/2021-06-27#CatalogusResource%3Astatuut)</sch:title>
    <sch:rule context="//dcat:Dataset/mdcat:statuut[$profile]|//dcat:DataService/mdcat:statuut[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/&gt; verwacht voor statuut (mdcat:statuut)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/&gt; verwacht voor statuut (mdcat:statuut)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#UsageNoteDistributieShape/3">
    <sch:title>Beschrijving - Een bondige tekstuele omschrijving van de catalogus.</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMin" value="count(dct:description) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor beschrijving (dct:description)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor beschrijving (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>
