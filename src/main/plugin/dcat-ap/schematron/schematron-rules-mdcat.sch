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
  <sch:pattern>
    <sch:title>$loc/strings/mdcat.pattern.title.1</sch:title>
    <sch:rule context="//vcard:hasEmail[$profile]">
      <sch:let name="mailto" value="starts-with(@rdf:resource,'mailto:')"/>
      <sch:assert test="$mailto = true()">$loc/strings/mdcat.pattern.assert.1</sch:assert>
      <sch:report test="$mailto = true()">$loc/strings/mdcat.pattern.report.1</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>$loc/strings/mdcat.pattern.title.2</sch:title>
    <sch:rule context="//dcat:contactPoint[$profile]">
      <sch:let name="hasEmail" value="normalize-space(vcard:Organization/vcard:hasEmail/@rdf:resource) != ''"/>
      <sch:let name="hasUrl" value="normalize-space(vcard:Organization/vcard:hasURL/@rdf:resource) != ''"/>
      <sch:assert test="$hasEmail or $hasUrl">$loc/strings/mdcat.pattern.assert.2</sch:assert>
      <sch:report test="$hasEmail or $hasUrl">$loc/strings/mdcat.pattern.report.2</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="naam" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#AgentShape/1399bd400d4637b15d5fe38202d6572f82150aac">
    <sch:title>$loc/strings/mdcat.pattern.title.3</sch:title>
    <sch:rule context="//foaf:Agent/foaf:name[$profile]|//dct:Agent/foaf:name[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.3</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.3</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactpagina" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#ContactinfoShape/0d43849949c290efe2f3d4ad1d010cdb7f0505bf">
    <sch:title>$loc/strings/mdcat.pattern.title.4</sch:title>
    <sch:rule context="//vcard:Organization/foaf:page[$profile]|//vcard:Kind/foaf:page[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.4</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.4</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="e-mail" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#ContactinfoShape/2cf221c2b6f9a619b0515c507ddd2bbb40fbb285">
    <sch:title>$loc/strings/mdcat.pattern.title.5</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasEmail[$profile]|//vcard:Kind/vcard:hasEmail[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^(mailto:)?[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.5</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.5</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="gestructureerde identificator" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#IdentificatorShape/0e92d523a1837590188fbfddd2ab0d9f901bdcab">
    <sch:title>$loc/strings/mdcat.pattern.title.6</sch:title>
    <sch:rule context="//adms:Identifier/generiek:gestructureerdeIdentificator[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(generiek:GestructureerdeIdentificator) = 1 or count(//generiek:GestructureerdeIdentificator[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.6</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.6</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend door" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#IdentificatorShape/ed560feb860205e0339910c9b2942564c01b5e11">
    <sch:title>$loc/strings/mdcat.pattern.title.7</sch:title>
    <sch:rule context="//adms:Identifier/dct:creator[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.7</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.7</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend door (String)" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#IdentificatorShape/5f023c37e7d18ecf8aecd2bb45eae0a05687cd6f">
    <sch:title>$loc/strings/mdcat.pattern.title.8</sch:title>
    <sch:rule context="//adms:Identifier/adms:schemaAgency[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mdcat.pattern.assert.8</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mdcat.pattern.report.8</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend op" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#IdentificatorShape/0f275ebdc16f2be1bf67063a80faf4ccea40332b">
    <sch:title>$loc/strings/mdcat.pattern.title.9</sch:title>
    <sch:rule context="//adms:Identifier/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.assert.9</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.report.9</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>$loc/strings/mdcat.pattern.title.10</sch:title>
    <sch:rule context="//dcat:Catalog/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.10</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.10</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>$loc/strings/mdcat.pattern.title.11</sch:title>
    <sch:rule context="//dcat:Catalog/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.11</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.11</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusShape/458062b0ae03c559426b85df3dd28e1c785acb0b">
    <sch:title>$loc/strings/mdcat.pattern.title.12</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.12</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.12</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="heeft DataService" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusShape/0b8b2df06927907abbf1e09b9c0c9c59bc6696f5">
    <sch:title>$loc/strings/mdcat.pattern.title.13</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:service[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.13</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.13</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="heeft Dataset" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusShape/b36184e1993242352bd0fb0cc0c9f8bdeea645ef">
    <sch:title>$loc/strings/mdcat.pattern.title.14</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:dataset[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.14</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.14</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusShape/509740cc7b3c86ebee90dc6303c11c40e2b08212">
    <sch:title>$loc/strings/mdcat.pattern.title.15</sch:title>
    <sch:rule context="//dcat:Catalog/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.15</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.15</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="record" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusShape/337cf55721093cc585693a5397601643d59a4c46">
    <sch:title>$loc/strings/mdcat.pattern.title.16</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:record[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:CatalogRecord) = 1 or count(//dcat:CatalogRecord[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.16</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.16</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>$loc/strings/mdcat.pattern.title.17</sch:title>
    <sch:rule context="//dcat:Catalog/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.17</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.17</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusShape/aabe67e6a56c5e2fc5695716e8f7b66edd525085">
    <sch:title>$loc/strings/mdcat.pattern.title.18</sch:title>
    <sch:rule context="//dcat:Catalog/dct:publisher[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.18</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.18</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="aanmaakdatum" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusRecordShape/73a4bdd8cd7b0472b3b38dc9f56b0f32b8239284">
    <sch:title>$loc/strings/mdcat.pattern.title.19</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.assert.19</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.report.19</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusRecordShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>$loc/strings/mdcat.pattern.title.20</sch:title>
    <sch:rule context="//dcat:CatalogRecord/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.20</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.20</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bron metadata record landingspagina" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusRecordShape/e7e0fa856a7a9fd5e0507143109ff56bbed15bc5">
    <sch:title>$loc/strings/mdcat.pattern.title.21</sch:title>
    <sch:rule context="//dcat:CatalogRecord/mdcat:landingpageVoorBronMetadata[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.21</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.21</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bron metadatarecord" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusRecordShape/ac72a26a136d49612ab47e1ead54cb3ac0f9dcb3">
    <sch:title>$loc/strings/mdcat.pattern.title.22</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:source[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.22</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.22</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusRecordShape/dd5cf5b162b3f92600a391f44660bf2b255693ac">
    <sch:title>$loc/strings/mdcat.pattern.title.23</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.23</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.23</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="hoofdonderwerp" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusRecordShape/e7d5497a1597fc6c5856517ab46c01bae413001b">
    <sch:title>$loc/strings/mdcat.pattern.title.24</sch:title>
    <sch:rule context="//dcat:CatalogRecord/foaf:primaryTopic[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.24</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.24</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusRecordShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>$loc/strings/mdcat.pattern.title.25</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.25</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.25</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusRecordShape/9e7585433d0896bc44cb41cdd8189793bd115cd0">
    <sch:title>$loc/strings/mdcat.pattern.title.26</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:modified[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.assert.26</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.report.26</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DistributieShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>$loc/strings/mdcat.pattern.title.27</sch:title>
    <sch:rule context="//dcat:Distribution/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.27</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.27</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DistributieShape/dd5cf5b162b3f92600a391f44660bf2b255693ac">
    <sch:title>$loc/strings/mdcat.pattern.title.28</sch:title>
    <sch:rule context="//dcat:Distribution/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.28</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.28</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DistributieShape/0e61107f343f202ee672ef465cfcdbbcd746e21d">
    <sch:title>$loc/strings/mdcat.pattern.title.29</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:downloadURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.29</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.29</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="formaat" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DistributieShape/866f7e6bf04104e9aa0f82fa4b8b0ff05ef17dc7">
    <sch:title>$loc/strings/mdcat.pattern.title.30</sch:title>
    <sch:rule context="//dcat:Distribution/dct:format[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.30</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.30</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DistributieShape/509740cc7b3c86ebee90dc6303c11c40e2b08212">
    <sch:title>$loc/strings/mdcat.pattern.title.31</sch:title>
    <sch:rule context="//dcat:Distribution/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.31</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.31</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rechten" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DistributieShape/62bb7a143add01ac0956709b58850f4f5e5a0e47">
    <sch:title>$loc/strings/mdcat.pattern.title.32</sch:title>
    <sch:rule context="//dcat:Distribution/dct:rights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.32</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.32</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DistributieShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>$loc/strings/mdcat.pattern.title.33</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.33</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.33</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegangsURL" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DistributieShape/3d0e850677d211050dd9e93ec6496e6af9908da6">
    <sch:title>$loc/strings/mdcat.pattern.title.34</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.34</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.34</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="verdeler" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DistributieShape/e142be9d61d29a86c3e36db738d8a9600b4a6ba7">
    <sch:title>$loc/strings/mdcat.pattern.title.35</sch:title>
    <sch:rule context="//dcat:Distribution/geodcat:distributor[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.35</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.35</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wordt aangeboden door" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DistributieShape/c612c1f62d45c84405f45260ab0737a10f5b0a18">
    <sch:title>$loc/strings/mdcat.pattern.title.36</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessService[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.36</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.36</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>$loc/strings/mdcat.pattern.title.37</sch:title>
    <sch:rule context="//dcat:DataService/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.37</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.37</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>$loc/strings/mdcat.pattern.title.38</sch:title>
    <sch:rule context="//dcat:DataService/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.38</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.38</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="biedt informatie aan over" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/5ed2c890f2c7588313cc9f93b35524bdb2d6328d">
    <sch:title>$loc/strings/mdcat.pattern.title.39</sch:title>
    <sch:rule context="//dcat:DataService/dcat:servesdataset[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.39</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.39</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform aan protocol" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/80a839685f13d2584ebe2f9b5d9a93ae2c1b21a0">
    <sch:title>$loc/strings/mdcat.pattern.title.40</sch:title>
    <sch:rule context="//dcat:DataService/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.40</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.40</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/458062b0ae03c559426b85df3dd28e1c785acb0b">
    <sch:title>$loc/strings/mdcat.pattern.title.41</sch:title>
    <sch:rule context="//dcat:DataService/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.41</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.41</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="creatiedatum" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/a0b7156be408a447d937582d4d0c3cafea754f8b">
    <sch:title>$loc/strings/mdcat.pattern.title.42</sch:title>
    <sch:rule context="//dcat:DataService/dct:created[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.assert.42</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.report.42</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointURL" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/67c89165b0f38567bf099862ffdef88f25e68714">
    <sch:title>$loc/strings/mdcat.pattern.title.43</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.43</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.43</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointbeschrijving" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/dbc2548616486a154002cfba6a3bc2cbc554a682">
    <sch:title>$loc/strings/mdcat.pattern.title.44</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointDescription[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.44</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.44</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/fe1a78c9169da2469a23fd783cf9a69060bfe198">
    <sch:title>$loc/strings/mdcat.pattern.title.45</sch:title>
    <sch:rule context="//dcat:DataService/dcat:landingPage[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.45</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.45</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor authenticatie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/2be8f764879c3f2218306704a430503d286c30e9">
    <sch:title>$loc/strings/mdcat.pattern.title.46</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorAuthenticatie[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.46</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.46</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor gebruiksinformatie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/c4eb7e771a95c6c3e5c04255458173a2b0b40f43">
    <sch:title>$loc/strings/mdcat.pattern.title.47</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorGebruiksinformatie[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.47</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.47</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor statusinformatie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/0cdcfe2387440711ebbe94a2fcc93a29377956c5">
    <sch:title>$loc/strings/mdcat.pattern.title.48</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorStatusinformatie[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.48</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.48</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="levensfase" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/13afabc6c35a0042403bd3a9f50222200152231a">
    <sch:title>$loc/strings/mdcat.pattern.title.49</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:levensfase[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.49</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.49</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/509740cc7b3c86ebee90dc6303c11c40e2b08212">
    <sch:title>$loc/strings/mdcat.pattern.title.50</sch:title>
    <sch:rule context="//dcat:DataService/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.50</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.50</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/4523d6e75f8993d15c9332b0aae5dbbe64a85b5a">
    <sch:title>$loc/strings/mdcat.pattern.title.51</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:ontwikkelingstoestand[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.51</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.51</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/0e54e6660eb6bc0ea08ebfce3dbbf188c3e400d8">
    <sch:title>$loc/strings/mdcat.pattern.title.52</sch:title>
    <sch:rule context="//dcat:DataService/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.assert.52</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.report.52</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rechten" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/62bb7a143add01ac0956709b58850f4f5e5a0e47">
    <sch:title>$loc/strings/mdcat.pattern.title.53</sch:title>
    <sch:rule context="//dcat:DataService/dct:rights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.53</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.53</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/f96c5f798f9e9c00220a293bd11f37e83616d33b">
    <sch:title>$loc/strings/mdcat.pattern.title.54</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:statuut[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.54</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.54</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/1712ef1b325d7d2807bc601d6409b70a42eaff10">
    <sch:title>$loc/strings/mdcat.pattern.title.55</sch:title>
    <sch:rule context="//dcat:DataService/dcat:theme[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.55</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.55</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>$loc/strings/mdcat.pattern.title.56</sch:title>
    <sch:rule context="//dcat:DataService/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.56</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.56</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/a81035a5dbbdae24651c34e5602a1fe6fe5427a3">
    <sch:title>$loc/strings/mdcat.pattern.title.57</sch:title>
    <sch:rule context="//dcat:DataService/dct:accessRights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.57</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.57</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/44f6426e2306c5bc0421823eb4a1a034b615f715">
    <sch:title>$loc/strings/mdcat.pattern.title.58</sch:title>
    <sch:rule context="//dcat:DataService/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.58</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.58</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/587f313308111b587d1bd2440a56622e64624864">
    <sch:title>$loc/strings/mdcat.pattern.title.59</sch:title>
    <sch:rule context="//dcat:DataService/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mdcat.pattern.assert.59</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mdcat.pattern.report.59</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DataServiceShape/9e7585433d0896bc44cb41cdd8189793bd115cd0">
    <sch:title>$loc/strings/mdcat.pattern.title.60</sch:title>
    <sch:rule context="//dcat:DataService/dct:modified[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.assert.60</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.report.60</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="Catalogus Resource (source)" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#RelatieQualificatieShape/aa69087cd9f59b7d23c9ca16a88c4298d77dcd0c">
    <sch:title>$loc/strings/mdcat.pattern.title.61</sch:title>
    <sch:rule context="//dcat:Relationship/mdcat:RelatieQualificatie.catalogusResource.source[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.61</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.61</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="Catalogus Resource (target)" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#RelatieQualificatieShape/80179238c15e4eb0f284c28f3a87c523281be2cd">
    <sch:title>$loc/strings/mdcat.pattern.title.62</sch:title>
    <sch:rule context="//dcat:Relationship/mdcat:RelatieQualificatie.catalogusResource.target[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.62</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.62</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rol" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#RelatieQualificatieShape/e5ccf692ee38c28199531eb5e0c59554153a57c3">
    <sch:title>$loc/strings/mdcat.pattern.title.63</sch:title>
    <sch:rule context="//dcat:Relationship/dcat:hadRole[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.63</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.63</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#StandaardShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>$loc/strings/mdcat.pattern.title.64</sch:title>
    <sch:rule context="//dct:Standard/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.64</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.64</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#StandaardShape/0e54e6660eb6bc0ea08ebfce3dbbf188c3e400d8">
    <sch:title>$loc/strings/mdcat.pattern.title.65</sch:title>
    <sch:rule context="//dct:Standard/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.assert.65</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.report.65</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="specificatie URL" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#StandaardShape/817c38a73348ef5623204d13efbf44e68a4612e8">
    <sch:title>$loc/strings/mdcat.pattern.title.66</sch:title>
    <sch:rule context="//dct:Standard/rdfs:seeAlso[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.66</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.66</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#StandaardShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>$loc/strings/mdcat.pattern.title.67</sch:title>
    <sch:rule context="//dct:Standard/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.67</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.67</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="type" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#StandaardShape/322371a77364a50f049d46180f6192532eea26dc">
    <sch:title>$loc/strings/mdcat.pattern.title.68</sch:title>
    <sch:rule context="//dct:Standard/dct:type[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.68</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.68</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#StandaardShape/587f313308111b587d1bd2440a56622e64624864">
    <sch:title>$loc/strings/mdcat.pattern.title.69</sch:title>
    <sch:rule context="//dct:Standard/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mdcat.pattern.assert.69</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mdcat.pattern.report.69</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="voorkeurslabel" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#StandaardShape/f8712dd0e04b5c6b79d939432a639019c7295c6f">
    <sch:title>$loc/strings/mdcat.pattern.title.70</sch:title>
    <sch:rule context="//dct:Standard/skos:prefLabel[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mdcat.pattern.assert.70</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mdcat.pattern.report.70</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="relatie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusResourceShape/0f8fcba8defd790e04421c1042f74286d52c564b">
    <sch:title>$loc/strings/mdcat.pattern.title.71</sch:title>
    <sch:rule context="//mdcat:RelatieQualificatie.catalogusResource.target/dct:relation[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.71</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.71</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#CatalogusResourceShape/aabe67e6a56c5e2fc5695716e8f7b66edd525085">
    <sch:title>$loc/strings/mdcat.pattern.title.72</sch:title>
    <sch:rule context="//mdcat:RelatieQualificatie.catalogusResource.target/dct:publisher[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.72</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.72</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>$loc/strings/mdcat.pattern.title.73</sch:title>
    <sch:rule context="//dcat:Dataset/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.73</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.73</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>$loc/strings/mdcat.pattern.title.74</sch:title>
    <sch:rule context="//dcat:Dataset/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.74</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.74</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/dd5cf5b162b3f92600a391f44660bf2b255693ac">
    <sch:title>$loc/strings/mdcat.pattern.title.75</sch:title>
    <sch:rule context="//dcat:Dataset/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.75</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.75</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/458062b0ae03c559426b85df3dd28e1c785acb0b">
    <sch:title>$loc/strings/mdcat.pattern.title.76</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.76</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.76</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="creatiedatum" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/a0b7156be408a447d937582d4d0c3cafea754f8b">
    <sch:title>$loc/strings/mdcat.pattern.title.77</sch:title>
    <sch:rule context="//dcat:Dataset/dct:created[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.assert.77</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.report.77</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="distributie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/cfbe0a11423fe15e990c3cbd5209404c26dbef0f">
    <sch:title>$loc/strings/mdcat.pattern.title.78</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:distribution[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Distribution) = 1 or count(//dcat:Distribution[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.78</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.78</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="eigenaar" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/0addb769185db828aa4c44888f0aa906471c3d06">
    <sch:title>$loc/strings/mdcat.pattern.title.79</sch:title>
    <sch:rule context="//dcat:Dataset/dct:rightsHolder[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.79</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.79</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="geografische dekking" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/883b5dc28b6bef2ce82b138ead1eb3c7f2073b92">
    <sch:title>$loc/strings/mdcat.pattern.title.80</sch:title>
    <sch:rule context="//dcat:Dataset/dct:spatial[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Location) = 1 or count(//dct:Location[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.80</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.80</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="herkomst" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/7f7729e4df614394423f92badbe4304148f90b07">
    <sch:title>$loc/strings/mdcat.pattern.title.81</sch:title>
    <sch:rule context="//dcat:Dataset/dct:provenance[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:ProvenanceStatement) = 1 or count(//dct:ProvenanceStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.81</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.81</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/fe1a78c9169da2469a23fd783cf9a69060bfe198">
    <sch:title>$loc/strings/mdcat.pattern.title.82</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:landingPage[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.82</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.82</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/0e54e6660eb6bc0ea08ebfce3dbbf188c3e400d8">
    <sch:title>$loc/strings/mdcat.pattern.title.83</sch:title>
    <sch:rule context="//dcat:Dataset/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.assert.83</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.report.83</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/f96c5f798f9e9c00220a293bd11f37e83616d33b">
    <sch:title>$loc/strings/mdcat.pattern.title.84</sch:title>
    <sch:rule context="//dcat:Dataset/mdcat:statuut[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.84</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.84</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/1712ef1b325d7d2807bc601d6409b70a42eaff10">
    <sch:title>$loc/strings/mdcat.pattern.title.85</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:theme[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.85</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.85</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>$loc/strings/mdcat.pattern.title.86</sch:title>
    <sch:rule context="//dcat:Dataset/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.86</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.86</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/a81035a5dbbdae24651c34e5602a1fe6fe5427a3">
    <sch:title>$loc/strings/mdcat.pattern.title.87</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accessRights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.87</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.87</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/44f6426e2306c5bc0421823eb4a1a034b615f715">
    <sch:title>$loc/strings/mdcat.pattern.title.88</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.88</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.88</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/587f313308111b587d1bd2440a56622e64624864">
    <sch:title>$loc/strings/mdcat.pattern.title.89</sch:title>
    <sch:rule context="//dcat:Dataset/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mdcat.pattern.assert.89</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mdcat.pattern.report.89</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="voorbeeldweergave" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/b797fd4af5bc2767e8e3a3799a5aae84ec998d04">
    <sch:title>$loc/strings/mdcat.pattern.title.90</sch:title>
    <sch:rule context="//dcat:Dataset/adms:sample[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Distribution) = 1 or count(//dcat:Distribution[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.90</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.90</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#DatasetShape/9e7585433d0896bc44cb41cdd8189793bd115cd0">
    <sch:title>$loc/strings/mdcat.pattern.title.91</sch:title>
    <sch:rule context="//dcat:Dataset/dct:modified[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.assert.91</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/mdcat.pattern.report.91</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="plaatsnaam" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#PlaatsShape/3562937fd68e5b9b91210d2e17383e28b6a7a53b">
    <sch:title>$loc/strings/mdcat.pattern.title.92</sch:title>
    <sch:rule context="//dct:Location/rdfs:label[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.92</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.92</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#VoorbeeldWeergaveShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>$loc/strings/mdcat.pattern.title.93</sch:title>
    <sch:rule context="//dcat:Distribution/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.93</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.93</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#VoorbeeldWeergaveShape/0e61107f343f202ee672ef465cfcdbbcd746e21d">
    <sch:title>$loc/strings/mdcat.pattern.title.94</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:downloadURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.94</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.94</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="mediatype" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#VoorbeeldWeergaveShape/f15bdaee3382af94fe22b0dade89fc2e9fefbbdc">
    <sch:title>$loc/strings/mdcat.pattern.title.95</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:mediatype[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mdcat.pattern.assert.95</sch:assert>
      <sch:report test="$validClass">$loc/strings/mdcat.pattern.report.95</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2022-04-21#VoorbeeldWeergaveShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>$loc/strings/mdcat.pattern.title.96</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.assert.96</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/mdcat.pattern.report.96</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>