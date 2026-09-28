<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
  <title>{$loc/strings/healthdcat-ap-300-restricted-cardinalities.000000.schematron}</title>
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
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000001.title</title>
    <rule context="//time:TemporalEntity">
      <assert test="count(dct:description) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000002.assert, ('#occurrences'), (string(count(dct:description))))" />
      </assert>
      <report test="count(dct:description) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000003.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000004.title</title>
    <rule context="//csvw:Table">
      <assert test="count(csvw:column) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000005.assert, ('#occurrences'), (string(count(csvw:column))))" />
      </assert>
      <report test="count(csvw:column) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000006.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000007.title</title>
    <rule context="//csvw:Table">
      <assert test="count(dct:title) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000008.assert, ('#occurrences'), (string(count(dct:title))))" />
      </assert>
      <report test="count(dct:title) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000009.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000010.title</title>
    <rule context="//csvw:Table">
      <assert test="count(csvw:url) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000011.assert, ('#occurrences'), (string(count(csvw:url))))" />
      </assert>
      <report test="count(csvw:url) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000012.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000013.title</title>
    <rule context="//cv:ContactPoint">
      <assert test="count(cv:email|cv:contactPage) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000014.assert, ('#occurrences'), (string(count(cv:email|cv:contactPage))))" />
      </assert>
      <report test="count(cv:email|cv:contactPage) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000015.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000016.title</title>
    <rule context="//vcard:Kind">
      <assert test="count(vcard:hasURL|vcard:hasEmail) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000017.assert, ('#occurrences'), (string(count(vcard:hasURL|vcard:hasEmail))))" />
      </assert>
      <report test="count(vcard:hasURL|vcard:hasEmail) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000018.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000019.title</title>
    <rule context="//vcard:Kind">
      <assert test="count(vcard:hasEmail) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000020.assert, ('#occurrences'), (string(count(vcard:hasEmail))))" />
      </assert>
      <report test="count(vcard:hasEmail) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000021.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000022.title</title>
    <rule context="//vcard:Kind">
      <assert test="count(vcard:hasURL) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000023.assert, ('#occurrences'), (string(count(vcard:hasURL))))" />
      </assert>
      <report test="count(vcard:hasURL) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000024.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000025.title</title>
    <rule context="//dcat:DatasetSeries">
      <assert test="count(dcatap:applicableLegislation) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000026.assert, ('#occurrences'), (string(count(dcatap:applicableLegislation))))" />
      </assert>
      <report test="count(dcatap:applicableLegislation) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000027.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000028.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dcat:theme) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000029.assert, ('#occurrences'), (string(count(dcat:theme))))" />
      </assert>
      <report test="count(dcat:theme) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000030.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000031.title</title>
    <rule context="//dcat:Distribution">
      <assert test="count(dcatap:applicableLegislation) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000032.assert, ('#occurrences'), (string(count(dcatap:applicableLegislation))))" />
      </assert>
      <report test="count(dcatap:applicableLegislation) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000033.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000034.title</title>
    <rule context="//csvw:Column">
      <assert test="count(csvw:propertyUrl) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000035.assert, ('#occurrences'), (string(count(csvw:propertyUrl))))" />
      </assert>
      <report test="count(csvw:propertyUrl) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000036.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000037.title</title>
    <rule context="//csvw:Column">
      <assert test="count(csvw:datatype) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000038.assert, ('#occurrences'), (string(count(csvw:datatype))))" />
      </assert>
      <report test="count(csvw:datatype) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000039.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000040.title</title>
    <rule context="//csvw:Column">
      <assert test="count(csvw:datatype) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000041.assert, ('#occurrences'), (string(count(csvw:datatype))))" />
      </assert>
      <report test="count(csvw:datatype) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000042.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000043.title</title>
    <rule context="//csvw:Column">
      <assert test="count(csvw:titles) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000044.assert, ('#occurrences'), (string(count(csvw:titles))))" />
      </assert>
      <report test="count(csvw:titles) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000045.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000046.title</title>
    <rule context="//csvw:Column">
      <assert test="count(dct:description) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000047.assert, ('#occurrences'), (string(count(dct:description))))" />
      </assert>
      <report test="count(dct:description) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000048.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000049.title</title>
    <rule context="//csvw:Column">
      <assert test="count(csvw:name) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000050.assert, ('#occurrences'), (string(count(csvw:name))))" />
      </assert>
      <report test="count(csvw:name) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000051.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000052.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:retentionPeriod) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000053.assert, ('#occurrences'), (string(count(healthdcatap:retentionPeriod))))" />
      </assert>
      <report test="count(healthdcatap:retentionPeriod) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000054.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000055.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:numberOfUniqueIndividuals) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000056.assert, ('#occurrences'), (string(count(healthdcatap:numberOfUniqueIndividuals))))" />
      </assert>
      <report test="count(healthdcatap:numberOfUniqueIndividuals) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000057.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000058.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:numberOfRecords) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000059.assert, ('#occurrences'), (string(count(healthdcatap:numberOfRecords))))" />
      </assert>
      <report test="count(healthdcatap:numberOfRecords) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000060.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000061.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:maxTypicalAge) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000062.assert, ('#occurrences'), (string(count(healthdcatap:maxTypicalAge))))" />
      </assert>
      <report test="count(healthdcatap:maxTypicalAge) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000063.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000064.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:minTypicalAge) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000065.assert, ('#occurrences'), (string(count(healthdcatap:minTypicalAge))))" />
      </assert>
      <report test="count(healthdcatap:minTypicalAge) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000066.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000067.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:hasStructuredData) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000068.assert, ('#occurrences'), (string(count(healthdcatap:hasStructuredData))))" />
      </assert>
      <report test="count(healthdcatap:hasStructuredData) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000069.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000070.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:hasStructuredData) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000071.assert, ('#occurrences'), (string(count(healthdcatap:hasStructuredData))))" />
      </assert>
      <report test="count(healthdcatap:hasStructuredData) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000072.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000073.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dct:accessRights) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000074.assert, ('#occurrences'), (string(count(dct:accessRights))))" />
      </assert>
      <report test="count(dct:accessRights) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000075.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000076.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dct:accessRights) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000077.assert, ('#occurrences'), (string(count(dct:accessRights))))" />
      </assert>
      <report test="count(dct:accessRights) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000078.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000079.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dcatap:applicableLegislation) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000080.assert, ('#occurrences'), (string(count(dcatap:applicableLegislation))))" />
      </assert>
      <report test="count(dcatap:applicableLegislation) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000081.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000082.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dcat:distribution) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000083.assert, ('#occurrences'), (string(count(dcat:distribution))))" />
      </assert>
      <report test="count(dcat:distribution) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000084.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000085.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dct:identifier) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000086.assert, ('#occurrences'), (string(count(dct:identifier))))" />
      </assert>
      <report test="count(dct:identifier) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000087.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000088.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dct:publisher) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000089.assert, ('#occurrences'), (string(count(dct:publisher))))" />
      </assert>
      <report test="count(dct:publisher) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000090.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000091.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(dcat:theme) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000092.assert, ('#occurrences'), (string(count(dcat:theme))))" />
      </assert>
      <report test="count(dcat:theme) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000093.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000094.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:hdab) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000095.assert, ('#occurrences'), (string(count(healthdcatap:hdab))))" />
      </assert>
      <report test="count(healthdcatap:hdab) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000096.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000097.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:hdab) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000098.assert, ('#occurrences'), (string(count(healthdcatap:hdab))))" />
      </assert>
      <report test="count(healthdcatap:hdab) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000099.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000100.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(geodcatap:custodian) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000101.assert, ('#occurrences'), (string(count(geodcatap:custodian))))" />
      </assert>
      <report test="count(geodcatap:custodian) &lt;= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000102.report, ('#max'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000103.title</title>
    <rule context="//dcat:Dataset">
      <assert test="count(healthdcatap:healthCategory) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000104.assert, ('#occurrences'), (string(count(healthdcatap:healthCategory))))" />
      </assert>
      <report test="count(healthdcatap:healthCategory) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000105.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000106.title</title>
    <rule context="//csvw:TableGroup">
      <assert test="count(csvw:table) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000107.assert, ('#occurrences'), (string(count(csvw:table))))" />
      </assert>
      <report test="count(csvw:table) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000108.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
  <pattern>
    <title>$loc/strings/healthdcat-ap-300-restricted-cardinalities.000109.title</title>
    <rule context="//dcat:Catalog">
      <assert test="count(dcatap:applicableLegislation) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000110.assert, ('#occurrences'), (string(count(dcatap:applicableLegislation))))" />
      </assert>
      <report test="count(dcatap:applicableLegislation) >= 1">
        <value-of select="geonet:replacePlaceholders($loc/strings/healthdcat-ap-300-restricted-cardinalities.000111.report, ('#min'), '1')" />
      </report>
    </rule>
  </pattern>
</schema>
