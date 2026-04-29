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
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.1</sch:title>
    <sch:rule context="//vcard:hasEmail[$profile]">
      <sch:let name="mailto" value="starts-with(@rdf:resource,'mailto:')"/>
      <sch:assert test="$mailto = true()">$loc/strings/dcat-ap-vl.pattern.assert.1</sch:assert>
      <sch:report test="$mailto = true()">$loc/strings/dcat-ap-vl.pattern.report.1</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.2</sch:title>
    <sch:rule context="//dcat:Catalog/dct:license[$profile]">
      <sch:let name="cc0" value="./@rdf:resource = 'https://data.vlaanderen.be/id/licentie/creative-commons-zero-verklaring/v1.0' or ./dct:LicenseDocument/@rdf:about = 'https://data.vlaanderen.be/id/licentie/creative-commons-zero-verklaring/v1.0'"/>
      <sch:assert test="$cc0 = true()">$loc/strings/dcat-ap-vl.pattern.assert.2</sch:assert>
      <sch:report test="$cc0 = true()">$loc/strings/dcat-ap-vl.pattern.report.2</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.3</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]|//dcat:DataService[$profile]">
      <sch:let name="hasKeyword" value="count(dcat:keyword[normalize-space(.) != '']) &gt; 0"/>
      <sch:assert test="$hasKeyword">$loc/strings/dcat-ap-vl.pattern.assert.3</sch:assert>
      <sch:report test="$hasKeyword">$loc/strings/dcat-ap-vl.pattern.report.3</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.4</sch:title>
    <sch:rule context="//dcat:contactPoint[$profile]">
      <sch:let name="hasEmail" value="normalize-space(vcard:Organization/vcard:hasEmail/@rdf:resource) != ''"/>
      <sch:let name="hasUrl" value="normalize-space(vcard:Organization/vcard:hasURL/@rdf:resource) != ''"/>
      <sch:assert test="$hasEmail or $hasUrl">$loc/strings/dcat-ap-vl.pattern.assert.4</sch:assert>
      <sch:report test="$hasEmail or $hasUrl">$loc/strings/dcat-ap-vl.pattern.report.4</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b95">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.5</sch:title>
    <sch:rule context="//dcat:Distribution/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.5</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.5</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b96">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.6</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.6</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.6</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rechten" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b97">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.7</sch:title>
    <sch:rule context="//dcat:Distribution/dct:rights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.7</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.7</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b98">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.8</sch:title>
    <sch:rule context="//dcat:Distribution/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.8</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.8</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="formaat" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b99">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.9</sch:title>
    <sch:rule context="//dcat:Distribution/dct:format[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.9</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.9</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b100">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.10</sch:title>
    <sch:rule context="//dcat:Distribution/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.10</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.10</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b101">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.11</sch:title>
    <sch:rule context="//dcat:Distribution/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.11</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.11</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b102">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.12</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:downloadURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.12</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.12</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegangsURL" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b103">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.13</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.13</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.13</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wordt aangeboden door" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b104">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.14</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessService[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.14</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.14</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="verdeler" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b105">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.15</sch:title>
    <sch:rule context="//dcat:Distribution/geodcat:distributor[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.15</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.15</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b2">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.16</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.16</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.16</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="aanmaakdatum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b3">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.17</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/dcat-ap-vl.pattern.assert.17</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/dcat-ap-vl.pattern.report.17</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b4">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.18</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.18</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.18</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b5">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.19</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:modified[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/dcat-ap-vl.pattern.assert.19</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/dcat-ap-vl.pattern.report.19</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bron metadata record landingspagina" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b6">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.20</sch:title>
    <sch:rule context="//dcat:CatalogRecord/mdcat:landingpageVoorBronMetadata[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.20</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.20</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b7">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.21</sch:title>
    <sch:rule context="//dcat:CatalogRecord/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.21</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.21</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b8">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.22</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.22</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.22</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bron metadatarecord" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b9">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.23</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:source[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.23</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.23</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="hoofdonderwerp" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b10">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.24</sch:title>
    <sch:rule context="//dcat:CatalogRecord/foaf:primaryTopic[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1 or matches($resource, '^\w+:(/?/?)[^\s]+$') or matches($resource, '^\w+:(/?/?)[^\s]+$')))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/dcat-ap-vl.pattern.assert.24</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/dcat-ap-vl.pattern.report.24</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b74">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.25</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:version[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.25</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.25</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b75">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.26</sch:title>
    <sch:rule context="//dcat:Dataset/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.26</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.26</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b76">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.27</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.27</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.27</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b77">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.28</sch:title>
    <sch:rule context="//dcat:Dataset/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.28</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.28</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b78">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.29</sch:title>
    <sch:rule context="//dcat:Dataset/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.29</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.29</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b79">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.30</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accessRights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.30</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.30</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b80">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.31</sch:title>
    <sch:rule context="//dcat:Dataset/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.31</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.31</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b81">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.32</sch:title>
    <sch:rule context="//dcat:Dataset/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.32</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.32</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="voorbeeldweergave" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b82">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.33</sch:title>
    <sch:rule context="//dcat:Dataset/adms:sample[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Distribution) = 1 or count(//dcat:Distribution[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.33</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.33</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b83">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.34</sch:title>
    <sch:rule context="//dcat:Dataset/mdcat:statuut[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.34</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.34</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b84">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.35</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:theme[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.35</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.35</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b85">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.36</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:landingPage[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.36</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.36</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b86">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.37</sch:title>
    <sch:rule context="//dcat:Dataset/dct:issued[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.37</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.37</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="herkomst" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b87">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.38</sch:title>
    <sch:rule context="//dcat:Dataset/dct:provenance[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:ProvenanceStatement) = 1 or count(//dct:ProvenanceStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.38</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.38</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b88">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.39</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.39</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.39</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b89">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.40</sch:title>
    <sch:rule context="//dcat:Dataset/dct:modified[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.40</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.40</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="creatiedatum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b90">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.41</sch:title>
    <sch:rule context="//dcat:Dataset/dct:created[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.41</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.41</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="geografische dekking" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b91">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.42</sch:title>
    <sch:rule context="//dcat:Dataset/dct:spatial[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Location) = 1 or count(//dct:Location[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.42</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.42</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="distributie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b92">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.43</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:distribution[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Distribution) = 1 or count(//dcat:Distribution[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.43</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.43</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="eigenaar" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b93">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.44</sch:title>
    <sch:rule context="//dcat:Dataset/dct:rightsHolder[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.44</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.44</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="in serie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b94">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.45</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:inSeries[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:DatasetSeries) = 1 or count(//dcat:DatasetSeries[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.45</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.45</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="naam" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b1">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.46</sch:title>
    <sch:rule context="//foaf:Agent/foaf:name[$profile]|//dct:Agent/foaf:name[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.46</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.46</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="eind datum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b137">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.47</sch:title>
    <sch:rule context="//dct:PeriodOfTime/dcat:endDate[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.47</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.47</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="start datum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b138">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.48</sch:title>
    <sch:rule context="//dct:PeriodOfTime/dcat:startDate[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.48</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.48</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="heeft start" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b139">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.49</sch:title>
    <sch:rule context="//dct:PeriodOfTime/time:hasBeginning[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(time:Instant) = 1 or count(//time:Instant[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.49</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.49</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="heeft einde" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b140">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.50</sch:title>
    <sch:rule context="//dct:PeriodOfTime/time:hasEnd[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(time:Instant) = 1 or count(//time:Instant[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.50</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.50</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b130">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.51</sch:title>
    <sch:rule context="//dct:Standard/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.51</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.51</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b131">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.52</sch:title>
    <sch:rule context="//dct:Standard/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.52</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.52</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b132">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.53</sch:title>
    <sch:rule context="//dct:Standard/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.53</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.53</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="voorkeurslabel" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b133">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.54</sch:title>
    <sch:rule context="//dct:Standard/skos:prefLabel[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.54</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.54</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="type" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b134">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.55</sch:title>
    <sch:rule context="//dct:Standard/dct:type[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.55</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.55</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="specificatie URL" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b135">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.56</sch:title>
    <sch:rule context="//dct:Standard/rdfs:seeAlso[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.56</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.56</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b136">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.57</sch:title>
    <sch:rule context="//dct:Standard/dct:issued[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.57</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.57</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b25">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.58</sch:title>
    <sch:rule context="//dcat:Catalog/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.58</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.58</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b26">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.59</sch:title>
    <sch:rule context="//dcat:Catalog/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.59</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.59</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b27">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.60</sch:title>
    <sch:rule context="//dcat:Catalog/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.60</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.60</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b28">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.61</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.61</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.61</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b29">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.62</sch:title>
    <sch:rule context="//dcat:Catalog/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.62</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.62</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b30">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.63</sch:title>
    <sch:rule context="//dcat:Catalog/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.63</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.63</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="record" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b31">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.64</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:record[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:CatalogRecord) = 1 or count(//dcat:CatalogRecord[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.64</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.64</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b32">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.65</sch:title>
    <sch:rule context="//dcat:Catalog/dct:publisher[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.65</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.65</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="heeft Dataset" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b33">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.66</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:dataset[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.66</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.66</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="heeft DataService" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b34">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.67</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:service[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.67</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.67</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="geometrie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b111">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.68</sch:title>
    <sch:rule context="//dct:Location/locn:geometry[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.68</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.68</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bounding box" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b112">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.69</sch:title>
    <sch:rule context="//dct:Location/dcat:bbox[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.69</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.69</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="centroïde" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b113">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.70</sch:title>
    <sch:rule context="//dct:Location/dcat:centroid[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.70</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.70</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="plaatsnaam" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b114">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.71</sch:title>
    <sch:rule context="//dct:Location/rdfs:label[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.71</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.71</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b17">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.72</sch:title>
    <sch:rule context="//dcat:Dataset/dct:publisher[$profile]|//dcat:DataService/dct:publisher[$profile]|//dcat:DatasetSeries/dct:publisher[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.72</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.72</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="relatie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b18">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.73</sch:title>
    <sch:rule context="//dcat:Dataset/dct:relation[$profile]|//dcat:DataService/dct:relation[$profile]|//dcat:DatasetSeries/dct:relation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1 or matches($resource, '^\w+:(/?/?)[^\s]+$') or matches($resource, '^\w+:(/?/?)[^\s]+$')))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/dcat-ap-vl.pattern.assert.73</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/dcat-ap-vl.pattern.report.73</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rol" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b115">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.74</sch:title>
    <sch:rule context="//dcat:Relationship/dcat:hadRole[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.74</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.74</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bronresource" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b116">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.75</sch:title>
    <sch:rule context="//dcat:Relationship/mdcat:RelatieQualificatie.catalogusResource.source[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1 or matches($resource, '^\w+:(/?/?)[^\s]+$') or matches($resource, '^\w+:(/?/?)[^\s]+$')))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/dcat-ap-vl.pattern.assert.75</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/dcat-ap-vl.pattern.report.75</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="doelresource" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b123">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.76</sch:title>
    <sch:rule context="//dcat:Relationship/mdcat:RelatieQualificatie.catalogusResource.target[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1 or matches($resource, '^\w+:(/?/?)[^\s]+$') or matches($resource, '^\w+:(/?/?)[^\s]+$')))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/dcat-ap-vl.pattern.assert.76</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/dcat-ap-vl.pattern.report.76</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend door (String)" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b107">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.77</sch:title>
    <sch:rule context="//adms:Identifier/adms:schemaAgency[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.77</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.77</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend op" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b108">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.78</sch:title>
    <sch:rule context="//adms:Identifier/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/dcat-ap-vl.pattern.assert.78</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/dcat-ap-vl.pattern.report.78</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="gestructureerde identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b109">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.79</sch:title>
    <sch:rule context="//adms:Identifier/generiek:gestructureerdeIdentificator[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(generiek:GestructureerdeIdentificator) = 1 or count(//generiek:GestructureerdeIdentificator[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.79</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.79</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend door" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b110">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.80</sch:title>
    <sch:rule context="//adms:Identifier/dct:creator[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.80</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.80</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b37">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.81</sch:title>
    <sch:rule context="//dcat:DataService/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.81</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.81</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b38">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.82</sch:title>
    <sch:rule context="//dcat:DataService/dcat:version[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.82</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.82</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b39">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.83</sch:title>
    <sch:rule context="//dcat:DataService/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.83</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.83</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b40">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.84</sch:title>
    <sch:rule context="//dcat:DataService/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.84</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.84</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b41">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.85</sch:title>
    <sch:rule context="//dcat:DataService/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.85</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.85</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b42">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.86</sch:title>
    <sch:rule context="//dcat:DataService/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.86</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.86</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointURL" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b43">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.87</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.87</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.87</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointbeschrijving" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b44">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.88</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointDescription[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.88</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.88</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b45">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.89</sch:title>
    <sch:rule context="//dcat:DataService/dcat:landingPage[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.89</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.89</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b46">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.90</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:ontwikkelingstoestand[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.90</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.90</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor authenticatie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b47">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.91</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorAuthenticatie[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.91</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.91</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="levensfase" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b48">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.92</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:levensfase[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.92</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.92</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor statusinformatie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b49">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.93</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorStatusinformatie[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.93</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.93</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b50">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.94</sch:title>
    <sch:rule context="//dcat:DataService/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.94</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.94</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b51">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.95</sch:title>
    <sch:rule context="//dcat:DataService/dct:accessRights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.95</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.95</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform aan protocol" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b52">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.96</sch:title>
    <sch:rule context="//dcat:DataService/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.96</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.96</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b53">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.97</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:statuut[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.97</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.97</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor gebruiksinformatie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b54">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.98</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorGebruiksinformatie[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.98</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.98</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rechten" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b55">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.99</sch:title>
    <sch:rule context="//dcat:DataService/dct:rights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.99</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.99</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b56">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.100</sch:title>
    <sch:rule context="//dcat:DataService/dcat:theme[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.100</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.100</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b57">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.101</sch:title>
    <sch:rule context="//dcat:DataService/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.101</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.101</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="creatiedatum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b58">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.102</sch:title>
    <sch:rule context="//dcat:DataService/dct:created[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.102</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.102</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b59">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.103</sch:title>
    <sch:rule context="//dcat:DataService/dct:modified[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.103</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.103</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b60">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.104</sch:title>
    <sch:rule context="//dcat:DataService/dct:issued[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.104</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.104</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="biedt informatie aan over" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b61">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.105</sch:title>
    <sch:rule context="//dcat:DataService/dcat:servesdataset[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.105</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.105</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b62">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.106</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.106</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.106</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b63">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.107</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.107</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.107</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b64">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.108</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.108</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.108</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b65">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.109</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.109</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.109</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="belanghebbende wetgeving" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b66">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.110</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(eli:LegalResource) = 1 or count(//eli:LegalResource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.110</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.110</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="periodiciteit" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b67">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.111</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:accrualPeriodicity[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Frequency) = 1 or count(//dct:Frequency[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.111</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.111</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatie datum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b68">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.112</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:issued[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.112</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.112</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b69">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.113</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:modified[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.assert.113</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-vl.pattern.report.113</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="geografische dekking" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b70">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.114</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:spatial[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Location) = 1 or count(//dct:Location[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.114</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.114</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="temporele dekking" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b71">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.115</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:temporal[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:PeriodOfTime) = 1 or count(//dct:PeriodOfTime[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.115</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.115</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b72">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.116</sch:title>
    <sch:rule context="//dcat:DatasetSeries/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.116</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.116</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b73">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.117</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:publisher[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent|dct:Agent) = 1 or count((//foaf:Agent|//dct:Agent)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.117</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.117</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="e-mail" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b35">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.118</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasEmail[$profile]|//vcard:Kind/vcard:hasEmail[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^(mailto:)?[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.118</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.118</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactpagina" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b36">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.119</sch:title>
    <sch:rule context="//vcard:Organization/foaf:page[$profile]|//vcard:Kind/foaf:page[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.119</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.119</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b141">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.120</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.120</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.120</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b142">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.121</sch:title>
    <sch:rule context="//dcat:Distribution/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.assert.121</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/dcat-ap-vl.pattern.report.121</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b143">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.122</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:downloadURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.122</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.122</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="mediatype" id="_:n19f0654cc0c94ae4b723bfc3b31c6f76b144">
    <sch:title>$loc/strings/dcat-ap-vl.pattern.title.123</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:mediatype[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-vl.pattern.assert.123</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-vl.pattern.report.123</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>