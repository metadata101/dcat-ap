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
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab38">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.1</sch:title>
    <sch:rule context="//skos:Concept/skos:prefLabel[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.1</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.1</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab8">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.2</sch:title>
    <sch:rule context="//foaf:Agent/foaf:name[$profile]|//dct:Agent/foaf:name[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.2</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.2</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab41">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.3</sch:title>
    <sch:rule context="//dcat:DataService/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.3</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.3</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab42">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.4</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointURL[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-211.pattern.assert.4</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-211.pattern.report.4</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab44">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.5</sch:title>
    <sch:rule context="//dcat:DataService/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.5</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.5</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab45">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.6</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointDescription[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-211.pattern.assert.6</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-211.pattern.report.6</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab48">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.7</sch:title>
    <sch:rule context="//dcat:Dataset/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.7</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.7</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab49">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.8</sch:title>
    <sch:rule context="//dcat:Dataset/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.8</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.8</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab50">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.9</sch:title>
    <sch:rule context="//dcat:Dataset/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.9</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.9</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab53">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.10</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.10</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.10</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab67">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.11</sch:title>
    <sch:rule context="//dcat:Dataset/dct:relation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-211.pattern.assert.11</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-211.pattern.report.11</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab70">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.12</sch:title>
    <sch:rule context="//dcat:Dataset/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.12</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.12</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab71">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.13</sch:title>
    <sch:rule context="//dcat:Dataset/adms:versionNotes[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.13</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.13</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab77">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.14</sch:title>
    <sch:rule context="//dcat:Dataset/dc:isReferencedBy[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-211.pattern.assert.14</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-211.pattern.report.14</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab33">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.15</sch:title>
    <sch:rule context="//dcat:Catalog/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.15</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.15</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab35">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.16</sch:title>
    <sch:rule context="//dcat:Catalog/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.16</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.16</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab102">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.17</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.17</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.17</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab106">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.18</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:downloadURL[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-211.pattern.assert.18</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-211.pattern.report.18</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab115">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.19</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessURL[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-211.pattern.assert.19</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-211.pattern.report.19</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab116">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.20</sch:title>
    <sch:rule context="//dcat:Distribution/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.20</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.20</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab39">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.21</sch:title>
    <sch:rule context="//spdx:Checksum/spdx:algorithm[$profile]">
      <sch:let name="hasValue" value="string() = 'spdx:checksumAlgorithm_sha1' or */@rdf:about = 'spdx:checksumAlgorithm_sha1' or ./@rdf:resource = 'spdx:checksumAlgorithm_sha1'"/>
      <sch:assert test="$hasValue">$loc/strings/dcat-ap-211.pattern.assert.21</sch:assert>
      <sch:report test="$hasValue">$loc/strings/dcat-ap-211.pattern.report.21</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab37">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.22</sch:title>
    <sch:rule context="//skos:ConceptScheme/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.22</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.22</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab122">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.23</sch:title>
    <sch:rule context="//dct:Location/dcat:bbox[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.23</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.23</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab123">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.24</sch:title>
    <sch:rule context="//dct:Location/dcat:centroid[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.24</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.24</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab124">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.25</sch:title>
    <sch:rule context="//dct:Location/locn:geometry[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.25</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.25</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab17">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.26</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.26</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.26</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nb81bc9f767394fb1b6b00397a283cd4ab18">
    <sch:title>$loc/strings/dcat-ap-211.pattern.title.27</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-211.pattern.assert.27</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-211.pattern.report.27</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>