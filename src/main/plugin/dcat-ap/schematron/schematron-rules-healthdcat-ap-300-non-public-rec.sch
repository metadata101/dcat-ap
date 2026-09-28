<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
  <title>{$loc/strings/healthdcat-ap-300-non-public-rec.000000.schematron}</title>
  <ns prefix="adms" uri="http://www.w3.org/ns/adms#" />
  <ns prefix="content" uri="http://www.w3.org/2011/content#" />
  <ns prefix="csvw" uri="http://www.w3.org/ns/csvw#" />
  <ns prefix="dc" uri="http://purl.org/dc/elements/1.1/" />
  <ns prefix="dcat" uri="http://www.w3.org/ns/dcat#" />
  <ns prefix="dcatap" uri="http://data.europa.eu/r5r/" />
  <ns prefix="dct" uri="http://purl.org/dc/terms/" />
  <ns prefix="dqv" uri="http://www.w3.org/ns/dqv#" />
  <ns prefix="dpv" uri="https://w3id.org/dpv#" />
  <ns prefix="cv" uri="http://data.europa.eu/m8g/" />
  <ns prefix="eli" uri="http://data.europa.eu/eli/ontology#" />
  <ns prefix="foaf" uri="http://xmlns.com/foaf/0.1/" />
  <ns prefix="gco" uri="http://www.isotc211.org/2005/gco" />
  <ns prefix="healthdcatap" uri="http://healthdataportal.eu/ns/health#" />
  <ns prefix="generiek" uri="http://data.vlaanderen.be/ns/generiek#" />
  <ns prefix="geodcat-w3c" uri="http://www.w3.org/ns/geodcat#" />
  <ns prefix="geodcatap" uri="http://data.europa.eu/930/" />
  <ns prefix="geonet" uri="http://www.fao.org/geonetwork" />
  <ns prefix="locn" uri="http://www.w3.org/ns/locn#" />
  <ns prefix="mdcat" uri="https://data.vlaanderen.be/ns/metadata-dcat#" />
  <ns prefix="mobilitydcatap" uri="https://w3id.org/mobilitydcat-ap#" />
  <ns prefix="oa" uri="http://www.w3.org/ns/oa#" />
  <ns prefix="odrl" uri="http://www.w3.org/ns/odrl/2/" />
  <ns prefix="org" uri="http://www.w3.org/ns/org#" />
  <ns prefix="owl" uri="http://www.w3.org/2002/07/owl#" />
  <ns prefix="prov" uri="http://www.w3.org/ns/prov#" />
  <ns prefix="rdf" uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#" />
  <ns prefix="rdfs" uri="http://www.w3.org/2000/01/rdf-schema#" />
  <ns prefix="schema" uri="http://schema.org/" />
  <ns prefix="sh" uri="http://www.w3.org/ns/shacl#" />
  <ns prefix="shacl" uri="https://purl.eu/ns/shacl#" />
  <ns prefix="skos" uri="http://www.w3.org/2004/02/skos/core#" />
  <ns prefix="spdx" uri="http://spdx.org/rdf/terms#" />
  <ns prefix="time" uri="http://www.w3.org/2006/time#" />
  <ns prefix="vcard" uri="http://www.w3.org/2006/vcard/ns#" />
  <ns prefix="xlink" uri="http://www.w3.org/1999/xlink" />
  <ns prefix="xml" uri="http://www.w3.org/XML/1998/namespace" />
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance" />
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000001.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(geodcatap:custodian) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000002.assert, ('#occurrences'), (string(count(geodcatap:custodian))))" />
      </assert>
      <report test="count(geodcatap:custodian) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000003.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000004.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dct:relation) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000005.assert, ('#occurrences'), (string(count(dct:relation))))" />
      </assert>
      <report test="count(dct:relation) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000006.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000007.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dcat:landingPage) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000008.assert, ('#occurrences'), (string(count(dcat:landingPage))))" />
      </assert>
      <report test="count(dcat:landingPage) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000009.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000010.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dcat:temporalResolution) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000011.assert, ('#occurrences'), (string(count(dcat:temporalResolution))))" />
      </assert>
      <report test="count(dcat:temporalResolution) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000012.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000013.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dct:temporal) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000014.assert, ('#occurrences'), (string(count(dct:temporal))))" />
      </assert>
      <report test="count(dct:temporal) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000015.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000016.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dct:source) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000017.assert, ('#occurrences'), (string(count(dct:source))))" />
      </assert>
      <report test="count(dct:source) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000018.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000019.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(adms:sample) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000020.assert, ('#occurrences'), (string(count(adms:sample))))" />
      </assert>
      <report test="count(adms:sample) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000021.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000022.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:retentionPeriod) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000023.assert, ('#occurrences'), (string(count(healthdcatap:retentionPeriod))))" />
      </assert>
      <report test="count(healthdcatap:retentionPeriod) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000024.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000025.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dqv:hasQualityAnnotation) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000026.assert, ('#occurrences'), (string(count(dqv:hasQualityAnnotation))))" />
      </assert>
      <report test="count(dqv:hasQualityAnnotation) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000027.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000028.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dpv:hasPurpose) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000029.assert, ('#occurrences'), (string(count(dpv:hasPurpose))))" />
      </assert>
      <report test="count(dpv:hasPurpose) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000030.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000031.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:populationCoverage) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000032.assert, ('#occurrences'), (string(count(healthdcatap:populationCoverage))))" />
      </assert>
      <report test="count(healthdcatap:populationCoverage) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000033.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000034.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dpv:hasPersonalData) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000035.assert, ('#occurrences'), (string(count(dpv:hasPersonalData))))" />
      </assert>
      <report test="count(dpv:hasPersonalData) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000036.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000037.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:analytics) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000038.assert, ('#occurrences'), (string(count(healthdcatap:analytics))))" />
      </assert>
      <report test="count(healthdcatap:analytics) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000039.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000040.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:hasCodeValues) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000041.assert, ('#occurrences'), (string(count(healthdcatap:hasCodeValues))))" />
      </assert>
      <report test="count(healthdcatap:hasCodeValues) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000042.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000043.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:hasCodingSystem) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000044.assert, ('#occurrences'), (string(count(healthdcatap:hasCodingSystem))))" />
      </assert>
      <report test="count(healthdcatap:hasCodingSystem) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000045.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000046.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dct:conformsTo) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000047.assert, ('#occurrences'), (string(count(dct:conformsTo))))" />
      </assert>
      <report test="count(dct:conformsTo) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000048.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000049.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(foaf:page) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000050.assert, ('#occurrences'), (string(count(foaf:page))))" />
      </assert>
      <report test="count(foaf:page) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000051.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000052.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dct:accrualPeriodicity) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000053.assert, ('#occurrences'), (string(count(dct:accrualPeriodicity))))" />
      </assert>
      <report test="count(dct:accrualPeriodicity) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000054.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000055.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:healthTheme) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000056.assert, ('#occurrences'), (string(count(healthdcatap:healthTheme))))" />
      </assert>
      <report test="count(healthdcatap:healthTheme) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000057.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000058.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dct:isReferencedBy) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000059.assert, ('#occurrences'), (string(count(dct:isReferencedBy))))" />
      </assert>
      <report test="count(dct:isReferencedBy) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000060.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000061.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dct:language) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000062.assert, ('#occurrences'), (string(count(dct:language))))" />
      </assert>
      <report test="count(dct:language) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000063.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000064.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dpv:hasLegalBasis) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000065.assert, ('#occurrences'), (string(count(dpv:hasLegalBasis))))" />
      </assert>
      <report test="count(dpv:hasLegalBasis) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000066.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000067.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:maxTypicalAge) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000068.assert, ('#occurrences'), (string(count(healthdcatap:maxTypicalAge))))" />
      </assert>
      <report test="count(healthdcatap:maxTypicalAge) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000069.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000070.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:minTypicalAge) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000071.assert, ('#occurrences'), (string(count(healthdcatap:minTypicalAge))))" />
      </assert>
      <report test="count(healthdcatap:minTypicalAge) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000072.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000073.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:numberOfRecords) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000074.assert, ('#occurrences'), (string(count(healthdcatap:numberOfRecords))))" />
      </assert>
      <report test="count(healthdcatap:numberOfRecords) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000075.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000076.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:numberOfUniqueIndividuals) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000077.assert, ('#occurrences'), (string(count(healthdcatap:numberOfUniqueIndividuals))))" />
      </assert>
      <report test="count(healthdcatap:numberOfUniqueIndividuals) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-non-public-rec.000078.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000079.title</title>
    <rule context="//dcat:Catalog/dcat:themeTaxonomy">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000080.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000081.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000082.title</title>
    <rule context="//dcat:Catalog">
      <let name="hasValue" value="dcat:themeTaxonomy/skos:Concept/@rdf:about='http://publications.europa.eu/resource/authority/data-theme'" />
      <assert test="$hasValue">$loc/strings/healthdcat-ap-300-non-public-rec.000083.assert</assert>
      <report test="$hasValue">$loc/strings/healthdcat-ap-300-non-public-rec.000084.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000085.title</title>
    <rule context="//dcat:Catalog/dct:spatial">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000086.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000087.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000088.title</title>
    <rule context="//dcat:Catalog/dct:publisher">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000089.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000090.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000091.title</title>
    <rule context="//dcat:Distribution/dcat:packageFormat">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000092.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000093.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000094.title</title>
    <rule context="//dcat:Distribution/dcat:compressFormat">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000095.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000096.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000097.title</title>
    <rule context="//dcat:Distribution/dcat:mediaType">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000098.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000099.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000100.title</title>
    <rule context="//dcat:Dataset/dct:type">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000101.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000102.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-non-public-rec.000103.title</title>
    <rule context="//dcat:Dataset/dct:spatial">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000104.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-non-public-rec.000105.report</report>
    </rule>
  </pattern>
</schema>
