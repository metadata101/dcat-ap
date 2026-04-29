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
  <sch:let name="profile" value="boolean(//dcat-ap:applicableLegislation[@rdf:resource='http://data.europa.eu/eli/reg_impl/2023/138/oj'])"/>
  <sch:pattern name="applicable legislation" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/0a6f3bb11ed4ea12f852c78996b89c9a54ffc0fb">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.1</sch:title>
    <sch:rule context="//dcat:Distribution/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.1</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.1</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="linked schemas" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/226b9cb0511ec6b8da045829e10d2676ddbb8375">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.2</sch:title>
    <sch:rule context="//dcat:Distribution/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.2</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.2</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="access service" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/23d4c038584493decec780192681ef61694bff7c">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.3</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessService[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.3</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.3</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="linked schemas" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/27b3b10cebe804356667d0cfca6f658b01f83fbb">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.4</sch:title>
    <sch:rule context="//dcat:Distribution/dct:conformsTo[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.4</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.4</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="access URL" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/653804840386e33525b3d39d205c174780be414b">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.5</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.5</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.5</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="applicable legislation" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/73465b7fbd7f991a08ddd1b766c2e46fa9dfc14e">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.6</sch:title>
    <sch:rule context="//dcat:Distribution/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(eli:LegalResource) = 1 or count(//eli:LegalResource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.6</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.6</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="access service" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/7434c99492683a2fb06dcdcf1f238671caf3d462">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.7</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessService[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.7</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.7</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rights" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/99435c17158fbaa12d1d955b8886d5bf935ab016">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.8</sch:title>
    <sch:rule context="//dcat:Distribution/dct:rights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.8</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.8</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="access URL" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/a490981ff58636ec8601ca500e67bd9c575eaed9">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.9</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessURL[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.9</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.9</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rights" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/b4c4138f0581e7240ec4dd866004c56407b3705a">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.10</sch:title>
    <sch:rule context="//dcat:Distribution/dct:rights[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.10</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.10</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licence" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/dbcf2adef675735c48b532392359af27af5e8b71">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.11</sch:title>
    <sch:rule context="//dcat:Distribution/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.11</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.11</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licence" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/f30149ffb6ec9d00dd5866b052105729fa27d02a">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.12</sch:title>
    <sch:rule context="//dcat:Distribution/dct:license[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.12</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.12</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DistributionShape/HVDELI">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.13</sch:title>
    <sch:rule context="//dcat:Distribution/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="hasValue" value="string() = 'http://data.europa.eu/eli/reg_impl/2023/138/oj' or */@rdf:about = 'http://data.europa.eu/eli/reg_impl/2023/138/oj' or ./@rdf:resource = 'http://data.europa.eu/eli/reg_impl/2023/138/oj'"/>
      <sch:assert test="$hasValue">$loc/strings/dcat-ap-hvd.pattern.assert.13</sch:assert>
      <sch:report test="$hasValue">$loc/strings/dcat-ap-hvd.pattern.report.13</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="dataset" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:CatalogShape/01d5c746936ff78bb5eb353a1b0e49303cb2fd31">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.14</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:dataset[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.14</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.14</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="record" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:CatalogShape/337cf55721093cc585693a5397601643d59a4c46">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.15</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:record[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:CatalogRecord) = 1 or count(//dcat:CatalogRecord[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.15</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.15</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="record" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:CatalogShape/34db0dabef6e2aa992eab790fc3e8d1e3f83bc12">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.16</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:record[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.16</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.16</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="dataset" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:CatalogShape/7b94c69361e00163d16d78016cd994668c7fccda">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.17</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:dataset[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.17</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.17</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="service" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:CatalogShape/c26f8a3ac6445e9f36176f951acd9d235af5ffd9">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.18</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:service[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.18</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.18</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="service" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:CatalogShape/e9a8f5414305eafd449b87a38bfe0c974341c9ac">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.19</sch:title>
    <sch:rule context="//dcat:Catalog/dcat:service[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.19</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.19</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="applicable legislation" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetSeriesShape/0a6f3bb11ed4ea12f852c78996b89c9a54ffc0fb">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.20</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.20</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.20</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="applicable legislation" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetSeriesShape/73465b7fbd7f991a08ddd1b766c2e46fa9dfc14e">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.21</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(eli:LegalResource) = 1 or count(//eli:LegalResource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.21</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.21</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="HVD Category" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetSeriesShape/892bcf3c90199fdd741a47fc4559dc59d5a5b034">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.22</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dcat-ap:hvdCategory[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.22</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.22</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="HVD Category" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetSeriesShape/924bfd3702cf51f4a6bc11bd1b7e06790d5d2fbc">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.23</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dcat-ap:hvdCategory[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.23</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.23</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetSeriesShape/HVDELI">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.24</sch:title>
    <sch:rule context="//dcat:DatasetSeries/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="hasValue" value="string() = 'http://data.europa.eu/eli/reg_impl/2023/138/oj' or */@rdf:about = 'http://data.europa.eu/eli/reg_impl/2023/138/oj' or ./@rdf:resource = 'http://data.europa.eu/eli/reg_impl/2023/138/oj'"/>
      <sch:assert test="$hasValue">$loc/strings/dcat-ap-hvd.pattern.assert.24</sch:assert>
      <sch:report test="$hasValue">$loc/strings/dcat-ap-hvd.pattern.report.24</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="primary topic" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:CatalogRecordShape/387c76a64757677cc2b899f0c4a20803263a0449">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.25</sch:title>
    <sch:rule context="//dcat:CatalogRecord/foaf:primaryTopic[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.25</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.25</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="primary topic" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:CatalogRecordShape/c65d45ed7195ead5f643ec8c8afd29c6dd9662bf">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.26</sch:title>
    <sch:rule context="//dcat:CatalogRecord/foaf:primaryTopic[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Dataset|dcat:DataService|dcat:DatasetSeries) = 1 or count((//dcat:Dataset|//dcat:DataService|//dcat:DatasetSeries)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.26</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.26</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="applicable legislation" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/0a6f3bb11ed4ea12f852c78996b89c9a54ffc0fb">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.27</sch:title>
    <sch:rule context="//dcat:DataService/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.27</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.27</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="serves dataset" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/1a61f733fafb015548fe0e21203d559c9cb4d228">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.28</sch:title>
    <sch:rule context="//dcat:DataService/dcat:servesDataset[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.28</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.28</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="HVD category" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/1aeb85e10acb27fafc68a1bc04adb4860ecbea59">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.29</sch:title>
    <sch:rule context="//dcat:DataService/dcat-ap:hvdCategory[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.29</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.29</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpoint URL" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/3bde2663aaca96d953765ac2e525ef64710bf4d6">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.30</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointURL[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.30</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.30</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="HVD category" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/60675e8175395481680e343172eea5fcd3f82cd4">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.31</sch:title>
    <sch:rule context="//dcat:DataService/dcat-ap:hvdCategory[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.31</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.31</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpoint description" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/63240e11f1eb66f636413d1dbb134f0ff9066a7c">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.32</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointDescription[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.32</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.32</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="documentation" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/68388ec47b77212d80036e8a02e9956f5ba0e0f5">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.33</sch:title>
    <sch:rule context="//dcat:DataService/foaf:page[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Document) = 1 or count(//foaf:Document[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.33</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.33</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="applicable legislation" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/73465b7fbd7f991a08ddd1b766c2e46fa9dfc14e">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.34</sch:title>
    <sch:rule context="//dcat:DataService/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(eli:LegalResource) = 1 or count(//eli:LegalResource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.34</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.34</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contact point" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/7b6713c1f4a52e964f5db57eabef294b6d04e90e">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.35</sch:title>
    <sch:rule context="//dcat:DataService/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.35</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.35</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rights" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/99435c17158fbaa12d1d955b8886d5bf935ab016">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.36</sch:title>
    <sch:rule context="//dcat:DataService/dct:rights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.36</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.36</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="documentation" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/998ce689a5bcc3e2764ff84a05255e34d91e8102">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.37</sch:title>
    <sch:rule context="//dcat:DataService/foaf:page[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.37</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.37</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contact point" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/9adf9f5890592909cf3e67021ae7ab4f895a7745">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.38</sch:title>
    <sch:rule context="//dcat:DataService/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.38</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.38</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rights" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/b4c4138f0581e7240ec4dd866004c56407b3705a">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.39</sch:title>
    <sch:rule context="//dcat:DataService/dct:rights[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.39</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.39</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="serves dataset" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/ca2bd10c893237fa342edb75240b08731acda92f">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.40</sch:title>
    <sch:rule context="//dcat:DataService/dcat:servesDataset[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.40</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.40</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licence" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/dbcf2adef675735c48b532392359af27af5e8b71">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.41</sch:title>
    <sch:rule context="//dcat:DataService/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.41</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.41</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpoint description" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/dc08f4dca4377fade57f89454e3fa06a8389d314">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.42</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointDescription[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.42</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.42</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpoint URL" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/eb3ac4e4fdde2e2588a9502c5956060a18c5c99f">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.43</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.43</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.43</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licence" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/f30149ffb6ec9d00dd5866b052105729fa27d02a">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.44</sch:title>
    <sch:rule context="//dcat:DataService/dct:license[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.44</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.44</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DataServiceShape/HVDELI">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.45</sch:title>
    <sch:rule context="//dcat:DataService/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="hasValue" value="string() = 'http://data.europa.eu/eli/reg_impl/2023/138/oj' or */@rdf:about = 'http://data.europa.eu/eli/reg_impl/2023/138/oj' or ./@rdf:resource = 'http://data.europa.eu/eli/reg_impl/2023/138/oj'"/>
      <sch:assert test="$hasValue">$loc/strings/dcat-ap-hvd.pattern.assert.45</sch:assert>
      <sch:report test="$hasValue">$loc/strings/dcat-ap-hvd.pattern.report.45</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="email" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#vcard:KindShape/8cf3e751730442052d1b2174336d21bb838e4aab">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.46</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasEmail[$profile]|//vcard:Kind/vcard:hasEmail[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^(mailto:)?[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.46</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.46</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contact page" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#vcard:KindShape/95cf5318d1604f72f1c5d4d22a360ce268437bf0">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.47</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasURL[$profile]|//vcard:Kind/vcard:hasURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.47</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.47</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="email" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#vcard:KindShape/9b6ccc41bb0ced6f6b8f28a86e120bd9d73b32fb">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.48</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasEmail[$profile]|//vcard:Kind/vcard:hasEmail[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.48</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.48</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contact page" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#vcard:KindShape/a736c4b01ea7557518c0c146f3e311947ce00ccc">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.49</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasURL[$profile]|//vcard:Kind/vcard:hasURL[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.49</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.49</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conforms to" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/08118c51bfc41b71d11f3a58e9410da74e6480e6">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.50</sch:title>
    <sch:rule context="//dcat:Dataset/dct:conformsTo[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.50</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.50</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="applicable legislation" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/0a6f3bb11ed4ea12f852c78996b89c9a54ffc0fb">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.51</sch:title>
    <sch:rule context="//dcat:Dataset/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.51</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.51</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="dataset distribution" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/2ab9813b47309d4af98fdfe34189ea24baecc8cd">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.52</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:distribution[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Distribution) = 1 or count(//dcat:Distribution[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.52</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.52</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="in series" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/63790d4374dda7d88681e2756e114a65082d9bfd">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.53</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:inSeries[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:DatasetSeries) = 1 or count(//dcat:DatasetSeries[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.53</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.53</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="applicable legislation" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/73465b7fbd7f991a08ddd1b766c2e46fa9dfc14e">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.54</sch:title>
    <sch:rule context="//dcat:Dataset/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(eli:LegalResource) = 1 or count(//eli:LegalResource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.54</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.54</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contact point" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/7b6713c1f4a52e964f5db57eabef294b6d04e90e">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.55</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization|vcard:Kind) = 1 or count((//vcard:Organization|//vcard:Kind)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.55</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.55</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="in series" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/8335ef1071b18fbd6dac863013c6a9de3d057ab0">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.56</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:inSeries[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.56</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.56</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="HVD Category" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/892bcf3c90199fdd741a47fc4559dc59d5a5b034">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.57</sch:title>
    <sch:rule context="//dcat:Dataset/dcat-ap:hvdCategory[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.57</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.57</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="HVD Category" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/924bfd3702cf51f4a6bc11bd1b7e06790d5d2fbc">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.58</sch:title>
    <sch:rule context="//dcat:Dataset/dcat-ap:hvdCategory[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.58</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.58</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contact point" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/9adf9f5890592909cf3e67021ae7ab4f895a7745">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.59</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.59</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.59</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conforms to" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/c84f7330b9538a899ebb875c44dc23c9882e74ac">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.60</sch:title>
    <sch:rule context="//dcat:Dataset/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/dcat-ap-hvd.pattern.assert.60</sch:assert>
      <sch:report test="$validClass">$loc/strings/dcat-ap-hvd.pattern.report.60</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="dataset distribution" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/f6f077451f13ccf5d721838425fcc37f6cebfe48">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.61</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:distribution[$profile]">
      <sch:let name="resource" value="(@rdf:resource, */@rdf:about)[1]"/>
      <sch:let name="isIRI" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0 and count(*[not(starts-with(name(), 'geonet:'))]) &gt;= 1"/>
      <sch:let name="isBlankNodeOrIRI" value="$isIRI or $isBlankNode"/>
      <sch:assert test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.assert.61</sch:assert>
      <sch:report test="$isBlankNodeOrIRI">$loc/strings/dcat-ap-hvd.pattern.report.61</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="" id="https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd#dcat:DatasetShape/HVDELI">
    <sch:title>$loc/strings/dcat-ap-hvd.pattern.title.62</sch:title>
    <sch:rule context="//dcat:Dataset/dcat-ap:applicableLegislation[$profile]">
      <sch:let name="hasValue" value="string() = 'http://data.europa.eu/eli/reg_impl/2023/138/oj' or */@rdf:about = 'http://data.europa.eu/eli/reg_impl/2023/138/oj' or ./@rdf:resource = 'http://data.europa.eu/eli/reg_impl/2023/138/oj'"/>
      <sch:assert test="$hasValue">$loc/strings/dcat-ap-hvd.pattern.assert.62</sch:assert>
      <sch:report test="$hasValue">$loc/strings/dcat-ap-hvd.pattern.report.62</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>