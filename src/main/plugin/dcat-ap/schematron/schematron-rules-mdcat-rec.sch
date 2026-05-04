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
  <sch:pattern name="formaat" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DistributieShape/6700896d1cda0a52b587461e48a50c4d221f043b">
    <sch:title>$loc/strings/mdcat-rec.pattern.title.1</sch:title>
    <sch:rule context="//dcat:Distribution/dct:format[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://publications.europa.eu/resource/authority/file-type'"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.assert.1</sch:assert>
      <sch:report test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.report.1</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform aan protocol" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/c394e1e5ae80a00d2aa307d647168d0c6733df26">
    <sch:title>$loc/strings/mdcat-rec.pattern.title.2</sch:title>
    <sch:rule context="//dcat:DataService/dct:conformsTo[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://data.vlaanderen.be/id/conceptscheme/dataserviceprotocol'"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.assert.2</sch:assert>
      <sch:report test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.report.2</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="levensfase" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/0aea9e8a54457ca50f1b00c07872cb7c7b39e8ba">
    <sch:title>$loc/strings/mdcat-rec.pattern.title.3</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:levensfase[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://data.vlaanderen.be/id/conceptscheme/levensfase'"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.assert.3</sch:assert>
      <sch:report test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.report.3</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/f9862087b9d1ec8465f46ee21e166c45776cf8bd">
    <sch:title>$loc/strings/mdcat-rec.pattern.title.4</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:ontwikkelingstoestand[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://data.vlaanderen.be/id/conceptscheme/ontwikkelingstoestand'"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.assert.4</sch:assert>
      <sch:report test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.report.4</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/67325124afc7d6eac4402056620665f7348ef62a">
    <sch:title>$loc/strings/mdcat-rec.pattern.title.5</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:statuut[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.assert.5</sch:assert>
      <sch:report test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.report.5</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/48290800138d735a1909018da1426a5d120eedf0">
    <sch:title>$loc/strings/mdcat-rec.pattern.title.6</sch:title>
    <sch:rule context="//dcat:DataService/dcat:theme[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://vocab.belgif.be/auth/datatheme'"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.assert.6</sch:assert>
      <sch:report test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.report.6</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/c5f6c428a4ae32239d9662d58fa65ae4f0cf49e6">
    <sch:title>$loc/strings/mdcat-rec.pattern.title.7</sch:title>
    <sch:rule context="//dcat:DataService/dct:accessRights[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://publications.europa.eu/resource/authority/access-right'"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.assert.7</sch:assert>
      <sch:report test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.report.7</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/67325124afc7d6eac4402056620665f7348ef62a">
    <sch:title>$loc/strings/mdcat-rec.pattern.title.8</sch:title>
    <sch:rule context="//dcat:Dataset/mdcat:statuut[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.assert.8</sch:assert>
      <sch:report test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.report.8</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/48290800138d735a1909018da1426a5d120eedf0">
    <sch:title>$loc/strings/mdcat-rec.pattern.title.9</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:theme[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://vocab.belgif.be/auth/datatheme'"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.assert.9</sch:assert>
      <sch:report test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.report.9</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/c5f6c428a4ae32239d9662d58fa65ae4f0cf49e6">
    <sch:title>$loc/strings/mdcat-rec.pattern.title.10</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accessRights[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://publications.europa.eu/resource/authority/access-right'"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.assert.10</sch:assert>
      <sch:report test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.report.10</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="mediatype" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#VoorbeeldWeergaveShape/91e8d1bb173f793bde16cb8a3dc8fde7844b5204">
    <sch:title>$loc/strings/mdcat-rec.pattern.title.11</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:mediatype[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://www.iana.org/assignments/media-types/media-types.xhtml'"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.assert.11</sch:assert>
      <sch:report test="$hasValue and $isIRI">$loc/strings/mdcat-rec.pattern.report.11</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>