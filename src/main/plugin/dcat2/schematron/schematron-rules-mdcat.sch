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
  <sch:ns prefix="geodcat" uri="http://data.europa.eu/930/"/>
  <sch:ns prefix="generiek" uri="http://data.vlaanderen.be/ns/generiek#"/>
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
      <sch:let name="hasEmail" value="normalize-space(vcard:Organization/vcard:hasEmail/@rdf:resource) != ''"/>
      <sch:let name="hasUrl" value="normalize-space(vcard:Organization/vcard:hasURL/@rdf:resource) != ''"/>
      <sch:assert test="$hasEmail or $hasUrl">A vcard:Organization does not have a vcard:hasEmail or a vcard:hasURL property.</sch:assert>
      <sch:report test="$hasEmail or $hasUrl">A vcard:Organization has a vcard:hasEmail or a vcard:hasURL property.</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="naam" id="https://data.vlaanderen.be/shacl/metadata_dcat#AgentShape/1399bd400d4637b15d5fe38202d6572f82150aac">
    <sch:title>v901. Naam - De naam van de agent. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Agent%3Anaam)</sch:title>
    <sch:rule context="//foaf:Agent/foaf:name[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van naam moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (foaf:name)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van naam moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (foaf:name)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="naam" id="https://data.vlaanderen.be/shacl/metadata_dcat#AgentShape/b96a7391d2808d207ce4e3c269dec2c6efad55c3">
    <sch:title>v212. Naam - De naam van de agent. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Agent%3Anaam)</sch:title>
    <sch:rule context="//foaf:Agent/foaf:name[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::foaf:name[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor naam (foaf:name)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor naam (foaf:name)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="naam" id="https://data.vlaanderen.be/shacl/metadata_dcat#AgentShape/e9d8e42e8041e72c4534134d5a9044b03bed7ec5">
    <sch:title>v000. Naam - De naam van de agent. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Agent%3Anaam)</sch:title>
    <sch:rule context="//foaf:Agent[$profile]">
      <sch:let name="validMin" value="count(foaf:name) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor naam (foaf:name)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor naam (foaf:name)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bounding box" id="https://data.vlaanderen.be/shacl/metadata_dcat#PlaatsShape/02f937f793dda13f6197e578a4f0f2ee6c9a5570">
    <sch:title>Bounding box - de afgrenzing van een plaats als een geografische rechthoek (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Plaats%3Abounding%20box)</sch:title>
    <sch:rule context="//dct:Location/dcat:bbox[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van bounding box moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dcat:bbox)</sch:assert>
      <sch:report test="$isLiteral">De range van bounding box moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dcat:bbox)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="centroïde" id="https://data.vlaanderen.be/shacl/metadata_dcat#PlaatsShape/2545f2b443edf700f1be24a7ac0d790faddfc7d3">
    <sch:title>Centroïde - het geografische middelpunt van een plaats (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Plaats%3Acentro%C3%AFde)</sch:title>
    <sch:rule context="//dct:Location/dcat:centroid[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van centroïde moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dcat:centroid)</sch:assert>
      <sch:report test="$isLiteral">De range van centroïde moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dcat:centroid)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="geometrie" id="https://data.vlaanderen.be/shacl/metadata_dcat#PlaatsShape/722a1f18cabb107c684fe4ca857876ade00b0d01">
    <sch:title>Geometrie - de geografische beschrijving van een plaats (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Plaats%3Ageometrie)</sch:title>
    <sch:rule context="//dct:Location/locn:geometry[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van geometrie moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (locn:geometry)</sch:assert>
      <sch:report test="$isLiteral">De range van geometrie moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (locn:geometry)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="plaatsnaam" id="https://data.vlaanderen.be/shacl/metadata_dcat#PlaatsShape/3562937fd68e5b9b91210d2e17383e28b6a7a53b">
    <sch:title>Plaatsnaam - een eenduidige, beknopte beschrijving die de plaats benoemt. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Plaats%3Aplaatsnaam)</sch:title>
    <sch:rule context="//dct:Location/rdfs:label[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van plaatsnaam moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (rdfs:label)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van plaatsnaam moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (rdfs:label)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="plaatsnaam" id="https://data.vlaanderen.be/shacl/metadata_dcat#PlaatsShape/eb63b1d3337e467fc4c15bc345f46548d91d7d37">
    <sch:title>Plaatsnaam - een eenduidige, beknopte beschrijving die de plaats benoemt. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Plaats%3Aplaatsnaam)</sch:title>
    <sch:rule context="//dct:Location/rdfs:label[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::rdfs:label[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor plaatsnaam (rdfs:label)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor plaatsnaam (rdfs:label)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>Beschrijving - Een bondige tekstuele omschrijving van de
standaard (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Abeschrijving)</sch:title>
    <sch:rule context="//dct:Standard/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van beschrijving moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:description)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van beschrijving moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/da05d674f29a225a7115411e9f7ca442a25f2c88">
    <sch:title>Beschrijving - Een bondige tekstuele omschrijving van de
standaard (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Abeschrijving)</sch:title>
    <sch:rule context="//dct:Standard/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor beschrijving (dct:description)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor beschrijving (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/0e54e6660eb6bc0ea08ebfce3dbbf188c3e400d8">
    <sch:title>Publicatiedatum - De datum waarop de standaard werd
gepubliceerd (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Apublicatiedatum)</sch:title>
    <sch:rule context="//dct:Standard/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">De range van publicatiedatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:issued)</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">De range van publicatiedatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:issued)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/fe9c62143da275c7458e0e71dedeb277670a016b">
    <sch:title>Publicatiedatum - De datum waarop de standaard werd
gepubliceerd (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Apublicatiedatum)</sch:title>
    <sch:rule context="//dct:Standard[$profile]">
      <sch:let name="validMax" value="count(dct:issued) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor publicatiedatum (dct:issued)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor publicatiedatum (dct:issued)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="specificatie URL" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/817c38a73348ef5623204d13efbf44e68a4612e8">
    <sch:title>Specificatie url - Een URL waarop men de specificatie kan
vinden (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Aspecificatie%20URL)</sch:title>
    <sch:rule context="//dct:Standard/rdfs:seeAlso[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van specificatie URL moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (rdfs:seeAlso)</sch:assert>
      <sch:report test="$validClass">De range van specificatie URL moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (rdfs:seeAlso)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="specificatie URL" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/db7c74598f8807ba1cfdb8f62f771fb27d4dbbe7">
    <sch:title>Specificatie url - Een URL waarop men de specificatie kan
vinden (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Aspecificatie%20URL)</sch:title>
    <sch:rule context="//dct:Standard[$profile]">
      <sch:let name="validMax" value="count(rdfs:seeAlso) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor specificatie URL (rdfs:seeAlso)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor specificatie URL (rdfs:seeAlso)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>Titel - naam van de standaard (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Atitel)</sch:title>
    <sch:rule context="//dct:Standard/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>Titel - naam van de standaard (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Atitel)</sch:title>
    <sch:rule context="//dct:Standard/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="type" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/322371a77364a50f049d46180f6192532eea26dc">
    <sch:title>Type - Een categorisatie van de standaard (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Atype)</sch:title>
    <sch:rule context="//dct:Standard/dct:type[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van type moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:type)</sch:assert>
      <sch:report test="$validClass">De range van type moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:type)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/302090a90a5755780bc8fe09be4bcd29193cfd6d">
    <sch:title>Versie - De versie van de standaard (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Aversie)</sch:title>
    <sch:rule context="//dct:Standard[$profile]">
      <sch:let name="validMax" value="count(owl:versionInfo) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor versie (owl:versionInfo)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor versie (owl:versionInfo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/587f313308111b587d1bd2440a56622e64624864">
    <sch:title>Versie - De versie van de standaard (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Aversie)</sch:title>
    <sch:rule context="//dct:Standard/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van versie moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (owl:versionInfo)</sch:assert>
      <sch:report test="$isLiteral">De range van versie moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (owl:versionInfo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="voorkeurslabel" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/dec1490408b1bea457bc40436431406882288252">
    <sch:title>Voorkeurslabel - Een afkorting, of notatie waaronder de
standaard bekend is. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Avoorkeurslabel)</sch:title>
    <sch:rule context="//dct:Standard[$profile]">
      <sch:let name="validMax" value="count(skos:prefLabel) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor voorkeurslabel (skos:prefLabel)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor voorkeurslabel (skos:prefLabel)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="voorkeurslabel" id="https://data.vlaanderen.be/shacl/metadata_dcat#StandaardShape/f8712dd0e04b5c6b79d939432a639019c7295c6f">
    <sch:title>Voorkeurslabel - Een afkorting, of notatie waaronder de
