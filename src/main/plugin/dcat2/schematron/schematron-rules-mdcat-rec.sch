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
  <sch:ns prefix="geodcat" uri="http://data.europa.eu/930/"/>
  <sch:ns prefix="generiek" uri="http://data.vlaanderen.be/ns/generiek#"/>
  <sch:let name="profile" value="boolean(/*[starts-with(//dcat:CatalogRecord//dct:Standard/@rdf:about, 'https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat')])"/>
  <sch:pattern name="conform aan protocol" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/c394e1e5ae80a00d2aa307d647168d0c6733df26">
    <sch:title>Conform aan protocol - Een protocol waaraan de dataservice voldoet. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aconform%20aan%20protocol)</sch:title>
    <sch:rule context="//dcat:DataService/dct:conformsTo[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://data.vlaanderen.be/id/conceptscheme/dataserviceprotocol'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://data.vlaanderen.be/id/conceptscheme/dataserviceprotocol&gt; verwacht voor conform aan protocol (dct:conformsTo)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://data.vlaanderen.be/id/conceptscheme/dataserviceprotocol&gt; verwacht voor conform aan protocol (dct:conformsTo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="levensfase" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/0aea9e8a54457ca50f1b00c07872cb7c7b39e8ba">
    <sch:title>1337. Levensfase - De levensfase waarin de dataservice zich bevindt. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alevensfase)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:levensfase[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://data.vlaanderen.be/id/conceptscheme/levensfase'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://data.vlaanderen.be/id/conceptscheme/levensfase&gt; verwacht voor levensfase (mdcat:levensfase)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://data.vlaanderen.be/id/conceptscheme/levensfase&gt; verwacht voor levensfase (mdcat:levensfase)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/f9862087b9d1ec8465f46ee21e166c45776cf8bd">
    <sch:title>1348. Ontwikkelingstoestand - De ontwikkelingstoestand waarin de dataservice is gedeployed. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aontwikkelingstoestand)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:ontwikkelingstoestand[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://data.vlaanderen.be/id/conceptscheme/ontwikkelingstoestand'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://data.vlaanderen.be/id/conceptscheme/ontwikkelingstoestand&gt; verwacht voor ontwikkelingstoestand (mdcat:ontwikkelingstoestand)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://data.vlaanderen.be/id/conceptscheme/ontwikkelingstoestand&gt; verwacht voor ontwikkelingstoestand (mdcat:ontwikkelingstoestand)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/67325124afc7d6eac4402056620665f7348ef62a">
    <sch:title>Statuut - Een aanduiding van op welke basis de catalogusresource beschikbaar is. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Astatuut)</sch:title>
    <sch:rule context="//dcat:DataService/dct:subject[skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'][$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden&gt; verwacht voor statuut (dct:subject[skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'])</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden&gt; verwacht voor statuut (dct:subject[skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'])</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/48290800138d735a1909018da1426a5d120eedf0">
    <sch:title>1352. Thema - De hoofdcategorie waartoe de dataservice behoort. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Athema)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:theme[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://vocab.belgif.be/auth/datatheme'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://vocab.belgif.be/auth/datatheme&gt; verwacht voor thema (dcat:theme)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://vocab.belgif.be/auth/datatheme&gt; verwacht voor thema (dcat:theme)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/c5f6c428a4ae32239d9662d58fa65ae4f0cf49e6">
    <sch:title>1362. Toegankelijkheid - De toegankelijkheid voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:DataService/dct:accessRights[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://publications.europa.eu/resource/authority/access-right'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;http://publications.europa.eu/resource/authority/access-right&gt; verwacht voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;http://publications.europa.eu/resource/authority/access-right&gt; verwacht voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/67325124afc7d6eac4402056620665f7348ef62a">
    <sch:title>Statuut - Een aanduiding van op welke basis de catalogusresource beschikbaar is. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Astatuut)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:subject[skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'][$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden&gt; verwacht voor statuut (dct:subject[skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'])</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden&gt; verwacht voor statuut (dct:subject[skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'])</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/48290800138d735a1909018da1426a5d120eedf0">
    <sch:title>1713. Thema - De hoofdcategorie waartoe de dataset behoort. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Athema)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:theme[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://vocab.belgif.be/auth/datatheme'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://vocab.belgif.be/auth/datatheme&gt; verwacht voor thema (dcat:theme)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://vocab.belgif.be/auth/datatheme&gt; verwacht voor thema (dcat:theme)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/c5f6c428a4ae32239d9662d58fa65ae4f0cf49e6">
    <sch:title>1718. Toegankelijkheid - De toegankelijkheid voor de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accessRights[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://publications.europa.eu/resource/authority/access-right'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;http://publications.europa.eu/resource/authority/access-right&gt; verwacht voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;http://publications.europa.eu/resource/authority/access-right&gt; verwacht voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="formaat" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/6700896d1cda0a52b587461e48a50c4d221f043b">
    <sch:title>Formaat - Het bestandsformaat waarin de data wordt gedeeld. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Aformaat)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:format[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://publications.europa.eu/resource/authority/file-type'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;http://publications.europa.eu/resource/authority/file-type&gt; verwacht voor formaat (dct:format)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;http://publications.europa.eu/resource/authority/file-type&gt; verwacht voor formaat (dct:format)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="mediatype" id="https://data.vlaanderen.be/shacl/metadata_dcat#VoorbeeldWeergaveShape/91e8d1bb173f793bde16cb8a3dc8fde7844b5204">
    <sch:title>Mediatype - Het voorstellingsvorm van de afbeelding (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#VoorbeeldWeergave%3Amediatype)</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:mediatype[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'https://www.iana.org/assignments/media-types/media-types.xhtml'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;https://www.iana.org/assignments/media-types/media-types.xhtml&gt; verwacht voor mediatype (dcat:mediatype)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;https://www.iana.org/assignments/media-types/media-types.xhtml&gt; verwacht voor mediatype (dcat:mediatype)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rol" id="https://data.vlaanderen.be/shacl/metadata_dcat#RelatieQualificatieShape/110bcc4a81256c6b4b080feb1fd85186147a7841">
    <sch:title>Rol - De functie hoe de entiteiten zich tot elkaar verhouden.  (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#RelatieQualificatie%3Arol)</sch:title>
    <sch:rule context="//dcat:Relationship/dcat:hadRole[$profile]">
      <sch:let name="hasValue" value="skos:Concept/skos:inScheme/@rdf:resource = 'http://inspire.ec.europa.eu/metadata-codelist/SpatialRepresentationType'"/>
      <sch:assert test="$hasValue">Enkel waarden uit codelijst &lt;http://inspire.ec.europa.eu/metadata-codelist/SpatialRepresentationType&gt; verwacht voor rol (dcat:hadRole)</sch:assert>
      <sch:report test="$hasValue">Enkel waarden uit codelijst &lt;http://inspire.ec.europa.eu/metadata-codelist/SpatialRepresentationType&gt; verwacht voor rol (dcat:hadRole)</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>