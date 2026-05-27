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
  <sch:pattern name="uitgever" id="_:n14f405c72961451c8f2eddfa3c5cb332b17">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.1</sch:title>
    <sch:rule context="//dcat:Dataset/dct:publisher|//dcat:DataService/dct:publisher|//dcat:DatasetSeries/dct:publisher">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.1</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.1</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="relatie" id="_:n14f405c72961451c8f2eddfa3c5cb332b18">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.2</sch:title>
    <sch:rule context="//dcat:Dataset/dct:relation|//dcat:DataService/dct:relation|//dcat:DatasetSeries/dct:relation">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1 or matches($resource, '^\w+:(/?/?)[^\s]+$') or matches($resource, '^\w+:(/?/?)[^\s]+$')))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/dcat-ap-vl-300.pattern.assert.2</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/dcat-ap-vl-300.pattern.report.2</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rol" id="_:n14f405c72961451c8f2eddfa3c5cb332b115">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.3</sch:title>
    <sch:rule context="//dcat:Relationship/dcat:hadRole">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.3</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.3</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bronresource" id="_:n14f405c72961451c8f2eddfa3c5cb332b116">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.4</sch:title>
    <sch:rule context="//dcat:Relationship/mdcat:RelatieQualificatie.catalogusResource.source">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1 or matches($resource, '^\w+:(/?/?)[^\s]+$') or matches($resource, '^\w+:(/?/?)[^\s]+$')))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/dcat-ap-vl-300.pattern.assert.4</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/dcat-ap-vl-300.pattern.report.4</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="doelresource" id="_:n14f405c72961451c8f2eddfa3c5cb332b123">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.5</sch:title>
    <sch:rule context="//dcat:Relationship/mdcat:RelatieQualificatie.catalogusResource.target">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1 or matches($resource, '^\w+:(/?/?)[^\s]+$') or matches($resource, '^\w+:(/?/?)[^\s]+$')))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/dcat-ap-vl-300.pattern.assert.5</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/dcat-ap-vl-300.pattern.report.5</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="naam" id="_:n14f405c72961451c8f2eddfa3c5cb332b1">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.6</sch:title>
    <sch:rule context="//foaf:Agent/foaf:name|//dct:Agent/foaf:name">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.6</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.6</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="_:n14f405c72961451c8f2eddfa3c5cb332b74">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.7</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:version">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.7</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.7</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="_:n14f405c72961451c8f2eddfa3c5cb332b75">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.8</sch:title>
    <sch:rule context="//dcat:Dataset/dct:description">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.8</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.8</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="_:n14f405c72961451c8f2eddfa3c5cb332b76">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.9</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:keyword">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.9</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.9</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n14f405c72961451c8f2eddfa3c5cb332b77">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.10</sch:title>
    <sch:rule context="//dcat:Dataset/dct:title">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.10</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.10</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b78">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.11</sch:title>
    <sch:rule context="//dcat:Dataset/dct:identifier">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.11</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.11</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="_:n14f405c72961451c8f2eddfa3c5cb332b79">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.12</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accessRights">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.12</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.12</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b80">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.13</sch:title>
    <sch:rule context="//dcat:Dataset/adms:identifier">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.13</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.13</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="_:n14f405c72961451c8f2eddfa3c5cb332b81">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.14</sch:title>
    <sch:rule context="//dcat:Dataset/dct:conformsTo">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.14</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.14</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="voorbeeldweergave" id="_:n14f405c72961451c8f2eddfa3c5cb332b82">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.15</sch:title>
    <sch:rule context="//dcat:Dataset/adms:sample">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Distribution) = 1 or count(//dcat:Distribution[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.15</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.15</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="_:n14f405c72961451c8f2eddfa3c5cb332b83">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.16</sch:title>
    <sch:rule context="//dcat:Dataset/mdcat:statuut">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.16</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.16</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="_:n14f405c72961451c8f2eddfa3c5cb332b84">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.17</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:theme">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.17</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.17</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina" id="_:n14f405c72961451c8f2eddfa3c5cb332b85">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.18</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:landingPage">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.18</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.18</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="_:n14f405c72961451c8f2eddfa3c5cb332b86">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.19</sch:title>
    <sch:rule context="//dcat:Dataset/dct:issued">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.19</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.19</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="herkomst" id="_:n14f405c72961451c8f2eddfa3c5cb332b87">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.20</sch:title>
    <sch:rule context="//dcat:Dataset/dct:provenance">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:ProvenanceStatement) = 1 or count(//dct:ProvenanceStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.20</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.20</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="_:n14f405c72961451c8f2eddfa3c5cb332b88">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.21</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:contactPoint">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.21</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.21</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="_:n14f405c72961451c8f2eddfa3c5cb332b89">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.22</sch:title>
    <sch:rule context="//dcat:Dataset/dct:modified">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.22</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.22</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="creatiedatum" id="_:n14f405c72961451c8f2eddfa3c5cb332b90">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.23</sch:title>
    <sch:rule context="//dcat:Dataset/dct:created">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.23</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.23</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="geografische dekking" id="_:n14f405c72961451c8f2eddfa3c5cb332b91">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.24</sch:title>
    <sch:rule context="//dcat:Dataset/dct:spatial">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Location) = 1 or count(//dct:Location[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.24</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.24</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="distributie" id="_:n14f405c72961451c8f2eddfa3c5cb332b92">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.25</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:distribution">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Distribution) = 1 or count(//dcat:Distribution[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.25</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.25</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="eigenaar" id="_:n14f405c72961451c8f2eddfa3c5cb332b93">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.26</sch:title>
    <sch:rule context="//dcat:Dataset/dct:rightsHolder">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.26</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.26</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="in serie" id="_:n14f405c72961451c8f2eddfa3c5cb332b94">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.27</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:inSeries">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="validClass" value="count(dcat:DatasetSeries) = 1 or count(//dcat:DatasetSeries[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$isIRI or $validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.27</sch:assert>
      <sch:report test="$isIRI or $validClass">$loc/strings/dcat-ap-vl-300.pattern.report.27</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b95">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.28</sch:title>
    <sch:rule context="//dcat:Distribution/dct:identifier">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.28</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.28</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n14f405c72961451c8f2eddfa3c5cb332b96">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.29</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.29</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.29</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rechten" id="_:n14f405c72961451c8f2eddfa3c5cb332b97">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.30</sch:title>
    <sch:rule context="//dcat:Distribution/dct:rights">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.30</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.30</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b98">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.31</sch:title>
    <sch:rule context="//dcat:Distribution/adms:identifier">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.31</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.31</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="formaat" id="_:n14f405c72961451c8f2eddfa3c5cb332b99">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.32</sch:title>
    <sch:rule context="//dcat:Distribution/dct:format">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.32</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.32</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="_:n14f405c72961451c8f2eddfa3c5cb332b100">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.33</sch:title>
    <sch:rule context="//dcat:Distribution/dct:license">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.33</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.33</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="_:n14f405c72961451c8f2eddfa3c5cb332b101">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.34</sch:title>
    <sch:rule context="//dcat:Distribution/dct:conformsTo">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.34</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.34</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="_:n14f405c72961451c8f2eddfa3c5cb332b102">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.35</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:downloadURL">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.35</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.35</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegangsURL" id="_:n14f405c72961451c8f2eddfa3c5cb332b103">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.36</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessURL">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.36</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.36</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wordt aangeboden door" id="_:n14f405c72961451c8f2eddfa3c5cb332b104">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.37</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessService">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.37</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.37</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="verdeler" id="_:n14f405c72961451c8f2eddfa3c5cb332b105">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.38</sch:title>
    <sch:rule context="//dcat:Distribution/geodcatap:distributor">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.38</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.38</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="geometrie" id="_:n14f405c72961451c8f2eddfa3c5cb332b111">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.39</sch:title>
    <sch:rule context="//dct:Location/locn:geometry">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.39</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.39</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bounding box" id="_:n14f405c72961451c8f2eddfa3c5cb332b112">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.40</sch:title>
    <sch:rule context="//dct:Location/dcat:bbox">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.40</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.40</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="centroïde" id="_:n14f405c72961451c8f2eddfa3c5cb332b113">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.41</sch:title>
    <sch:rule context="//dct:Location/dcat:centroid">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.41</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.41</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="plaatsnaam" id="_:n14f405c72961451c8f2eddfa3c5cb332b114">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.42</sch:title>
    <sch:rule context="//dct:Location/rdfs:label">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.42</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.42</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="e-mail" id="_:n14f405c72961451c8f2eddfa3c5cb332b35">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.43</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasEmail|//vcard:Kind/vcard:hasEmail">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^(mailto:)?[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.43</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.43</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactpagina" id="_:n14f405c72961451c8f2eddfa3c5cb332b36">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.44</sch:title>
    <sch:rule context="//vcard:Organization/foaf:page|//vcard:Kind/foaf:page">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.44</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.44</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b25">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.45</sch:title>
    <sch:rule context="//dcat:Catalog/dct:identifier">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.45</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.45</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n14f405c72961451c8f2eddfa3c5cb332b26">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.46</sch:title>
    <sch:rule context="//dcat:Catalog/dct:title">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.46</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.46</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="_:n14f405c72961451c8f2eddfa3c5cb332b27">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.47</sch:title>
    <sch:rule context="//dcat:Catalog/dct:description">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.47</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.47</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="_:n14f405c72961451c8f2eddfa3c5cb332b28">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.48</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:contactPoint">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.48</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.48</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="_:n14f405c72961451c8f2eddfa3c5cb332b29">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.49</sch:title>
    <sch:rule context="//dcat:Catalog/dct:license">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.49</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.49</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b30">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.50</sch:title>
    <sch:rule context="//dcat:Catalog/adms:identifier">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.50</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.50</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="record" id="_:n14f405c72961451c8f2eddfa3c5cb332b31">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.51</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:record">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:CatalogRecord) = 1 or count(//dcat:CatalogRecord[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.51</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.51</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="_:n14f405c72961451c8f2eddfa3c5cb332b32">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.52</sch:title>
    <sch:rule context="//dcat:Catalog/dct:publisher">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.52</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.52</sch:report>
    </sch:rule>
  </sch:pattern>
  <!-- commented out for now: there should be an equivalent being generated for dcat:dataset/dcat:Dataset/@rdf:about -->
  <!--  <sch:pattern name="heeft Dataset" id="_:n14f405c72961451c8f2eddfa3c5cb332b33">-->
  <!--    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.53</sch:title>-->
  <!--    <sch:rule context="//dcat:Catalog/dcat:dataset">-->
  <!--      <sch:let name="resource" value="@rdf:resource"/>-->
  <!--      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>-->
  <!--      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.53</sch:assert>-->
  <!--      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.53</sch:report>-->
  <!--    </sch:rule>-->
  <!--  </sch:pattern>-->
  <!--  <sch:pattern name="heeft DataService" id="_:n14f405c72961451c8f2eddfa3c5cb332b34">-->
  <!--    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.54</sch:title>-->
  <!--    <sch:rule context="//dcat:Catalog/dcat:service">-->
  <!--      <sch:let name="resource" value="@rdf:resource"/>-->
  <!--      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>-->
  <!--      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.54</sch:assert>-->
  <!--      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.54</sch:report>-->
  <!--    </sch:rule>-->
  <!--  </sch:pattern>-->
  <sch:pattern name="eind datum" id="_:n14f405c72961451c8f2eddfa3c5cb332b137">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.55</sch:title>
    <sch:rule context="//dct:PeriodOfTime/dcat:endDate">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.55</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.55</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="start datum" id="_:n14f405c72961451c8f2eddfa3c5cb332b138">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.56</sch:title>
    <sch:rule context="//dct:PeriodOfTime/dcat:startDate">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.56</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.56</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="heeft start" id="_:n14f405c72961451c8f2eddfa3c5cb332b139">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.57</sch:title>
    <sch:rule context="//dct:PeriodOfTime/time:hasBeginning">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(time:Instant) = 1 or count(//time:Instant[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.57</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.57</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="heeft einde" id="_:n14f405c72961451c8f2eddfa3c5cb332b140">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.58</sch:title>
    <sch:rule context="//dct:PeriodOfTime/time:hasEnd">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(time:Instant) = 1 or count(//time:Instant[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.58</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.58</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n14f405c72961451c8f2eddfa3c5cb332b130">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.63</sch:title>
    <sch:rule context="//dct:Standard/dct:title">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.63</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.63</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="_:n14f405c72961451c8f2eddfa3c5cb332b131">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.64</sch:title>
    <sch:rule context="//dct:Standard/dct:description">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.64</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.64</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="_:n14f405c72961451c8f2eddfa3c5cb332b132">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.65</sch:title>
    <sch:rule context="//dct:Standard/owl:versionInfo">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.65</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.65</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="voorkeurslabel" id="_:n14f405c72961451c8f2eddfa3c5cb332b133">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.66</sch:title>
    <sch:rule context="//dct:Standard/skos:prefLabel">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.66</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.66</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="type" id="_:n14f405c72961451c8f2eddfa3c5cb332b134">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.67</sch:title>
    <sch:rule context="//dct:Standard/dct:type">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.67</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.67</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="specificatie URL" id="_:n14f405c72961451c8f2eddfa3c5cb332b135">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.68</sch:title>
    <sch:rule context="//dct:Standard/rdfs:seeAlso">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.68</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.68</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="_:n14f405c72961451c8f2eddfa3c5cb332b136">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.69</sch:title>
    <sch:rule context="//dct:Standard/dct:issued">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.69</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.69</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="_:n14f405c72961451c8f2eddfa3c5cb332b37">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.70</sch:title>
    <sch:rule context="//dcat:DataService/dct:description">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.70</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.70</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="_:n14f405c72961451c8f2eddfa3c5cb332b38">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.71</sch:title>
    <sch:rule context="//dcat:DataService/dcat:version">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.71</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.71</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b39">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.72</sch:title>
    <sch:rule context="//dcat:DataService/dct:identifier">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.72</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.72</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="_:n14f405c72961451c8f2eddfa3c5cb332b40">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.73</sch:title>
    <sch:rule context="//dcat:DataService/dcat:keyword">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.73</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.73</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n14f405c72961451c8f2eddfa3c5cb332b41">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.74</sch:title>
    <sch:rule context="//dcat:DataService/dct:title">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.74</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.74</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="_:n14f405c72961451c8f2eddfa3c5cb332b42">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.75</sch:title>
    <sch:rule context="//dcat:DataService/dcat:contactPoint">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.75</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.75</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointURL" id="_:n14f405c72961451c8f2eddfa3c5cb332b43">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.76</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointURL">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.76</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.76</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointbeschrijving" id="_:n14f405c72961451c8f2eddfa3c5cb332b44">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.77</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointDescription">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.77</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.77</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina" id="_:n14f405c72961451c8f2eddfa3c5cb332b45">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.78</sch:title>
    <sch:rule context="//dcat:DataService/dcat:landingPage">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.78</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.78</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="_:n14f405c72961451c8f2eddfa3c5cb332b46">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.79</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:ontwikkelingstoestand">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.79</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.79</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor authenticatie" id="_:n14f405c72961451c8f2eddfa3c5cb332b47">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.80</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorAuthenticatie">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.80</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.80</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="levensfase" id="_:n14f405c72961451c8f2eddfa3c5cb332b48">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.81</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:levensfase">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.81</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.81</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor statusinformatie" id="_:n14f405c72961451c8f2eddfa3c5cb332b49">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.82</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorStatusinformatie">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.82</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.82</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b50">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.83</sch:title>
    <sch:rule context="//dcat:DataService/adms:identifier">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.83</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.83</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="_:n14f405c72961451c8f2eddfa3c5cb332b51">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.84</sch:title>
    <sch:rule context="//dcat:DataService/dct:accessRights">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.84</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.84</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform aan protocol" id="_:n14f405c72961451c8f2eddfa3c5cb332b52">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.85</sch:title>
    <sch:rule context="//dcat:DataService/dct:conformsTo">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.85</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.85</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="_:n14f405c72961451c8f2eddfa3c5cb332b53">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.86</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:statuut">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.86</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.86</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor gebruiksinformatie" id="_:n14f405c72961451c8f2eddfa3c5cb332b54">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.87</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorGebruiksinformatie">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.87</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.87</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rechten" id="_:n14f405c72961451c8f2eddfa3c5cb332b55">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.88</sch:title>
    <sch:rule context="//dcat:DataService/dct:rights">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.88</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.88</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="_:n14f405c72961451c8f2eddfa3c5cb332b56">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.89</sch:title>
    <sch:rule context="//dcat:DataService/dcat:theme">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.89</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.89</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="_:n14f405c72961451c8f2eddfa3c5cb332b57">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.90</sch:title>
    <sch:rule context="//dcat:DataService/dct:license">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.90</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.90</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="creatiedatum" id="_:n14f405c72961451c8f2eddfa3c5cb332b58">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.91</sch:title>
    <sch:rule context="//dcat:DataService/dct:created">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.91</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.91</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="_:n14f405c72961451c8f2eddfa3c5cb332b59">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.92</sch:title>
    <sch:rule context="//dcat:DataService/dct:modified">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.92</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.92</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="_:n14f405c72961451c8f2eddfa3c5cb332b60">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.93</sch:title>
    <sch:rule context="//dcat:DataService/dct:issued">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.93</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.93</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="biedt informatie aan over" id="_:n14f405c72961451c8f2eddfa3c5cb332b61">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.94</sch:title>
    <sch:rule context="//dcat:DataService/dcat:servesdataset">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.94</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.94</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b2">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.95</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:identifier">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.95</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.95</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="aanmaakdatum" id="_:n14f405c72961451c8f2eddfa3c5cb332b3">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.96</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:issued">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/dcat-ap-vl-300.pattern.assert.96</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/dcat-ap-vl-300.pattern.report.96</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n14f405c72961451c8f2eddfa3c5cb332b4">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.97</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:title">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.assert.97</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl-300.pattern.report.97</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="_:n14f405c72961451c8f2eddfa3c5cb332b5">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.98</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:modified">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/dcat-ap-vl-300.pattern.assert.98</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/dcat-ap-vl-300.pattern.report.98</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bron metadata record landingspagina" id="_:n14f405c72961451c8f2eddfa3c5cb332b6">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.99</sch:title>
    <sch:rule context="//dcat:CatalogRecord/mdcat:landingpageVoorBronMetadata">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.99</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.99</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b7">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.100</sch:title>
    <sch:rule context="//dcat:CatalogRecord/adms:identifier">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.100</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.100</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="_:n14f405c72961451c8f2eddfa3c5cb332b8">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.101</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:conformsTo">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.101</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.101</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bron metadatarecord" id="_:n14f405c72961451c8f2eddfa3c5cb332b9">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.102</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:source">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.102</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.102</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="hoofdonderwerp" id="_:n14f405c72961451c8f2eddfa3c5cb332b10">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.103</sch:title>
    <sch:rule context="//dcat:CatalogRecord/foaf:primaryTopic">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1 or matches($resource, '^\w+:(/?/?)[^\s]+$') or matches($resource, '^\w+:(/?/?)[^\s]+$')))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/dcat-ap-vl-300.pattern.assert.103</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/dcat-ap-vl-300.pattern.report.103</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="_:n14f405c72961451c8f2eddfa3c5cb332b62">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.104</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:description">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.104</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.104</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n14f405c72961451c8f2eddfa3c5cb332b63">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.105</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:title">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.105</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.105</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b64">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.106</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:identifier">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.106</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.106</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="_:n14f405c72961451c8f2eddfa3c5cb332b65">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.107</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dcat:contactPoint">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.107</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.107</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="belanghebbende wetgeving" id="_:n14f405c72961451c8f2eddfa3c5cb332b66">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.108</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dcatap:applicableLegislation">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(eli:LegalResource) = 1 or count(//eli:LegalResource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.108</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.108</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="periodiciteit" id="_:n14f405c72961451c8f2eddfa3c5cb332b67">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.109</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:accrualPeriodicity">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Frequency) = 1 or count(//dct:Frequency[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.109</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.109</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatie datum" id="_:n14f405c72961451c8f2eddfa3c5cb332b68">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.110</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:issued">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.110</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.110</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="_:n14f405c72961451c8f2eddfa3c5cb332b69">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.111</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:modified">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.111</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.111</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="geografische dekking" id="_:n14f405c72961451c8f2eddfa3c5cb332b70">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.112</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:spatial">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Location) = 1 or count(//dct:Location[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.112</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.112</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="temporele dekking" id="_:n14f405c72961451c8f2eddfa3c5cb332b71">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.113</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:temporal">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:PeriodOfTime) = 1 or count(//dct:PeriodOfTime[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.113</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.113</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b72">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.114</sch:title>
    <sch:rule context="//dcat:DatasetSeries/adms:identifier">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.114</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.114</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="_:n14f405c72961451c8f2eddfa3c5cb332b73">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.115</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:publisher">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.115</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.115</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend door (String)" id="_:n14f405c72961451c8f2eddfa3c5cb332b107">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.116</sch:title>
    <sch:rule context="//adms:Identifier/adms:schemaAgency">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.assert.116</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl-300.pattern.report.116</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend op" id="_:n14f405c72961451c8f2eddfa3c5cb332b108">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.117</sch:title>
    <sch:rule context="//adms:Identifier/dct:issued">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/dcat-ap-vl-300.pattern.assert.117</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/dcat-ap-vl-300.pattern.report.117</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="gestructureerde identificator" id="_:n14f405c72961451c8f2eddfa3c5cb332b109">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.118</sch:title>
    <sch:rule context="//adms:Identifier/generiek:gestructureerdeIdentificator">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(generiek:GestructureerdeIdentificator) = 1 or count(//generiek:GestructureerdeIdentificator[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.118</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.118</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend door" id="_:n14f405c72961451c8f2eddfa3c5cb332b110">
    <sch:title>$loc/strings/dcat-ap-vl-300.pattern.title.119</sch:title>
    <sch:rule context="//adms:Identifier/dct:creator">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.assert.119</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl-300.pattern.report.119</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>
