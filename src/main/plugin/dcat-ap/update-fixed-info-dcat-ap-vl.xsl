<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright (C) 2001-2016 Food and Agriculture Organization of the
  ~ United Nations (FAO-UN), United Nations World Food Programme (WFP)
  ~ and United Nations Environment Programme (UNEP)
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or (at
  ~ your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful, but
  ~ WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  ~ General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  ~
  ~ Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
  ~ Rome - Italy. email: geonetwork@osgeo.org
  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:spdx="http://spdx.org/rdf/terms#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:adms="http://www.w3.org/ns/adms#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:dcatap="http://data.europa.eu/r5r/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:schema="http://schema.org/"
                xmlns:locn="http://www.w3.org/ns/locn#"
                xmlns:gml="http://www.opengis.net/gml"
                xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
                xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#"
                xmlns:mobilitydcatap="https://w3id.org/mobilitydcat-ap"
                xmlns:gn-fn-dcat-ap="http://geonetwork-opensource.org/xsl/functions/profiles/dcat-ap"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:uuid="java:java.util.UUID"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all"
                version="2.0">

  <xsl:variable name="dcatapvlURI" select="'https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03'"/>
  <xsl:variable name="metadatadcatURI" select="'https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22'"/>


  <!-- Rename dct:subject -->
  <xsl:template mode="update-fixed-info-profile" match="dct:subject[$profile = ($dcatapvlURI, $metadatadcatURI)]">
    <xsl:if test="count(skos:Concept) = 1">
      <mdcat:statuut>
        <xsl:apply-templates mode="update-fixed-info-profile" select="skos:Concept"/>
      </mdcat:statuut>
    </xsl:if>
  </xsl:template>

  <!-- Ensure catalog record VL profile is correctly encoded -->
  <xsl:template mode="update-fixed-info-profile" match="dcat:CatalogRecord/dct:conformsTo/dct:Standard[$profile = $dcatapvlURI]">
    <dct:Standard rdf:about="https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03">
      <dct:identifier>https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03</dct:identifier>
      <dct:title>Dcat-ap-vl</dct:title>
      <dct:description xml:lang="nl">Dit applicatieprofiel beschrijft Open Data Catalogi in Vlaanderen. DCAT-AP Vlaanderen (DCAT-AP VL) is een verdere specialisatie van DCAT-AP. De applicatie waarop dit profiel betrekking heeft is een Open Data Portaal in Vlaanderen. Open Data portalen zijn catalogussen van Open Data datasets. Ze hebben als belangrijkste doelstelling het vindbaar maken van data en hierdoor het hergebruik ervan te stimuleren. Open Data portalen vervullen een centrale rol in de overheidsopdracht om de toegankelijkheid tot overheidsinformatie te realiseren. Met dit applicatieprofiel bevorderen we de uniformiteit van de beschikbare informatie over datasets. Tevens vereenvoudigen we het aggregatie proces van meerdere Open Data Catalogi. Dit document bevat de verplichte elementen en bijkomende elementen waarover DCAT-AP Vlaanderen een uitspraak doet. Aanbevolen en optionele informatie waarvoor geen bijkomende afspraken in de context van DCAT-AP Vlaanderen zijn, zijn niet opgenomen in dit document. Hiervoor verwijzen we naar de DCAT-AP specificatie zelf.</dct:description>
      <owl:versionInfo>2.0</owl:versionInfo>
    </dct:Standard>
  </xsl:template>

  <xsl:template mode="update-fixed-info-profile" match="dcat:CatalogRecord/dct:conformsTo/dct:Standard[$profile = $metadatadcatURI]">
    <dct:Standard rdf:about="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22">
      <dct:identifier>https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22</dct:identifier>
      <dct:title>Metadata-dcat</dct:title>
      <dct:description xml:lang="nl">Het applicatieprofiel “metadata dcat”. Dit is een applicatieprofiel gebaseerd op DCAT en richt zich op het verzamelen van informatie over generieke datasets, distributies en services die door een overheid beschikbaar gesteld worden. De datasets en services omvatten zowel publiek toegankelijke als afgeschermde data en diensten (ontwikkeld in en voor eender welk technisch perspectief). Het samenbrengen van al deze informatie in een catalogus laat toe om de vindbaarheid van deze datasets en services te verhogen. Dit applicatieprofiel is het generieke basisprofiel. Afgeleide profielen kunnen zeker aangemaakt worden voor specifieke domeinen of communities. Bijvoorbeeld is DCAT-AP-VL zo’n afgeleid applicatieprofiel, specifiek voor het Open data domein en bijhorende community.</dct:description>
      <owl:versionInfo>2.0</owl:versionInfo>
    </dct:Standard>
  </xsl:template>


  <!-- Enforce open data keyword on DCAT-ap-VL -->
  <xsl:template mode="update-fixed-info-profile" match="dcat:Dataset[$profile = $dcatapvlURI]|dcat:DataService[$profile = $dcatapvlURI]">
    <xsl:copy copy-namespaces="no">
      <xsl:copy-of select="@*"/>
      <xsl:choose>
        <xsl:when test="name() = 'dcat:Dataset'">
          <mdcat:statuut>
            <skos:Concept rdf:about="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATA">
              <skos:prefLabel xml:lang="nl">Vlaamse Open data</skos:prefLabel>
              <skos:prefLabel xml:lang="en">Vlaamse Open data</skos:prefLabel>
              <skos:prefLabel xml:lang="fr">Vlaamse Open data</skos:prefLabel>
              <skos:prefLabel xml:lang="de">Vlaamse Open data</skos:prefLabel>
              <skos:inScheme rdf:resource="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden"/>
            </skos:Concept>
          </mdcat:statuut>
        </xsl:when>
        <xsl:otherwise>
          <mdcat:statuut>
            <skos:Concept rdf:about="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATASERVICE">
              <skos:prefLabel xml:lang="nl">Vlaamse Open data Service</skos:prefLabel>
              <skos:prefLabel xml:lang="en">Vlaamse Open data Service</skos:prefLabel>
              <skos:prefLabel xml:lang="fr">Vlaamse Open data Service</skos:prefLabel>
              <skos:prefLabel xml:lang="de">Vlaamse Open data Service</skos:prefLabel>
              <skos:inScheme rdf:resource="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden"/>
            </skos:Concept>
          </mdcat:statuut>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="update-fixed-info-profile" select="* intersect (mdcat:statuut | dct:subject)[not(skos:Concept/@rdf:about = (
          'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATA',
          'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATASERVICE'
        ))]"/>

      <xsl:apply-templates mode="update-fixed-info-profile" select="* except (mdcat:statuut | dct:subject)"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