standaard bekend is. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Standaard%3Avoorkeurslabel)</sch:title>
    <sch:rule context="//dct:Standard/skos:prefLabel[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van voorkeurslabel moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (skos:prefLabel)</sch:assert>
      <sch:report test="$isLiteral">De range van voorkeurslabel moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (skos:prefLabel)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactpagina" id="https://data.vlaanderen.be/shacl/metadata_dcat#ContactinfoShape/0d43849949c290efe2f3d4ad1d010cdb7f0505bf">
    <sch:title>1001. Contactpagina - Een webpagina die ofwel toelaat om contact op te nemen (via b.v. een webformulier) of die informatie bevat hoe men contact kan opnemen. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Contactinfo%3Acontactpagina)</sch:title>
    <sch:rule context="//vcard:Organization/foaf:page[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van contactpagina moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (foaf:page)</sch:assert>
      <sch:report test="$validClass">De range van contactpagina moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (foaf:page)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactpagina" id="https://data.vlaanderen.be/shacl/metadata_dcat#ContactinfoShape/376ba2894840068d71059e7be03bfaf8995aee90">
    <sch:title>1002. Contactpagina - Een webpagina die ofwel toelaat om contact op te nemen (via b.v. een webformulier) of die informatie bevat hoe men contact kan opnemen. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Contactinfo%3Acontactpagina)</sch:title>
    <sch:rule context="//vcard:Organization[$profile]">
      <sch:let name="validMax" value="count(foaf:page) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor contactpagina (foaf:page)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor contactpagina (foaf:page)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="e-mail" id="https://data.vlaanderen.be/shacl/metadata_dcat#ContactinfoShape/2cf221c2b6f9a619b0515c507ddd2bbb40fbb285">
    <sch:title>413. E-mail - Het e-mailadres waarmee een gebruiker contact kan opnemen voor informatie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Contactinfo%3Ae-mail)</sch:title>
    <sch:rule context="//vcard:Organization/vcard:hasEmail[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van e-mail moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (vcard:hasEmail)</sch:assert>
      <sch:report test="$validClass">De range van e-mail moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (vcard:hasEmail)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="e-mail" id="https://data.vlaanderen.be/shacl/metadata_dcat#ContactinfoShape/42ad698554950cda0098f1f04803fac8470af8ad">
    <sch:title>1004. E-mail - Het e-mailadres waarmee een gebruiker contact kan opnemen voor informatie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Contactinfo%3Ae-mail)</sch:title>
    <sch:rule context="//vcard:Organization[$profile]">
      <sch:let name="validMax" value="count(vcard:hasEmail) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor e-mail (vcard:hasEmail)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor e-mail (vcard:hasEmail)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="gestructureerde identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#IdentificatorShape/0e92d523a1837590188fbfddd2ab0d9f901bdcab">
    <sch:title>Gestructureerde identificator - Identificator vh object opgesplitst in zijn onderdelen. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Identificator%3Agestructureerde%20identificator)</sch:title>
    <sch:rule context="//adms:Identifier/generiek:gestructureerdeIdentificator[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(generiek:GestructureerdeIdentificator) = 1 or count(//generiek:GestructureerdeIdentificator[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van gestructureerde identificator moet van het type &lt;http://data.vlaanderen.be/ns/generiek#GestructureerdeIdentificator&gt; zijn. (generiek:gestructureerdeIdentificator)</sch:assert>
      <sch:report test="$validClass">De range van gestructureerde identificator moet van het type &lt;http://data.vlaanderen.be/ns/generiek#GestructureerdeIdentificator&gt; zijn. (generiek:gestructureerdeIdentificator)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="gestructureerde identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#IdentificatorShape/6789412851c92fe5eb8479182507dd72e28ab811">
    <sch:title>Gestructureerde identificator - Identificator vh object opgesplitst in zijn onderdelen. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Identificator%3Agestructureerde%20identificator)</sch:title>
    <sch:rule context="//adms:Identifier[$profile]">
      <sch:let name="validMax" value="count(generiek:gestructureerdeIdentificator) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor gestructureerde identificator (generiek:gestructureerdeIdentificator)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor gestructureerde identificator (generiek:gestructureerdeIdentificator)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="notatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#IdentificatorShape/71a444ee0ec5b354586504464e5c6bffb69d78c8">
    <sch:title>Notatie - String gebruikt om het object uniek te identificeren.  (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Identificator%3Anotatie)</sch:title>
    <sch:rule context="//adms:Identifier/skos:notation[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van notatie moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (skos:notation)</sch:assert>
      <sch:report test="$isLiteral">De range van notatie moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (skos:notation)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="notatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#IdentificatorShape/ccb2d543d17baa8b6b0ca2a42156eed6f23e3f6e">
    <sch:title>Notatie - String gebruikt om het object uniek te identificeren.  (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Identificator%3Anotatie)</sch:title>
    <sch:rule context="//adms:Identifier[$profile]">
      <sch:let name="validMax" value="count(skos:notation) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor notatie (skos:notation)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor notatie (skos:notation)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend door" id="https://data.vlaanderen.be/shacl/metadata_dcat#IdentificatorShape/ed560feb860205e0339910c9b2942564c01b5e11">
    <sch:title>Toegekend door - Link naar de agent die de identificator heeft uitgegeven. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Identificator%3Atoegekend%20door)</sch:title>
    <sch:rule context="//adms:Identifier/dct:creator[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent) = 1 or count(//foaf:Agent[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van toegekend door moet van het type &lt;http://xmlns.com/foaf/0.1/Agent&gt; zijn. (dct:creator)</sch:assert>
      <sch:report test="$validClass">De range van toegekend door moet van het type &lt;http://xmlns.com/foaf/0.1/Agent&gt; zijn. (dct:creator)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend door" id="https://data.vlaanderen.be/shacl/metadata_dcat#IdentificatorShape/f0a3fc099a35481d2891e1eac3a099feb6f942d8">
    <sch:title>Toegekend door - Link naar de agent die de identificator heeft uitgegeven. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Identificator%3Atoegekend%20door)</sch:title>
    <sch:rule context="//adms:Identifier[$profile]">
      <sch:let name="validMax" value="count(dct:creator) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor toegekend door (dct:creator)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor toegekend door (dct:creator)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend door (String)" id="https://data.vlaanderen.be/shacl/metadata_dcat#IdentificatorShape/5f023c37e7d18ecf8aecd2bb45eae0a05687cd6f">
    <sch:title>Toegekend door (string) - Naam vd agent die de identificator heeft toegekend. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Identificator%3Atoegekend%20door%20(String))</sch:title>
    <sch:rule context="//adms:Identifier/adms:schemaAgency[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van toegekend door (String) moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (adms:schemaAgency)</sch:assert>
      <sch:report test="$isLiteral">De range van toegekend door (String) moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (adms:schemaAgency)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend door (String)" id="https://data.vlaanderen.be/shacl/metadata_dcat#IdentificatorShape/9f8532791e13c302ae6dcc70ef353c796f948c85">
    <sch:title>Toegekend door (string) - Naam vd agent die de identificator heeft toegekend. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Identificator%3Atoegekend%20door%20(String))</sch:title>
    <sch:rule context="//adms:Identifier[$profile]">
      <sch:let name="validMax" value="count(adms:schemaAgency) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor toegekend door (String) (adms:schemaAgency)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor toegekend door (String) (adms:schemaAgency)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend op" id="https://data.vlaanderen.be/shacl/metadata_dcat#IdentificatorShape/0f275ebdc16f2be1bf67063a80faf4ccea40332b">
    <sch:title>Toegekend op - Tijdstip waarop de identificator werd uitgegeven. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Identificator%3Atoegekend%20op)</sch:title>
    <sch:rule context="//adms:Identifier/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">De range van toegekend op moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:issued)</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">De range van toegekend op moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:issued)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegekend op" id="https://data.vlaanderen.be/shacl/metadata_dcat#IdentificatorShape/3b5973d35f612c133f22e9f710f65db63d861b6b">
    <sch:title>Toegekend op - Tijdstip waarop de identificator werd uitgegeven. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Identificator%3Atoegekend%20op)</sch:title>
    <sch:rule context="//adms:Identifier[$profile]">
      <sch:let name="validMax" value="count(dct:issued) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor toegekend op (dct:issued)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor toegekend op (dct:issued)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="aanmaakdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/73a4bdd8cd7b0472b3b38dc9f56b0f32b8239284">
    <sch:title>1201. Aanmaakdatum - De datum van (formele) opname van de bijbehorende dataset of dataservice in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aaanmaakdatum)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">De range van aanmaakdatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:issued)</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">De range van aanmaakdatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:issued)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="aanmaakdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/8172f8df2a73384c65fdb3332d8ee0c9ef574804">
    <sch:title>1202. Aanmaakdatum - De datum van (formele) opname van de bijbehorende dataset of dataservice in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aaanmaakdatum)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(dct:issued) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor aanmaakdatum (dct:issued)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor aanmaakdatum (dct:issued)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>1204. Alternatieve identificator - Een alternatieve identificator (dan de unieke identificator) voor een record in de catalogus kan hier beschreven worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aalternatieve%20identificator)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:assert>
      <sch:report test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bron metadata record landingspagina" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/0311d40d6c8081dc49766336ad753baee5d276f2">
    <sch:title>Bron metadata record landingspagina - Een webpagina in een menselijk leesbare vorm van de bron metadata record. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Abron%20metadata%20record%20landingspagina)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(mdcat:bron metadata record landingspagina) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor bron metadata record landingspagina (mdcat:bron metadata record landingspagina)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor bron metadata record landingspagina (mdcat:bron metadata record landingspagina)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bron metadata record landingspagina" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/48c46070935428444a8dfe37e3b3172aa804f5e0">
    <sch:title>Bron metadata record landingspagina - Een webpagina in een menselijk leesbare vorm van de bron metadata record. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Abron%20metadata%20record%20landingspagina)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMin" value="count(mdcat:bron metadata record landingspagina) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor bron metadata record landingspagina (mdcat:bron metadata record landingspagina)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor bron metadata record landingspagina (mdcat:bron metadata record landingspagina)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bron metadata record landingspagina" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/e7e0fa856a7a9fd5e0507143109ff56bbed15bc5">
    <sch:title>Bron metadata record landingspagina - Een webpagina in een menselijk leesbare vorm van de bron metadata record. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Abron%20metadata%20record%20landingspagina)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/mdcat:bron metadata record landingspagina[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van bron metadata record landingspagina moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (mdcat:bron metadata record landingspagina)</sch:assert>
      <sch:report test="$validClass">De range van bron metadata record landingspagina moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (mdcat:bron metadata record landingspagina)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bron metadatarecord" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/ac72a26a136d49612ab47e1ead54cb3ac0f9dcb3">
    <sch:title>Bron metadatarecord - De record in een andere catalogus waarvan deze record en de beschrijvingen van het bijhorende hoofdonderwerp van afgeleid zijn. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Abron%20metadatarecord)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:source[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van bron metadatarecord moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (dct:source)</sch:assert>
      <sch:report test="$validClass">De range van bron metadatarecord moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (dct:source)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="bron metadatarecord" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/c779d25f1f0ba872826b725cf9254a3bec5a82ce">
    <sch:title>Bron metadatarecord - De record in een andere catalogus waarvan deze record en de beschrijvingen van het bijhorende hoofdonderwerp van afgeleid zijn. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Abron%20metadatarecord)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(dct:source) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor bron metadatarecord (dct:source)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor bron metadatarecord (dct:source)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/dd5cf5b162b3f92600a391f44660bf2b255693ac">
    <sch:title>Conform - De (metadata) standaard volgens welke
