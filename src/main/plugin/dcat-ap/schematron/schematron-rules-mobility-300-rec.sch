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
  <sch:pattern name="application layer protocol" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Distribution_Shape_applicationLayerProtocol">
    <sch:title>$loc/strings/mobility-300-rec.pattern.title.1</sch:title>
    <sch:rule context="//dcat:Distribution/mobilitydcatap:applicationLayerProtocol[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="matchesPattern" value="matches($resource, '^https://w3id\.org/mobilitydcat-ap/application-layer-protocol/.+$')"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300-rec.pattern.assert.1</sch:assert>
      <sch:report test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300-rec.pattern.report.1</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="description" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Distribution_Shape_description">
    <sch:title>$loc/strings/mobility-300-rec.pattern.title.2</sch:title>
    <sch:rule context="//dcat:Distribution/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300-rec.pattern.assert.2</sch:assert>
      <sch:report test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300-rec.pattern.report.2</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licence" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Distribution_Shape_licence">
    <sch:title>$loc/strings/mobility-300-rec.pattern.title.3</sch:title>
    <sch:rule context="//dcat:Distribution/dct:license[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/mobility-300-rec.pattern.assert.3</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/mobility-300-rec.pattern.report.3</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="georeferencing method" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_georeferencingMethod">
    <sch:title>$loc/strings/mobility-300-rec.pattern.title.4</sch:title>
    <sch:rule context="//dcat:Dataset/mobilitydcatap:georeferencingMethod[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="matchesPattern" value="matches($resource, '^https://w3id\.org/mobilitydcat-ap/georeferencing-method/.+$')"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300-rec.pattern.assert.4</sch:assert>
      <sch:report test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300-rec.pattern.report.4</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contact point" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_contactPoint">
    <sch:title>$loc/strings/mobility-300-rec.pattern.title.5</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/mobility-300-rec.pattern.assert.5</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/mobility-300-rec.pattern.report.5</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="keyword / tag" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_keyword">
    <sch:title>$loc/strings/mobility-300-rec.pattern.title.6</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-300-rec.pattern.assert.6</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-300-rec.pattern.report.6</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="network coverage" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_networkCoverage">
    <sch:title>$loc/strings/mobility-300-rec.pattern.title.7</sch:title>
    <sch:rule context="//dcat:Dataset/mobilitydcatap:networkCoverage[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="matchesPattern" value="matches($resource, '^https://w3id\.org/mobilitydcat-ap/network-coverage/.+$')"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300-rec.pattern.assert.7</sch:assert>
      <sch:report test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300-rec.pattern.report.7</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rights holder" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_rightsHolder">
    <sch:title>$loc/strings/mobility-300-rec.pattern.title.8</sch:title>
    <sch:rule context="//dcat:Dataset/dct:rightsHolder[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/mobility-300-rec.pattern.assert.8</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/mobility-300-rec.pattern.report.8</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="theme / category" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_theme">
    <sch:title>$loc/strings/mobility-300-rec.pattern.title.9</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:theme[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="matchesPattern" value="matches($resource, '^http://publications\.europa\.eu/resource/authority/data-theme/.+$')"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300-rec.pattern.assert.9</sch:assert>
      <sch:report test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300-rec.pattern.report.9</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="temporal coverage" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_temporal">
    <sch:title>$loc/strings/mobility-300-rec.pattern.title.10</sch:title>
    <sch:rule context="//dcat:Dataset/dct:temporal[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/mobility-300-rec.pattern.assert.10</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/mobility-300-rec.pattern.report.10</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="transport mode" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_transportMode">
    <sch:title>$loc/strings/mobility-300-rec.pattern.title.11</sch:title>
    <sch:rule context="//dcat:Dataset/mobilitydcatap:transportMode[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="matchesPattern" value="matches($resource, '^https://w3id\.org/mobilitydcat-ap/transport-mode/.+$')"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300-rec.pattern.assert.11</sch:assert>
      <sch:report test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300-rec.pattern.report.11</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>