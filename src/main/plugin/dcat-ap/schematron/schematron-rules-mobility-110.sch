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
  <sch:pattern name="algorithm" id="_:n09c766334d33454f855f4cff0e6888f7b74">
    <sch:title>$loc/strings/mobility-110.pattern.title.1</sch:title>
    <sch:rule context="//spdx:Checksum/spdx:algorithm[$profile]">
      <sch:let name="hasValue" value="string() = 'spdx:checksumAlgorithm_sha1' or */@rdf:about = 'spdx:checksumAlgorithm_sha1' or ./@rdf:resource = 'spdx:checksumAlgorithm_sha1'"/>
      <sch:assert test="$hasValue">$loc/strings/mobility-110.pattern.assert.1</sch:assert>
      <sch:report test="$hasValue">$loc/strings/mobility-110.pattern.report.1</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="checksum value" id="_:n09c766334d33454f855f4cff0e6888f7b75">
    <sch:title>$loc/strings/mobility-110.pattern.title.2</sch:title>
    <sch:rule context="//spdx:Checksum/spdx:checksumValue[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.2</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.2</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="standard name" id="_:n09c766334d33454f855f4cff0e6888f7b126">
    <sch:title>$loc/strings/mobility-110.pattern.title.3</sch:title>
    <sch:rule context="//mobilitydcatap:mobilityDataStandard/dct:conformsTo[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="matchesPattern" value="matches($resource, 'https://w3id.org/mobilitydcat-ap/mobility-data-standard/')"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-110.pattern.assert.3</sch:assert>
      <sch:report test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-110.pattern.report.3</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="version" id="_:n09c766334d33454f855f4cff0e6888f7b127">
    <sch:title>$loc/strings/mobility-110.pattern.title.4</sch:title>
    <sch:rule context="//mobilitydcatap:mobilityDataStandard/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.4</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.4</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="schema" id="_:n09c766334d33454f855f4cff0e6888f7b128">
    <sch:title>$loc/strings/mobility-110.pattern.title.5</sch:title>
    <sch:rule context="//mobilitydcatap:mobilityDataStandard/mobilitydcatap:schema[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-110.pattern.assert.5</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-110.pattern.report.5</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="language" id="_:n09c766334d33454f855f4cff0e6888f7b58">
    <sch:title>$loc/strings/mobility-110.pattern.title.6</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:language[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((count(dct:LinguisticSystem) = 1 or count(//dct:LinguisticSystem[@rdf:about = $resource]) = 1))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/mobility-110.pattern.assert.6</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/mobility-110.pattern.report.6</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="primary topic" id="_:n09c766334d33454f855f4cff0e6888f7b63">
    <sch:title>$loc/strings/mobility-110.pattern.title.7</sch:title>
    <sch:rule context="//dcat:CatalogRecord/foaf:primaryTopic[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.7</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.7</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publisher" id="_:n09c766334d33454f855f4cff0e6888f7b69">
    <sch:title>$loc/strings/mobility-110.pattern.title.8</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:publisher[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.8</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.8</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="source metadata" id="_:n09c766334d33454f855f4cff0e6888f7b70">
    <sch:title>$loc/strings/mobility-110.pattern.title.9</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:source[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:CatalogRecord) = 1 or count(//dcat:CatalogRecord[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.9</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.9</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="mobility data standard" id="_:n09c766334d33454f855f4cff0e6888f7b91">
    <sch:title>$loc/strings/mobility-110.pattern.title.10</sch:title>
    <sch:rule context="//dcat:Distribution/mobilitydcatap:MobilityDataStandard[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((matches($resource, '^\w+:(/?/?)[^\s]+$') and (matches($resource, 'https://w3id.org/mobilitydcat-ap/mobility-data-standard/'))) or (count(mobilitydcatap:MobilityDataStandard) = 1 or count(//mobilitydcatap:MobilityDataStandard[@rdf:about = $resource]) = 1))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/mobility-110.pattern.assert.10</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/mobility-110.pattern.report.10</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="application layer protocol" id="_:n09c766334d33454f855f4cff0e6888f7b96">
    <sch:title>$loc/strings/mobility-110.pattern.title.11</sch:title>
    <sch:rule context="//dcat:Distribution/mobilitydcatap:applicationLayerProtocol[$profile]">
      <sch:let name="matchesPattern" value="matches(normalize-space(.), 'https://w3id.org/mobilitydcat-ap/application-layer-protocol')"/>
      <sch:assert test="$matchesPattern">$loc/strings/mobility-110.pattern.assert.11</sch:assert>
      <sch:report test="$matchesPattern">$loc/strings/mobility-110.pattern.report.11</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="character encoding" id="_:n09c766334d33454f855f4cff0e6888f7b97">
    <sch:title>$loc/strings/mobility-110.pattern.title.12</sch:title>
    <sch:rule context="//dcat:Distribution/content:characterEncoding[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.12</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.12</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="communication method" id="_:n09c766334d33454f855f4cff0e6888f7b98">
    <sch:title>$loc/strings/mobility-110.pattern.title.13</sch:title>
    <sch:rule context="//dcat:Distribution/mobilitydcatap:communicationMethod[$profile]">
      <sch:let name="matchesPattern" value="matches(normalize-space(.), 'https://w3id.org/mobilitydcat-ap/communication-method')"/>
      <sch:assert test="$matchesPattern">$loc/strings/mobility-110.pattern.assert.13</sch:assert>
      <sch:report test="$matchesPattern">$loc/strings/mobility-110.pattern.report.13</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="data format notes" id="_:n09c766334d33454f855f4cff0e6888f7b99">
    <sch:title>$loc/strings/mobility-110.pattern.title.14</sch:title>
    <sch:rule context="//dcat:Distribution/mobilitydcatap:dataFormatNotes[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.14</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.14</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="grammar" id="_:n09c766334d33454f855f4cff0e6888f7b100">
    <sch:title>$loc/strings/mobility-110.pattern.title.15</sch:title>
    <sch:rule context="//dcat:Distribution/mobilitydcatap:grammar[$profile]">
      <sch:let name="matchesPattern" value="matches(normalize-space(.), 'https://w3id.org/mobilitydcat-ap/grammar')"/>
      <sch:assert test="$matchesPattern">$loc/strings/mobility-110.pattern.assert.15</sch:assert>
      <sch:report test="$matchesPattern">$loc/strings/mobility-110.pattern.report.15</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="sample" id="_:n09c766334d33454f855f4cff0e6888f7b101">
    <sch:title>$loc/strings/mobility-110.pattern.title.16</sch:title>
    <sch:rule context="//dcat:Distribution/adms:sample[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-110.pattern.assert.16</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-110.pattern.report.16</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="temporal coverage" id="_:n09c766334d33454f855f4cff0e6888f7b102">
    <sch:title>$loc/strings/mobility-110.pattern.title.17</sch:title>
    <sch:rule context="//dcat:Distribution/dct:temporal[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:PeriodOfTime) = 1 or count(//dct:PeriodOfTime[@rdf:about = $resource]) = 1"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$validClass and $isBlankNodeOrIRI">$loc/strings/mobility-110.pattern.assert.17</sch:assert>
      <sch:report test="$validClass and $isBlankNodeOrIRI">$loc/strings/mobility-110.pattern.report.17</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="dataset" id="_:n09c766334d33454f855f4cff0e6888f7b25">
    <sch:title>$loc/strings/mobility-110.pattern.title.18</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:dataset[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.18</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.18</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="description" id="_:n09c766334d33454f855f4cff0e6888f7b26">
    <sch:title>$loc/strings/mobility-110.pattern.title.19</sch:title>
    <sch:rule context="//dcat:Catalog/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.19</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.19</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="homepage" id="_:n09c766334d33454f855f4cff0e6888f7b27">
    <sch:title>$loc/strings/mobility-110.pattern.title.20</sch:title>
    <sch:rule context="//dcat:Catalog/foaf:homepage[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-110.pattern.assert.20</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-110.pattern.report.20</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publisher" id="_:n09c766334d33454f855f4cff0e6888f7b28">
    <sch:title>$loc/strings/mobility-110.pattern.title.21</sch:title>
    <sch:rule context="//dcat:Catalog/dct:publisher[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.21</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.21</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="record" id="_:n09c766334d33454f855f4cff0e6888f7b29">
    <sch:title>$loc/strings/mobility-110.pattern.title.22</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:record[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:CatalogRecord) = 1 or count(//dcat:CatalogRecord[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.22</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.22</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="spatial / geographic" id="_:n09c766334d33454f855f4cff0e6888f7b30">
    <sch:title>$loc/strings/mobility-110.pattern.title.23</sch:title>
    <sch:rule context="//dcat:Catalog/dct:spatial[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Location) = 1 or count(//dct:Location[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.23</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.23</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="title" id="_:n09c766334d33454f855f4cff0e6888f7b31">
    <sch:title>$loc/strings/mobility-110.pattern.title.24</sch:title>
    <sch:rule context="//dcat:Catalog/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.24</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.24</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="language" id="_:n09c766334d33454f855f4cff0e6888f7b32">
    <sch:title>$loc/strings/mobility-110.pattern.title.25</sch:title>
    <sch:rule context="//dcat:Catalog/dct:language[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((count(dct:LinguisticSystem) = 1 or count(//dct:LinguisticSystem[@rdf:about = $resource]) = 1))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/mobility-110.pattern.assert.25</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/mobility-110.pattern.report.25</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licence" id="_:n09c766334d33454f855f4cff0e6888f7b37">
    <sch:title>$loc/strings/mobility-110.pattern.title.26</sch:title>
    <sch:rule context="//dcat:Catalog/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.26</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.26</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="themes" id="_:n09c766334d33454f855f4cff0e6888f7b43">
    <sch:title>$loc/strings/mobility-110.pattern.title.27</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:themeTaxonomy[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:ConceptScheme) = 1 or count(//skos:ConceptScheme[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.27</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.27</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="has part" id="_:n09c766334d33454f855f4cff0e6888f7b49">
    <sch:title>$loc/strings/mobility-110.pattern.title.28</sch:title>
    <sch:rule context="//dcat:Catalog/dct:hasPart[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Catalog) = 1 or count(//dcat:Catalog[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.28</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.28</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identifier" id="_:n09c766334d33454f855f4cff0e6888f7b50">
    <sch:title>$loc/strings/mobility-110.pattern.title.29</sch:title>
    <sch:rule context="//dcat:Catalog/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.29</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.29</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="is part of" id="_:n09c766334d33454f855f4cff0e6888f7b51">
    <sch:title>$loc/strings/mobility-110.pattern.title.30</sch:title>
    <sch:rule context="//dcat:Catalog/dct:isPartOf[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Catalog) = 1 or count(//dcat:Catalog[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.30</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.30</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="other identifier" id="_:n09c766334d33454f855f4cff0e6888f7b52">
    <sch:title>$loc/strings/mobility-110.pattern.title.31</sch:title>
    <sch:rule context="//dcat:Catalog/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.31</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.31</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="quality annotation resource" id="_:n09c766334d33454f855f4cff0e6888f7b129">
    <sch:title>$loc/strings/mobility-110.pattern.title.32</sch:title>
    <sch:rule context="//dqv:QualityAnnotation/oa:hasBody[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.32</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.32</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="quality annotation target" id="_:n09c766334d33454f855f4cff0e6888f7b130">
    <sch:title>$loc/strings/mobility-110.pattern.title.33</sch:title>
    <sch:rule context="//dqv:QualityAnnotation/oa:hasTarget[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.33</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.33</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="administrative area" id="_:n09c766334d33454f855f4cff0e6888f7b5">
    <sch:title>$loc/strings/mobility-110.pattern.title.34</sch:title>
    <sch:rule context="//locn:Address/locn:adminUnitL2[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.34</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.34</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="city" id="_:n09c766334d33454f855f4cff0e6888f7b6">
    <sch:title>$loc/strings/mobility-110.pattern.title.35</sch:title>
    <sch:rule context="//locn:Address/locn:postName[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.35</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.35</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="country" id="_:n09c766334d33454f855f4cff0e6888f7b7">
    <sch:title>$loc/strings/mobility-110.pattern.title.36</sch:title>
    <sch:rule context="//locn:Address/locn:adminUnitL1[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.36</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.36</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="postal code" id="_:n09c766334d33454f855f4cff0e6888f7b8">
    <sch:title>$loc/strings/mobility-110.pattern.title.37</sch:title>
    <sch:rule context="//locn:Address/locn:postCode[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.37</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.37</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="street address" id="_:n09c766334d33454f855f4cff0e6888f7b9">
    <sch:title>$loc/strings/mobility-110.pattern.title.38</sch:title>
    <sch:rule context="//locn:Address/locn:thoroughfare[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.38</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.38</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="gazetteer" id="_:n09c766334d33454f855f4cff0e6888f7b111">
    <sch:title>$loc/strings/mobility-110.pattern.title.39</sch:title>
    <sch:rule context="//dct:Location/skos:inScheme[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-110.pattern.assert.39</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-110.pattern.report.39</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="geographic identifier" id="_:n09c766334d33454f855f4cff0e6888f7b112">
    <sch:title>$loc/strings/mobility-110.pattern.title.40</sch:title>
    <sch:rule context="//dct:Location/dct:identifier[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((matches($resource, '^\w+:(/?/?)[^\s]+$') and (matches($resource, 'http://publications.europa.eu/resource/authority/continent') or matches($resource, 'http://publications.europa.eu/resource/authority/country') or matches($resource, 'http://publications.europa.eu/resource/authority/place') or matches($resource, 'http://sws.geonames.org/') or matches($resource, 'https://sws.geonames.org/') or matches($resource, '^http://data\.europa\.eu/nuts/code/.+$'))))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/mobility-110.pattern.assert.40</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/mobility-110.pattern.report.40</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="geographic name" id="_:n09c766334d33454f855f4cff0e6888f7b125">
    <sch:title>$loc/strings/mobility-110.pattern.title.41</sch:title>
    <sch:rule context="//dct:Location/skos:prefLabel[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.41</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.41</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="accrual periodicity" id="_:n09c766334d33454f855f4cff0e6888f7b76">
    <sch:title>$loc/strings/mobility-110.pattern.title.42</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accrualPeriodicity[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((count(dct:Frequency) = 1 or count(//dct:Frequency[@rdf:about = $resource]) = 1))"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$matchesOrAlternative and $isIRI">$loc/strings/mobility-110.pattern.assert.42</sch:assert>
      <sch:report test="$matchesOrAlternative and $isIRI">$loc/strings/mobility-110.pattern.report.42</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="mobility theme" id="_:n09c766334d33454f855f4cff0e6888f7b81">
    <sch:title>$loc/strings/mobility-110.pattern.title.43</sch:title>
    <sch:rule context="//dcat:Dataset/mobilitydcatap:mobilityTheme[$profile]">
      <sch:let name="matchesPattern" value="matches(normalize-space(.), 'https://w3id.org/mobilitydcat-ap/mobility-theme')"/>
      <sch:assert test="$matchesPattern">$loc/strings/mobility-110.pattern.assert.43</sch:assert>
      <sch:report test="$matchesPattern">$loc/strings/mobility-110.pattern.report.43</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="georeferencing method" id="_:n09c766334d33454f855f4cff0e6888f7b82">
    <sch:title>$loc/strings/mobility-110.pattern.title.44</sch:title>
    <sch:rule context="//dcat:Dataset/mobilitydcatap:georeferencingMethod[$profile]">
      <sch:let name="matchesPattern" value="matches(normalize-space(.), 'https://w3id.org/mobilitydcat-ap/georeferencing-method')"/>
      <sch:assert test="$matchesPattern">$loc/strings/mobility-110.pattern.assert.44</sch:assert>
      <sch:report test="$matchesPattern">$loc/strings/mobility-110.pattern.report.44</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="network coverage" id="_:n09c766334d33454f855f4cff0e6888f7b83">
    <sch:title>$loc/strings/mobility-110.pattern.title.45</sch:title>
    <sch:rule context="//dcat:Dataset/mobilitydcatap:networkCoverage[$profile]">
      <sch:let name="matchesPattern" value="matches(normalize-space(.), 'https://w3id.org/mobilitydcat-ap/network-coverage')"/>
      <sch:assert test="$matchesPattern">$loc/strings/mobility-110.pattern.assert.45</sch:assert>
      <sch:report test="$matchesPattern">$loc/strings/mobility-110.pattern.report.45</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="reference system" id="_:n09c766334d33454f855f4cff0e6888f7b84">
    <sch:title>$loc/strings/mobility-110.pattern.title.46</sch:title>
    <sch:rule context="//dcat:Dataset/dct:conformsTo[$profile]">
      <sch:let name="matchesPattern" value="matches(normalize-space(.), 'http://www.opengis.net/def/crs/EPSG/0/')"/>
      <sch:assert test="$matchesPattern">$loc/strings/mobility-110.pattern.assert.46</sch:assert>
      <sch:report test="$matchesPattern">$loc/strings/mobility-110.pattern.report.46</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rights holder" id="_:n09c766334d33454f855f4cff0e6888f7b85">
    <sch:title>$loc/strings/mobility-110.pattern.title.47</sch:title>
    <sch:rule context="//dcat:Dataset/dct:rightsHolder[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.47</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.47</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="transport mode" id="_:n09c766334d33454f855f4cff0e6888f7b86">
    <sch:title>$loc/strings/mobility-110.pattern.title.48</sch:title>
    <sch:rule context="//dcat:Dataset/mobilitydcatap:transportMode[$profile]">
      <sch:let name="matchesPattern" value="matches(normalize-space(.), 'https://w3id.org/mobilitydcat-ap/transport-mode')"/>
      <sch:assert test="$matchesPattern">$loc/strings/mobility-110.pattern.assert.48</sch:assert>
      <sch:report test="$matchesPattern">$loc/strings/mobility-110.pattern.report.48</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="applicable legislation" id="_:n09c766334d33454f855f4cff0e6888f7b87">
    <sch:title>$loc/strings/mobility-110.pattern.title.49</sch:title>
    <sch:rule context="//dcat:Dataset/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.49</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.49</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="assessment result" id="_:n09c766334d33454f855f4cff0e6888f7b88">
    <sch:title>$loc/strings/mobility-110.pattern.title.50</sch:title>
    <sch:rule context="//dcat:Dataset/mobilitydcatap:assessmentResult[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(mobilitydcatap:Assessment) = 1 or count(//mobilitydcatap:Assessment[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.50</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.50</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="intended information service" id="_:n09c766334d33454f855f4cff0e6888f7b89">
    <sch:title>$loc/strings/mobility-110.pattern.title.51</sch:title>
    <sch:rule context="//dcat:Dataset/mobilitydcatap:intentedInformationService[$profile]">
      <sch:let name="matchesPattern" value="matches(normalize-space(.), 'https://w3id.org/mobilitydcat-ap/intended-information-service')"/>
      <sch:assert test="$matchesPattern">$loc/strings/mobility-110.pattern.assert.51</sch:assert>
      <sch:report test="$matchesPattern">$loc/strings/mobility-110.pattern.report.51</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="quality description" id="_:n09c766334d33454f855f4cff0e6888f7b90">
    <sch:title>$loc/strings/mobility-110.pattern.title.52</sch:title>
    <sch:rule context="//dcat:Dataset/dqv:hasQualityAnnotation[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dqv:QualityAnnotation) = 1 or count(//dqv:QualityAnnotation[@rdf:about = $resource]) = 1"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$validClass and $isBlankNodeOrIRI">$loc/strings/mobility-110.pattern.assert.52</sch:assert>
      <sch:report test="$validClass and $isBlankNodeOrIRI">$loc/strings/mobility-110.pattern.report.52</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="email" id="_:n09c766334d33454f855f4cff0e6888f7b103">
    <sch:title>$loc/strings/mobility-110.pattern.title.53</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasEmail[$profile]|//vcard:Kind/vcard:hasEmail[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="matchesPattern" value="matches($resource, '^mailto:.+')"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-110.pattern.assert.53</sch:assert>
      <sch:report test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-110.pattern.report.53</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="name" id="_:n09c766334d33454f855f4cff0e6888f7b104">
    <sch:title>$loc/strings/mobility-110.pattern.title.54</sch:title>
    <sch:rule context="//vcard:Organization/vcard:fn[$profile]|//vcard:Kind/vcard:fn[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.54</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.54</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="URL" id="_:n09c766334d33454f855f4cff0e6888f7b105">
    <sch:title>$loc/strings/mobility-110.pattern.title.55</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasURL[$profile]|//vcard:Kind/vcard:hasURL[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-110.pattern.assert.55</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-110.pattern.report.55</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="address" id="_:n09c766334d33454f855f4cff0e6888f7b106">
    <sch:title>$loc/strings/mobility-110.pattern.title.56</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasAddress[$profile]|//vcard:Kind/vcard:hasAddress[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Address) = 1 or count(//vcard:Address[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.56</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.56</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="affiliation" id="_:n09c766334d33454f855f4cff0e6888f7b107">
    <sch:title>$loc/strings/mobility-110.pattern.title.57</sch:title>
    <sch:rule context="//vcard:Organization/vcard:organization-name[$profile]|//vcard:Kind/vcard:organization-name[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.57</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.57</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="phone" id="_:n09c766334d33454f855f4cff0e6888f7b108">
    <sch:title>$loc/strings/mobility-110.pattern.title.58</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasTelephone[$profile]|//vcard:Kind/vcard:hasTelephone[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-110.pattern.assert.58</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-110.pattern.report.58</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="name" id="_:n09c766334d33454f855f4cff0e6888f7b10">
    <sch:title>$loc/strings/mobility-110.pattern.title.59</sch:title>
    <sch:rule context="//foaf:Agent/foaf:name[$profile]|//dct:Agent/foaf:name[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.59</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.59</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="type" id="_:n09c766334d33454f855f4cff0e6888f7b11">
    <sch:title>$loc/strings/mobility-110.pattern.title.60</sch:title>
    <sch:rule context="//foaf:Agent/dct:type[$profile]|//dct:Agent/dct:type[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.60</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.60</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="address" id="_:n09c766334d33454f855f4cff0e6888f7b12">
    <sch:title>$loc/strings/mobility-110.pattern.title.61</sch:title>
    <sch:rule context="//foaf:Agent/locn:address[$profile]|//dct:Agent/locn:address[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(locn:Address) = 1 or count(//locn:Address[@rdf:about = $resource]) = 1"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$validClass and $isBlankNodeOrIRI">$loc/strings/mobility-110.pattern.assert.61</sch:assert>
      <sch:report test="$validClass and $isBlankNodeOrIRI">$loc/strings/mobility-110.pattern.report.61</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="affiliation" id="_:n09c766334d33454f855f4cff0e6888f7b13">
    <sch:title>$loc/strings/mobility-110.pattern.title.62</sch:title>
    <sch:rule context="//foaf:Agent/org:memberOf[$profile]|//dct:Agent/org:memberOf[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(org:Organization) = 1 or count(//org:Organization[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.62</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.62</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="email" id="_:n09c766334d33454f855f4cff0e6888f7b14">
    <sch:title>$loc/strings/mobility-110.pattern.title.63</sch:title>
    <sch:rule context="//foaf:Agent/foaf:mbox[$profile]|//dct:Agent/foaf:mbox[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isMailto" value="starts-with(lower-case($resource), 'mailto:')"/>
      <sch:assert test="$isIRI and $isMailto">$loc/strings/mobility-110.pattern.assert.63</sch:assert>
      <sch:report test="$isIRI and $isMailto">$loc/strings/mobility-110.pattern.report.63</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="first name" id="_:n09c766334d33454f855f4cff0e6888f7b15">
    <sch:title>$loc/strings/mobility-110.pattern.title.64</sch:title>
    <sch:rule context="//foaf:Agent/foaf:firstName[$profile]|//dct:Agent/foaf:firstName[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.64</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.64</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="phone" id="_:n09c766334d33454f855f4cff0e6888f7b16">
    <sch:title>$loc/strings/mobility-110.pattern.title.65</sch:title>
    <sch:rule context="//foaf:Agent/foaf:phone[$profile]|//dct:Agent/foaf:phone[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-110.pattern.assert.65</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-110.pattern.report.65</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="surname" id="_:n09c766334d33454f855f4cff0e6888f7b17">
    <sch:title>$loc/strings/mobility-110.pattern.title.66</sch:title>
    <sch:rule context="//foaf:Agent/foaf:surname[$profile]|//dct:Agent/foaf:surname[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.66</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.66</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="work place Homepage URL" id="_:n09c766334d33454f855f4cff0e6888f7b18">
    <sch:title>$loc/strings/mobility-110.pattern.title.67</sch:title>
    <sch:rule context="//foaf:Agent/foaf:workplaceHomepage[$profile]|//dct:Agent/foaf:workplaceHomepage[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-110.pattern.assert.67</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-110.pattern.report.67</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conditions for access and usage" id="_:n09c766334d33454f855f4cff0e6888f7b131">
    <sch:title>$loc/strings/mobility-110.pattern.title.68</sch:title>
    <sch:rule context="//dct:RightsStatement/dct:type[$profile]">
      <sch:let name="matchesPattern" value="matches(normalize-space(.), 'https://w3id.org/mobilitydcat-ap/conditions-for-access-and-usage')"/>
      <sch:assert test="$matchesPattern">$loc/strings/mobility-110.pattern.assert.68</sch:assert>
      <sch:report test="$matchesPattern">$loc/strings/mobility-110.pattern.report.68</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="Additional information for access and usage" id="_:n09c766334d33454f855f4cff0e6888f7b132">
    <sch:title>$loc/strings/mobility-110.pattern.title.69</sch:title>
    <sch:rule context="//dct:RightsStatement/rdfs:label[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.69</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.69</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="title" id="_:n09c766334d33454f855f4cff0e6888f7b73">
    <sch:title>$loc/strings/mobility-110.pattern.title.70</sch:title>
    <sch:rule context="//skos:ConceptScheme/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.70</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.70</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="preferred label" id="_:n09c766334d33454f855f4cff0e6888f7b71">
    <sch:title>$loc/strings/mobility-110.pattern.title.71</sch:title>
    <sch:rule context="//skos:Concept/skos:prefLabel[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.71</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.71</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="category scheme" id="_:n09c766334d33454f855f4cff0e6888f7b72">
    <sch:title>$loc/strings/mobility-110.pattern.title.72</sch:title>
    <sch:rule context="//skos:Concept/skos:inScheme[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:ConceptScheme) = 1 or count(//skos:ConceptScheme[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/mobility-110.pattern.assert.72</sch:assert>
      <sch:report test="$validClass">$loc/strings/mobility-110.pattern.report.72</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="assessment result" id="_:n09c766334d33454f855f4cff0e6888f7b24">
    <sch:title>$loc/strings/mobility-110.pattern.title.73</sch:title>
    <sch:rule context="//mobilitydcatap:Assessment/oa:hasBody[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-110.pattern.assert.73</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-110.pattern.report.73</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="standard licence" id="_:n09c766334d33454f855f4cff0e6888f7b109">
    <sch:title>$loc/strings/mobility-110.pattern.title.74</sch:title>
    <sch:rule context="//dct:LicenseDocument/dct:identifier[$profile]">
      <sch:let name="matchesPattern" value="matches(normalize-space(.), 'http://publications.europa.eu/resource/authority/access-right')"/>
      <sch:assert test="$matchesPattern">$loc/strings/mobility-110.pattern.assert.74</sch:assert>
      <sch:report test="$matchesPattern">$loc/strings/mobility-110.pattern.report.74</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licence text" id="_:n09c766334d33454f855f4cff0e6888f7b110">
    <sch:title>$loc/strings/mobility-110.pattern.title.75</sch:title>
    <sch:rule context="//dct:LicenseDocument/rdfs:label[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-110.pattern.assert.75</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-110.pattern.report.75</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>