regels het hoofdonderwerp waarnaar de
Catalogus Record verwijst, beschreven
wordt. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aconform)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van conform moet van het type &lt;http://purl.org/dc/terms/Standard&gt; zijn. (dct:conformsTo)</sch:assert>
      <sch:report test="$validClass">De range van conform moet van het type &lt;http://purl.org/dc/terms/Standard&gt; zijn. (dct:conformsTo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="hoofdonderwerp" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/2a7abc3b7d6df32e4a340775a9e1522a0ac1c669">
    <sch:title>1206. Hoofdonderwerp - De resource (dataset of dataservice) beschreven in het record. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Ahoofdonderwerp)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(foaf:primaryTopic) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor hoofdonderwerp (foaf:primaryTopic)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor hoofdonderwerp (foaf:primaryTopic)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="hoofdonderwerp" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/e7d5497a1597fc6c5856517ab46c01bae413001b">
    <sch:title>1208. Hoofdonderwerp - De resource (dataset of dataservice) beschreven in het record. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Ahoofdonderwerp)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/foaf:primaryTopic[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Dataset|dcat:DataService) = 1 or count((//dcat:Dataset|//dcat:DataService)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van hoofdonderwerp moet van het type &lt;http://www.w3.org/ns/dcat#Resource&gt; zijn. (foaf:primaryTopic)</sch:assert>
      <sch:report test="$validClass">De range van hoofdonderwerp moet van het type &lt;http://www.w3.org/ns/dcat#Resource&gt; zijn. (foaf:primaryTopic)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="hoofdonderwerp" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/f806d2d1fd264df77aee55564a0a70eecd47ee2e">
    <sch:title>1209. Hoofdonderwerp - De resource (dataset of dataservice) beschreven in het record. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Ahoofdonderwerp)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMin" value="count(foaf:primaryTopic) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor hoofdonderwerp (foaf:primaryTopic)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor hoofdonderwerp (foaf:primaryTopic)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/05134c4e7c34157d6f7ac1128713a08418e0fe7d">
    <sch:title>1210. Identificator - De unieke identificator van het record in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:assert>
      <sch:report test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:title>1211. Identificator - De unieke identificator van het record in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMin" value="count(dct:identifier) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:title>1212. Identificator - De unieke identificator van het record in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(dct:identifier) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>1216. Titel - De naam van het record in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Atitel)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>1217. Titel - De naam van het record in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Atitel)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/29906bf16cadf6d568c4da3e161ef38ba2f726fd">
    <sch:title>1218. Wijzigingsdatum - De meest recente datum waarop de record in de catalogus is gewijzigd, bijgewerkt of aangepast. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Awijzigingsdatum)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMax" value="count(dct:modified) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor wijzigingsdatum (dct:modified)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor wijzigingsdatum (dct:modified)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/6a51b2354ea38a815d6131b4e05f8587791de4e0">
    <sch:title>1219. Wijzigingsdatum - De meest recente datum waarop de record in de catalogus is gewijzigd, bijgewerkt of aangepast. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Awijzigingsdatum)</sch:title>
    <sch:rule context="//dcat:CatalogRecord[$profile]">
      <sch:let name="validMin" value="count(dct:modified) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor wijzigingsdatum (dct:modified)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor wijzigingsdatum (dct:modified)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusRecordShape/9e7585433d0896bc44cb41cdd8189793bd115cd0">
    <sch:title>1220. Wijzigingsdatum - De meest recente datum waarop de record in de catalogus is gewijzigd, bijgewerkt of aangepast. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusRecord%3Awijzigingsdatum)</sch:title>
    <sch:rule context="//dcat:CatalogRecord/dct:modified[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">De range van wijzigingsdatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:modified)</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">De range van wijzigingsdatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:modified)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>1301. Alternatieve identificator - Een alternatieve identificator (dan de unieke identificator) voor een dataservice kan hier beschreven worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aalternatieve%20identificator)</sch:title>
    <sch:rule context="//dcat:DataService/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:assert>
      <sch:report test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>1303. Beschrijving - Een bondige tekstuele omschrijving van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:DataService/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van beschrijving moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:description)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van beschrijving moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/da05d674f29a225a7115411e9f7ca442a25f2c88">
    <sch:title>1306. Beschrijving - Een bondige tekstuele omschrijving van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:DataService/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor beschrijving (dct:description)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor beschrijving (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="biedt informatie aan over" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/5ed2c890f2c7588313cc9f93b35524bdb2d6328d">
    <sch:title>1308. Biedt informatie aan over - De data die via deze dataservice worden aangeboden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Abiedt%20informatie%20aan%20over)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:servesdataset[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">De range van biedt informatie aan over moet van het type &lt;http://www.w3.org/ns/dcat#Dataset&gt; zijn. (dcat:servesdataset)</sch:assert>
      <sch:report test="$validClass">De range van biedt informatie aan over moet van het type &lt;http://www.w3.org/ns/dcat#Dataset&gt; zijn. (dcat:servesdataset)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform aan protocol" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/80a839685f13d2584ebe2f9b5d9a93ae2c1b21a0">
    <sch:title>1309. Conform aan protocol - Een protocol waaraan de dataservice voldoet. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aconform%20aan%20protocol)</sch:title>
    <sch:rule context="//dcat:DataService/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van conform aan protocol moet van het type &lt;http://purl.org/dc/terms/Standard&gt; zijn. (dct:conformsTo)</sch:assert>
      <sch:report test="$validClass">De range van conform aan protocol moet van het type &lt;http://purl.org/dc/terms/Standard&gt; zijn. (dct:conformsTo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/19ee039173472235e539aea2aa961ff7d3b89f5a">
    <sch:title>1312. Contactinformatie - De relevante contactinformatie waarmee een eindgebruiker in contact kan treden met de verantwoordelijken van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Acontactinformatie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dcat:contactPoint) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor contactinformatie (dcat:contactPoint)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor contactinformatie (dcat:contactPoint)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/458062b0ae03c559426b85df3dd28e1c785acb0b">
    <sch:title>1313. Contactinformatie - De relevante contactinformatie waarmee een eindgebruiker in contact kan treden met de verantwoordelijken van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Acontactinformatie)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization) = 1 or count(//vcard:Organization[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van contactinformatie moet van het type &lt;http://www.w3.org/2006/vcard/ns#Kind&gt; zijn. (dcat:contactPoint)</sch:assert>
      <sch:report test="$validClass">De range van contactinformatie moet van het type &lt;http://www.w3.org/2006/vcard/ns#Kind&gt; zijn. (dcat:contactPoint)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/e332dbce5947de4314c3ed3fe5862f26d70a15c4">
    <sch:title>1314. Contactinformatie - De relevante contactinformatie waarmee een eindgebruiker in contact kan treden met de verantwoordelijken van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Acontactinformatie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dcat:contactPoint) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor contactinformatie (dcat:contactPoint)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor contactinformatie (dcat:contactPoint)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="creatiedatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/6b0d5813153da700505d795c17d681878225c6d1">
    <sch:title>Creatiedatum - Het tijdsmoment waarop de dataservice voor het eerst werd geactiveerd. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Acreatiedatum)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:created) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor creatiedatum (dct:created)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor creatiedatum (dct:created)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="creatiedatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/a0b7156be408a447d937582d4d0c3cafea754f8b">
    <sch:title>Creatiedatum - Het tijdsmoment waarop de dataservice voor het eerst werd geactiveerd. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Acreatiedatum)</sch:title>
    <sch:rule context="//dcat:DataService/dct:created[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">De range van creatiedatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:created)</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">De range van creatiedatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:created)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/67c89165b0f38567bf099862ffdef88f25e68714">
    <sch:title>1315. Endpointurl - De rootlocatie of het primaire endpoint van de dienst (een web-resolvable URI). (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3AendpointURL)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointUrl[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van endpointURL moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (dcat:endpointUrl)</sch:assert>
      <sch:report test="$validClass">De range van endpointURL moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (dcat:endpointUrl)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/9978564bd5823785ddace8934e848c68e6e813e3">
    <sch:title>1317. Endpointurl - De rootlocatie of het primaire endpoint van de dienst (een web-resolvable URI). (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3AendpointURL)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dcat:endpointUrl) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor endpointURL (dcat:endpointUrl)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor endpointURL (dcat:endpointUrl)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointbeschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/66883b2795f003760d4bb617bd1f472da1e1524f">
    <sch:title>1319. Endpointbeschrijving - Een beschrijving van de diensten die beschikbaar zijn via de end-points, met inbegrip van hun operaties, parameters, enz. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aendpointbeschrijving)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dcat:endpointDescription) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor endpointbeschrijving (dcat:endpointDescription)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor endpointbeschrijving (dcat:endpointDescription)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointbeschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/bd44e3e6c4317f226cd1124fbaf1d72e94e8f15e">
    <sch:title>1320. Endpointbeschrijving - Een beschrijving van de diensten die beschikbaar zijn via de end-points, met inbegrip van hun operaties, parameters, enz. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aendpointbeschrijving)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dcat:endpointDescription) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor endpointbeschrijving (dcat:endpointDescription)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor endpointbeschrijving (dcat:endpointDescription)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="endpointbeschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/dbc2548616486a154002cfba6a3bc2cbc554a682">
    <sch:title>1321. Endpointbeschrijving - Een beschrijving van de diensten die beschikbaar zijn via de end-points, met inbegrip van hun operaties, parameters, enz. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aendpointbeschrijving)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:endpointDescription[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van endpointbeschrijving moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:endpointDescription)</sch:assert>
      <sch:report test="$validClass">De range van endpointbeschrijving moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:endpointDescription)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/05134c4e7c34157d6f7ac1128713a08418e0fe7d">
    <sch:title>1322. Identificator - De unieke identificator van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:DataService/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:assert>
      <sch:report test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:title>1323. Identificator - De unieke identificator van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:identifier) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:title>1324. Identificator - De unieke identificator van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:identifier) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/fe1a78c9169da2469a23fd783cf9a69060bfe198">
    <sch:title>1327. Landingspagina - Een algemene webpagina waarnaar kan worden genavigeerd in een webbrowser, met algemene aanvullende informatie over de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:landingPage[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van landingspagina moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:landingPage)</sch:assert>
      <sch:report test="$validClass">De range van landingspagina moet van het type &lt;http://www.w3.org/2001/XMLSchema#anyURI&gt; zijn. (dcat:landingPage)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor authenticatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/2be8f764879c3f2218306704a430503d286c30e9">
    <sch:title>1328. Landingspagina voor authenticatie - Een verwijzing naar de landingspagina met de specifieke informatie over de authenticatie voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina%20voor%20authenticatie)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorAuthenticatie[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van landingspagina voor authenticatie moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (mdcat:landingspaginaVoorAuthenticatie)</sch:assert>
      <sch:report test="$validClass">De range van landingspagina voor authenticatie moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (mdcat:landingspaginaVoorAuthenticatie)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor authenticatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/e9bf439f5272396af4486645c4dd4ae47c27c030">
    <sch:title>1330. Landingspagina voor authenticatie - Een verwijzing naar de landingspagina met de specifieke informatie over de authenticatie voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina%20voor%20authenticatie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:landingspaginaVoorAuthenticatie) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor landingspagina voor authenticatie (mdcat:landingspaginaVoorAuthenticatie)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor landingspagina voor authenticatie (mdcat:landingspaginaVoorAuthenticatie)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor gebruiksinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/b643cb8952d752ef63a2b25c7fcebd89d08fb015">
    <sch:title>1332. Landingspagina voor gebruiksinformatie - Een verwijzing naar de landingspagina met de specifieke informatie over het gebruik van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina%20voor%20gebruiksinformatie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:landingspaginaVoorGebruiksinformatie) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor landingspagina voor gebruiksinformatie (mdcat:landingspaginaVoorGebruiksinformatie)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor landingspagina voor gebruiksinformatie (mdcat:landingspaginaVoorGebruiksinformatie)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor gebruiksinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/c4eb7e771a95c6c3e5c04255458173a2b0b40f43">
    <sch:title>1333. Landingspagina voor gebruiksinformatie - Een verwijzing naar de landingspagina met de specifieke informatie over het gebruik van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina%20voor%20gebruiksinformatie)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorGebruiksinformatie[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van landingspagina voor gebruiksinformatie moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (mdcat:landingspaginaVoorGebruiksinformatie)</sch:assert>
      <sch:report test="$validClass">De range van landingspagina voor gebruiksinformatie moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (mdcat:landingspaginaVoorGebruiksinformatie)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor statusinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/0cdcfe2387440711ebbe94a2fcc93a29377956c5">
    <sch:title>1334. Landingspagina voor statusinformatie - Een verwijzing naar de statuspagina van de dataservice (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina%20voor%20statusinformatie)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:landingspaginaVoorStatusinformatie[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van landingspagina voor statusinformatie moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (mdcat:landingspaginaVoorStatusinformatie)</sch:assert>
      <sch:report test="$validClass">De range van landingspagina voor statusinformatie moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (mdcat:landingspaginaVoorStatusinformatie)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina voor statusinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/82e4f4e38a285ebeffb0f14c036b491b71a26200">
    <sch:title>1336. Landingspagina voor statusinformatie - Een verwijzing naar de statuspagina van de dataservice (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alandingspagina%20voor%20statusinformatie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:landingspaginaVoorStatusinformatie) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor landingspagina voor statusinformatie (mdcat:landingspaginaVoorStatusinformatie)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor landingspagina voor statusinformatie (mdcat:landingspaginaVoorStatusinformatie)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="levensfase" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/13afabc6c35a0042403bd3a9f50222200152231a">
    <sch:title>1338. Levensfase - De levensfase waarin de dataservice zich bevindt. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alevensfase)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:levensfase[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van levensfase moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (mdcat:levensfase)</sch:assert>
      <sch:report test="$validClass">De range van levensfase moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (mdcat:levensfase)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="levensfase" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/8a32a3e6b5ca4b68f8846b184e7faa4f48a0ee1d">
    <sch:title>1340. Levensfase - De levensfase waarin de dataservice zich bevindt. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alevensfase)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:levensfase) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor levensfase (mdcat:levensfase)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor levensfase (mdcat:levensfase)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/509740cc7b3c86ebee90dc6303c11c40e2b08212">
    <sch:title>1341. Licentie - De licentie van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alicentie)</sch:title>
    <sch:rule context="//dcat:DataService/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van licentie moet van het type &lt;http://purl.org/dc/terms/LicenseDocument&gt; zijn. (dct:license)</sch:assert>
      <sch:report test="$validClass">De range van licentie moet van het type &lt;http://purl.org/dc/terms/LicenseDocument&gt; zijn. (dct:license)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/cafd2e3e66044d8ba2c435a9353e6880952086c5">
    <sch:title>1343. Licentie - De licentie van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Alicentie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:license) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor licentie (dct:license)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor licentie (dct:license)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/4523d6e75f8993d15c9332b0aae5dbbe64a85b5a">
    <sch:title>1345. Ontwikkelingstoestand - De ontwikkelingstoestand waarin de dataservice is gedeployed. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aontwikkelingstoestand)</sch:title>
    <sch:rule context="//dcat:DataService/mdcat:ontwikkelingstoestand[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van ontwikkelingstoestand moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (mdcat:ontwikkelingstoestand)</sch:assert>
      <sch:report test="$validClass">De range van ontwikkelingstoestand moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (mdcat:ontwikkelingstoestand)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="ontwikkelingstoestand" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/76f6cfca9a1964a539a879c911777c741a37cff0">
    <sch:title>1346. Ontwikkelingstoestand - De ontwikkelingstoestand waarin de dataservice is gedeployed. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aontwikkelingstoestand)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(mdcat:ontwikkelingstoestand) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor ontwikkelingstoestand (mdcat:ontwikkelingstoestand)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor ontwikkelingstoestand (mdcat:ontwikkelingstoestand)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/0e54e6660eb6bc0ea08ebfce3dbbf188c3e400d8">
    <sch:title>Publicatiedatum - Het tijdsmoment waarop de service werd gepubliceerd door de uitgever. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Apublicatiedatum)</sch:title>
    <sch:rule context="//dcat:DataService/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">De range van publicatiedatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:issued)</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">De range van publicatiedatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:issued)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/fe9c62143da275c7458e0e71dedeb277670a016b">
    <sch:title>Publicatiedatum - Het tijdsmoment waarop de service werd gepubliceerd door de uitgever. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Apublicatiedatum)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:issued) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor publicatiedatum (dct:issued)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor publicatiedatum (dct:issued)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rechten" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/62bb7a143add01ac0956709b58850f4f5e5a0e47">
    <sch:title>1349. Rechten - Bepalingen van juridische aard die gelden op de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Arechten)</sch:title>
    <sch:rule context="//dcat:DataService/dct:rights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van rechten moet van het type &lt;http://purl.org/dc/terms/RightsStatement&gt; zijn. (dct:rights)</sch:assert>
      <sch:report test="$validClass">De range van rechten moet van het type &lt;http://purl.org/dc/terms/RightsStatement&gt; zijn. (dct:rights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/f96c5f798f9e9c00220a293bd11f37e83616d33b">
    <sch:title>Statuut - Een aanduiding van op welke basis de catalogusresource beschikbaar is. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Astatuut)</sch:title>
    <sch:rule context="//dcat:DataService/dct:subject[skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'][$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van statuut moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:subject[skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'])</sch:assert>
      <sch:report test="$validClass">De range van statuut moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:subject[skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'])</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/1712ef1b325d7d2807bc601d6409b70a42eaff10">
    <sch:title>1351. Thema - De hoofdcategorie waartoe de dataservice behoort. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Athema)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:theme[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van thema moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dcat:theme)</sch:assert>
      <sch:report test="$validClass">De range van thema moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dcat:theme)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/25d18a6e2598024ea186cc7be4391bdfd1bca21f">
    <sch:title>1354. Titel - De naam van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atitel)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:title) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor titel (dct:title)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>1357. Titel - De naam van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atitel)</sch:title>
    <sch:rule context="//dcat:DataService/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>1358. Titel - De naam van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atitel)</sch:title>
    <sch:rule context="//dcat:DataService/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/7463895a2bb9e7e4c96cd9a2e7f83ce2cf787098">
    <sch:title>1360. Toegankelijkheid - De toegankelijkheid voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:accessRights) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/a81035a5dbbdae24651c34e5602a1fe6fe5427a3">
    <sch:title>1361. Toegankelijkheid - De toegankelijkheid voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:DataService/dct:accessRights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van toegankelijkheid moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:accessRights)</sch:assert>
      <sch:report test="$validClass">De range van toegankelijkheid moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/f9524ba86e28981345a2b84aea788460ad4e805e">
    <sch:title>1363. Toegankelijkheid - De toegankelijkheid voor de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:accessRights) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/1b8b3557ea1ccbabc0962c345782ae53740e72e1">
    <sch:title>1364. Trefwoord - Een trefwoord of tag die de resource beschrijft. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atrefwoord)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:keyword[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dcat:keyword[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor trefwoord (dcat:keyword)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor trefwoord (dcat:keyword)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/44f6426e2306c5bc0421823eb4a1a034b615f715">
    <sch:title>1365. Trefwoord - Een trefwoord of tag die de resource beschrijft. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Atrefwoord)</sch:title>
    <sch:rule context="//dcat:DataService/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van trefwoord moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dcat:keyword)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van trefwoord moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dcat:keyword)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/302090a90a5755780bc8fe09be4bcd29193cfd6d">
    <sch:title>1667. Versie - Een unieke aanduiding van een variant van de dataservice door middel van een versienummer of -naam van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aversie)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(owl:versionInfo) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor versie (owl:versionInfo)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor versie (owl:versionInfo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/587f313308111b587d1bd2440a56622e64624864">
    <sch:title>1668. Versie - Een unieke aanduiding van een variant van de dataservice door middel van een versienummer of -naam van de dataservice. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Aversie)</sch:title>
    <sch:rule context="//dcat:DataService/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van versie moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (owl:versionInfo)</sch:assert>
      <sch:report test="$isLiteral">De range van versie moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (owl:versionInfo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/29906bf16cadf6d568c4da3e161ef38ba2f726fd">
    <sch:title>Wijzigingsdatum - Het tijdsmoment waarop de dataservice werd gewijzigd (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Awijzigingsdatum)</sch:title>
    <sch:rule context="//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:modified) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor wijzigingsdatum (dct:modified)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor wijzigingsdatum (dct:modified)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#DataServiceShape/9e7585433d0896bc44cb41cdd8189793bd115cd0">
    <sch:title>Wijzigingsdatum - Het tijdsmoment waarop de dataservice werd gewijzigd (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#DataService%3Awijzigingsdatum)</sch:title>
    <sch:rule context="//dcat:DataService/dct:modified[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">De range van wijzigingsdatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:modified)</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">De range van wijzigingsdatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:modified)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>v067. Alternatieve identificator - Een alternatieve identificator (dan de unieke identificator) voor een dataset kan hier beschreven worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aalternatieve%20identificator)</sch:title>
    <sch:rule context="//dcat:Dataset/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:assert>
      <sch:report test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>v207. Beschrijving - Een bondige tekstuele omschrijving van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van beschrijving moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:description)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van beschrijving moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/7521953addc62cf367ab3c8ec0dc63cb5981ea23">
    <sch:title>v037. Beschrijving - Een bondige tekstuele omschrijving van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dct:description) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor beschrijving (dct:description)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor beschrijving (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/da05d674f29a225a7115411e9f7ca442a25f2c88">
    <sch:title>v215. Beschrijving - Een bondige tekstuele omschrijving van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor beschrijving (dct:description)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor beschrijving (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/dd5cf5b162b3f92600a391f44660bf2b255693ac">
    <sch:title>v056. Conform - Een standaard, schema, applicatieprofiel, vocabularium, CRS, ... waaraan de dataset voldoet. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aconform)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van conform moet van het type &lt;http://purl.org/dc/terms/Standard&gt; zijn. (dct:conformsTo)</sch:assert>
      <sch:report test="$validClass">De range van conform moet van het type &lt;http://purl.org/dc/terms/Standard&gt; zijn. (dct:conformsTo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/19ee039173472235e539aea2aa961ff7d3b89f5a">
    <sch:title>1705. Contactinformatie - De relevante contactinformatie waarmee een eindgebruiker in contact kan treden met de verantwoordelijken van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Acontactinformatie)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dcat:contactPoint) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor contactinformatie (dcat:contactPoint)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor contactinformatie (dcat:contactPoint)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/458062b0ae03c559426b85df3dd28e1c785acb0b">
    <sch:title>1406. Contactinformatie - De relevante contactinformatie waarmee een eindgebruiker in contact kan treden met de verantwoordelijken van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Acontactinformatie)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:contactPoint[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(vcard:Organization) = 1 or count(//vcard:Organization[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van contactinformatie moet van het type &lt;http://www.w3.org/2006/vcard/ns#Kind&gt; zijn. (dcat:contactPoint)</sch:assert>
      <sch:report test="$validClass">De range van contactinformatie moet van het type &lt;http://www.w3.org/2006/vcard/ns#Kind&gt; zijn. (dcat:contactPoint)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="contactinformatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/e332dbce5947de4314c3ed3fe5862f26d70a15c4">
    <sch:title>v041. Contactinformatie - De relevante contactinformatie waarmee een eindgebruiker in contact kan treden met de verantwoordelijken van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Acontactinformatie)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dcat:contactPoint) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor contactinformatie (dcat:contactPoint)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor contactinformatie (dcat:contactPoint)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="creatiedatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/6b0d5813153da700505d795c17d681878225c6d1">
    <sch:title>Creatiedatum - Het tijdsmoment waarop de dataset ontstaan is. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Acreatiedatum)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dct:created) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor creatiedatum (dct:created)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor creatiedatum (dct:created)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="creatiedatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/a0b7156be408a447d937582d4d0c3cafea754f8b">
    <sch:title>Creatiedatum - Het tijdsmoment waarop de dataset ontstaan is. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Acreatiedatum)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:created[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">De range van creatiedatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:created)</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">De range van creatiedatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:created)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="distributie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/cfbe0a11423fe15e990c3cbd5209404c26dbef0f">
    <sch:title>v046. Distributie - Een beschikbare distributie van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Adistributie)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:distribution[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Distribution) = 1 or count(//dcat:Distribution[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van distributie moet van het type &lt;http://www.w3.org/ns/dcat#Distribution&gt; zijn. (dcat:distribution)</sch:assert>
      <sch:report test="$validClass">De range van distributie moet van het type &lt;http://www.w3.org/ns/dcat#Distribution&gt; zijn. (dcat:distribution)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="eigenaar" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/0addb769185db828aa4c44888f0aa906471c3d06">
    <sch:title>Eigenaar - de agent die de eigendomsrechten heeft (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aeigenaar)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:rightsHolder[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent) = 1 or count(//foaf:Agent[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van eigenaar moet van het type &lt;http://purl.org/dc/terms/Agent&gt; zijn. (dct:rightsHolder)</sch:assert>
      <sch:report test="$validClass">De range van eigenaar moet van het type &lt;http://purl.org/dc/terms/Agent&gt; zijn. (dct:rightsHolder)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="geografische dekking" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/883b5dc28b6bef2ce82b138ead1eb3c7f2073b92">
    <sch:title>Geografische dekking - Het geografische gebied waarover de dataset informatie heeft. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Ageografische%20dekking)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:spatial[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Location) = 1 or count(//dct:Location[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van geografische dekking moet van het type &lt;http://purl.org/dc/terms/Location&gt; zijn. (dct:spatial)</sch:assert>
      <sch:report test="$validClass">De range van geografische dekking moet van het type &lt;http://purl.org/dc/terms/Location&gt; zijn. (dct:spatial)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="herkomst" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/7f7729e4df614394423f92badbe4304148f90b07">
    <sch:title>Herkomst - De ontstaansgeschiedenis van een dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aherkomst)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:provenance[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:ProvenanceStatement) = 1 or count(//dct:ProvenanceStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van herkomst moet van het type &lt;http://purl.org/dc/terms/ProvenanceStatement&gt; zijn. (dct:provenance)</sch:assert>
      <sch:report test="$validClass">De range van herkomst moet van het type &lt;http://purl.org/dc/terms/ProvenanceStatement&gt; zijn. (dct:provenance)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/05134c4e7c34157d6f7ac1128713a08418e0fe7d">
    <sch:title>v060. Identificator - De unieke identificator van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:assert>
      <sch:report test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:title>1708. Identificator - De unieke identificator van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dct:identifier) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:title>1409. Identificator - De unieke identificator van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dct:identifier) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="landingspagina" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/fe1a78c9169da2469a23fd783cf9a69060bfe198">
    <sch:title>1712. Landingspagina - Een algemene webpagina waarnaar kan worden genavigeerd in een webbrowser, met algemene informatie over de dataset, zijn distributies en/of aanvullende informatie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Alandingspagina)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:landingPage[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van landingspagina moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (dcat:landingPage)</sch:assert>
      <sch:report test="$validClass">De range van landingspagina moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (dcat:landingPage)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/0e54e6660eb6bc0ea08ebfce3dbbf188c3e400d8">
    <sch:title>Publicatiedatum - Het tijdsmoment waarop de dataset werd gepubliceerd door de uitgever. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Apublicatiedatum)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:issued[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">De range van publicatiedatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:issued)</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">De range van publicatiedatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:issued)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="publicatiedatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/fe9c62143da275c7458e0e71dedeb277670a016b">
    <sch:title>Publicatiedatum - Het tijdsmoment waarop de dataset werd gepubliceerd door de uitgever. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Apublicatiedatum)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dct:issued) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor publicatiedatum (dct:issued)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor publicatiedatum (dct:issued)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="statuut" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/f96c5f798f9e9c00220a293bd11f37e83616d33b">
    <sch:title>Statuut - Een aanduiding van op welke basis de catalogusresource beschikbaar is. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Astatuut)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:subject[skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'][$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van statuut moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:subject[skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'])</sch:assert>
      <sch:report test="$validClass">De range van statuut moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:subject[skos:Concept/skos:inScheme/@rdf:resource = 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden'])</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="thema" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/1712ef1b325d7d2807bc601d6409b70a42eaff10">
    <sch:title>v115. Thema - De hoofdcategorie waartoe de dataset behoort. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Athema)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:theme[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van thema moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dcat:theme)</sch:assert>
      <sch:report test="$validClass">De range van thema moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dcat:theme)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/25d18a6e2598024ea186cc7be4391bdfd1bca21f">
    <sch:title>v039. Titel - De naam van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atitel)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dct:title) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor titel (dct:title)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>v214. Titel - De naam van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atitel)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>v206. Titel - De naam van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atitel)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/7463895a2bb9e7e4c96cd9a2e7f83ce2cf787098">
    <sch:title>1716. Toegankelijkheid - De toegankelijkheid voor de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMin" value="count(dct:accessRights) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/a81035a5dbbdae24651c34e5602a1fe6fe5427a3">
    <sch:title>1717. Toegankelijkheid - De toegankelijkheid voor de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:accessRights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van toegankelijkheid moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:accessRights)</sch:assert>
      <sch:report test="$validClass">De range van toegankelijkheid moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegankelijkheid" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/f9524ba86e28981345a2b84aea788460ad4e805e">
    <sch:title>v100. Toegankelijkheid - De toegankelijkheid voor de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atoegankelijkheid)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dct:accessRights) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor toegankelijkheid (dct:accessRights)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor toegankelijkheid (dct:accessRights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/1b8b3557ea1ccbabc0962c345782ae53740e72e1">
    <sch:title>1719. Trefwoord - Een trefwoord of tag die de resource beschrijft. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atrefwoord)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:keyword[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dcat:keyword[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor trefwoord (dcat:keyword)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor trefwoord (dcat:keyword)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="trefwoord" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/44f6426e2306c5bc0421823eb4a1a034b615f715">
    <sch:title>1720. Trefwoord - Een trefwoord of tag die de resource beschrijft. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Atrefwoord)</sch:title>
    <sch:rule context="//dcat:Dataset/dcat:keyword[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van trefwoord moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dcat:keyword)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van trefwoord moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dcat:keyword)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/302090a90a5755780bc8fe09be4bcd29193cfd6d">
    <sch:title>v076. Versie - Een unieke aanduiding van een variant van de dataset door middel van een versienummer of -naam van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aversie)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(owl:versionInfo) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor versie (owl:versionInfo)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor versie (owl:versionInfo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="versie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/587f313308111b587d1bd2440a56622e64624864">
    <sch:title>v075. Versie - Een unieke aanduiding van een variant van de dataset door middel van een versienummer of -naam van de dataset. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Aversie)</sch:title>
    <sch:rule context="//dcat:Dataset/owl:versionInfo[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van versie moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (owl:versionInfo)</sch:assert>
      <sch:report test="$isLiteral">De range van versie moet van het type &lt;http://www.w3.org/2001/XMLSchema#string&gt; zijn. (owl:versionInfo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="voorbeeldweergave" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/b797fd4af5bc2767e8e3a3799a5aae84ec998d04">
    <sch:title>Voorbeeldweergave - Een verkleinde weergave van een afbeelding die de dataset illustreert.? (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Avoorbeeldweergave)</sch:title>
    <sch:rule context="//dcat:Dataset/adms:sample[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Distribution) = 1 or count(//dcat:Distribution[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van voorbeeldweergave moet van het type &lt;http://www.w3.org/ns/dcat#Distribution&gt; zijn. (adms:sample)</sch:assert>
      <sch:report test="$validClass">De range van voorbeeldweergave moet van het type &lt;http://www.w3.org/ns/dcat#Distribution&gt; zijn. (adms:sample)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/29906bf16cadf6d568c4da3e161ef38ba2f726fd">
    <sch:title>Wijzigingsdatum - Het tijdsmoment waarop de dataset werd geactualiseerd (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Awijzigingsdatum)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]">
      <sch:let name="validMax" value="count(dct:modified) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor wijzigingsdatum (dct:modified)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor wijzigingsdatum (dct:modified)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wijzigingsdatum" id="https://data.vlaanderen.be/shacl/metadata_dcat#DatasetShape/9e7585433d0896bc44cb41cdd8189793bd115cd0">
    <sch:title>Wijzigingsdatum - Het tijdsmoment waarop de dataset werd geactualiseerd (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Dataset%3Awijzigingsdatum)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:modified[$profile]">
      <sch:let name="isNotEmpty" value="normalize-space(.) != ''"/>
      <sch:let name="isDate" value="matches(., '^\d{4}-\d{2}-\d{2}(Z|(-|\+)\d{2}:\d{2}|T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|(-|\+)\d{2}:\d{2})?)?$')"/>
      <sch:assert test="$isNotEmpty and $isDate">De range van wijzigingsdatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:modified)</sch:assert>
      <sch:report test="$isNotEmpty and $isDate">De range van wijzigingsdatum moet van het type &lt;http://www.w3.org/2001/XMLSchema#dateTime&gt; zijn. (dct:modified)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="alternatieve identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/39607ae8317e4f99846f57f713d51b19528e5764">
    <sch:title>1801. Alternatieve identificator - Een alternatieve identificator (dan de unieke identificator) voor een distributie kan hier beschreven worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Aalternatieve%20identificator)</sch:title>
    <sch:rule context="//dcat:Distribution/adms:identifier[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(adms:Identifier) = 1 or count(//adms:Identifier[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:assert>
      <sch:report test="$validClass">De range van alternatieve identificator moet van het type &lt;http://www.w3.org/ns/adms#Identifier&gt; zijn. (adms:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="conform" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/dd5cf5b162b3f92600a391f44660bf2b255693ac">
    <sch:title>Conform - Een standaard, schema, implementatie-
