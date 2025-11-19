<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0"
                exclude-result-prefixes="#all">

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:variable name="dcat-profiles">

    <profile
      uri="https://joinup.ec.europa.eu/collection/semic-support-centre/solution/dcat-application-profile-data-portals-europe/release/200">
      <alias>DCAT-AP</alias>
      <description>DCAT-ap base profile</description>
      <versionInfo>2.0.0</versionInfo>
      <dcatVersion>2.0.0</dcatVersion>
    </profile>

    <profile
      uri="https://interoperable-europe.ec.europa.eu/collection/semic-support-centre/solution/dcat-application-profile-data-portals-europe/release/300">
      <alias>DCAT-AP</alias>
      <description>DCAT-ap base profile</description>
      <versionInfo>3.0.0</versionInfo>
      <dcatVersion>3.0.0</dcatVersion>
    </profile>

    <profile uri="https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03">
      <alias>DCAT-AP-VL</alias>
      <description>Dit applicatieprofiel beschrijft Open Data Catalogi in Vlaanderen. DCAT-AP Vlaanderen (DCAT-AP VL) is
        een verdere specialisatie van DCAT-AP. De applicatie waarop dit profiel betrekking heeft is een Open Data
        Portaal in Vlaanderen. Open Data portalen zijn catalogussen van Open Data datasets. Ze hebben als belangrijkste
        doelstelling het vindbaar maken van data en hierdoor het hergebruik ervan te stimuleren. Open Data portalen
        vervullen een centrale rol in de overheidsopdracht om de toegankelijkheid tot overheidsinformatie te realiseren.
        Met dit applicatieprofiel bevorderen we de uniformiteit van de beschikbare informatie over datasets. Tevens
        vereenvoudigen we het aggregatie proces van meerdere Open Data Catalogi. Dit document bevat de verplichte
        elementen en bijkomende elementen waarover DCAT-AP Vlaanderen een uitspraak doet. Aanbevolen en optionele
        informatie waarvoor geen bijkomende afspraken in de context van DCAT-AP Vlaanderen zijn, zijn niet opgenomen in
        dit document. Hiervoor verwijzen we naar de DCAT-AP specificatie zelf.
      </description>
      <versionInfo>2.0</versionInfo>
      <dcatVersion>2.0.0</dcatVersion>
    </profile>
    <profile uri="https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/xxx">
      <alias>DCAT-AP-VL</alias>
      <description>Dit applicatieprofiel beschrijft Open Data Catalogi in Vlaanderen. DCAT-AP Vlaanderen (DCAT-AP VL) is
        een verdere specialisatie van DCAT-AP. De applicatie waarop dit profiel betrekking heeft is een Open Data
        Portaal in Vlaanderen. Open Data portalen zijn catalogussen van Open Data datasets. Ze hebben als belangrijkste
        doelstelling het vindbaar maken van data en hierdoor het hergebruik ervan te stimuleren. Open Data portalen
        vervullen een centrale rol in de overheidsopdracht om de toegankelijkheid tot overheidsinformatie te realiseren.
        Met dit applicatieprofiel bevorderen we de uniformiteit van de beschikbare informatie over datasets. Tevens
        vereenvoudigen we het aggregatie proces van meerdere Open Data Catalogi. Dit document bevat de verplichte
        elementen en bijkomende elementen waarover DCAT-AP Vlaanderen een uitspraak doet. Aanbevolen en optionele
        informatie waarvoor geen bijkomende afspraken in de context van DCAT-AP Vlaanderen zijn, zijn niet opgenomen in
        dit document. Hiervoor verwijzen we naar de DCAT-AP specificatie zelf.
      </description>
      <versionInfo>3.0</versionInfo>
      <dcatVersion>3.0.0</dcatVersion>
    </profile>

    <profile uri="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22">
      <alias>metadata-dcat</alias>
      <description>Het applicatieprofiel “Metadata DCAT”. Dit is een applicatieprofiel gebaseerd op DCAT en richt zich
        op het verzamelen van informatie over generieke datasets, distributies en services die door een overheid
        beschikbaar gesteld worden. De datasets en services omvatten zowel publiek toegankelijke als afgeschermde data
        en diensten (ontwikkeld in en voor eender welk technisch perspectief). Het samenbrengen van al deze informatie
        in een catalogus laat toe om de vindbaarheid van deze datasets en services te verhogen. Dit applicatieprofiel is
        het generieke basisprofiel. Afgeleide profielen kunnen zeker aangemaakt worden voor specifieke domeinen of
        communities. Bijvoorbeeld is DCAT-AP-VL zo’n afgeleid applicatieprofiel, specifiek voor het Open data domein en
        bijhorende community.
      </description>
      <versionInfo>2.0</versionInfo>
      <dcatVersion>2.0.0</dcatVersion>
    </profile>
    <profile uri="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/xxx">
      <alias>metadata-dcat</alias>
      <description>Het applicatieprofiel “Metadata DCAT”. Dit is een applicatieprofiel gebaseerd op DCAT en richt zich
        op het verzamelen van informatie over generieke datasets, distributies en services die door een overheid
        beschikbaar gesteld worden. De datasets en services omvatten zowel publiek toegankelijke als afgeschermde data
        en diensten (ontwikkeld in en voor eender welk technisch perspectief). Het samenbrengen van al deze informatie
        in een catalogus laat toe om de vindbaarheid van deze datasets en services te verhogen. Dit applicatieprofiel is
        het generieke basisprofiel. Afgeleide profielen kunnen zeker aangemaakt worden voor specifieke domeinen of
        communities. Bijvoorbeeld is DCAT-AP-VL zo’n afgeleid applicatieprofiel, specifiek voor het Open data domein en
        bijhorende community.
      </description>
      <versionInfo>3.0</versionInfo>
      <dcatVersion>3.0.0</dcatVersion>
    </profile>

    <profile uri="https://www.w3.org/mobility-ap/">
      <alias>mobilityDCAT-AP</alias>
      <description>A mobility extension for the DCAT application profile for data portals in Europe </description>
      <versionInfo>3.0.0</versionInfo>
      <dcatVersion>3.0.0</dcatVersion>
    </profile>

  </xsl:variable>
</xsl:stylesheet>
