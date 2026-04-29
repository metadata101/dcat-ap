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
  <sch:pattern name="access URL" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Distribution_Shape_accessURL">
    <sch:title>$loc/strings/mobility-300.pattern.title.1</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessURL[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-300.pattern.assert.1</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-300.pattern.report.1</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="mobility data standard" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Distribution_Shape_mobilityDataStandard">
    <sch:title>$loc/strings/mobility-300.pattern.title.2</sch:title>
    <sch:rule context="//dcat:Distribution/mobilitydcatap:mobilityDataStandard[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="matchesOrAlternative" value="((matches($resource, '^\w+:(/?/?)[^\s]+$') and (matches($resource, '^https://w3id\.org/mobilitydcat-ap/mobility-data-standard/.+$'))) or (count(mobilitydcatap:MobilityDataStandard) = 1 or count(//mobilitydcatap:MobilityDataStandard[@rdf:about = $resource]) = 1))"/>
      <sch:assert test="$matchesOrAlternative">$loc/strings/mobility-300.pattern.assert.2</sch:assert>
      <sch:report test="$matchesOrAlternative">$loc/strings/mobility-300.pattern.report.2</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="format" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Distribution_Shape_format">
    <sch:title>$loc/strings/mobility-300.pattern.title.3</sch:title>
    <sch:rule context="//dcat:Distribution/dct:format[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="matchesPattern" value="matches($resource, '^http://publications\.europa\.eu/resource/authority/file-type/.+$')"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300.pattern.assert.3</sch:assert>
      <sch:report test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300.pattern.report.3</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rights" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Distribution_Shape_rights">
    <sch:title>$loc/strings/mobility-300.pattern.title.4</sch:title>
    <sch:rule context="//dcat:Distribution/dct:rights[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/mobility-300.pattern.assert.4</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/mobility-300.pattern.report.4</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="email" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Kind_Shape_email">
    <sch:title>$loc/strings/mobility-300.pattern.title.5</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasEmail[$profile]|//vcard:Kind/vcard:hasEmail[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-300.pattern.assert.5</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-300.pattern.report.5</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="name" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Kind_Shape_name">
    <sch:title>$loc/strings/mobility-300.pattern.title.6</sch:title>
    <sch:rule context="//vcard:Organization/vcard:fn[$profile]|//vcard:Kind/vcard:fn[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-300.pattern.assert.6</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-300.pattern.report.6</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="preferred label" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Category_Shape_prefLabel">
    <sch:title>$loc/strings/mobility-300.pattern.title.7</sch:title>
    <sch:rule context="//skos:Concept/skos:prefLabel[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-300.pattern.assert.7</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-300.pattern.report.7</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="category scheme" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Category_Shape_inScheme">
    <sch:title>$loc/strings/mobility-300.pattern.title.8</sch:title>
    <sch:rule context="//skos:Concept/skos:inScheme[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/mobility-300.pattern.assert.8</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/mobility-300.pattern.report.8</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="description" id="https://w3id.org/mobilitydcat-ap/drafts/latest#DatasetSeries_Shape_description">
    <sch:title>$loc/strings/mobility-300.pattern.title.9</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300.pattern.assert.9</sch:assert>
      <sch:report test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300.pattern.report.9</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publisher" id="https://w3id.org/mobilitydcat-ap/drafts/latest#DatasetSeries_Shape_publisher">
    <sch:title>$loc/strings/mobility-300.pattern.title.10</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:publisher[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/mobility-300.pattern.assert.10</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/mobility-300.pattern.report.10</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="title" id="https://w3id.org/mobilitydcat-ap/drafts/latest#DatasetSeries_Shape_title">
    <sch:title>$loc/strings/mobility-300.pattern.title.11</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300.pattern.assert.11</sch:assert>
      <sch:report test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300.pattern.report.11</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conditions for access and usage" id="https://w3id.org/mobilitydcat-ap/drafts/latest#RightsStatement_Shape_type">
    <sch:title>$loc/strings/mobility-300.pattern.title.12</sch:title>
    <sch:rule context="//dct:RightsStatement/dct:type[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="matchesPattern" value="matches($resource, '^https://w3id\.org/mobilitydcat-ap/conditions-for-access-and-usage/.+$')"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300.pattern.assert.12</sch:assert>
      <sch:report test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300.pattern.report.12</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="homepage" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Catalogue_Shape_homepage_mandatory">
    <sch:title>$loc/strings/mobility-300.pattern.title.13</sch:title>
    <sch:rule context="//dcat:Catalog/foaf:homepage[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-300.pattern.assert.13</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-300.pattern.report.13</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="title" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Catalogue_Shape_title">
    <sch:title>$loc/strings/mobility-300.pattern.title.14</sch:title>
    <sch:rule context="//dcat:Catalog/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300.pattern.assert.14</sch:assert>
      <sch:report test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300.pattern.report.14</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="description" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Catalogue_Shape_description">
    <sch:title>$loc/strings/mobility-300.pattern.title.15</sch:title>
    <sch:rule context="//dcat:Catalog/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300.pattern.assert.15</sch:assert>
      <sch:report test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300.pattern.report.15</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="title" id="https://w3id.org/mobilitydcat-ap/drafts/latest#CategoryScheme_Shape_title">
    <sch:title>$loc/strings/mobility-300.pattern.title.16</sch:title>
    <sch:rule context="//skos:ConceptScheme/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/mobility-300.pattern.assert.16</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/mobility-300.pattern.report.16</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="description" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_description">
    <sch:title>$loc/strings/mobility-300.pattern.title.17</sch:title>
    <sch:rule context="//dcat:Dataset/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300.pattern.assert.17</sch:assert>
      <sch:report test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300.pattern.report.17</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="dataset distribution" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_distribution">
    <sch:title>$loc/strings/mobility-300.pattern.title.18</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:distribution[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/mobility-300.pattern.assert.18</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/mobility-300.pattern.report.18</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="frequency" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_accrualPeriodicity">
    <sch:title>$loc/strings/mobility-300.pattern.title.19</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accrualPeriodicity[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/mobility-300.pattern.assert.19</sch:assert>
      <sch:report test="$isIRI">$loc/strings/mobility-300.pattern.report.19</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="mobility theme" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_mobilityTheme">
    <sch:title>$loc/strings/mobility-300.pattern.title.20</sch:title>
    <sch:rule context="//dcat:Dataset/mobilitydcatap:mobilityTheme[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="matchesPattern" value="matches($resource, '^https://w3id\.org/mobilitydcat-ap/mobility-theme/.+$')"/>
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300.pattern.assert.20</sch:assert>
      <sch:report test="$isIRI and $matchesPattern and $isIRI">$loc/strings/mobility-300.pattern.report.20</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="spatial / geographic coverage" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_spatial">
    <sch:title>$loc/strings/mobility-300.pattern.title.21</sch:title>
    <sch:rule context="//dcat:Dataset/dct:spatial[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/mobility-300.pattern.assert.21</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/mobility-300.pattern.report.21</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="title" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_title">
    <sch:title>$loc/strings/mobility-300.pattern.title.22</sch:title>
    <sch:rule context="//dcat:Dataset/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300.pattern.assert.22</sch:assert>
      <sch:report test="$isUniqueLang and $isLiteral">$loc/strings/mobility-300.pattern.report.22</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publisher" id="https://w3id.org/mobilitydcat-ap/drafts/latest#Dataset_Shape_publisher">
    <sch:title>$loc/strings/mobility-300.pattern.title.23</sch:title>
    <sch:rule context="//dcat:Dataset/dct:publisher[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/mobility-300.pattern.assert.23</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/mobility-300.pattern.report.23</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>