model, applicatieprofiel, vocabularium
waaraan de distributie voldoet. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Aconform)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:conformsTo[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:Standard) = 1 or count(//dct:Standard[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van conform moet van het type &lt;http://purl.org/dc/terms/Standard&gt; zijn. (dct:conformsTo)</sch:assert>
      <sch:report test="$validClass">De range van conform moet van het type &lt;http://purl.org/dc/terms/Standard&gt; zijn. (dct:conformsTo)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/0e61107f343f202ee672ef465cfcdbbcd746e21d">
    <sch:title>1803. Downloadurl - De URL waar de data gedownload kan worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3AdownloadURL)</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:downloadURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van downloadURL moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (dcat:downloadURL)</sch:assert>
      <sch:report test="$validClass">De range van downloadURL moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (dcat:downloadURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/1ff94e5c0d35c7d1a7f2c4bd160a8c8e4eee6f97">
    <sch:title>v090. Downloadurl - De URL waar de data gedownload kan worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3AdownloadURL)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dcat:downloadURL) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor downloadURL (dcat:downloadURL)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor downloadURL (dcat:downloadURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="formaat" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/866f7e6bf04104e9aa0f82fa4b8b0ff05ef17dc7">
    <sch:title>Formaat - Het bestandsformaat waarin de data wordt gedeeld. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Aformaat)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:format[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van formaat moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:format)</sch:assert>
      <sch:report test="$validClass">De range van formaat moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dct:format)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="formaat" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/c202c852e84ae0c736f1f6a8f8030db817602116">
    <sch:title>1901. Formaat - Het bestandsformaat waarin de data wordt gedeeld. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Aformaat)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dct:format) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor formaat (dct:format)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor formaat (dct:format)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/05134c4e7c34157d6f7ac1128713a08418e0fe7d">
    <sch:title>1902. Identificator - De unieke identificator van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:identifier[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:assert test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:assert>
      <sch:report test="$isLiteral">De range van identificator moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Literal&gt; zijn. (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/972d73e7a13100b66c0c2f44466edac47aa1ab28">
    <sch:title>1903. Identificator - De unieke identificator van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMin" value="count(dct:identifier) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="identificator" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/bb43a48c77e7d98609af3d3bb1b1648370465308">
    <sch:title>1904. Identificator - De unieke identificator van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Aidentificator)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dct:identifier) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor identificator (dct:identifier)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/509740cc7b3c86ebee90dc6303c11c40e2b08212">
    <sch:title>v087. Licentie - De licentie van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Alicentie)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:license[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:LicenseDocument) = 1 or count(//dct:LicenseDocument[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van licentie moet van het type &lt;http://purl.org/dc/terms/LicenseDocument&gt; zijn. (dct:license)</sch:assert>
      <sch:report test="$validClass">De range van licentie moet van het type &lt;http://purl.org/dc/terms/LicenseDocument&gt; zijn. (dct:license)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="licentie" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/cafd2e3e66044d8ba2c435a9353e6880952086c5">
    <sch:title>v088. Licentie - De licentie van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Alicentie)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dct:license) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor licentie (dct:license)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor licentie (dct:license)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rechten" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/62bb7a143add01ac0956709b58850f4f5e5a0e47">
    <sch:title>1907. Rechten - Bepalingen van juridische aard die gelden op de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Arechten)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:rights[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dct:RightsStatement) = 1 or count(//dct:RightsStatement[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van rechten moet van het type &lt;http://purl.org/dc/terms/RightsStatement&gt; zijn. (dct:rights)</sch:assert>
      <sch:report test="$validClass">De range van rechten moet van het type &lt;http://purl.org/dc/terms/RightsStatement&gt; zijn. (dct:rights)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>v216. Titel - De naam van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Atitel)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>v205. Titel - De naam van de distributie. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Atitel)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegangsURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/28a9b5a610271b2ad2cd6917763075560213ca20">
    <sch:title>v220. Toegangsurl - Een URL waar de data kan gevonden worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3AtoegangsURL)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dcat:accessURL) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor toegangsURL (dcat:accessURL)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor toegangsURL (dcat:accessURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegangsURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/3d0e850677d211050dd9e93ec6496e6af9908da6">
    <sch:title>1910. Toegangsurl - Een URL waar de data kan gevonden worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3AtoegangsURL)</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van toegangsURL moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (dcat:accessURL)</sch:assert>
      <sch:report test="$validClass">De range van toegangsURL moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (dcat:accessURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="toegangsURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/bf4475984ce7d0eb4bade6e749e672a8efa7dd2d">
    <sch:title>v079. Toegangsurl - Een URL waar de data kan gevonden worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3AtoegangsURL)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMin" value="count(dcat:accessURL) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor toegangsURL (dcat:accessURL)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor toegangsURL (dcat:accessURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="verdeler" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/97ed7a72fee66a4fd972d36d70822272beaf40ce">
    <sch:title>Verdeler - de agent die instaat voor de verdeling (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Averdeler)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(geodcat:distributor) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor verdeler (geodcat:distributor)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor verdeler (geodcat:distributor)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="verdeler" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/e142be9d61d29a86c3e36db738d8a9600b4a6ba7">
    <sch:title>Verdeler - de agent die instaat voor de verdeling (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Averdeler)</sch:title>
    <sch:rule context="//dcat:Distribution/geodcat:distributor[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent) = 1 or count(//foaf:Agent[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van verdeler moet van het type &lt;http://purl.org/dc/terms/Agent&gt; zijn. (geodcat:distributor)</sch:assert>
      <sch:report test="$validClass">De range van verdeler moet van het type &lt;http://purl.org/dc/terms/Agent&gt; zijn. (geodcat:distributor)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="wordt aangeboden door" id="https://data.vlaanderen.be/shacl/metadata_dcat#DistributieShape/c612c1f62d45c84405f45260ab0737a10f5b0a18">
    <sch:title>1912. Wordt aangeboden door - Een dataservice die deze distributie aanbiedt. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#Distributie%3Awordt%20aangeboden%20door)</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:accessService[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="matches($resource, '^\w+:(/?/?)[^\s]+$')"/>
      <sch:assert test="$validClass">De range van wordt aangeboden door moet van het type &lt;http://www.w3.org/ns/dcat#DataService&gt; zijn. (dcat:accessService)</sch:assert>
      <sch:report test="$validClass">De range van wordt aangeboden door moet van het type &lt;http://www.w3.org/ns/dcat#DataService&gt; zijn. (dcat:accessService)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#VoorbeeldWeergaveShape/0e9a7d4dbf6ec19568d474169ad717f71e882319">
    <sch:title>Beschrijving - Een bondige tekstuele omschrijving van de afbeelding (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#VoorbeeldWeergave%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:description[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van beschrijving moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:description)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van beschrijving moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="beschrijving" id="https://data.vlaanderen.be/shacl/metadata_dcat#VoorbeeldWeergaveShape/da05d674f29a225a7115411e9f7ca442a25f2c88">
    <sch:title>Beschrijving - Een bondige tekstuele omschrijving van de afbeelding (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#VoorbeeldWeergave%3Abeschrijving)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:description[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:description[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor beschrijving (dct:description)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor beschrijving (dct:description)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#VoorbeeldWeergaveShape/0e61107f343f202ee672ef465cfcdbbcd746e21d">
    <sch:title>Downloadurl - De URL waar de afbeelding gedownload kan worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#VoorbeeldWeergave%3AdownloadURL)</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:downloadURL[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(rdfs:Resource) = 1 or count(//rdfs:Resource[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van downloadURL moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (dcat:downloadURL)</sch:assert>
      <sch:report test="$validClass">De range van downloadURL moet van het type &lt;http://www.w3.org/2000/01/rdf-schema#Resource&gt; zijn. (dcat:downloadURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#VoorbeeldWeergaveShape/1ff94e5c0d35c7d1a7f2c4bd160a8c8e4eee6f97">
    <sch:title>Downloadurl - De URL waar de afbeelding gedownload kan worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#VoorbeeldWeergave%3AdownloadURL)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dcat:downloadURL) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor downloadURL (dcat:downloadURL)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor downloadURL (dcat:downloadURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="downloadURL" id="https://data.vlaanderen.be/shacl/metadata_dcat#VoorbeeldWeergaveShape/ad42d11500885f18c10b5ee1a87b5ceca761f903">
    <sch:title>Downloadurl - De URL waar de afbeelding gedownload kan worden. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#VoorbeeldWeergave%3AdownloadURL)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMin" value="count(dcat:downloadURL) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor downloadURL (dcat:downloadURL)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor downloadURL (dcat:downloadURL)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="mediatype" id="https://data.vlaanderen.be/shacl/metadata_dcat#VoorbeeldWeergaveShape/06b127df99a6de2b3aef269b0d4b8746a5b78dcc">
    <sch:title>Mediatype - Het voorstellingsvorm van de afbeelding (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#VoorbeeldWeergave%3Amediatype)</sch:title>
    <sch:rule context="//dcat:Distribution[$profile]">
      <sch:let name="validMax" value="count(dcat:mediatype) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor mediatype (dcat:mediatype)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor mediatype (dcat:mediatype)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="mediatype" id="https://data.vlaanderen.be/shacl/metadata_dcat#VoorbeeldWeergaveShape/f15bdaee3382af94fe22b0dade89fc2e9fefbbdc">
    <sch:title>Mediatype - Het voorstellingsvorm van de afbeelding (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#VoorbeeldWeergave%3Amediatype)</sch:title>
    <sch:rule context="//dcat:Distribution/dcat:mediatype[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van mediatype moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dcat:mediatype)</sch:assert>
      <sch:report test="$validClass">De range van mediatype moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dcat:mediatype)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#VoorbeeldWeergaveShape/8041fe094c27b123422bd03a4e13ff0641087607">
    <sch:title>Titel - naam van de afbeelding (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#VoorbeeldWeergave%3Atitel)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="current" value="."/>
      <sch:let name="isUniqueLang" value="count(preceding-sibling::dct:title[string() = string($current) and @xml:lang = $current/@xml:lang]) = 0"/>
      <sch:assert test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:assert>
      <sch:report test="$isUniqueLang">Slechts 1 waarde voor elke taal toegelaten voor titel (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="titel" id="https://data.vlaanderen.be/shacl/metadata_dcat#VoorbeeldWeergaveShape/f28ce523c4b4fcb15d8c7d4f279da195ba7403ab">
    <sch:title>Titel - naam van de afbeelding (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#VoorbeeldWeergave%3Atitel)</sch:title>
    <sch:rule context="//dcat:Distribution/dct:title[$profile]">
      <sch:let name="isLiteral" value="normalize-space(.) != ''"/>
      <sch:let name="hasLang" value="normalize-space(@xml:lang) != ''"/>
      <sch:assert test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:assert>
      <sch:report test="$isLiteral and $hasLang">De range van titel moet van het type &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#langString&gt; zijn. (dct:title)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="Catalogus Resource (source)" id="https://data.vlaanderen.be/shacl/metadata_dcat#RelatieQualificatieShape/230fa664054f86199f30c98c6d4140bfb1437470">
    <sch:title>Catalogus resource (source) - Referentie naar verbonden klasse. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#RelatieQualificatie%3ACatalogus%20Resource%20(source))</sch:title>
    <sch:rule context="//dcat:Relationship[$profile]">
      <sch:let name="validMin" value="count(mdcat:RelatieQualificatie.catalogusResource.source) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor Catalogus Resource (source) (mdcat:RelatieQualificatie.catalogusResource.source)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor Catalogus Resource (source) (mdcat:RelatieQualificatie.catalogusResource.source)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="Catalogus Resource (source)" id="https://data.vlaanderen.be/shacl/metadata_dcat#RelatieQualificatieShape/aa69087cd9f59b7d23c9ca16a88c4298d77dcd0c">
    <sch:title>Catalogus resource (source) - Referentie naar verbonden klasse. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#RelatieQualificatie%3ACatalogus%20Resource%20(source))</sch:title>
    <sch:rule context="//dcat:Relationship/mdcat:RelatieQualificatie.catalogusResource.source[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Dataset|dcat:DataService) = 1 or count((//dcat:Dataset|//dcat:DataService)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van Catalogus Resource (source) moet van het type &lt;http://www.w3.org/ns/dcat#Resource&gt; zijn. (mdcat:RelatieQualificatie.catalogusResource.source)</sch:assert>
      <sch:report test="$validClass">De range van Catalogus Resource (source) moet van het type &lt;http://www.w3.org/ns/dcat#Resource&gt; zijn. (mdcat:RelatieQualificatie.catalogusResource.source)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="Catalogus Resource (source)" id="https://data.vlaanderen.be/shacl/metadata_dcat#RelatieQualificatieShape/f5a6aff37ed40db28a354dd68f524952b0433d4a">
    <sch:title>Catalogus resource (source) - Referentie naar verbonden klasse. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#RelatieQualificatie%3ACatalogus%20Resource%20(source))</sch:title>
    <sch:rule context="//dcat:Relationship[$profile]">
      <sch:let name="validMax" value="count(mdcat:RelatieQualificatie.catalogusResource.source) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor Catalogus Resource (source) (mdcat:RelatieQualificatie.catalogusResource.source)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor Catalogus Resource (source) (mdcat:RelatieQualificatie.catalogusResource.source)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="Catalogus Resource (target)" id="https://data.vlaanderen.be/shacl/metadata_dcat#RelatieQualificatieShape/78ce02089c3f0ee33902d0bc3cc0e00e7d26e097">
    <sch:title>Catalogus resource (target) - Referentie naar verbonden klasse. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#RelatieQualificatie%3ACatalogus%20Resource%20(target))</sch:title>
    <sch:rule context="//dcat:Relationship[$profile]">
      <sch:let name="validMin" value="count(mdcat:RelatieQualificatie.catalogusResource.target) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor Catalogus Resource (target) (mdcat:RelatieQualificatie.catalogusResource.target)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor Catalogus Resource (target) (mdcat:RelatieQualificatie.catalogusResource.target)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="Catalogus Resource (target)" id="https://data.vlaanderen.be/shacl/metadata_dcat#RelatieQualificatieShape/80179238c15e4eb0f284c28f3a87c523281be2cd">
    <sch:title>Catalogus resource (target) - Referentie naar verbonden klasse. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#RelatieQualificatie%3ACatalogus%20Resource%20(target))</sch:title>
    <sch:rule context="//dcat:Relationship/mdcat:RelatieQualificatie.catalogusResource.target[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Dataset|dcat:DataService) = 1 or count((//dcat:Dataset|//dcat:DataService)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van Catalogus Resource (target) moet van het type &lt;http://www.w3.org/ns/dcat#Resource&gt; zijn. (mdcat:RelatieQualificatie.catalogusResource.target)</sch:assert>
      <sch:report test="$validClass">De range van Catalogus Resource (target) moet van het type &lt;http://www.w3.org/ns/dcat#Resource&gt; zijn. (mdcat:RelatieQualificatie.catalogusResource.target)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="Catalogus Resource (target)" id="https://data.vlaanderen.be/shacl/metadata_dcat#RelatieQualificatieShape/c883e705823614530bb3fd7b4046023772ea8807">
    <sch:title>Catalogus resource (target) - Referentie naar verbonden klasse. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#RelatieQualificatie%3ACatalogus%20Resource%20(target))</sch:title>
    <sch:rule context="//dcat:Relationship[$profile]">
      <sch:let name="validMax" value="count(mdcat:RelatieQualificatie.catalogusResource.target) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor Catalogus Resource (target) (mdcat:RelatieQualificatie.catalogusResource.target)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor Catalogus Resource (target) (mdcat:RelatieQualificatie.catalogusResource.target)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rol" id="https://data.vlaanderen.be/shacl/metadata_dcat#RelatieQualificatieShape/68837b0eda962a941b0162e1ae4c5f0e471e0c51">
    <sch:title>Rol - De functie hoe de entiteiten zich tot elkaar verhouden.  (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#RelatieQualificatie%3Arol)</sch:title>
    <sch:rule context="//dcat:Relationship[$profile]">
      <sch:let name="validMin" value="count(dcat:hadRole) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor rol (dcat:hadRole)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor rol (dcat:hadRole)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rol" id="https://data.vlaanderen.be/shacl/metadata_dcat#RelatieQualificatieShape/acb59b00c5c67fec8d3f0b2543d5259a09b17d18">
    <sch:title>Rol - De functie hoe de entiteiten zich tot elkaar verhouden.  (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#RelatieQualificatie%3Arol)</sch:title>
    <sch:rule context="//dcat:Relationship[$profile]">
      <sch:let name="validMax" value="count(dcat:hadRole) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor rol (dcat:hadRole)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor rol (dcat:hadRole)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="rol" id="https://data.vlaanderen.be/shacl/metadata_dcat#RelatieQualificatieShape/e5ccf692ee38c28199531eb5e0c59554153a57c3">
    <sch:title>Rol - De functie hoe de entiteiten zich tot elkaar verhouden.  (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#RelatieQualificatie%3Arol)</sch:title>
    <sch:rule context="//dcat:Relationship/dcat:hadRole[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(skos:Concept) = 1 or count(//skos:Concept[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van rol moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dcat:hadRole)</sch:assert>
      <sch:report test="$validClass">De range van rol moet van het type &lt;http://www.w3.org/2004/02/skos/core#Concept&gt; zijn. (dcat:hadRole)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="relatie" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusResourceShape/0f8fcba8defd790e04421c1042f74286d52c564b">
    <sch:title>Relatie - een verband tussen twee resources. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusResource%3Arelatie)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:relation[$profile]|//dcat:DataService/dct:relation[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(dcat:Dataset|dcat:DataService) = 1 or count((//dcat:Dataset|//dcat:DataService)[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van relatie moet van het type &lt;http://www.w3.org/ns/dcat#Resource&gt; zijn. (dct:relation)</sch:assert>
      <sch:report test="$validClass">De range van relatie moet van het type &lt;http://www.w3.org/ns/dcat#Resource&gt; zijn. (dct:relation)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusResourceShape/5334cf8edf5cc07e349524728fe4c9b076e4c45e">
    <sch:title>2002. Uitgever - De uitgever, de entiteit die verantwoordelijk is voor het beschikbaar stellen, van de resource in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusResource%3Auitgever)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]|//dcat:DataService[$profile]">
      <sch:let name="validMax" value="count(dct:publisher) &lt;= 1"/>
      <sch:assert test="$validMax">Maximaal 1 waarden toegelaten voor uitgever (dct:publisher)</sch:assert>
      <sch:report test="$validMax">Maximaal 1 waarden toegelaten voor uitgever (dct:publisher)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusResourceShape/aabe67e6a56c5e2fc5695716e8f7b66edd525085">
    <sch:title>v052. Uitgever - De uitgever, de entiteit die verantwoordelijk is voor het beschikbaar stellen, van de resource in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusResource%3Auitgever)</sch:title>
    <sch:rule context="//dcat:Dataset/dct:publisher[$profile]|//dcat:DataService/dct:publisher[$profile]">
      <sch:let name="resource" value="@rdf:resource"/>
      <sch:let name="validClass" value="count(foaf:Agent) = 1 or count(//foaf:Agent[@rdf:about = $resource]) = 1"/>
      <sch:assert test="$validClass">De range van uitgever moet van het type &lt;http://purl.org/dc/terms/Agent&gt; zijn. (dct:publisher)</sch:assert>
      <sch:report test="$validClass">De range van uitgever moet van het type &lt;http://purl.org/dc/terms/Agent&gt; zijn. (dct:publisher)</sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern name="uitgever" id="https://data.vlaanderen.be/shacl/metadata_dcat#CatalogusResourceShape/e2d4034a0a398701f4257641ebcbc85e8683b29d">
    <sch:title>v049. Uitgever - De uitgever, de entiteit die verantwoordelijk is voor het beschikbaar stellen, van de resource in de catalogus. (https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22#CatalogusResource%3Auitgever)</sch:title>
    <sch:rule context="//dcat:Dataset[$profile]|//dcat:DataService[$profile]">
      <sch:let name="validMin" value="count(dct:publisher) &gt;= 1"/>
      <sch:assert test="$validMin">Minimaal 1 waarden verwacht voor uitgever (dct:publisher)</sch:assert>
      <sch:report test="$validMin">Minimaal 1 waarden verwacht voor uitgever (dct:publisher)</sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>