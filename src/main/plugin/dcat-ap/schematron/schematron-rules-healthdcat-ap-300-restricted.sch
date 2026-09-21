<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
  <title>{$loc/strings/healthdcat-ap-300-restricted.000000.schematron}</title>
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
    <title>$loc/strings/healthdcat-ap-300-restricted.000001.title</title>
    <rule context="//csvw:TableGroup/csvw:table">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(csvw:Table) = 1 or count((//csvw:Table)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000002.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000003.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000004.title</title>
    <rule context="//dcat:Dataset/healthdcatap:retentionPeriod">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(dct:PeriodOfTime) = 1 or count((//dct:PeriodOfTime)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000005.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000006.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000007.title</title>
    <rule context="//dcat:Dataset/healthdcatap:hasCodingSystem">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(dct:Standard) = 1 or count((//dct:Standard)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000008.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000009.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000010.title</title>
    <rule context="//dcat:Dataset/healthdcatap:hasVariables">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(csvw:TableGroup) = 1 or count((//csvw:TableGroup)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000011.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000012.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000013.title</title>
    <rule context="//dcat:Dataset/dqv:hasQualityAnnotation">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(dqv:QualityCertificate) = 1 or count((//dqv:QualityCertificate)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000014.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000015.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000016.title</title>
    <rule context="//dcat:Dataset/dpv:hasPersonalData">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(dpv:PersonalData) = 1 or count((//dpv:PersonalData)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000017.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000018.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000019.title</title>
    <rule context="//dcat:Dataset/dpv:hasLegalBasis">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(dpv:LegalBasis) = 1 or count((//dpv:LegalBasis)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000020.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000021.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000022.title</title>
    <rule context="//dcat:Dataset/healthdcatap:healthTheme">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(skos:Concept) = 1 or count((//skos:Concept)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000023.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000024.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000025.title</title>
    <rule context="//dcat:Dataset/healthdcatap:healthCategory">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(skos:Concept) = 1 or count((//skos:Concept)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000026.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000027.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000028.title</title>
    <rule context="//dcat:Dataset/healthdcatap:hdab">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(foaf:Agent) = 1 or count((//foaf:Agent)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000029.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000030.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000031.title</title>
    <rule context="//dcat:Dataset/dpv:hasPurpose">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(dpv:Purpose) = 1 or count((//dpv:Purpose)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000032.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000033.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000034.title</title>
    <rule context="//dcat:Dataset/healthdcatap:analytics">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(dcat:Distribution) = 1 or count((//dcat:Distribution)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000035.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000036.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000037.title</title>
    <rule context="//time:TemporalEntity/cv:frequency">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(dct:Frequency) = 1 or count((//dct:Frequency)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000038.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000039.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000040.title</title>
    <rule context="//time:TemporalEntity/cv:frequency">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000041.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000042.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000043.title</title>
    <rule context="//time:TemporalEntity/dct:description">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000044.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000045.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000046.title</title>
    <rule context="//dct:LicenseDocument/dct:type">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000047.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000048.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000049.title</title>
    <rule context="//csvw:Table/csvw:column">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0" />
      <assert test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000050.assert</assert>
      <report test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000051.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000052.title</title>
    <rule context="//csvw:Table/dcat:keyword">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000053.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000054.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000055.title</title>
    <rule context="//csvw:Table/dct:title">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000056.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000057.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000058.title</title>
    <rule context="//csvw:Table/csvw:url">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000059.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000060.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000061.title</title>
    <rule context="//cv:ContactPoint/cv:specialOpeningHoursSpecification">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(time:TemporalEntity) = 1 or count((//time:TemporalEntity)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000062.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000063.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000064.title</title>
    <rule context="//cv:ContactPoint/cv:specialOpeningHoursSpecification">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0" />
      <assert test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000065.assert</assert>
      <report test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000066.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000067.title</title>
    <rule context="//cv:ContactPoint/cv:openingHours">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(time:TemporalEntity) = 1 or count((//time:TemporalEntity)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000068.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000069.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000070.title</title>
    <rule context="//cv:ContactPoint/cv:openingHours">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0" />
      <assert test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000071.assert</assert>
      <report test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000072.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000073.title</title>
    <rule context="//cv:ContactPoint/cv:telephone">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000074.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000075.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000076.title</title>
    <rule context="//cv:ContactPoint/cv:contactPage">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000077.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000078.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000079.title</title>
    <rule context="//cv:ContactPoint/cv:email">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000080.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000081.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000082.title</title>
    <rule context="//dcat:Catalog/dct:language">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000083.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000084.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000085.title</title>
    <rule context="//vcard:Kind/vcard:hasEmail">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000086.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000087.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000088.title</title>
    <rule context="//vcard:Kind/vcard:hasURL">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000089.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000090.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000091.title</title>
    <rule context="//csvw:Table/csvw:column">
      <let name="resource" value="@rdf:resource" />
      <let name="validClass" value="count(csvw:Column) = 1 or count((//csvw:Column)[@rdf:about = $resource]) = 1" />
      <assert test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000092.assert</assert>
      <report test="$validClass">$loc/strings/healthdcat-ap-300-restricted.000093.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000094.title</title>
    <rule context="//dcat:DatasetSeries/dcatap:applicableLegislation">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000095.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000096.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000097.title</title>
    <rule context="//dcat:Distribution/dcatap:availability">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000098.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000099.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000100.title</title>
    <rule context="//dcat:Distribution/adms:status">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000101.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000102.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000103.title</title>
    <rule context="//dcat:Distribution/dct:language">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000104.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000105.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000106.title</title>
    <rule context="//dcat:Distribution/dct:format">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000107.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000108.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000109.title</title>
    <rule context="//time:TemporalEntity/cv:frequency">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000110.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000111.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000112.title</title>
    <rule context="//dcat:Dataset/prov:wasGeneratedBy">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0" />
      <assert test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000113.assert</assert>
      <report test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000114.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000115.title</title>
    <rule context="//dcat:Dataset/healthdcatap:healthTheme">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000116.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000117.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000118.title</title>
    <rule context="//dcat:Dataset/dct:conformsTo">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000119.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000120.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000121.title</title>
    <rule context="//dcat:Dataset/healthdcatap:hasCodingSystem">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000122.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000123.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000124.title</title>
    <rule context="//dcat:Dataset/healthdcatap:healthCategory">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000125.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000126.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000127.title</title>
    <rule context="//dcat:Dataset/dct:accessRights">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000128.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000129.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000130.title</title>
    <rule context="//dcat:Dataset">
      <let name="hasValue" value="dcat:theme/skos:Concept/@rdf:about='http://publications.europa.eu/resource/authority/data-theme/HEAL'" />
      <assert test="$hasValue">$loc/strings/healthdcat-ap-300-restricted.000131.assert</assert>
      <report test="$hasValue">$loc/strings/healthdcat-ap-300-restricted.000132.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000133.title</title>
    <rule context="//dcat:Dataset/dcat:theme">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000134.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000135.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000136.title</title>
    <rule context="//dcat:Dataset/dct:language">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000137.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000138.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000139.title</title>
    <rule context="//dcat:Dataset/dct:accrualPeriodicity">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000140.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000141.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000142.title</title>
    <rule context="//dcat:Distribution/dcatap:applicableLegislation">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000143.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000144.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000145.title</title>
    <rule context="//csvw:Column/csvw:propertyUrl">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000146.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000147.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000148.title</title>
    <rule context="//csvw:Column/csvw:datatype">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000149.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000150.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000151.title</title>
    <rule context="//csvw:Column/csvw:titles">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000152.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000153.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000154.title</title>
    <rule context="//csvw:Column/dct:description">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000155.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000156.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000157.title</title>
    <rule context="//csvw:Column/csvw:name">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000158.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000159.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000160.title</title>
    <rule context="//dcat:Dataset/dct:alternative">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000161.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000162.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000163.title</title>
    <rule context="//dcat:Dataset/healthdcatap:populationCoverage">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000164.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000165.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000166.title</title>
    <rule context="//dcat:Dataset/healthdcatap:numberOfUniqueIndividuals">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <let name="castTest" value="normalize-space(.) castable as xs:integer" />
      <assert test="$isLiteral and $castTest">$loc/strings/healthdcat-ap-300-restricted.000167.assert</assert>
      <report test="$isLiteral and $castTest">$loc/strings/healthdcat-ap-300-restricted.000168.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000169.title</title>
    <rule context="//dcat:Dataset/healthdcatap:numberOfRecords">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <let name="castTest" value="normalize-space(.) castable as xs:integer" />
      <assert test="$isLiteral and $castTest">$loc/strings/healthdcat-ap-300-restricted.000170.assert</assert>
      <report test="$isLiteral and $castTest">$loc/strings/healthdcat-ap-300-restricted.000171.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000172.title</title>
    <rule context="//dcat:Dataset/healthdcatap:maxTypicalAge">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <let name="castTest" value="normalize-space(.) castable as xs:integer" />
      <assert test="$isLiteral and $castTest">$loc/strings/healthdcat-ap-300-restricted.000173.assert</assert>
      <report test="$isLiteral and $castTest">$loc/strings/healthdcat-ap-300-restricted.000174.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000175.title</title>
    <rule context="//dcat:Dataset/healthdcatap:minTypicalAge">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <let name="castTest" value="normalize-space(.) castable as xs:integer" />
      <assert test="$isLiteral and $castTest">$loc/strings/healthdcat-ap-300-restricted.000176.assert</assert>
      <report test="$isLiteral and $castTest">$loc/strings/healthdcat-ap-300-restricted.000177.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000178.title</title>
    <rule context="//dcat:Dataset/healthdcatap:hasCodingSystem">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0" />
      <assert test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000179.assert</assert>
      <report test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000180.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000181.title</title>
    <rule context="//dcat:Dataset/healthdcatap:hasCodeValues">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000182.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000183.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000184.title</title>
    <rule context="//dcat:Dataset/healthdcatap:hasStructuredData">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <let name="castTest" value="normalize-space(.) castable as xs:boolean" />
      <assert test="$isLiteral and $castTest">$loc/strings/healthdcat-ap-300-restricted.000185.assert</assert>
      <report test="$isLiteral and $castTest">$loc/strings/healthdcat-ap-300-restricted.000186.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000187.title</title>
    <rule context="//dcat:Dataset/healthdcatap:healthTheme">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0" />
      <assert test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000188.assert</assert>
      <report test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000189.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000190.title</title>
    <rule context="//dcat:Dataset">
      <let name="hasValue" value="dct:accessRights/skos:Concept/@rdf:about='http://publications.europa.eu/resource/authority/access-right/RESTRICTED'" />
      <assert test="$hasValue">$loc/strings/healthdcat-ap-300-restricted.000191.assert</assert>
      <report test="$hasValue">$loc/strings/healthdcat-ap-300-restricted.000192.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000193.title</title>
    <rule context="//dcat:Dataset/dcatap:applicableLegislation">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000194.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000195.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000196.title</title>
    <rule context="//dcat:Dataset/dct:identifier">
      <let name="isLiteral" value="normalize-space(.) != ''" />
      <assert test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000197.assert</assert>
      <report test="$isLiteral">$loc/strings/healthdcat-ap-300-restricted.000198.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000199.title</title>
    <rule context="//dcat:Dataset/dct:publisher">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0" />
      <assert test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000200.assert</assert>
      <report test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000201.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000202.title</title>
    <rule context="//dcat:Dataset/dcat:theme">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000203.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000204.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000205.title</title>
    <rule context="//dcat:Dataset/dpv:hasPurpose">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0" />
      <assert test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000206.assert</assert>
      <report test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000207.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000208.title</title>
    <rule context="//dcat:Dataset/healthdcatap:hdab">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0" />
      <assert test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000209.assert</assert>
      <report test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000210.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000211.title</title>
    <rule context="//dcat:Dataset/geodcatap:custodian">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <let name="isBlankNode" value="count(@rdf:resource) = 0 and count(@rdf:about) = 0" />
      <assert test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000212.assert</assert>
      <report test="$isIRI or $isBlankNode">$loc/strings/healthdcat-ap-300-restricted.000213.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000214.title</title>
    <rule context="//dcat:Dataset/healthdcatap:healthCategory">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000215.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000216.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000217.title</title>
    <rule context="//spdx:Checksum/spdx:algorithm">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000218.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000219.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000220.title</title>
    <rule context="//dcat:Catalog/dcatap:applicableLegislation">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000221.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000222.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000223.title</title>
    <rule context="//dcat:DataService/dct:format">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000224.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000225.report</report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted.000226.title</title>
    <rule context="//dcat:DataService/dct:accessRights">
      <let name="resource" value="(@rdf:resource, */@rdf:about)[1]" />
      <let name="isIRI" value="matches($resource, '^[a-zA-Z][a-zA-Z0-9.+-]*://.*$')" />
      <assert test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000227.assert</assert>
      <report test="$isIRI">$loc/strings/healthdcat-ap-300-restricted.000228.report</report>
    </rule>
  </pattern>
</schema>
