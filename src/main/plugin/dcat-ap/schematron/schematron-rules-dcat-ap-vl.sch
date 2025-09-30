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
  <sch:ns prefix="skos" uri="http://www.w3.org/2004/02/skos/core#"/>
  <sch:ns prefix="xml" uri="http://www.w3.org/XML/1998/namespace"/>
  <sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
  <sch:ns prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
  <sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>
  <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
  <sch:ns prefix="mdcat" uri="https://data.vlaanderen.be/ns/metadata-dcat#"/>
  <sch:ns prefix="geodcat" uri="http://data.europa.eu/930/"/>
  <sch:ns prefix="generiek" uri="https://data.vlaanderen.be/ns/generiek#"/>
  <sch:ns prefix="rdfs" uri="http://www.w3.org/2000/01/rdf-schema#"/>
  <sch:title xmlns="http://www.w3.org/2001/XMLSchema">{$loc/strings/schematron.title}</sch:title>
  <sch:let name="profile" value="boolean(/*[starts-with(//dcat:CatalogRecord//dct:Standard/@rdf:about, 'https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL')])"/>
  <sch:pattern>
    <sch:title>$loc/strings/pattern.title.1</sch:title>
    <sch:rule context="//vcard:hasEmail[$profile]">
      <sch:let name="mailto" value="starts-with(@rdf:resource,'mailto:')"/>
      <sch:assert test="$mailto = true()">$loc/strings/pattern.assert.1</sch:assert>
      <sch:report test="$mailto = true()">$loc/strings/pattern.report.1</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>$loc/strings/pattern.title.2</sch:title>
    <sch:rule context="//dcat:Catalog/dct:license[$profile]">
      <sch:let name="cc0" value="./@rdf:resource = 'https://data.vlaanderen.be/id/licentie/creative-commons-zero-verklaring/v1.0' or ./dct:LicenseDocument/@rdf:about = 'https://data.vlaanderen.be/id/licentie/creative-commons-zero-verklaring/v1.0'"/>
      <sch:assert test="$cc0 = true()">$loc/strings/pattern.assert.2</sch:assert>
      <sch:report test="$cc0 = true()">$loc/strings/pattern.report.2</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>$loc/strings/pattern.title.3</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accessRights[$profile]|//dcat:DataService/dct:accessRights[$profile]">
      <sch:let name="public" value="*/@rdf:about = 'http://publications.europa.eu/resource/authority/access-right/PUBLIC' or ./@rdf:resource = 'http://publications.europa.eu/resource/authority/access-right/PUBLIC'"/>
      <sch:assert test="$public = true()">$loc/strings/pattern.assert.3</sch:assert>
      <sch:report test="$public = true()">$loc/strings/pattern.report.3</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>$loc/strings/pattern.title.4</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]|//dcat:DataService[$profile]">
      <sch:let name="hasKeyword" value="count(dcat:keyword[normalize-space(.) != '']) &gt; 0"/>
      <sch:assert test="$hasKeyword">$loc/strings/pattern.assert.4</sch:assert>
      <sch:report test="$hasKeyword">$loc/strings/pattern.report.4</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>$loc/strings/pattern.title.5</sch:title>
    <sch:rule context="//dcat:contactPoint[$profile]">
      <sch:let name="hasEmail" value="normalize-space(vcard:Organization/vcard:hasEmail/@rdf:resource) != ''"/>
      <sch:let name="hasUrl" value="normalize-space(vcard:Organization/vcard:hasURL/@rdf:resource) != ''"/>
      <sch:assert test="$hasEmail or $hasUrl">$loc/strings/pattern.assert.5</sch:assert>
      <sch:report test="$hasEmail or $hasUrl">$loc/strings/pattern.report.5</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="naam" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#AgentShape/1399bd400d4637b15d5fe38202d6572f82150aac">
    <sch:title>$loc/strings/pattern.title.6</sch:title>
    <sch:rule context="//foaf:Agent/foaf:name[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/pattern.assert.6</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/pattern.report.6</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="naam" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#AgentShape/b96a7391d2808d207ce4e3c269dec2c6efad55c3">
    <sch:title>$loc/strings/pattern.title.7</sch:title>
    <sch:rule context="//foaf:Agent/foaf:name[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::foaf:name[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">$loc/strings/pattern.assert.7</sch:assert>
      <sch:report test="$isUniqueLang">$loc/strings/pattern.report.7</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="naam" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#AgentShape/e9d8e42e8041e72c4534134d5a9044b03bed7ec5">
    <sch:title>$loc/strings/pattern.title.8</sch:title>
    <sch:rule context="//foaf:Agent[$profile]">
      <sch:let name="validMin" value="count(foaf:name) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.8</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.8</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactpagina" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#ContactinfoShape/0d43849949c290efe2f3d4ad1d010cdb7f0505bf">
    <sch:title>$loc/strings/pattern.title.9</sch:title>
    <sch:rule context="//vcard:Organization/foaf:page[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">$loc/strings/pattern.assert.9</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">$loc/strings/pattern.report.9</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactpagina" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#ContactinfoShape/376ba2894840068d71059e7be03bfaf8995aee90">
    <sch:title>$loc/strings/pattern.title.10</sch:title>
    <sch:rule context="//vcard:Organization[$profile]">
      <sch:let name="validMax" value="count(foaf:page) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.10</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.10</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="e-mail" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#ContactinfoShape/2cf221c2b6f9a619b0515c507ddd2bbb40fbb285">
    <sch:title>$loc/strings/pattern.title.11</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasEmail[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">$loc/strings/pattern.assert.11</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">$loc/strings/pattern.report.11</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="e-mail" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#ContactinfoShape/42ad698554950cda0098f1f04803fac8470af8ad">
    <sch:title>$loc/strings/pattern.title.12</sch:title>
    <sch:rule context="//vcard:Organization[$profile]">
      <sch:let name="validMax" value="count(vcard:hasEmail) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.12</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.12</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="aanmaakdatum" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/73a4bdd8cd7b0472b3b38dc9f56b0f32b8239284">
    <sch:title>$loc/strings/pattern.title.13</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/pattern.assert.13</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/pattern.report.13</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="aanmaakdatum" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/8172f8df2a73384c65fdb3332d8ee0c9ef574804">
    <sch:title>$loc/strings/pattern.title.14</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(dct:issued) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.14</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.14</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>$loc/strings/pattern.title.15</sch:title>
    <sch:rule context="//dcat:CatalogRecord/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.15</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.15</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="hoofdonderwerp" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/2a7abc3b7d6df32e4a340775a9e1522a0ac1c669">
    <sch:title>$loc/strings/pattern.title.16</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(foaf:primaryTopic) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.16</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.16</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="hoofdonderwerp" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/e7d5497a1597fc6c5856517ab46c01bae413001b">
    <sch:title>$loc/strings/pattern.title.17</sch:title>
    <sch:rule context="//dcat:CatalogRecord/foaf:primaryTopic[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Dataset|dcat:DataService) = 1 or count((//dcat:Dataset|//dcat:DataService)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.17</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.17</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="hoofdonderwerp" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/f806d2d1fd264df77aee55564a0a70eecd47ee2e">
    <sch:title>$loc/strings/pattern.title.18</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMin" value="count(foaf:primaryTopic) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.18</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.18</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/05134c4e7c34157d6f7ac1128713a08418e0fe7d">
    <sch:title>$loc/strings/pattern.title.19</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/pattern.assert.19</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/pattern.report.19</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:title>$loc/strings/pattern.title.20</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMin" value="count(dct:identifier) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.20</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.20</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:title>$loc/strings/pattern.title.21</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(dct:identifier) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.21</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.21</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/5c245f65e6c2294cd7079eb566de6fd4e4adb829">
    <sch:title>$loc/strings/pattern.title.22</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(dct:title) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.22</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.22</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>$loc/strings/pattern.title.23</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">$loc/strings/pattern.assert.23</sch:assert>
      <sch:report test="$isUniqueLang">$loc/strings/pattern.report.23</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>$loc/strings/pattern.title.24</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/pattern.assert.24</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/pattern.report.24</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/29906bf16cadf6d568c4da3e161ef38ba2f726fd">
    <sch:title>$loc/strings/pattern.title.25</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(dct:modified) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.25</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.25</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/6a51b2354ea38a815d6131b4e05f8587791de4e0">
    <sch:title>$loc/strings/pattern.title.26</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMin" value="count(dct:modified) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.26</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.26</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusRecordShape/9e7585433d0896bc44cb41cdd8189793bd115cd0">
    <sch:title>$loc/strings/pattern.title.27</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:modified[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">$loc/strings/pattern.assert.27</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">$loc/strings/pattern.report.27</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>$loc/strings/pattern.title.28</sch:title>
    <sch:rule context="//dcat:DataService/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.28</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.28</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>$loc/strings/pattern.title.29</sch:title>
    <sch:rule context="//dcat:DataService/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/pattern.assert.29</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/pattern.report.29</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/4a16176c26d8d5526c76974a1530f1ffdd596e93">
    <sch:title>$loc/strings/pattern.title.30</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:description) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.30</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.30</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/da05d674f29a225a7115411e9f7ca442a25f2c88">
    <sch:title>$loc/strings/pattern.title.31</sch:title>
    <sch:rule context="//dcat:DataService/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">$loc/strings/pattern.assert.31</sch:assert>
      <sch:report test="$isUniqueLang">$loc/strings/pattern.report.31</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="biedt informatie aan over" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/5ed2c890f2c7588313cc9f93b35524bdb2d6328d">
    <sch:title>$loc/strings/pattern.title.32</sch:title>
    <sch:rule context="//dcat:DataService/dcat:servesdataset[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.32</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.32</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform aan protocol" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/80a839685f13d2584ebe2f9b5d9a93ae2c1b21a0">
    <sch:title>$loc/strings/pattern.title.33</sch:title>
    <sch:rule context="//dcat:DataService/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.33</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.33</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/19ee039173472235e539aea2aa961ff7d3b89f5a">
    <sch:title>$loc/strings/pattern.title.34</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dcat:contactPoint) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.34</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.34</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/458062b0ae03c559426b85df3dd28e1c785acb0b">
    <sch:title>$loc/strings/pattern.title.35</sch:title>
    <sch:rule context="//dcat:DataService/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization) = 1 or count(//vcard:Organization[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.35</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.35</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/e332dbce5947de4314c3ed3fe5862f26d70a15c4">
    <sch:title>$loc/strings/pattern.title.36</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dcat:contactPoint) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.36</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.36</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointURL" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/67c89165b0f38567bf099862ffdef88f25e68714">
    <sch:title>$loc/strings/pattern.title.37</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointURL[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">$loc/strings/pattern.assert.37</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">$loc/strings/pattern.report.37</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointURL" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/9978564bd5823785ddace8934e848c68e6e813e3">
    <sch:title>$loc/strings/pattern.title.38</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dcat:endpointURL) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.38</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.38</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointURL" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/bc15a30c5a91fb01a98d4b0969c268df7f6ff717">
    <sch:title>$loc/strings/pattern.title.39</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dcat:endpointURL) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.39</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.39</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointbeschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/66883b2795f003760d4bb617bd1f472da1e1524f">
    <sch:title>$loc/strings/pattern.title.40</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dcat:endpointDescription) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.40</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.40</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointbeschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/bd44e3e6c4317f226cd1124fbaf1d72e94e8f15e">
    <sch:title>$loc/strings/pattern.title.41</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dcat:endpointDescription) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.41</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.41</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointbeschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/dbc2548616486a154002cfba6a3bc2cbc554a682">
    <sch:title>$loc/strings/pattern.title.42</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointDescription[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">$loc/strings/pattern.assert.42</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">$loc/strings/pattern.report.42</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/05134c4e7c34157d6f7ac1128713a08418e0fe7d">
    <sch:title>$loc/strings/pattern.title.43</sch:title>
    <sch:rule context="//dcat:DataService/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/pattern.assert.43</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/pattern.report.43</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:title>$loc/strings/pattern.title.44</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:identifier) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.44</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.44</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:title>$loc/strings/pattern.title.45</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:identifier) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.45</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.45</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/fe1a78c9169da2469a23fd783cf9a69060bfe198">
    <sch:title>$loc/strings/pattern.title.46</sch:title>
    <sch:rule context="//dcat:DataService/dcat:landingPage[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">$loc/strings/pattern.assert.46</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">$loc/strings/pattern.report.46</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor authenticatie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/2be8f764879c3f2218306704a430503d286c30e9">
    <sch:title>$loc/strings/pattern.title.47</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorAuthenticatie[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">$loc/strings/pattern.assert.47</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">$loc/strings/pattern.report.47</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor authenticatie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/e9bf439f5272396af4486645c4dd4ae47c27c030">
    <sch:title>$loc/strings/pattern.title.48</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:landingspaginaVoorAuthenticatie) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.48</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.48</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor gebruiksinformatie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/b643cb8952d752ef63a2b25c7fcebd89d08fb015">
    <sch:title>$loc/strings/pattern.title.49</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:landingspaginaVoorGebruiksinformatie) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.49</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.49</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor gebruiksinformatie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/c4eb7e771a95c6c3e5c04255458173a2b0b40f43">
    <sch:title>$loc/strings/pattern.title.50</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorGebruiksinformatie[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">$loc/strings/pattern.assert.50</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">$loc/strings/pattern.report.50</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor statusinformatie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/0cdcfe2387440711ebbe94a2fcc93a29377956c5">
    <sch:title>$loc/strings/pattern.title.51</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorStatusinformatie[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">$loc/strings/pattern.assert.51</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">$loc/strings/pattern.report.51</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor statusinformatie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/82e4f4e38a285ebeffb0f14c036b491b71a26200">
    <sch:title>$loc/strings/pattern.title.52</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:landingspaginaVoorStatusinformatie) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.52</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.52</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="levensfase" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/13afabc6c35a0042403bd3a9f50222200152231a">
    <sch:title>$loc/strings/pattern.title.53</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:levensfase[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.53</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.53</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="levensfase" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/8a32a3e6b5ca4b68f8846b184e7faa4f48a0ee1d">
    <sch:title>$loc/strings/pattern.title.54</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:levensfase) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.54</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.54</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/509740cc7b3c86ebee90dc6303c11c40e2b08212">
    <sch:title>$loc/strings/pattern.title.55</sch:title>
    <sch:rule context="//dcat:DataService/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.55</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.55</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/a42564b7be6f290f20410a7d087232aece0c058e">
    <sch:title>$loc/strings/pattern.title.56</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:license) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.56</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.56</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/cafd2e3e66044d8ba2c435a9353e6880952086c5">
    <sch:title>$loc/strings/pattern.title.57</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:license) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.57</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.57</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/4523d6e75f8993d15c9332b0aae5dbbe64a85b5a">
    <sch:title>$loc/strings/pattern.title.58</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:ontwikkelingstoestand[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.58</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.58</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/76f6cfca9a1964a539a879c911777c741a37cff0">
    <sch:title>$loc/strings/pattern.title.59</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:ontwikkelingstoestand) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.59</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.59</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rechten" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/62bb7a143add01ac0956709b58850f4f5e5a0e47">
    <sch:title>$loc/strings/pattern.title.60</sch:title>
    <sch:rule context="//dcat:DataService/dct:rights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.60</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.60</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/1712ef1b325d7d2807bc601d6409b70a42eaff10">
    <sch:title>$loc/strings/pattern.title.61</sch:title>
    <sch:rule context="//dcat:DataService/dcat:theme[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.61</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.61</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/25d18a6e2598024ea186cc7be4391bdfd1bca21f">
    <sch:title>$loc/strings/pattern.title.62</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:title) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.62</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.62</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/5c245f65e6c2294cd7079eb566de6fd4e4adb829">
    <sch:title>$loc/strings/pattern.title.63</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:title) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.63</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.63</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>$loc/strings/pattern.title.64</sch:title>
    <sch:rule context="//dcat:DataService/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">$loc/strings/pattern.assert.64</sch:assert>
      <sch:report test="$isUniqueLang">$loc/strings/pattern.report.64</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>$loc/strings/pattern.title.65</sch:title>
    <sch:rule context="//dcat:DataService/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/pattern.assert.65</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/pattern.report.65</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/7463895a2bb9e7e4c96cd9a2e7f83ce2cf787098">
    <sch:title>$loc/strings/pattern.title.66</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:accessRights) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.66</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.66</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/a81035a5dbbdae24651c34e5602a1fe6fe5427a3">
    <sch:title>$loc/strings/pattern.title.67</sch:title>
    <sch:rule context="//dcat:DataService/dct:accessRights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.67</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.67</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/f9524ba86e28981345a2b84aea788460ad4e805e">
    <sch:title>$loc/strings/pattern.title.68</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:accessRights) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.68</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.68</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/44f6426e2306c5bc0421823eb4a1a034b615f715">
    <sch:title>$loc/strings/pattern.title.69</sch:title>
    <sch:rule context="//dcat:DataService/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/pattern.assert.69</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/pattern.report.69</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/302090a90a5755780bc8fe09be4bcd29193cfd6d">
    <sch:title>$loc/strings/pattern.title.70</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(owl:versionInfo) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.70</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.70</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DataServiceShape/587f313308111b587d1bd2440a56622e64624864">
    <sch:title>$loc/strings/pattern.title.71</sch:title>
    <sch:rule context="//dcat:DataService/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/pattern.assert.71</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/pattern.report.71</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>$loc/strings/pattern.title.72</sch:title>
    <sch:rule context="//dcat:Dataset/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.72</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.72</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>$loc/strings/pattern.title.73</sch:title>
    <sch:rule context="//dcat:Dataset/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/pattern.assert.73</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/pattern.report.73</sch:report>
    </sch:rule>
  </sch:pattern>
  <!-- To fix in shacl>schematron conversion, should handle multilinguality and should perhaps be put in -rec file? -->
  <!--  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/4a16176c26d8d5526c76974a1530f1ffdd596e93">-->
  <!--    <sch:title>$loc/strings/pattern.title.74</sch:title>-->
  <!--    <sch:rule context="//dcat:Dataset[$profile]">-->
  <!--      <sch:let name="validMax" value="count(dct:description) &lt;= 1"/>-->
  <!--      <sch:assert test="$validMax">$loc/strings/pattern.assert.74</sch:assert>-->
  <!--      <sch:report test="$validMax">$loc/strings/pattern.report.74</sch:report>-->
  <!--    </sch:rule>-->
  <!--  </sch:pattern>-->
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/7521953addc62cf367ab3c8ec0dc63cb5981ea23">
    <sch:title>$loc/strings/pattern.title.75</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dct:description) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.75</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.75</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/da05d674f29a225a7115411e9f7ca442a25f2c88">
    <sch:title>$loc/strings/pattern.title.76</sch:title>
    <sch:rule context="//dcat:Dataset/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">$loc/strings/pattern.assert.76</sch:assert>
      <sch:report test="$isUniqueLang">$loc/strings/pattern.report.76</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/dd5cf5b162b3f92600a391f44660bf2b255693ac">
    <sch:title>$loc/strings/pattern.title.77</sch:title>
    <sch:rule context="//dcat:Dataset/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.77</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.77</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/19ee039173472235e539aea2aa961ff7d3b89f5a">
    <sch:title>$loc/strings/pattern.title.78</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dcat:contactPoint) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.78</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.78</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/458062b0ae03c559426b85df3dd28e1c785acb0b">
    <sch:title>$loc/strings/pattern.title.79</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization) = 1 or count(//vcard:Organization[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.79</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.79</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/e332dbce5947de4314c3ed3fe5862f26d70a15c4">
    <sch:title>$loc/strings/pattern.title.80</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dcat:contactPoint) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.80</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.80</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="distributie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/cfbe0a11423fe15e990c3cbd5209404c26dbef0f">
    <sch:title>$loc/strings/pattern.title.81</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:distribution[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Distribution) = 1 or count(//dcat:Distribution[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.81</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.81</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/05134c4e7c34157d6f7ac1128713a08418e0fe7d">
    <sch:title>$loc/strings/pattern.title.82</sch:title>
    <sch:rule context="//dcat:Dataset/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/pattern.assert.82</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/pattern.report.82</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:title>$loc/strings/pattern.title.83</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dct:identifier) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.83</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.83</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:title>$loc/strings/pattern.title.84</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dct:identifier) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.84</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.84</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/fe1a78c9169da2469a23fd783cf9a69060bfe198">
    <sch:title>$loc/strings/pattern.title.85</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:landingPage[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">$loc/strings/pattern.assert.85</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">$loc/strings/pattern.report.85</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/1712ef1b325d7d2807bc601d6409b70a42eaff10">
    <sch:title>$loc/strings/pattern.title.86</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:theme[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.86</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.86</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/25d18a6e2598024ea186cc7be4391bdfd1bca21f">
    <sch:title>$loc/strings/pattern.title.87</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dct:title) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.87</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.87</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>$loc/strings/pattern.title.88</sch:title>
    <sch:rule context="//dcat:Dataset/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">$loc/strings/pattern.assert.88</sch:assert>
      <sch:report test="$isUniqueLang">$loc/strings/pattern.report.88</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>$loc/strings/pattern.title.89</sch:title>
    <sch:rule context="//dcat:Dataset/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/pattern.assert.89</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/pattern.report.89</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/7463895a2bb9e7e4c96cd9a2e7f83ce2cf787098">
    <sch:title>$loc/strings/pattern.title.90</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dct:accessRights) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.90</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.90</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/a81035a5dbbdae24651c34e5602a1fe6fe5427a3">
    <sch:title>$loc/strings/pattern.title.91</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accessRights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.91</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.91</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/f9524ba86e28981345a2b84aea788460ad4e805e">
    <sch:title>$loc/strings/pattern.title.92</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dct:accessRights) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.92</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.92</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/44f6426e2306c5bc0421823eb4a1a034b615f715">
    <sch:title>$loc/strings/pattern.title.93</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/pattern.assert.93</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/pattern.report.93</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/302090a90a5755780bc8fe09be4bcd29193cfd6d">
    <sch:title>$loc/strings/pattern.title.94</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(owl:versionInfo) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.94</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.94</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DatasetShape/587f313308111b587d1bd2440a56622e64624864">
    <sch:title>$loc/strings/pattern.title.95</sch:title>
    <sch:rule context="//dcat:Dataset/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/pattern.assert.95</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/pattern.report.95</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>$loc/strings/pattern.title.96</sch:title>
    <sch:rule context="//dcat:Distribution/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.96</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.96</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/0e61107f343f202ee672ef465cfcdbbcd746e21d">
    <sch:title>$loc/strings/pattern.title.97</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:downloadURL[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">$loc/strings/pattern.assert.97</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">$loc/strings/pattern.report.97</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/1ff94e5c0d35c7d1a7f2c4bd160a8c8e4eee6f97">
    <sch:title>$loc/strings/pattern.title.98</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dcat:downloadURL) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.98</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.98</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/05134c4e7c34157d6f7ac1128713a08418e0fe7d">
    <sch:title>$loc/strings/pattern.title.99</sch:title>
    <sch:rule context="//dcat:Distribution/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">$loc/strings/pattern.assert.99</sch:assert>
      <sch:report test="$isLiteral">$loc/strings/pattern.report.99</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:title>$loc/strings/pattern.title.100</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMin" value="count(dct:identifier) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.100</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.100</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:title>$loc/strings/pattern.title.101</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dct:identifier) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.101</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.101</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/509740cc7b3c86ebee90dc6303c11c40e2b08212">
    <sch:title>$loc/strings/pattern.title.102</sch:title>
    <sch:rule context="//dcat:Distribution/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.102</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.102</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/cafd2e3e66044d8ba2c435a9353e6880952086c5">
    <sch:title>$loc/strings/pattern.title.103</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dct:license) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.103</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.103</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rechten" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/62bb7a143add01ac0956709b58850f4f5e5a0e47">
    <sch:title>$loc/strings/pattern.title.104</sch:title>
    <sch:rule context="//dcat:Distribution/dct:rights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.104</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.104</sch:report>
    </sch:rule>
  </sch:pattern>
  <!-- To fix in shacl>schematron conversion, should handle multilinguality and should perhaps be put in -rec file? -->
  <!--  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/5c245f65e6c2294cd7079eb566de6fd4e4adb829">-->
  <!--    <sch:title>$loc/strings/pattern.title.105</sch:title>-->
  <!--    <sch:rule context="//dcat:Distribution[$profile]">-->
  <!--      <sch:let name="validMax" value="count(dct:title) &lt;= 1"/>-->
  <!--      <sch:assert test="$validMax">$loc/strings/pattern.assert.105</sch:assert>-->
  <!--      <sch:report test="$validMax">$loc/strings/pattern.report.105</sch:report>-->
  <!--    </sch:rule>-->
  <!--  </sch:pattern>-->
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>$loc/strings/pattern.title.106</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">$loc/strings/pattern.assert.106</sch:assert>
      <sch:report test="$isUniqueLang">$loc/strings/pattern.report.106</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>$loc/strings/pattern.title.107</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/pattern.assert.107</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/pattern.report.107</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegangsURL" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/28a9b5a610271b2ad2cd6917763075560213ca20">
    <sch:title>$loc/strings/pattern.title.108</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dcat:accessURL) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.108</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.108</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegangsURL" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/3d0e850677d211050dd9e93ec6496e6af9908da6">
    <sch:title>$loc/strings/pattern.title.109</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessURL[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">$loc/strings/pattern.assert.109</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">$loc/strings/pattern.report.109</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegangsURL" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/bf4475984ce7d0eb4bade6e749e672a8efa7dd2d">
    <sch:title>$loc/strings/pattern.title.110</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMin" value="count(dcat:accessURL) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.110</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.110</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wordt aangeboden door" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#DistributieShape/c612c1f62d45c84405f45260ab0737a10f5b0a18">
    <sch:title>$loc/strings/pattern.title.111</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessService[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.111</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.111</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusResourceShape/2ea1d293b25f05ec202dd2dcf8924e8518262c91">
    <sch:title>$loc/strings/pattern.title.112</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]|//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(mdcat:statuut) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.112</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.112</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusResourceShape/f96c5f798f9e9c00220a293bd11f37e83616d33b">
    <sch:title>$loc/strings/pattern.title.113</sch:title>
    <sch:rule context="//dcat:Dataset/mdcat:statuut[$profile]|//dcat:DataService/mdcat:statuut[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.113</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.113</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusResourceShape/5334cf8edf5cc07e349524728fe4c9b076e4c45e">
    <sch:title>$loc/strings/pattern.title.114</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]|//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:publisher) &lt;= 1"/>
      <sch:assert test="$validMax">$loc/strings/pattern.assert.114</sch:assert>
      <sch:report test="$validMax">$loc/strings/pattern.report.114</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusResourceShape/aabe67e6a56c5e2fc5695716e8f7b66edd525085">
    <sch:title>$loc/strings/pattern.title.115</sch:title>
    <sch:rule context="//dcat:Dataset/dct:publisher[$profile]|//dcat:DataService/dct:publisher[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent) = 1 or count(//foaf:Agent[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">$loc/strings/pattern.assert.115</sch:assert>
      <sch:report test="$validClass">$loc/strings/pattern.report.115</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#CatalogusResourceShape/e2d4034a0a398701f4257641ebcbc85e8683b29d">
    <sch:title>$loc/strings/pattern.title.116</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]|//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:publisher) &gt;= 1"/>
      <sch:assert test="$validMin">$loc/strings/pattern.assert.116</sch:assert>
      <sch:report test="$validMin">$loc/strings/pattern.report.116</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#UsageNoteDistributieShape/1">
    <sch:title>$loc/strings/pattern.title.117</sch:title>
    <sch:rule context="//dcat:Distribution/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">$loc/strings/pattern.assert.117</sch:assert>
      <sch:report test="$isLiteral and $hasLang">$loc/strings/pattern.report.117</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/DCAT-AP-VL#UsageNoteDistributieShape/4">
    <sch:title>$loc/strings/pattern.title.118</sch:title>
    <sch:rule context="//dcat:Distribution/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">$loc/strings/pattern.assert.118</sch:assert>
      <sch:report test="$isUniqueLang">$loc/strings/pattern.report.118</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>
