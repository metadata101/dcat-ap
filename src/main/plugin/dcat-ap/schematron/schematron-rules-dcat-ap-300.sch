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
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b34">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.1</sch:title>
    <sch:rule context="//dcat:DataService/dct:accessRights[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.1</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.1</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b35">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.2</sch:title>
    <sch:rule context="//dcat:DataService/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/dcat-ap-300.pattern.assert.2</sch:assert>
      <sch:report test="$isIRI">$loc/strings/dcat-ap-300.pattern.report.2</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b36">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.3</sch:title>
    <sch:rule context="//dcat:DataService/dct:conformsTo[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.3</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.3</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b37">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.4</sch:title>
    <sch:rule context="//dcat:DataService/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.4</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.4</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b38">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.5</sch:title>
    <sch:rule context="//dcat:DataService/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.5</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.5</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b39">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.6</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointURL[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.6</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.6</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b40">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.7</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointDescription[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.7</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.7</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b41">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.8</sch:title>
    <sch:rule context="//dcat:DataService/dct:format[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.8</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.8</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b42">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.9</sch:title>
    <sch:rule context="//dcat:DataService/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.9</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.9</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b43">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.10</sch:title>
    <sch:rule context="//dcat:DataService/dcat:landingPage[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.10</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.10</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b44">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.11</sch:title>
    <sch:rule context="//dcat:DataService/dct:license[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.11</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.11</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b45">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.12</sch:title>
    <sch:rule context="//dcat:DataService/dct:publisher[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.12</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.12</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b46">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.13</sch:title>
    <sch:rule context="//dcat:DataService/dcat:servesDataset[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.13</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.13</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b47">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.14</sch:title>
    <sch:rule context="//dcat:DataService/dcat:theme[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/dcat-ap-300.pattern.assert.14</sch:assert>
      <sch:report test="$isIRI">$loc/strings/dcat-ap-300.pattern.report.14</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b48">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.15</sch:title>
    <sch:rule context="//dcat:DataService/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.15</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.15</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b31">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.16</sch:title>
    <sch:rule context="//skos:Concept/skos:prefLabel[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.16</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.16</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b10">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.17</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.17</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.17</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b11">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.18</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.18</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.18</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b49">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.19</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accessRights[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.19</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.19</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b50">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.20</sch:title>
    <sch:rule context="//dcat:Dataset/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/dcat-ap-300.pattern.assert.20</sch:assert>
      <sch:report test="$isIRI">$loc/strings/dcat-ap-300.pattern.report.20</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b51">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.21</sch:title>
    <sch:rule context="//dcat:Dataset/dct:conformsTo[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.21</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.21</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b52">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.22</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.22</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.22</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b53">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.23</sch:title>
    <sch:rule context="//dcat:Dataset/dct:creator[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.23</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.23</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b54">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.24</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:distribution[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.24</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.24</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b55">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.25</sch:title>
    <sch:rule context="//dcat:Dataset/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.25</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.25</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b56">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.26</sch:title>
    <sch:rule context="//dcat:Dataset/foaf:page[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.26</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.26</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b57">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.27</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accrualPeriodicity[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.27</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.27</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b58">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.28</sch:title>
    <sch:rule context="//dcat:Dataset/dct:spatial[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.28</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.28</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b59">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.29</sch:title>
    <sch:rule context="//dcat:Dataset/dct:hasVersion[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.29</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.29</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b60">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.30</sch:title>
    <sch:rule context="//dcat:Dataset/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.30</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.30</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b61">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.31</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:inSeries[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.31</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.31</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b62">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.32</sch:title>
    <sch:rule context="//dcat:Dataset/dct:isReferencedBy[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.32</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.32</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b63">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.33</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.33</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.33</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b64">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.34</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:landingPage[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.34</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.34</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b65">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.35</sch:title>
    <sch:rule context="//dcat:Dataset/dct:language[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.35</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.35</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b67">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.36</sch:title>
    <sch:rule context="//dcat:Dataset/adms:identifier[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.36</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.36</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b68">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.37</sch:title>
    <sch:rule context="//dcat:Dataset/dct:provenance[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.37</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.37</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b69">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.38</sch:title>
    <sch:rule context="//dcat:Dataset/dct:publisher[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.38</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.38</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b70">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.39</sch:title>
    <sch:rule context="//dcat:Dataset/prov:qualifiedAttribution[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.39</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.39</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b71">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.40</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:qualifiedRelation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.40</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.40</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b72">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.41</sch:title>
    <sch:rule context="//dcat:Dataset/dct:relation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.41</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.41</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b74">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.42</sch:title>
    <sch:rule context="//dcat:Dataset/adms:sample[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.42</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.42</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b75">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.43</sch:title>
    <sch:rule context="//dcat:Dataset/dct:source[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.43</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.43</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b77">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.44</sch:title>
    <sch:rule context="//dcat:Dataset/dct:temporal[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.44</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.44</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b79">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.45</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:theme[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/dcat-ap-300.pattern.assert.45</sch:assert>
      <sch:report test="$isIRI">$loc/strings/dcat-ap-300.pattern.report.45</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b80">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.46</sch:title>
    <sch:rule context="//dcat:Dataset/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.46</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.46</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b81">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.47</sch:title>
    <sch:rule context="//dcat:Dataset/dct:type[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.47</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.47</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b82">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.48</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:version[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.48</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.48</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b83">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.49</sch:title>
    <sch:rule context="//dcat:Dataset/adms:versionNotes[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.49</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.49</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b84">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.50</sch:title>
    <sch:rule context="//dcat:Dataset/prov:wasGeneratedBy[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.50</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.50</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b127">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.51</sch:title>
    <sch:rule context="//dct:Location/dcat:bbox[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.51</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.51</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b128">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.52</sch:title>
    <sch:rule context="//dct:Location/dcat:centroid[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.52</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.52</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b129">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.53</sch:title>
    <sch:rule context="//dct:Location/locn:geometry[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.53</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.53</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b1">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.54</sch:title>
    <sch:rule context="//foaf:Agent/foaf:name[$profile]|//dct:Agent/foaf:name[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.54</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.54</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b138">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.55</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/dcat-ap-300.pattern.assert.55</sch:assert>
      <sch:report test="$isIRI">$loc/strings/dcat-ap-300.pattern.report.55</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b139">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.56</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.56</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.56</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b140">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.57</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.57</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.57</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b141">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.58</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:accrualPeriodicity[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.58</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.58</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b142">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.59</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:spatial[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.59</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.59</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b143">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.60</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:modified[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.60</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.60</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b144">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.61</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:publisher[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.61</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.61</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b145">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.62</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:issued[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.62</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.62</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b146">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.63</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:temporal[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.63</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.63</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b147">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.64</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.64</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.64</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b12">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.65</sch:title>
    <sch:rule context="//dcat:Catalog/dct:language[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.65</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.65</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b13">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.66</sch:title>
    <sch:rule context="//dcat:Catalog/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/dcat-ap-300.pattern.assert.66</sch:assert>
      <sch:report test="$isIRI">$loc/strings/dcat-ap-300.pattern.report.66</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b14">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.67</sch:title>
    <sch:rule context="//dcat:Catalog/dct:license[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.67</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.67</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b16">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.68</sch:title>
    <sch:rule context="//dcat:Catalog/dct:spatial[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.68</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.68</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b17">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.69</sch:title>
    <sch:rule context="//dcat:Catalog/dct:hasPart[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.69</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.69</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b19">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.70</sch:title>
    <sch:rule context="//dcat:Catalog/dct:rights[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.70</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.70</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b20">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.71</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:record[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.71</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.71</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b21">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.72</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:themeTaxonomy[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.72</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.72</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b22">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.73</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:service[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.73</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.73</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b23">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.74</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:catalog[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.74</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.74</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b24">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.75</sch:title>
    <sch:rule context="//dcat:Catalog/dct:creator[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.75</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.75</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b25">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.76</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:dataset[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.76</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.76</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b26">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.77</sch:title>
    <sch:rule context="//dcat:Catalog/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.77</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.77</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b28">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.78</sch:title>
    <sch:rule context="//dcat:Catalog/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.78</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.78</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b29">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.79</sch:title>
    <sch:rule context="//dcat:Catalog/foaf:homepage[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.79</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.79</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b101">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.80</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessService[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.80</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.80</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b102">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.81</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessURL[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.81</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.81</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b103">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.82</sch:title>
    <sch:rule context="//dcat:Distribution/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isIRI">$loc/strings/dcat-ap-300.pattern.assert.82</sch:assert>
      <sch:report test="$isIRI">$loc/strings/dcat-ap-300.pattern.report.82</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b104">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.83</sch:title>
    <sch:rule context="//dcat:Distribution/dcat-ap:availability[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.83</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.83</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b106">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.84</sch:title>
    <sch:rule context="//dcat:Distribution/spdx:checksum[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.84</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.84</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b107">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.85</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:compressFormat[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.85</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.85</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b108">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.86</sch:title>
    <sch:rule context="//dcat:Distribution/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.86</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.86</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b109">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.87</sch:title>
    <sch:rule context="//dcat:Distribution/foaf:page[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.87</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.87</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b110">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.88</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:downloadURL[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.88</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.88</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b111">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.89</sch:title>
    <sch:rule context="//dcat:Distribution/dct:format[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.89</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.89</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b112">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.90</sch:title>
    <sch:rule context="//dcat:Distribution/odrl:hasPolicy[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.90</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.90</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b113">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.91</sch:title>
    <sch:rule context="//dcat:Distribution/dct:language[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.91</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.91</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b114">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.92</sch:title>
    <sch:rule context="//dcat:Distribution/dct:license[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.92</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.92</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b115">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.93</sch:title>
    <sch:rule context="//dcat:Distribution/dct:conformsTo[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.93</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.93</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b116">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.94</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:mediaType[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.94</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.94</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b118">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.95</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:packageFormat[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.95</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.95</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b120">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.96</sch:title>
    <sch:rule context="//dcat:Distribution/dct:rights[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.96</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.96</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b122">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.97</sch:title>
    <sch:rule context="//dcat:Distribution/adms:status[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.assert.97</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-300.pattern.report.97</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b124">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.98</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.98</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.98</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="_:nda9faa1a21e94bcb880955d0f5842e59b30">
    <sch:title>$loc/strings/dcat-ap-300.pattern.title.99</sch:title>
    <sch:rule context="//skos:ConceptScheme/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/dcat-ap-300.pattern.assert.99</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/dcat-ap-300.pattern.report.99</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>