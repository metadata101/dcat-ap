<?xml version="1.0" encoding="utf-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
  <sch:title xmlns="http://www.w3.org/2001/XMLSchema">{$loc/strings/schematron.title}</sch:title>
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
  <sch:ns prefix="mdcat" uri="http://data.vlaanderen.be/ns/metadata-dcat#"/>
  <sch:let name="profile" value="boolean(/*[starts-with(//dcat:CatalogRecord//dct:Standard/@rdf:about, 'https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat')])"/>
  <sch:pattern>
    <sch:title>vcard:hasEmail is a URI with the mailto protocol.</sch:title>
    <sch:rule context="//vcard:hasEmail[$profile]">
      <sch:let name="mailto" value="starts-with(@rdf:resource,'mailto:')"/>
      <sch:assert test="$mailto = true()">vcard:hasEmail property is not a URI with the mailto: protocol.</sch:assert>
      <sch:report test="$mailto = true()">vcard:hasEmail property is a URI with the mailto: protocol.</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>At least one of vcard:hasEmail or vcard:hasURL is a required for a contactpoint.</sch:title>
    <sch:rule context="//dcat:contactPoint[$profile]">
      <sch:let name="hasEmail" value="*/vcard:hasEmail"/>
      <sch:let name="hasUrl" value="*/vcard:hasURL"/>
      <sch:assert test="$hasEmail or $hasUrl">A vcard:Organization does not have a vcard:hasEmail or a vcard:hasURL property.</sch:assert>
      <sch:report test="$hasEmail or $hasUrl">A vcard:Organization has a vcard:hasEmail or a vcard:hasURL property.</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="naam" id="https://data.vlaanderen.be/shacl/metadata_dcat#AgentShape/1399bd400d4637b15d5fe38202d6572f82150aac">
    <sch:title>Naam - De naam van de agent. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Agent%3Anaam)</sch:title>
    <sch:rule context="//foaf:Agent/foaf:name[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van naam moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (foaf:name)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van naam moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (foaf:name)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="naam" id="https://data.vlaanderen.be/shacl/metadata_dcat#AgentShape/b96a7391d2808d207ce4e3c269dec2c6efad55c3">
    <sch:title>Naam - De naam van de agent. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Agent%3Anaam)</sch:title>
    <sch:rule context="//foaf:Agent/foaf:name[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::foaf:name[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor naam (foaf:name)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor naam (foaf:name)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="naam" id="https://data.vlaanderen.be/shacl/metadata_dcat#AgentShape/e9d8e42e8041e72c4534134d5a9044b03bed7ec5">
    <sch:title>Naam - De naam van de agent. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Agent%3Anaam)</sch:title>
    <sch:rule context="//foaf:Agent[$profile]">
      <sch:let name="validMin" value="count(foaf:name) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor naam (foaf:name)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor naam (foaf:name)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactpagina" id="https://data.vlaanderen.be/shacl/metadata_dcat#Contactinfo Shape/0d43849949c290efe2f3d4ad1d010cdb7f0505bf">
    <sch:title>Contactpagina - Een webpagina die ofwel toelaat om contact op te nemen (via b.v. een webformulier) of die informatie bevat hoe men contact kan opnemen. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Contactinfo%20%3Acontactpagina)</sch:title>
    <sch:rule context="//vcard:Organization/foaf:page[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">De range van contactpagina moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (foaf:page)</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">De range van contactpagina moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (foaf:page)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactpagina" id="https://data.vlaanderen.be/shacl/metadata_dcat#Contactinfo Shape/376ba2894840068d71059e7be03bfaf8995aee90">
    <sch:title>Contactpagina - Een webpagina die ofwel toelaat om contact op te nemen (via b.v. een webformulier) of die informatie bevat hoe men contact kan opnemen. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Contactinfo%20%3Acontactpagina)</sch:title>
    <sch:rule context="//vcard:Organization[$profile]">
      <sch:let name="validMax" value="count(foaf:page) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor contactpagina (foaf:page)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor contactpagina (foaf:page)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="e-mail" id="https://data.vlaanderen.be/shacl/metadata_dcat#Contactinfo Shape/2cf221c2b6f9a619b0515c507ddd2bbb40fbb285">
    <sch:title>E-mail - Het e-mailadres waarmee een gebruiker contact kan opnemen voor informatie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Contactinfo%20%3Ae-mail)</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasEmail[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">De range van e-mail moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (vcard:hasEmail)</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">De range van e-mail moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (vcard:hasEmail)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="e-mail" id="https://data.vlaanderen.be/shacl/metadata_dcat#Contactinfo Shape/42ad698554950cda0098f1f04803fac8470af8ad">
    <sch:title>E-mail - Het e-mailadres waarmee een gebruiker contact kan opnemen voor informatie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Contactinfo%20%3Ae-mail)</sch:title>
    <sch:rule context="//vcard:Organization[$profile]">
      <sch:let name="validMax" value="count(vcard:hasEmail) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor e-mail (vcard:hasEmail)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor e-mail (vcard:hasEmail)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="aanmaakdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/73a4bdd8cd7b0472b3b38dc9f56b0f32b8239284">
    <sch:title>Aanmaakdatum - De datum van (formele) opname van de bijbehorende dataset of dataservice in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aaanmaakdatum)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">De range van aanmaakdatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:issued)</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">De range van aanmaakdatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:issued)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="aanmaakdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/8172f8df2a73384c65fdb3332d8ee0c9ef574804">
    <sch:title>Aanmaakdatum - De datum van (formele) opname van de bijbehorende dataset of dataservice in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aaanmaakdatum)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(dct:issued) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor aanmaakdatum (dct:issued)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor aanmaakdatum (dct:issued)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>Alternatieve identificator - Een alternatieve identificator (dan de unieke identificator) voor een record in de catalogus kan hier beschreven worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aalternatieve%20identificator)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:assert>
      <sch:report test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="hoofdonderwerp" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/2a7abc3b7d6df32e4a340775a9e1522a0ac1c669">
    <sch:title>Hoofdonderwerp - De resource (dataset of dataservice) beschreven in het record. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Ahoofdonderwerp)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(foaf:primaryTopic) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor hoofdonderwerp (foaf:primaryTopic)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor hoofdonderwerp (foaf:primaryTopic)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="hoofdonderwerp" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/e7d5497a1597fc6c5856517ab46c01bae413001b">
    <sch:title>Hoofdonderwerp - De resource (dataset of dataservice) beschreven in het record. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Ahoofdonderwerp)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/foaf:primaryTopic[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Dataset|dcat:DataService) = 1 or count((//dcat:Dataset|//dcat:DataService)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van hoofdonderwerp moet van het type &lt;http://www.w3.org/ns/dcat#Resource&gt; zijn. (foaf:primaryTopic)</sch:assert>
      <sch:report test="$validClass">De range van hoofdonderwerp moet van het type &lt;http://www.w3.org/ns/dcat#Resource&gt; zijn. (foaf:primaryTopic)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="hoofdonderwerp" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/f806d2d1fd264df77aee55564a0a70eecd47ee2e">
    <sch:title>Hoofdonderwerp - De resource (dataset of dataservice) beschreven in het record. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Ahoofdonderwerp)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMin" value="count(foaf:primaryTopic) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor hoofdonderwerp (foaf:primaryTopic)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor hoofdonderwerp (foaf:primaryTopic)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/05134c4e7c34157d6f7ac1128713a08418e0fe7d">
    <sch:title>Identificator - De unieke identificator van het record in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:assert>
      <sch:report test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:title>Identificator - De unieke identificator van het record in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMin" value="count(dct:identifier) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:title>Identificator - De unieke identificator van het record in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(dct:identifier) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/5c245f65e6c2294cd7079eb566de6fd4e4adb829">
    <sch:title>Titel - De naam van het record in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Atitel)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(dct:title) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>Titel - De naam van het record in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Atitel)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>Titel - De naam van het record in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Atitel)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/29906bf16cadf6d568c4da3e161ef38ba2f726fd">
    <sch:title>Wijzigingsdatum - De meest recente datum waarop de record in de catalogus is gewijzigd, bijgewerkt of aangepast. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Awijzigingsdatum)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(dct:modified) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor wijzigingsdatum (dct:modified)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor wijzigingsdatum (dct:modified)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/6a51b2354ea38a815d6131b4e05f8587791de4e0">
    <sch:title>Wijzigingsdatum - De meest recente datum waarop de record in de catalogus is gewijzigd, bijgewerkt of aangepast. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Awijzigingsdatum)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMin" value="count(dct:modified) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor wijzigingsdatum (dct:modified)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor wijzigingsdatum (dct:modified)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/9e7585433d0896bc44cb41cdd8189793bd115cd0">
    <sch:title>Wijzigingsdatum - De meest recente datum waarop de record in de catalogus is gewijzigd, bijgewerkt of aangepast. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Awijzigingsdatum)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:modified[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">De range van wijzigingsdatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:modified)</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">De range van wijzigingsdatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:modified)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>Alternatieve identificator - Een alternatieve identificator (dan de unieke identificator) voor een dataservice kan hier beschreven worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aalternatieve%20identificator)</sch:title>
    <sch:rule context="//dcat:DataService/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:assert>
      <sch:report test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>Beschrijving - Een bondige tekstuele omschrijving van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:DataService/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van beschrijving moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:description)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van beschrijving moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/4a16176c26d8d5526c76974a1530f1ffdd596e93">
    <sch:title>Beschrijving - Een bondige tekstuele omschrijving van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:description) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor beschrijving (dct:description)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor beschrijving (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/da05d674f29a225a7115411e9f7ca442a25f2c88">
    <sch:title>Beschrijving - Een bondige tekstuele omschrijving van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:DataService/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor beschrijving (dct:description)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor beschrijving (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="biedt informatie aan over" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/5ed2c890f2c7588313cc9f93b35524bdb2d6328d">
    <sch:title>Biedt informatie aan over - De data die via deze dataservice worden aangeboden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Abiedt%20informatie%20aan%20over)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:servesdataset[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">De range van biedt informatie aan over moet van het type &lt;http://www.w3.org/ns/dcat#Dataset&gt; zijn. (dcat:servesdataset)</sch:assert>
      <sch:report test="$validClass">De range van biedt informatie aan over moet van het type &lt;http://www.w3.org/ns/dcat#Dataset&gt; zijn. (dcat:servesdataset)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform aan protocol" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/80a839685f13d2584ebe2f9b5d9a93ae2c1b21a0">
    <sch:title>Conform aan protocol - Een protocol waaraan de dataservice voldoet. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aconform%20aan%20protocol)</sch:title>
    <sch:rule context="//dcat:DataService/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van conform aan protocol moet van het type &lt;http://purl.org/dc/terms/Standard&gt; zijn. (dct:conformsTo)</sch:assert>
      <sch:report test="$validClass">De range van conform aan protocol moet van het type &lt;http://purl.org/dc/terms/Standard&gt; zijn. (dct:conformsTo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/19ee039173472235e539aea2aa961ff7d3b89f5a">
    <sch:title>Contactinformatie - De relevante contactinformatie waarmee een eindgebruiker in contact kan treden met de verantwoordelijken van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Acontactinformatie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dcat:contactPoint) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor contactinformatie (dcat:contactPoint)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor contactinformatie (dcat:contactPoint)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/458062b0ae03c559426b85df3dd28e1c785acb0b">
    <sch:title>Contactinformatie - De relevante contactinformatie waarmee een eindgebruiker in contact kan treden met de verantwoordelijken van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Acontactinformatie)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization) = 1 or count(//vcard:Organization[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van contactinformatie moet van het type &lt;http://www.w3.org/2006/vcard/ns#Kind&gt; zijn. (dcat:contactPoint)</sch:assert>
      <sch:report test="$validClass">De range van contactinformatie moet van het type &lt;http://www.w3.org/2006/vcard/ns#Kind&gt; zijn. (dcat:contactPoint)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/e332dbce5947de4314c3ed3fe5862f26d70a15c4">
    <sch:title>Contactinformatie - De relevante contactinformatie waarmee een eindgebruiker in contact kan treden met de verantwoordelijken van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Acontactinformatie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dcat:contactPoint) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor contactinformatie (dcat:contactPoint)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor contactinformatie (dcat:contactPoint)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/67c89165b0f38567bf099862ffdef88f25e68714">
    <sch:title>Endpointurl - De rootlocatie of het primaire endpoint van de dienst (een web-resolvable URI). (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3AendpointURL)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointUrl[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">De range van endpointURL moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:endpointUrl)</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">De range van endpointURL moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:endpointUrl)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/9978564bd5823785ddace8934e848c68e6e813e3">
    <sch:title>Endpointurl - De rootlocatie of het primaire endpoint van de dienst (een web-resolvable URI). (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3AendpointURL)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dcat:endpointUrl) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor endpointURL (dcat:endpointUrl)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor endpointURL (dcat:endpointUrl)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointbeschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/66883b2795f003760d4bb617bd1f472da1e1524f">
    <sch:title>Endpointbeschrijving - Een beschrijving van de diensten die beschikbaar zijn via de end-points, met inbegrip van hun operaties, parameters, enz. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aendpointbeschrijving)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dcat:endpointDescription) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor endpointbeschrijving (dcat:endpointDescription)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor endpointbeschrijving (dcat:endpointDescription)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointbeschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/bd44e3e6c4317f226cd1124fbaf1d72e94e8f15e">
    <sch:title>Endpointbeschrijving - Een beschrijving van de diensten die beschikbaar zijn via de end-points, met inbegrip van hun operaties, parameters, enz. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aendpointbeschrijving)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dcat:endpointDescription) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor endpointbeschrijving (dcat:endpointDescription)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor endpointbeschrijving (dcat:endpointDescription)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointbeschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/dbc2548616486a154002cfba6a3bc2cbc554a682">
    <sch:title>Endpointbeschrijving - Een beschrijving van de diensten die beschikbaar zijn via de end-points, met inbegrip van hun operaties, parameters, enz. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aendpointbeschrijving)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointDescription[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">De range van endpointbeschrijving moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:endpointDescription)</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">De range van endpointbeschrijving moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:endpointDescription)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/05134c4e7c34157d6f7ac1128713a08418e0fe7d">
    <sch:title>Identificator - De unieke identificator van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:DataService/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:assert>
      <sch:report test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:title>Identificator - De unieke identificator van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:identifier) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:title>Identificator - De unieke identificator van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:identifier) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/fe1a78c9169da2469a23fd783cf9a69060bfe198">
    <sch:title>Landingspagina - Een algemene webpagina waarnaar kan worden genavigeerd in een webbrowser, met algemene aanvullende informatie over de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:landingPage[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">De range van landingspagina moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:landingPage)</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">De range van landingspagina moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:landingPage)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor authenticatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/2be8f764879c3f2218306704a430503d286c30e9">
    <sch:title>Landingspagina voor authenticatie - Een verwijzing naar de landingspagina met de specifieke informatie over de authenticatie voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina%20voor%20authenticatie)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorAuthenticatie[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">De range van landingspagina voor authenticatie moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (mdcat:landingspaginaVoorAuthenticatie)</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">De range van landingspagina voor authenticatie moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (mdcat:landingspaginaVoorAuthenticatie)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor authenticatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/e9bf439f5272396af4486645c4dd4ae47c27c030">
    <sch:title>Landingspagina voor authenticatie - Een verwijzing naar de landingspagina met de specifieke informatie over de authenticatie voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina%20voor%20authenticatie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:landingspaginaVoorAuthenticatie) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor landingspagina voor authenticatie (mdcat:landingspaginaVoorAuthenticatie)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor landingspagina voor authenticatie (mdcat:landingspaginaVoorAuthenticatie)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor gebruiksinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/b643cb8952d752ef63a2b25c7fcebd89d08fb015">
    <sch:title>Landingspagina voor gebruiksinformatie - Een verwijzing naar de landingspagina met de specifieke informatie over het gebruik van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina%20voor%20gebruiksinformatie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:landingspaginaVoorGebruiksinformatie) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor landingspagina voor gebruiksinformatie (mdcat:landingspaginaVoorGebruiksinformatie)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor landingspagina voor gebruiksinformatie (mdcat:landingspaginaVoorGebruiksinformatie)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor gebruiksinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/c4eb7e771a95c6c3e5c04255458173a2b0b40f43">
    <sch:title>Landingspagina voor gebruiksinformatie - Een verwijzing naar de landingspagina met de specifieke informatie over het gebruik van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina%20voor%20gebruiksinformatie)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorGebruiksinformatie[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">De range van landingspagina voor gebruiksinformatie moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (mdcat:landingspaginaVoorGebruiksinformatie)</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">De range van landingspagina voor gebruiksinformatie moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (mdcat:landingspaginaVoorGebruiksinformatie)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor statusinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/0cdcfe2387440711ebbe94a2fcc93a29377956c5">
    <sch:title>Landingspagina voor statusinformatie - Een verwijzing naar de statuspagina van de dataservice (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina%20voor%20statusinformatie)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorStatusinformatie[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">De range van landingspagina voor statusinformatie moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (mdcat:landingspaginaVoorStatusinformatie)</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">De range van landingspagina voor statusinformatie moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (mdcat:landingspaginaVoorStatusinformatie)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor statusinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/82e4f4e38a285ebeffb0f14c036b491b71a26200">
    <sch:title>Landingspagina voor statusinformatie - Een verwijzing naar de statuspagina van de dataservice (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina%20voor%20statusinformatie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:landingspaginaVoorStatusinformatie) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor landingspagina voor statusinformatie (mdcat:landingspaginaVoorStatusinformatie)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor landingspagina voor statusinformatie (mdcat:landingspaginaVoorStatusinformatie)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="levensfase" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/13afabc6c35a0042403bd3a9f50222200152231a">
    <sch:title>Levensfase - De levensfase waarin de dataservice zich bevindt. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alevensfase)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:levensfase[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van levensfase moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (mdcat:levensfase)</sch:assert>
      <sch:report test="$validClass">De range van levensfase moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (mdcat:levensfase)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="levensfase" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/8a32a3e6b5ca4b68f8846b184e7faa4f48a0ee1d">
    <sch:title>Levensfase - De levensfase waarin de dataservice zich bevindt. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alevensfase)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:levensfase) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor levensfase (mdcat:levensfase)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor levensfase (mdcat:levensfase)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/509740cc7b3c86ebee90dc6303c11c40e2b08212">
    <sch:title>Licentie - De licentie van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alicentie)</sch:title>
    <sch:rule context="//dcat:DataService/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van licentie moet van het type &lt;http://purl.org/dc/terms/LicenseDocument&gt; zijn. (dct:license)</sch:assert>
      <sch:report test="$validClass">De range van licentie moet van het type &lt;http://purl.org/dc/terms/LicenseDocument&gt; zijn. (dct:license)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/cafd2e3e66044d8ba2c435a9353e6880952086c5">
    <sch:title>Licentie - De licentie van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alicentie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:license) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor licentie (dct:license)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor licentie (dct:license)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/4523d6e75f8993d15c9332b0aae5dbbe64a85b5a">
    <sch:title>Ontwikkelingstoestand - De ontwikkelingstoestand waarin de dataservice is gedeployed. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aontwikkelingstoestand)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:ontwikkelingstoestand[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van ontwikkelingstoestand moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (mdcat:ontwikkelingstoestand)</sch:assert>
      <sch:report test="$validClass">De range van ontwikkelingstoestand moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (mdcat:ontwikkelingstoestand)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/76f6cfca9a1964a539a879c911777c741a37cff0">
    <sch:title>Ontwikkelingstoestand - De ontwikkelingstoestand waarin de dataservice is gedeployed. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aontwikkelingstoestand)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:ontwikkelingstoestand) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor ontwikkelingstoestand (mdcat:ontwikkelingstoestand)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor ontwikkelingstoestand (mdcat:ontwikkelingstoestand)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rechten" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/62bb7a143add01ac0956709b58850f4f5e5a0e47">
    <sch:title>Rechten - Bepalingen van juridische aard die gelden op de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Arechten)</sch:title>
    <sch:rule context="//dcat:DataService/dct:rights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van rechten moet van het type &lt;http://purl.org/dc/terms/RightsStatement&gt; zijn. (dct:rights)</sch:assert>
      <sch:report test="$validClass">De range van rechten moet van het type &lt;http://purl.org/dc/terms/RightsStatement&gt; zijn. (dct:rights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/1712ef1b325d7d2807bc601d6409b70a42eaff10">
    <sch:title>Thema - De hoofdcategorie waartoe de dataservice behoort. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Athema)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:theme[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van thema moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dcat:theme)</sch:assert>
      <sch:report test="$validClass">De range van thema moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dcat:theme)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/25d18a6e2598024ea186cc7be4391bdfd1bca21f">
    <sch:title>Titel - De naam van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atitel)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:title) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor titel (dct:title)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/5c245f65e6c2294cd7079eb566de6fd4e4adb829">
    <sch:title>Titel - De naam van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atitel)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:title) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>Titel - De naam van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atitel)</sch:title>
    <sch:rule context="//dcat:DataService/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>Titel - De naam van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atitel)</sch:title>
    <sch:rule context="//dcat:DataService/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/7463895a2bb9e7e4c96cd9a2e7f83ce2cf787098">
    <sch:title>Toegankelijkheid - De toegankelijkheid voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:accessRights) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/a81035a5dbbdae24651c34e5602a1fe6fe5427a3">
    <sch:title>Toegankelijkheid - De toegankelijkheid voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:DataService/dct:accessRights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van toegankelijkheid moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:accessRights)</sch:assert>
      <sch:report test="$validClass">De range van toegankelijkheid moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/f9524ba86e28981345a2b84aea788460ad4e805e">
    <sch:title>Toegankelijkheid - De toegankelijkheid voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:accessRights) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/1b8b3557ea1ccbabc0962c345782ae53740e72e1">
    <sch:title>Trefwoord - Een trefwoord of tag die de resource beschrijft. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atrefwoord)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:keyword[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dcat:keyword[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor trefwoord (dcat:keyword)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor trefwoord (dcat:keyword)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/44f6426e2306c5bc0421823eb4a1a034b615f715">
    <sch:title>Trefwoord - Een trefwoord of tag die de resource beschrijft. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atrefwoord)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van trefwoord moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dcat:keyword)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van trefwoord moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dcat:keyword)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/302090a90a5755780bc8fe09be4bcd29193cfd6d">
    <sch:title>Versie - Een unieke aanduiding van een variant van de dataservice door middel van een versienummer of -naam van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aversie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(owl:versionInfo) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor versie (owl:versionInfo)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor versie (owl:versionInfo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/587f313308111b587d1bd2440a56622e64624864">
    <sch:title>Versie - Een unieke aanduiding van een variant van de dataservice door middel van een versienummer of -naam van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aversie)</sch:title>
    <sch:rule context="//dcat:DataService/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van versie moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (owl:versionInfo)</sch:assert>
      <sch:report test="$isLiteral">De range van versie moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (owl:versionInfo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>Alternatieve identificator - Een alternatieve identificator (dan de unieke identificator) voor een dataset kan hier beschreven worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aalternatieve%20identificator)</sch:title>
    <sch:rule context="//dcat:Dataset/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:assert>
      <sch:report test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>Beschrijving - Een bondige tekstuele omschrijving van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van beschrijving moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:description)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van beschrijving moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/4a16176c26d8d5526c76974a1530f1ffdd596e93">
    <sch:title>Beschrijving - Een bondige tekstuele omschrijving van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dct:description) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor beschrijving (dct:description)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor beschrijving (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/7521953addc62cf367ab3c8ec0dc63cb5981ea23">
    <sch:title>Beschrijving - Een bondige tekstuele omschrijving van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dct:description) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor beschrijving (dct:description)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor beschrijving (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/da05d674f29a225a7115411e9f7ca442a25f2c88">
    <sch:title>Beschrijving - Een bondige tekstuele omschrijving van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor beschrijving (dct:description)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor beschrijving (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/dd5cf5b162b3f92600a391f44660bf2b255693ac">
    <sch:title>Conform - Een standaard, schema, applicatieprofiel, vocabularium waaraan de dataset voldoet. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aconform)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van conform moet van het type &lt;http://purl.org/dc/terms/Standard&gt; zijn. (dct:conformsTo)</sch:assert>
      <sch:report test="$validClass">De range van conform moet van het type &lt;http://purl.org/dc/terms/Standard&gt; zijn. (dct:conformsTo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/19ee039173472235e539aea2aa961ff7d3b89f5a">
    <sch:title>Contactinformatie - De relevante contactinformatie waarmee een eindgebruiker in contact kan treden met de verantwoordelijken van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Acontactinformatie)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dcat:contactPoint) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor contactinformatie (dcat:contactPoint)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor contactinformatie (dcat:contactPoint)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/458062b0ae03c559426b85df3dd28e1c785acb0b">
    <sch:title>Contactinformatie - De relevante contactinformatie waarmee een eindgebruiker in contact kan treden met de verantwoordelijken van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Acontactinformatie)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization) = 1 or count(//vcard:Organization[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van contactinformatie moet van het type &lt;http://schema.org/ContactPoint&gt; zijn. (dcat:contactPoint)</sch:assert>
      <sch:report test="$validClass">De range van contactinformatie moet van het type &lt;http://schema.org/ContactPoint&gt; zijn. (dcat:contactPoint)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/e332dbce5947de4314c3ed3fe5862f26d70a15c4">
    <sch:title>Contactinformatie - De relevante contactinformatie waarmee een eindgebruiker in contact kan treden met de verantwoordelijken van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Acontactinformatie)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dcat:contactPoint) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor contactinformatie (dcat:contactPoint)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor contactinformatie (dcat:contactPoint)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="distributie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/cfbe0a11423fe15e990c3cbd5209404c26dbef0f">
    <sch:title>Distributie - Een beschikbare distributie van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Adistributie)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:distribution[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Distribution) = 1 or count(//dcat:Distribution[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van distributie moet van het type &lt;http://www.w3.org/ns/dcat#Distribution&gt; zijn. (dcat:distribution)</sch:assert>
      <sch:report test="$validClass">De range van distributie moet van het type &lt;http://www.w3.org/ns/dcat#Distribution&gt; zijn. (dcat:distribution)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/05134c4e7c34157d6f7ac1128713a08418e0fe7d">
    <sch:title>Identificator - De unieke identificator van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:assert>
      <sch:report test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:title>Identificator - De unieke identificator van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dct:identifier) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:title>Identificator - De unieke identificator van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dct:identifier) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/fe1a78c9169da2469a23fd783cf9a69060bfe198">
    <sch:title>Landingspagina - Een algemene webpagina waarnaar kan worden genavigeerd in een webbrowser, met algemene informatie over de dataset, zijn distributies en/of aanvullende informatie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Alandingspagina)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:landingPage[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">De range van landingspagina moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:landingPage)</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">De range van landingspagina moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:landingPage)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/1712ef1b325d7d2807bc601d6409b70a42eaff10">
    <sch:title>Thema - De hoofdcategorie waartoe de dataset behoort. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Athema)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:theme[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van thema moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dcat:theme)</sch:assert>
      <sch:report test="$validClass">De range van thema moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dcat:theme)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/25d18a6e2598024ea186cc7be4391bdfd1bca21f">
    <sch:title>Titel - De naam van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atitel)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dct:title) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor titel (dct:title)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/5c245f65e6c2294cd7079eb566de6fd4e4adb829">
    <sch:title>Titel - De naam van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atitel)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dct:title) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>Titel - De naam van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atitel)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>Titel - De naam van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atitel)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/7463895a2bb9e7e4c96cd9a2e7f83ce2cf787098">
    <sch:title>Toegankelijkheid - De toegankelijkheid voor de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dct:accessRights) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/a81035a5dbbdae24651c34e5602a1fe6fe5427a3">
    <sch:title>Toegankelijkheid - De toegankelijkheid voor de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accessRights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van toegankelijkheid moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:accessRights)</sch:assert>
      <sch:report test="$validClass">De range van toegankelijkheid moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/f9524ba86e28981345a2b84aea788460ad4e805e">
    <sch:title>Toegankelijkheid - De toegankelijkheid voor de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dct:accessRights) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/1b8b3557ea1ccbabc0962c345782ae53740e72e1">
    <sch:title>Trefwoord - Een trefwoord of tag die de resource beschrijft. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atrefwoord)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:keyword[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dcat:keyword[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor trefwoord (dcat:keyword)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor trefwoord (dcat:keyword)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/44f6426e2306c5bc0421823eb4a1a034b615f715">
    <sch:title>Trefwoord - Een trefwoord of tag die de resource beschrijft. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atrefwoord)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van trefwoord moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dcat:keyword)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van trefwoord moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dcat:keyword)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/302090a90a5755780bc8fe09be4bcd29193cfd6d">
    <sch:title>Versie - Een unieke aanduiding van een variant van de dataset door middel van een versienummer of -naam van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aversie)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(owl:versionInfo) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor versie (owl:versionInfo)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor versie (owl:versionInfo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/587f313308111b587d1bd2440a56622e64624864">
    <sch:title>Versie - Een unieke aanduiding van een variant van de dataset door middel van een versienummer of -naam van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aversie)</sch:title>
    <sch:rule context="//dcat:Dataset/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van versie moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (owl:versionInfo)</sch:assert>
      <sch:report test="$isLiteral">De range van versie moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (owl:versionInfo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>Alternatieve identificator - Een alternatieve identificator (dan de unieke identificator) voor een distributie kan hier beschreven worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Aalternatieve%20identificator)</sch:title>
    <sch:rule context="//dcat:Distribution/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:assert>
      <sch:report test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/0e61107f343f202ee672ef465cfcdbbcd746e21d">
    <sch:title>Downloadurl - De URL waar de data gedownload kan worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3AdownloadURL)</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:downloadURL[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">De range van downloadURL moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:downloadURL)</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">De range van downloadURL moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:downloadURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/1ff94e5c0d35c7d1a7f2c4bd160a8c8e4eee6f97">
    <sch:title>Downloadurl - De URL waar de data gedownload kan worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3AdownloadURL)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dcat:downloadURL) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor downloadURL (dcat:downloadURL)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor downloadURL (dcat:downloadURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/05134c4e7c34157d6f7ac1128713a08418e0fe7d">
    <sch:title>Identificator - De unieke identificator van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:assert>
      <sch:report test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:title>Identificator - De unieke identificator van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMin" value="count(dct:identifier) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:title>Identificator - De unieke identificator van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dct:identifier) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/509740cc7b3c86ebee90dc6303c11c40e2b08212">
    <sch:title>Licentie - De licentie van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Alicentie)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van licentie moet van het type &lt;http://purl.org/dc/terms/LicenseDocument&gt; zijn. (dct:license)</sch:assert>
      <sch:report test="$validClass">De range van licentie moet van het type &lt;http://purl.org/dc/terms/LicenseDocument&gt; zijn. (dct:license)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/cafd2e3e66044d8ba2c435a9353e6880952086c5">
    <sch:title>Licentie - De licentie van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Alicentie)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dct:license) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor licentie (dct:license)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor licentie (dct:license)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rechten" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/62bb7a143add01ac0956709b58850f4f5e5a0e47">
    <sch:title>Rechten - Bepalingen van juridische aard die gelden op de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Arechten)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:rights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van rechten moet van het type &lt;http://purl.org/dc/terms/RightsStatement&gt; zijn. (dct:rights)</sch:assert>
      <sch:report test="$validClass">De range van rechten moet van het type &lt;http://purl.org/dc/terms/RightsStatement&gt; zijn. (dct:rights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/5c245f65e6c2294cd7079eb566de6fd4e4adb829">
    <sch:title>Titel - De naam van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Atitel)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dct:title) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>Titel - De naam van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Atitel)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>Titel - De naam van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Atitel)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegangsURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/28a9b5a610271b2ad2cd6917763075560213ca20">
    <sch:title>Toegangsurl - Een URL waar de data kan gevonden worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3AtoegangsURL)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dcat:accessURL) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor toegangsURL (dcat:accessURL)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor toegangsURL (dcat:accessURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegangsURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/3d0e850677d211050dd9e93ec6496e6af9908da6">
    <sch:title>Toegangsurl - Een URL waar de data kan gevonden worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3AtoegangsURL)</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessURL[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(@rdf:resource) != ''"/>
      <sch:let name="isURI" value="matches(@rdf:resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$isNotEmpty and $isURI">De range van toegangsURL moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:accessURL)</sch:assert>
      <sch:report test="$isNotEmpty and $isURI">De range van toegangsURL moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:accessURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegangsURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/bf4475984ce7d0eb4bade6e749e672a8efa7dd2d">
    <sch:title>Toegangsurl - Een URL waar de data kan gevonden worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3AtoegangsURL)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMin" value="count(dcat:accessURL) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor toegangsURL (dcat:accessURL)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor toegangsURL (dcat:accessURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wordt aangeboden door" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/c612c1f62d45c84405f45260ab0737a10f5b0a18">
    <sch:title>Wordt aangeboden door - Een dataservice die deze distributie aanbiedt. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Awordt%20aangeboden%20door)</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessService[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">De range van wordt aangeboden door moet van het type &lt;http://www.w3.org/ns/dcat#DataService&gt; zijn. (dcat:accessService)</sch:assert>
      <sch:report test="$validClass">De range van wordt aangeboden door moet van het type &lt;http://www.w3.org/ns/dcat#DataService&gt; zijn. (dcat:accessService)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusResourceShape/5334cf8edf5cc07e349524728fe4c9b076e4c45e">
    <sch:title>Uitgever - De uitgever, de entiteit die verantwoordelijk is voor het beschikbaar stellen, van de resource in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusResource%3Auitgever)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]|//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:publisher) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor uitgever (dct:publisher)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor uitgever (dct:publisher)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusResourceShape/aabe67e6a56c5e2fc5695716e8f7b66edd525085">
    <sch:title>Uitgever - De uitgever, de entiteit die verantwoordelijk is voor het beschikbaar stellen, van de resource in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusResource%3Auitgever)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:publisher[$profile]|//dcat:DataService/dct:publisher[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent) = 1 or count(//foaf:Agent[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van uitgever moet van het type &lt;http://purl.org/dc/terms/Agent&gt; zijn. (dct:publisher)</sch:assert>
      <sch:report test="$validClass">De range van uitgever moet van het type &lt;http://purl.org/dc/terms/Agent&gt; zijn. (dct:publisher)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusResourceShape/e2d4034a0a398701f4257641ebcbc85e8683b29d">
    <sch:title>Uitgever - De uitgever, de entiteit die verantwoordelijk is voor het beschikbaar stellen, van de resource in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusResource%3Auitgever)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]|//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:publisher) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor uitgever (dct:publisher)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor uitgever (dct:publisher)</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>