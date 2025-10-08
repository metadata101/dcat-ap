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

  <!-- Ensure catalog record VL profile is correctly encoded. This overwrites what was set in the snippet list of config-editor.xml and ensures all languages are present. -->
  <xsl:template mode="update-fixed-info-profile" match="dcat:CatalogRecord/dct:conformsTo/dct:Standard[$profile = $dcatapvlURI]">
    <dct:Standard rdf:about="https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03">
      <dct:identifier>https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03</dct:identifier>
      <dct:title xml:lang="nl">DCAT-AP Vlaanderen</dct:title>
      <dct:title xml:lang="fr">DCAT-AP Flandre</dct:title>
      <dct:title xml:lang="de">DCAT-AP Flandern</dct:title>
      <dct:title xml:lang="en">DCAT-AP Flanders</dct:title>
      <dct:description xml:lang="nl">Dit applicatieprofiel beschrijft Open Data Catalogi in Vlaanderen. DCAT-AP Vlaanderen (DCAT-AP VL) is een verdere specialisatie van DCAT-AP. De applicatie waarop dit profiel betrekking heeft is een Open Data Portaal in Vlaanderen. Open Data portalen zijn catalogussen van Open Data datasets. Ze hebben als belangrijkste doelstelling het vindbaar maken van data en hierdoor het hergebruik ervan te stimuleren. Open Data portalen vervullen een centrale rol in de overheidsopdracht om de toegankelijkheid tot overheidsinformatie te realiseren. Met dit applicatieprofiel bevorderen we de uniformiteit van de beschikbare informatie over datasets. Tevens vereenvoudigen we het aggregatie proces van meerdere Open Data Catalogi. Dit document bevat de verplichte elementen en bijkomende elementen waarover DCAT-AP Vlaanderen een uitspraak doet. Aanbevolen en optionele informatie waarvoor geen bijkomende afspraken in de context van DCAT-AP Vlaanderen zijn, zijn niet opgenomen in dit document. Hiervoor verwijzen we naar de DCAT-AP specificatie zelf.</dct:description>
      <dct:description xml:lang="fr">Ce profil d'application décrit les catalogues de données ouvertes en Flandre. DCAT-AP Flandre (DCAT-AP VL) est une spécialisation supplémentaire de DCAT-AP. L'application concernée par ce profil est un portail de données ouvertes en Flandre. Les portails de données ouvertes sont des catalogues de jeux de données ouvertes. Leur objectif principal est de faciliter la découverte des données et ainsi de stimuler leur réutilisation. Ils jouent un rôle central dans la mission du gouvernement visant à garantir l'accessibilité des informations gouvernementales. Avec ce profil d'application, nous favorisons l'uniformité des informations disponibles entre les jeux de données. Nous simplifions également le processus d'agrégation de plusieurs catalogues de données ouvertes. Ce document contient les éléments obligatoires et les éléments supplémentaires sur lesquels DCAT-AP Flandre émet une déclaration. Les informations recommandées et facultatives pour lesquelles aucun accord supplémentaire n'existe dans le cadre de DCAT-AP Flandre ne sont pas incluses dans ce document. Pour cela, nous nous référons à la spécification DCAT-AP elle-même.</dct:description>
      <dct:description xml:lang="de">Dieses Anwendungsprofil beschreibt Open Data-Kataloge in Flandern. DCAT-AP Flandern (DCAT-AP VL) ist eine lokale Ableitung von DCAT-AP. Die Anwendung, auf die sich dieses Profil bezieht, ist ein Open Data-Portal in Flandern. Open Data-Portale sind Kataloge mit Open Data-Datensätzen. Ihr Hauptzweck besteht darin, Daten auffindbar zu machen und so ihre Wiederverwendung zu fördern. Open Data-Portale spielen eine zentrale Rolle beim Auftrag der Regierung, Zugang zu Regierungsinformationen erreichbar zu machen. Mit diesem Anwendungsprofil fördern wir die Einheitlichkeit der verfügbaren Informationen über alle Datensätze hinweg. Wir vereinfachen außerdem den Aggregationsprozess mehrerer Open Data-Kataloge. Dieses Dokument enthält die obligatorischen Elemente und zusätzliche Elemente, die spezifisch für DCAT-AP Flandern beschrieben werden. Empfohlene und optionale Informationen, für die im Rahmen von DCAT-AP Flandern keine zusätzlichen Vereinbarungen bestehen, sind in diesem Dokument nicht enthalten. Hierzu verweisen wir auf die DCAT-AP-Spezifikation selbst.</dct:description>
      <dct:description xml:lang="en">This application profile describes Open Data Catalogues in Flanders. DCAT-AP Flanders (DCAT-AP VL) is a further specialization of DCAT-AP. The application to which this profile relates is an Open Data Portal in Flanders. Open Data Portals are catalogs of Open Data datasets. Their main purpose is to make data discoverable and thus stimulate its reuse. Open Data Portals play a central role in the government's mission to achieve accessibility to government information. With this application profile, we promote the uniformity of available information across datasets. We also simplify the aggregation process of multiple Open Data Catalogs. This document contains the mandatory elements and additional elements on which DCAT-AP Flanders provides a statement. Recommended and optional information for which no additional agreements exist within the context of DCAT-AP Flanders are not included in this document. For this, we refer to the DCAT-AP specification itself.</dct:description>
      <owl:versionInfo>2.0</owl:versionInfo>
    </dct:Standard>
  </xsl:template>

  <xsl:template mode="update-fixed-info-profile" match="dcat:CatalogRecord/dct:conformsTo/dct:Standard[$profile = $metadatadcatURI]">
    <dct:Standard rdf:about="https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22">
      <dct:identifier>https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22</dct:identifier>
      <dct:title xml:lang="nl">Metadata DCAT</dct:title>
      <dct:title xml:lang="fr">Metadata DCAT</dct:title>
      <dct:title xml:lang="de">Metadata DCAT</dct:title>
      <dct:title xml:lang="en">Metadata DCAT</dct:title>
      <dct:description xml:lang="nl">Het applicatieprofiel "Metadata DCAT". Dit is een applicatieprofiel gebaseerd op DCAT en richt zich op het verzamelen van informatie over generieke datasets, distributies en services die door een overheid beschikbaar gesteld worden. De datasets en services omvatten zowel publiek toegankelijke als afgeschermde data en diensten (ontwikkeld in en voor eender welk technisch perspectief). Het samenbrengen van al deze informatie in een catalogus laat toe om de vindbaarheid van deze datasets en services te verhogen. Dit applicatieprofiel is het generieke basisprofiel. Afgeleide profielen kunnen zeker aangemaakt worden voor specifieke domeinen of communities. Bijvoorbeeld is DCAT-AP-VL zo’n afgeleid applicatieprofiel, specifiek voor het Open data domein en bijhorende community.</dct:description>
      <dct:description xml:lang="fr">Le profil d'application "Metadata DCAT". Ce profil d'application est basé sur DCAT et se concentre sur la collecte d'informations sur les jeux de données génériques, les distributions et les services mis à disposition par un gouvernement. Ces jeux de données et services comprennent des données et services publics et privés (développés dans et pour toute perspective technique). Le regroupement de toutes ces informations dans un catalogue facilite la découverte de ces jeux de données et services. Ce profil d'application constitue le profil de base générique. Des profils dérivés peuvent être créés pour des domaines ou des communautés spécifiques. Par exemple, DCAT-AP-VL est un tel profil d'application dérivé, spécifiquement destiné au domaine des données ouvertes et à la communauté qui lui est associée.</dct:description>
      <dct:description xml:lang="de">Das Anwendungsprofil „Metadata DCAT“. Dieses Anwendungsprofil basiert auf DCAT und konzentriert sich auf die Erfassung von Informationen über generische Datensätze, Repräsentanzen und Dienste, die von einer Regierung bereitgestellt werden. Die Datensätze und Dienste umfassen sowohl öffentlich zugängliche als auch private Daten und Dienste (entwickelt in und für beliebige technische Komponenten). Die Erfassung all dieser Informationen in einem Katalog erhöht die Auffindbarkeit dieser Datensätze und Dienste. Dieses Anwendungsprofil ist das generische Basisprofil. Abgeleitete Profile können selbstverständlich für spezifische Domänen oder Gemeinschaften erstellt werden. Beispielsweise ist DCAT-AP-VL ein solches abgeleitetes Anwendungsprofil speziell für den Open-Data-Bereich und die zugehörige Community.</dct:description>
      <dct:description xml:lang="en">The "Metadata DCAT" application profile. This application profile is based on DCAT and focuses on collecting information about generic datasets, distributions, and services made available by a government. The datasets and services include both publicly accessible and private data and services (developed in and for any technical perspective). Bringing all this information together in a catalog increases the discoverability of these datasets and services. This application profile is the generic base profile. Derived profiles can certainly be created for specific domains or communities. For example, DCAT-AP-VL is such a derived application profile, specifically for the Open Data domain and its associated community.</dct:description>
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
