<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) 2001-2007 Food and Agriculture Organization of the
United Nations (FAO-UN), United Nations World Food Programme (WFP)
and United Nations Environment Programme (UNEP)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA

Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
Rome - Italy. email: geonetwork@osgeo.org
-->
<!--
  rdf-to-xml.xsl
  XML Schema for http://www.w3.org/ns/dcat# namespace

  Description: Converts a SPARQL SELECT result (XML) into an XML record that conforms to the DCAT-AP XML Schema.
      -->
<xsl:stylesheet xmlns:sr="http://www.w3.org/2005/sparql-results#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:spdx="http://spdx.org/rdf/terms#" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:adms="http://www.w3.org/ns/adms#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms/" xmlns:dcat="http://www.w3.org/ns/dcat#"
                xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:schema="http://schema.org/"
                xmlns:locn="http://www.w3.org/ns/locn#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#" xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:gn-fn-dcat-ap="http://geonetwork-opensource.org/xsl/functions/profiles/dcat-ap"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0"
                exclude-result-prefixes="#all">
  <!-- Tell the XSL processor to output XML. -->
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <!-- Default language for plain literals. -->
  <xsl:variable name="defaultLang">nl</xsl:variable>
  <xsl:variable name="xsdNs" select="'http://www.w3.org/2001/XMLSchema#'"/>
  <xsl:param name="uuid"/>

  <!-- dcat:Catalog -->
  <xsl:template match="/">
    <xsl:variable name="catalogURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type' and
                                             sr:binding[@name='object']/sr:uri = 'http://www.w3.org/ns/dcat#Catalog']/sr:binding[@name='subject']"/>
    <rdf:RDF>
      <!-- Set the xsi:schemaLocation attribute, used for validation: http://www.openarchives.org/OAI/2.0/rdf.xsd -->
      <xsl:attribute name="xsi:schemaLocation"
                     select="'http://www.w3.org/1999/02/22-rdf-syntax-ns# http://www.openarchives.org/OAI/2.0/rdf.xsd'"/>
      <xsl:for-each select="$catalogURIs">
        <xsl:variable name="catalogURI" select="./*"/>
        <dcat:Catalog rdf:about="{./*}">
          <!-- dct:title -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:title</xsl:with-param>
          </xsl:call-template>
          <!-- dct:description -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:description</xsl:with-param>
          </xsl:call-template>
          <!-- dct:identifier -->
          <xsl:call-template name="identifier">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:identifier</xsl:with-param>
          </xsl:call-template>
          <!-- dct:publisher -->
          <xsl:call-template name="agents">
            <xsl:with-param name="agentURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/publisher' and
                                                     sr:binding[@name='subject']/* = $catalogURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:publisher</xsl:with-param>
          </xsl:call-template>
          <!-- dct:rightsHolder -->
          <xsl:call-template name="agents">
            <xsl:with-param name="agentURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/rightsHolder' and
                                                     sr:binding[@name='subject']/* = $catalogURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:rightsHolder</xsl:with-param>
          </xsl:call-template>
          <!-- foaf:homepage -->
          <xsl:call-template name="documents">
            <xsl:with-param name="documentURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://xmlns.com/foaf/0.1/homepage' and
                                                         sr:binding[@name='subject']/* = $catalogURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">foaf:homepage</xsl:with-param>
          </xsl:call-template>
          <!-- dct:license -->
          <xsl:call-template name="licenses">
            <xsl:with-param name="licenseURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/license' and
                                                       sr:binding[@name='subject']/* = $catalogURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:license</xsl:with-param>
          </xsl:call-template>
          <!-- dct:language-->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/language' and
                                                        sr:binding[@name='subject']/* = $catalogURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:language</xsl:with-param>
            <xsl:with-param name="rdfType">dct:LinguisticSystem</xsl:with-param>
          </xsl:call-template>
          <!-- dct:issued-->
          <xsl:call-template name="dates">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:issued</xsl:with-param>
          </xsl:call-template>
          <!-- dct:modified-->
          <xsl:call-template name="dates">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:modified</xsl:with-param>
          </xsl:call-template>
          <!-- dct:hasPart -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:hasPart</xsl:with-param>
          </xsl:call-template>
          <!-- dct:isPartOf -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:isPartOf</xsl:with-param>
          </xsl:call-template>
          <!-- dct:rights -->
          <xsl:call-template name="rightsStatements">
            <xsl:with-param name="statementURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/rights' and
                                                         sr:binding[@name='subject']/* = $catalogURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:rights</xsl:with-param>
          </xsl:call-template>
          <!-- dct:spatial -->
          <xsl:call-template name="locations">
            <xsl:with-param name="locationURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/spatial' and
                                                        sr:binding[@name='subject']/* = $catalogURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:spatial</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:contactPoint -->
          <xsl:call-template name="organizations">
            <xsl:with-param name="organizationURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/dcat#contactPoint' and
                                                            sr:binding[@name='subject']/* = $catalogURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dcat:contactPoint</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:record -->
          <xsl:call-template name="record">
            <xsl:with-param name="recordURIs"
                            select="//sr:result[sr:binding[@name='subject']/* = $catalogURI and
                                    sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/dcat#record']/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dcat:record</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:dataset -->
          <xsl:call-template name="datasets">
            <xsl:with-param name="datasetURIs"
                            select="//sr:result[sr:binding[@name='subject']/* = $catalogURI and
                                    sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/dcat#dataset']/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dcat:dataset</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:service -->
          <xsl:call-template name="services">
            <xsl:with-param name="serviceURIs"
                            select="//sr:result[sr:binding[@name='subject']/* = $catalogURI and
                                    sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/dcat#service']/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dcat:service</xsl:with-param>
          </xsl:call-template>
        </dcat:Catalog>
      </xsl:for-each>
      <!-- if no catalog information found -->
      <xsl:if test="not($catalogURIs[1])">
        <!-- dcat:dataset -->
        <dcat:Catalog>
          <dct:title>catalog title</dct:title>
          <dct:description>catalog description</dct:description>
          <dct:publisher>
            <foaf:Agent rdf:about="http://purl.org/mydomain/myidentifer">
              <foaf:name>publisher name</foaf:name>
            </foaf:Agent>
          </dct:publisher>
          <xsl:call-template name="record">
            <xsl:with-param name="recordURIs"
                            select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type' and
                                    sr:binding[@name='object']/sr:uri = 'http://www.w3.org/ns/dcat#CatalogRecord']/sr:binding[@name='subject']"/>
            <xsl:with-param name="predicate">dcat:record</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="datasets">
            <xsl:with-param name="datasetURIs"
                            select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type' and
                                    sr:binding[@name='object']/sr:uri = 'http://www.w3.org/ns/dcat#Dataset']/sr:binding[@name='subject']"/>
            <xsl:with-param name="predicate">dcat:dataset</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="services">
            <xsl:with-param name="serviceURIs"
                            select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type' and
                                    sr:binding[@name='object']/sr:uri = 'http://www.w3.org/ns/dcat#DataService']/sr:binding[@name='subject']"/>
            <xsl:with-param name="predicate">dcat:service</xsl:with-param>
          </xsl:call-template>
        </dcat:Catalog>
      </xsl:if>
    </rdf:RDF>
  </xsl:template>

  <!-- dcat:CatalogRecord -->
  <xsl:template name="record">
    <xsl:param name="recordURIs"/>
    <xsl:param name="predicate"/>

    <xsl:for-each select="$recordURIs">
      <xsl:variable name="recordURI" select="./*"/>
      <xsl:element name="{$predicate}">
        <dcat:CatalogRecord>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- dct:identifier -->
          <dct:identifier>
            <xsl:value-of select="$uuid"/>
          </dct:identifier>
          <!-- foaf:primaryTopic -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">foaf:primaryTopic</xsl:with-param>
          </xsl:call-template>
          <!-- dct:modified -->
          <xsl:call-template name="dates">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:modified</xsl:with-param>
          </xsl:call-template>
          <!-- dct:title -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:title</xsl:with-param>
          </xsl:call-template>
          <!-- dct:conformsTo -->
          <xsl:variable name="standardURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/conformsTo' and
                      sr:binding[@name='subject']/* = $recordURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
          <xsl:call-template name="standards">
            <xsl:with-param name="standardURIs" select="$standardURIs"/>
            <xsl:with-param name="predicate">dct:conformsTo</xsl:with-param>
            <xsl:with-param name="defaultVersionValue">2.0</xsl:with-param>
          </xsl:call-template>
          <xsl:if test="count($standardURIs) = 0">
            <dct:conformsTo>
              <dct:Standard rdf:about="https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03">
                <dct:title>Dcat-ap-vl</dct:title>
                <dct:description>Dit applicatieprofiel beschrijft Open Data Catalogi in Vlaanderen. DCAT-AP Vlaanderen (DCAT-AP VL) is een verdere specialisatie van DCAT-AP. De applicatie waarop dit profiel betrekking heeft is een Open Data Portaal in Vlaanderen. Open Data portalen zijn catalogussen van Open Data datasets. Ze hebben als belangrijkste doelstelling het vindbaar maken van data en hierdoor het hergebruik ervan te stimuleren. Open Data portalen vervullen een centrale rol in de overheidsopdracht om de toegankelijkheid tot overheidsinformatie te realiseren. Met dit applicatieprofiel bevorderen we de uniformiteit van de beschikbare informatie over datasets. Tevens vereenvoudigen we het aggregatie proces van meerdere Open Data Catalogi. Dit document bevat de verplichte elementen en bijkomende elementen waarover DCAT-AP Vlaanderen een uitspraak doet. Aanbevolen en optionele informatie waarvoor geen bijkomende afspraken in de context van DCAT-AP Vlaanderen zijn, zijn niet opgenomen in dit document. Hiervoor verwijzen we naar de DCAT-AP specificatie zelf.</dct:description>
                <owl:versionInfo>2.0</owl:versionInfo>
              </dct:Standard>
            </dct:conformsTo>
          </xsl:if>
          <!-- dct:issued -->
          <xsl:call-template name="dates">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:issued</xsl:with-param>
          </xsl:call-template>
          <!-- dct:title -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:title</xsl:with-param>
          </xsl:call-template>
          <!-- dct:description -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:description</xsl:with-param>
          </xsl:call-template>
          <!-- dct:language-->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/language' and
                      sr:binding[@name='subject']/* = $recordURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:language</xsl:with-param>
            <xsl:with-param name="rdfType">dct:LinguisticSystem</xsl:with-param>
          </xsl:call-template>
          <!-- dct:source -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:source</xsl:with-param>
          </xsl:call-template>
          <!-- adms:identifier -->
          <adms:identifier>
            <adms:Identifier>
              <skos:notation>
                <xsl:value-of select="$recordURI"/>
              </skos:notation>
            </adms:Identifier>
          </adms:identifier>
        </dcat:CatalogRecord>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- dcat:Dataset -->
  <xsl:template name="datasets">
    <xsl:param name="datasetURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$datasetURIs">
      <xsl:variable name="datasetURI" select="./*"/>
      <xsl:element name="{$predicate}">
        <dcat:Dataset>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- dct:identifier -->
          <xsl:call-template name="identifier">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:identifier</xsl:with-param>
          </xsl:call-template>
          <!-- dct:title -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:title</xsl:with-param>
          </xsl:call-template>
          <!-- dct:description -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:description</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:contactPoint -->
          <xsl:call-template name="organizations">
            <xsl:with-param name="organizationURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/dcat#contactPoint' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dcat:contactPoint</xsl:with-param>
          </xsl:call-template>
          <!-- dct:created-->
          <xsl:call-template name="dates">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:created</xsl:with-param>
          </xsl:call-template>
          <!-- dct:issued-->
          <xsl:call-template name="dates">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:issued</xsl:with-param>
          </xsl:call-template>
          <!-- dct:modified-->
          <xsl:call-template name="dates">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:modified</xsl:with-param>
          </xsl:call-template>
          <!-- dct:publisher -->
          <xsl:call-template name="agents">
            <xsl:with-param name="agentURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/publisher' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:publisher</xsl:with-param>
          </xsl:call-template>
          <!-- dct:rightsHolder -->
          <xsl:call-template name="agents">
            <xsl:with-param name="agentURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/rightsHolder' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:rightsHolder</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:keyword -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:keyword</xsl:with-param>
          </xsl:call-template>
          <!-- dct:subject -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/subject' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:subject</xsl:with-param>
            <xsl:with-param name="rdfType"/>
          </xsl:call-template>
          <!-- mdcat:MAGDA-categorie -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'https://data.vlaanderen.be/ns/metadata-dcat#MAGDA-categorie' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">mdcat:MAGDA-categorie</xsl:with-param>
            <xsl:with-param name="rdfType"/>
          </xsl:call-template>
          <!-- mdcat:statuut -->
          <xsl:variable name="statuuts">
            <xsl:call-template name="concepts">
              <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'https://data.vlaanderen.be/ns/metadata-dcat#statuut' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
              <xsl:with-param name="predicate">mdcat:statuut</xsl:with-param>
              <xsl:with-param name="rdfType"/>
            </xsl:call-template>
          </xsl:variable>
          <mdcat:statuut>
            <skos:Concept rdf:about="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATA">
              <skos:prefLabel xml:lang="nl">Vlaamse Open data</skos:prefLabel>
              <skos:prefLabel xml:lang="en">Vlaamse Open data</skos:prefLabel>
              <skos:prefLabel xml:lang="fr">Vlaamse Open data</skos:prefLabel>
              <skos:prefLabel xml:lang="de">Vlaamse Open data</skos:prefLabel>
              <skos:inScheme rdf:resource="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden"/>
            </skos:Concept>
          </mdcat:statuut>
          <xsl:for-each select="$statuuts[*/skos:Concept/@rdf:about != 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATA']">
            <xsl:copy-of select="."/>
          </xsl:for-each>
          <!-- dcat:theme -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/dcat#theme' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dcat:theme</xsl:with-param>
            <xsl:with-param name="rdfType"/>
          </xsl:call-template>
          <!-- dct:accessRights -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/accessRights' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:accessRights</xsl:with-param>
            <xsl:with-param name="rdfType">dct:RightsStatement</xsl:with-param>
          </xsl:call-template>
          <!-- dct:conformsTo -->
          <xsl:call-template name="standards">
            <xsl:with-param name="standardURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/conformsTo' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:conformsTo</xsl:with-param>
          </xsl:call-template>
          <!-- foaf:page -->
          <xsl:call-template name="documents">
            <xsl:with-param name="documentURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://xmlns.com/foaf/0.1/page' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object'  and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">foaf:page</xsl:with-param>
          </xsl:call-template>
          <!-- dct:accrualPeriodicity -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/accrualPeriodicity' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:accrualPeriodicity</xsl:with-param>
            <xsl:with-param name="rdfType">dct:Frequency</xsl:with-param>
          </xsl:call-template>
          <!-- dct:hasVersion -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:hasVersion</xsl:with-param>
          </xsl:call-template>
          <!-- dct:isVersionOf-->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:isVersionOf</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:landingPage-->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:landingPage</xsl:with-param>
          </xsl:call-template>
          <!-- dct:language-->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/language' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:language</xsl:with-param>
            <xsl:with-param name="rdfType">dct:LinguisticSystem</xsl:with-param>
          </xsl:call-template>
          <!-- adms:identifier -->
          <xsl:call-template name="identifiers">
            <xsl:with-param name="identifierURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/adms#identifier' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">adms:identifier</xsl:with-param>
          </xsl:call-template>
          <!-- dct:provenance-->
          <xsl:call-template name="provenanceStatements">
            <xsl:with-param name="statementURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/provenance' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:provenance</xsl:with-param>
          </xsl:call-template>
          <!-- dct:relation-->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:relation</xsl:with-param>
          </xsl:call-template>
          <!-- dct:source-->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:source</xsl:with-param>
          </xsl:call-template>
          <!-- dct:spatial -->
          <xsl:call-template name="locations">
            <xsl:with-param name="locationURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/spatial' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:spatial</xsl:with-param>
          </xsl:call-template>
          <!-- dct:temporal -->
          <xsl:call-template name="periods">
            <xsl:with-param name="periodURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/temporal' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:temporal</xsl:with-param>
          </xsl:call-template>
          <!-- dct:type-->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/type' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:type</xsl:with-param>
            <xsl:with-param name="rdfType"/>
          </xsl:call-template>
          <!-- owl:versionInfo -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">owl:versionInfo</xsl:with-param>
          </xsl:call-template>
          <!-- adms:versionNotes -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">adms:versionNotes</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:distribution -->
          <xsl:call-template name="distributions">
            <xsl:with-param name="distributionURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/dcat#distribution' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dcat:distribution</xsl:with-param>
          </xsl:call-template>
          <!-- adms:sample -->
          <xsl:call-template name="distributions">
            <xsl:with-param name="distributionURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/adms#sample' and
                      sr:binding[@name='subject']/* = $datasetURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">adms:sample</xsl:with-param>
          </xsl:call-template>
        </dcat:Dataset>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- dcat:DataService -->
  <xsl:template name="services">
    <xsl:param name="serviceURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$serviceURIs">
      <xsl:variable name="serviceURI" select="./*"/>
      <xsl:element name="{$predicate}">
        <dcat:DataService>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- dct:identifier -->
          <xsl:call-template name="identifier">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:identifier</xsl:with-param>
          </xsl:call-template>
          <!-- dct:title -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:title</xsl:with-param>
          </xsl:call-template>
          <!-- dct:description -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:description</xsl:with-param>
          </xsl:call-template>
          <!-- dct:publisher -->
          <xsl:call-template name="agents">
            <xsl:with-param name="agentURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/publisher' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:publisher</xsl:with-param>
          </xsl:call-template>
          <!-- dct:rightsHolder -->
          <xsl:call-template name="agents">
            <xsl:with-param name="agentURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/rightsHolder' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:rightsHolder</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:endpointURL -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:endpointURL</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:endpointURL</xsl:with-param>
            <xsl:with-param name="xmlNameOverwrite">dcat:endpointURL</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:endpointDescription -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:endpointDescription</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:servesDataset -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:servesDataset</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:landingPage -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:landingPage</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:contactPoint -->
          <xsl:call-template name="organizations">
            <xsl:with-param name="organizationURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/dcat#contactPoint' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dcat:contactPoint</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:keyword -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:keyword</xsl:with-param>
          </xsl:call-template>
          <!-- dct:language-->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/language' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:language</xsl:with-param>
            <xsl:with-param name="rdfType">dct:LinguisticSystem</xsl:with-param>
          </xsl:call-template>
          <!-- adms:identifier -->
          <xsl:call-template name="identifiers">
            <xsl:with-param name="identifierURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/adms#identifier' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">adms:identifier</xsl:with-param>
          </xsl:call-template>
          <!-- owl:versionInfo -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">owl:versionInfo</xsl:with-param>
          </xsl:call-template>
          <!-- mdcat:landingspaginaVoorAuthenticatie -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">mdcat:landingspaginaVoorAuthenticatie</xsl:with-param>
          </xsl:call-template>
          <!-- mdcat:landingspaginaVoorStatusinformatie -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">mdcat:landingspaginaVoorStatusinformatie</xsl:with-param>
          </xsl:call-template>
          <!-- mdcat:landingspaginaVoorGebruiksinformatie -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">mdcat:landingspaginaVoorGebruiksinformatie</xsl:with-param>
          </xsl:call-template>
          <!-- mdcat:levensfase -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'https://data.vlaanderen.be/ns/metadata-dcat#levensfase' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">mdcat:levensfase</xsl:with-param>
            <xsl:with-param name="rdfType"/>
          </xsl:call-template>
          <!-- mdcat:ontwikkelingstoestand -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'https://data.vlaanderen.be/ns/metadata-dcat#ontwikkelingstoestand' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">mdcat:ontwikkelingstoestand</xsl:with-param>
            <xsl:with-param name="rdfType"/>
          </xsl:call-template>
          <!-- dcat:qualifiedRelation -->
          <xsl:call-template name="checksums">
            <xsl:with-param name="checksumURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://spdx.org/rdf/terms#checksum' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dcat:qualifiedRelation</xsl:with-param>
          </xsl:call-template>
          <!-- dct:subject -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/subject' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:subject</xsl:with-param>
            <xsl:with-param name="rdfType"/>
          </xsl:call-template>
          <!-- mdcat:MAGDA-categorie -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'https://data.vlaanderen.be/ns/metadata-dcat#MAGDA-categorie' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">mdcat:MAGDA-categorie</xsl:with-param>
            <xsl:with-param name="rdfType"/>
          </xsl:call-template>
          <!-- mdcat:statuut -->
          <xsl:variable name="statuuts">
            <xsl:call-template name="concepts">
              <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'https://data.vlaanderen.be/ns/metadata-dcat#statuut' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
              <xsl:with-param name="predicate">mdcat:statuut</xsl:with-param>
              <xsl:with-param name="rdfType"/>
            </xsl:call-template>
          </xsl:variable>
          <mdcat:statuut>
            <skos:Concept rdf:about="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATASERVICE">
              <skos:prefLabel xml:lang="nl">Vlaamse Open data Service</skos:prefLabel>
              <skos:prefLabel xml:lang="en">Vlaamse Open data Service</skos:prefLabel>
              <skos:prefLabel xml:lang="fr">Vlaamse Open data Service</skos:prefLabel>
              <skos:prefLabel xml:lang="de">Vlaamse Open data Service</skos:prefLabel>
              <skos:inScheme rdf:resource="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden"/>
            </skos:Concept>
          </mdcat:statuut>
          <xsl:for-each select="$statuuts[*/skos:Concept/@rdf:about != 'https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATASERVICE']">
            <xsl:copy-of select="."/>
          </xsl:for-each>
          <!-- dcat:theme -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/dcat#theme' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dcat:theme</xsl:with-param>
            <xsl:with-param name="rdfType"/>
          </xsl:call-template>
          <!-- dct:accessRights -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/accessRights' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:accessRights</xsl:with-param>
            <xsl:with-param name="rdfType">dct:RightsStatement</xsl:with-param>
          </xsl:call-template>
          <!-- dct:conformsTo-->
          <xsl:call-template name="standards">
            <xsl:with-param name="standardURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/conformsTo' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:conformsTo</xsl:with-param>
          </xsl:call-template>
          <!-- dct:creator -->
          <xsl:call-template name="agents">
            <xsl:with-param name="agentURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/publisher' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:creator</xsl:with-param>
          </xsl:call-template>
          <!-- dct:isReferencedBy -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:isReferencedBy</xsl:with-param>
          </xsl:call-template>
          <!-- dct:license -->
          <xsl:call-template name="licenses">
            <xsl:with-param name="licenseURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/license' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:license</xsl:with-param>
          </xsl:call-template>
          <!-- dct:created -->
          <xsl:call-template name="dates">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:created</xsl:with-param>
          </xsl:call-template>
          <!-- dct:issued -->
          <xsl:call-template name="dates">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:issued</xsl:with-param>
          </xsl:call-template>
          <!-- dct:modified-->
          <xsl:call-template name="dates">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:modified</xsl:with-param>
          </xsl:call-template>
          <!-- dct:relation -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:relation</xsl:with-param>
          </xsl:call-template>
          <!-- dct:rights -->
          <xsl:call-template name="rightsStatements">
            <xsl:with-param name="statementURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/rights' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:rights</xsl:with-param>
          </xsl:call-template>
          <!-- dct:type-->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/type' and
                      sr:binding[@name='subject']/* = $serviceURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:type</xsl:with-param>
            <xsl:with-param name="rdfType"/>
          </xsl:call-template>
        </dcat:DataService>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- foaf:Agent -->
  <xsl:template name="agents">
    <xsl:param name="agentURIs"/>
    <xsl:param name="predicate"/>
    <!-- for each agent -->
    <xsl:for-each select="$agentURIs">
      <xsl:variable name="agentURI" select="./*"/>
      <xsl:element name="{$predicate}">
        <foaf:Agent>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- foaf:name -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">foaf:name</xsl:with-param>
          </xsl:call-template>
          <!-- dct:type-->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/type' and
                      sr:binding[@name='subject']/* = $agentURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:type</xsl:with-param>
            <xsl:with-param name="rdfType"/>
          </xsl:call-template>
        </foaf:Agent>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- foaf:Document -->
  <xsl:template name="documents">
    <xsl:param name="documentURIs"/>
    <xsl:param name="predicate"/>
    <!-- for each document -->
    <xsl:for-each select="$documentURIs">
      <xsl:element name="{$predicate}">
        <foaf:Document>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- foaf:name -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">foaf:name</xsl:with-param>
          </xsl:call-template>
        </foaf:Document>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- dct:Location -->
  <xsl:template name="locations">
    <xsl:param name="locationURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$locationURIs">
      <xsl:element name="{$predicate}">
        <dct:Location>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- locn:geometry -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">locn:geometry</xsl:with-param>
          </xsl:call-template>
          <!-- skos:prefLabel -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">skos:prefLabel</xsl:with-param>
          </xsl:call-template>
        </dct:Location>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- dct:LicenseDocument -->
  <xsl:template name="licenses">
    <xsl:param name="licenseURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$licenseURIs">
      <xsl:variable name="licenseURI" select="./*"/>
      <!-- plain literals, should be resources -->
      <xsl:if test="./sr:literal and not(gn-fn-dcat-ap:resolve-datatype(./sr:literal/@datatype) = 'http://www.w3.org/2001/XMLSchema#anyURI')">
        <xsl:comment>Range violation in input for <xsl:value-of select="$predicate"/>: found a literal and was expecting
          a resource, like:
          &lt;<xsl:value-of select="$predicate"/> rdf:resource="<xsl:value-of
            select="normalize-space(./sr:literal/string())"/>"/&gt;
          or
          <xsl:value-of select="$predicate"/> &lt;<xsl:value-of select="normalize-space(./sr:literal/string())"/>&gt;
        </xsl:comment>
      </xsl:if>
      <xsl:element name="{$predicate}">
        <dct:LicenseDocument>
          <xsl:choose>
            <xsl:when test="./sr:uri">
              <xsl:attribute name="rdf:about">
                <xsl:value-of select="./sr:uri"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:when test="gn-fn-dcat-ap:resolve-datatype(./sr:literal/@datatype) = 'http://www.w3.org/2001/XMLSchema#anyURI'">
              <xsl:attribute name="rdf:about">
                <xsl:value-of select="./sr:literal"/>
              </xsl:attribute>
            </xsl:when>
          </xsl:choose>
          <!-- dct:type -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/type' and
                      sr:binding[@name='subject']/* = $licenseURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:type</xsl:with-param>
            <xsl:with-param name="rdfType"></xsl:with-param>
          </xsl:call-template>
          <!-- dct:title -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="$licenseURI"/>
            <xsl:with-param name="predicate">dct:title</xsl:with-param>
          </xsl:call-template>
          <!-- dct:description -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="$licenseURI"/>
            <xsl:with-param name="predicate">dct:description</xsl:with-param>
          </xsl:call-template>
          <!-- dct:identifier -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="$licenseURI"/>
            <xsl:with-param name="predicate">dct:identifier</xsl:with-param>
          </xsl:call-template>
        </dct:LicenseDocument>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- dct:RightsStatement -->
  <xsl:template name="rightsStatements">
    <xsl:param name="statementURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$statementURIs">
      <xsl:element name="{$predicate}">
        <dct:RightsStatement>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- dct:title -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:title</xsl:with-param>
          </xsl:call-template>
          <!-- dct:description -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:description</xsl:with-param>
          </xsl:call-template>
        </dct:RightsStatement>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- dct:Standard -->
  <xsl:template name="standards">
    <xsl:param name="standardURIs"/>
    <xsl:param name="predicate"/>
    <xsl:param name="defaultVersionValue" select="''"/>
    <xsl:for-each select="$standardURIs">
      <xsl:element name="{$predicate}">
        <dct:Standard>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- dct:title -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:title</xsl:with-param>
          </xsl:call-template>
          <!-- dct:description -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:description</xsl:with-param>
          </xsl:call-template>
          <!-- owl:versionInfo -->
          <xsl:variable name="version">
            <xsl:call-template name="properties">
              <xsl:with-param name="subject" select="./*"/>
              <xsl:with-param name="predicate">owl:versionInfo</xsl:with-param>
            </xsl:call-template>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="normalize-space($version) != ''">
              <xsl:copy-of copy-namespaces="no" select="$version"/>
            </xsl:when>
            <xsl:when test="normalize-space($defaultVersionValue)">
              <owl:versionInfo>
                <xsl:value-of select="$defaultVersionValue"/>
              </owl:versionInfo>
            </xsl:when>
          </xsl:choose>
        </dct:Standard>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- dct:ProvenanceStatement -->
  <xsl:template name="provenanceStatements">
    <xsl:param name="statementURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$statementURIs">
      <xsl:element name="{$predicate}">
        <dct:ProvenanceStatement>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- dct:title -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:title</xsl:with-param>
          </xsl:call-template>
          <!-- dct:description -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:description</xsl:with-param>
          </xsl:call-template>
        </dct:ProvenanceStatement>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- skos:Concept -->
  <xsl:template name="concepts">
    <xsl:param name="conceptURIs"/>
    <xsl:param name="predicate"/>
    <xsl:param name="rdfType"/>
    <xsl:for-each select="$conceptURIs">
      <xsl:element name="{$predicate}">
        <skos:Concept>
          <xsl:choose>
            <xsl:when test="./sr:uri">
              <xsl:attribute name="rdf:about">
                <xsl:value-of select="./sr:uri"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:when test="./sr:literal">
              <xsl:comment>Range violation in input for <xsl:value-of select="$predicate"/>: found a literal and was
                expecting a resource (URI or blank node).
              </xsl:comment>
            </xsl:when>
          </xsl:choose>
          <!-- rdf:type -->
          <xsl:if test="$rdfType != ''">
            <rdf:type rdf:resource="{$rdfType}"/>
          </xsl:if>
          <!-- skos:prefLabel -->
          <xsl:variable name="labels">
            <xsl:call-template name="properties">
              <xsl:with-param name="subject" select="./*"/>
              <xsl:with-param name="predicate">skos:prefLabel</xsl:with-param>
            </xsl:call-template>
          </xsl:variable>
          <xsl:for-each-group select="$labels/skos:prefLabel" group-by="@xml:lang">
            <xsl:copy-of select="$labels/skos:prefLabel[@xml:lang = current-grouping-key()][1]"/>
          </xsl:for-each-group>
          <!-- dct:type -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">skos:inScheme</xsl:with-param>
          </xsl:call-template>
        </skos:Concept>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- skos:ConceptScheme -->
  <xsl:template name="conceptSchemes">
    <xsl:param name="conceptSchemeURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$conceptSchemeURIs">
      <xsl:element name="{$predicate}">
        <skos:ConceptScheme>
          <xsl:choose>
            <xsl:when test="./sr:uri">
              <xsl:attribute name="rdf:about">
                <xsl:value-of select="./sr:uri"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:when test="./sr:literal">
              <xsl:comment>Range violation in input for <xsl:value-of select="$predicate"/>: found a literal and was
                expecting a resource (URI or blank node).
              </xsl:comment>
            </xsl:when>
          </xsl:choose>
          <!-- skos:prefLabel -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">skos:prefLabel</xsl:with-param>
          </xsl:call-template>
        </skos:ConceptScheme>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- adms:Identifier -->
  <xsl:template name="identifiers">
    <xsl:param name="identifierURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$identifierURIs">
      <xsl:element name="{$predicate}">
        <adms:Identifier>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- skos:notation -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">skos:notation</xsl:with-param>
          </xsl:call-template>
        </adms:Identifier>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- vcard:Address-->
  <xsl:template name="addresses">
    <xsl:param name="addressURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$addressURIs">
      <xsl:element name="{$predicate}">
        <vcard:Address>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- vcard:street-address -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">vcard:street-address</xsl:with-param>
          </xsl:call-template>
          <!-- vvcard:locality -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">vcard:locality</xsl:with-param>
          </xsl:call-template>
          <!-- vcard:postal-code -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">vcard:postal-code</xsl:with-param>
          </xsl:call-template>
          <!-- vcard:country-name -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">vcard:country-name</xsl:with-param>
          </xsl:call-template>
        </vcard:Address>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- vcard:Organization -->
  <xsl:template name="organizations">
    <xsl:param name="organizationURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$organizationURIs">
      <xsl:variable name="organizationURI" select="./*"/>
      <xsl:element name="{$predicate}">
        <vcard:Organization>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- vcard:fn -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">vcard:fn</xsl:with-param>
          </xsl:call-template>
          <!-- vcard:organization-name -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">vcard:organization-name</xsl:with-param>
          </xsl:call-template>
          <!-- vcard:hasAddress -->
          <xsl:call-template name="addresses">
            <xsl:with-param name="addressURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/2006/vcard/ns#hasAddress' and
                      sr:binding[@name='subject']/* = $organizationURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">vcard:hasAddress</xsl:with-param>
          </xsl:call-template>
          <!-- vcard:hasEmail -->
          <xsl:call-template name="mail-properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">vcard:hasEmail</xsl:with-param>
          </xsl:call-template>
          <!-- vcard:hasURL -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">vcard:hasURL</xsl:with-param>
          </xsl:call-template>
          <!-- vcard:hasTelephone -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">vcard:hasTelephone</xsl:with-param>
          </xsl:call-template>
          <!-- dct:type -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:type</xsl:with-param>
          </xsl:call-template>
        </vcard:Organization>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- dcat:Distribution -->
  <xsl:template name="distributions">
    <xsl:param name="distributionURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$distributionURIs">
      <xsl:variable name="distributionURI" select="./*"/>
      <xsl:element name="{$predicate}">
        <dcat:Distribution>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- dct:identifier -->
          <xsl:call-template name="identifier">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:identifier</xsl:with-param>
          </xsl:call-template>
          <!-- dct:title -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:title</xsl:with-param>
          </xsl:call-template>
          <!-- dct:description -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:description</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:accessURL -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:accessURL</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:downloadURL -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:downloadURL</xsl:with-param>
          </xsl:call-template>
          <!-- dct:issued -->
          <xsl:call-template name="dates">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:issued</xsl:with-param>
          </xsl:call-template>
          <!-- dct:modified-->
          <xsl:call-template name="dates">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:modified</xsl:with-param>
          </xsl:call-template>
          <!-- dct:format -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/format' and
                      sr:binding[@name='subject']/* = $distributionURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:format</xsl:with-param>
            <xsl:with-param name="rdfType">dct:MediaTypeOrExtent</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:mediaType -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/dcat#mediaType' and
                      sr:binding[@name='subject']/* = $distributionURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dcat:mediaType</xsl:with-param>
            <xsl:with-param name="rdfType">dct:MediaTypeOrExtent</xsl:with-param>
          </xsl:call-template>
          <!-- dct:language -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/language' and
                      sr:binding[@name='subject']/* = $distributionURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:language</xsl:with-param>
            <xsl:with-param name="rdfType">dct:LinguisticSystem</xsl:with-param>
          </xsl:call-template>
          <!-- dct:license -->
          <xsl:call-template name="licenses">
            <xsl:with-param name="licenseURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/license' and
                      sr:binding[@name='subject']/* = $distributionURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:license</xsl:with-param>
          </xsl:call-template>
          <!-- dct:rights -->
          <xsl:call-template name="rightsStatements">
            <xsl:with-param name="statementURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/rights' and
                      sr:binding[@name='subject']/* = $distributionURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:rights</xsl:with-param>
          </xsl:call-template>
          <!-- dcat:byteSize -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:byteSize</xsl:with-param>
          </xsl:call-template>
          <!-- spdx:checksum -->
          <xsl:call-template name="checksums">
            <xsl:with-param name="checksumURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://spdx.org/rdf/terms#checksum' and
                      sr:binding[@name='subject']/* = $distributionURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">spdx:checksum</xsl:with-param>
          </xsl:call-template>
          <!-- foaf:page -->
          <xsl:call-template name="documents">
            <xsl:with-param name="documentURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://xmlns.com/foaf/0.1/page' and
                      sr:binding[@name='subject']/* = $distributionURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">foaf:page</xsl:with-param>
          </xsl:call-template>
          <!-- dct:conformsTo-->
          <xsl:call-template name="standards">
            <xsl:with-param name="standardURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/conformsTo' and
                      sr:binding[@name='subject']/* = $distributionURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">dct:conformsTo</xsl:with-param>
          </xsl:call-template>
          <!-- adms:status -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://www.w3.org/ns/adms#status' and
                      sr:binding[@name='subject']/* = $distributionURI]/sr:binding[@name='object']"/>
            <xsl:with-param name="predicate">adms:status</xsl:with-param>
            <xsl:with-param name="rdfType"></xsl:with-param>
          </xsl:call-template>
          <!-- dcat:accessService -->
          <xsl:call-template name="urls">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:accessService</xsl:with-param>
          </xsl:call-template>
          <!-- dct:accessRights -->
          <xsl:call-template name="concepts">
            <xsl:with-param name="conceptURIs" select="//sr:result[sr:binding[@name='predicate']/sr:uri = 'http://purl.org/dc/terms/accessRights' and
                      sr:binding[@name='subject']/* = $distributionURI]/sr:binding[@name='object' and (sr:uri or sr:bnode)]"/>
            <xsl:with-param name="predicate">dct:accessRights</xsl:with-param>
            <xsl:with-param name="rdfType">dct:RightsStatement</xsl:with-param>
          </xsl:call-template>
        </dcat:Distribution>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- dct:PeriodOfTime -->
  <xsl:template name="periods">
    <xsl:param name="periodURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$periodURIs">
      <xsl:element name="{$predicate}">
        <dct:PeriodOfTime>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">schema:startDate</xsl:with-param>
          </xsl:call-template>
          <!-- skos:prefLabel -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">schema:endDate</xsl:with-param>
          </xsl:call-template>
        </dct:PeriodOfTime>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- spdx:Checksum -->
  <xsl:template name="checksums">
    <xsl:param name="checksumURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$checksumURIs">
      <xsl:element name="{$predicate}">
        <spdx:Checksum>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- spdx:algorithm -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">spdx:algorithm</xsl:with-param>
          </xsl:call-template>
          <!-- spdx:checksumValue -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">spdx:checksumValue</xsl:with-param>
          </xsl:call-template>
        </spdx:Checksum>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- dcat:qualifiesRelation -->
  <xsl:template name="qualifiedRelation">
    <xsl:param name="qualifiedRelationURIs"/>
    <xsl:param name="predicate"/>
    <xsl:for-each select="$qualifiedRelationURIs">
      <xsl:element name="{$predicate}">
        <dcat:Relationship>
          <xsl:if test="./sr:uri">
            <xsl:attribute name="rdf:about">
              <xsl:value-of select="./sr:uri"/>
            </xsl:attribute>
          </xsl:if>
          <!-- dcat:hasRole -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dcat:hadRole</xsl:with-param>
          </xsl:call-template>
          <!-- dct:description -->
          <xsl:call-template name="properties">
            <xsl:with-param name="subject" select="./*"/>
            <xsl:with-param name="predicate">dct:description</xsl:with-param>
          </xsl:call-template>
        </dcat:Relationship>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- dct:identifier -->
  <xsl:template name="identifier">
    <xsl:param name="subject"/>
    <xsl:param name="predicate"/>
    <xsl:param name="existingId" select="''"/>
    <!-- Select all objects matching the subject and predicate pattern -->
    <xsl:for-each select="//sr:result[sr:binding[@name='subject']/* = $subject and
                      sr:binding[@name='pAsQName']/sr:literal = $predicate]/sr:binding[@name='object']">
      <xsl:choose>
        <!-- plain literals -->
        <xsl:when test="./sr:literal and (not($existingId) or ./sr:literal != $existingId)">
          <xsl:element name="{$predicate}">
            <xsl:value-of select="./sr:literal"/>
          </xsl:element>
        </xsl:when>
        <!-- URIs -->
        <xsl:when test="./sr:uri">
          <xsl:comment>Range violation in input for <xsl:value-of select="$predicate"/>: found a resource and was
            expecting a literal, like:
            &lt;<xsl:value-of select="$predicate"/>&gt;<xsl:value-of select="./sr:literal/string()"/>&lt;/<xsl:value-of
              select="$predicate"/>&gt;
          </xsl:comment>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- simple properties -->
  <xsl:template name="properties">
    <xsl:param name="subject"/>
    <xsl:param name="predicate"/>
    <!-- Select all objects matching the subject and predicate pattern -->
    <xsl:for-each select="//sr:result[sr:binding[@name='subject']/* = $subject and
                      sr:binding[@name='pAsQName']/sr:literal = $predicate]/sr:binding[@name='object']">
      <xsl:choose>
        <!-- plain literals -->
        <xsl:when test="./sr:literal">
          <xsl:element name="{$predicate}">
            <!-- rdf:datatype attribute -->
            <xsl:if test="gn-fn-dcat-ap:resolve-datatype(./sr:literal/@datatype)">
              <xsl:attribute name="rdf:datatype" select="gn-fn-dcat-ap:resolve-datatype(./sr:literal/@datatype)"/>
            </xsl:if>
            <!-- language tag attribute -->
            <xsl:choose>
              <xsl:when test="./sr:literal/@xml:lang">
                <xsl:attribute name="xml:lang">
                  <xsl:value-of select="./sr:literal/@xml:lang"/>
                </xsl:attribute>
              </xsl:when>
              <xsl:when test="$predicate = ('dcat:keyword')">
                <xsl:attribute name="xml:lang" select="'nl'"/>
              </xsl:when>
            </xsl:choose>
            <!-- literal value -->
            <xsl:value-of select="./sr:literal"/>
          </xsl:element>
        </xsl:when>
        <!-- URIs -->
        <xsl:when test="./sr:uri">
          <xsl:element name="{$predicate}">
            <xsl:attribute name="rdf:resource" select="./sr:uri"/>
          </xsl:element>
        </xsl:when>
        <!-- blank nodes -->
        <xsl:when test="./sr:bnode">
          <xsl:element name="{$predicate}">
            <xsl:attribute name="rdf:resource" select="./sr:bnode"/>
          </xsl:element>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- urls -->
  <xsl:template name="urls">
    <xsl:param name="subject"/>
    <xsl:param name="predicate"/>
    <xsl:param name="xmlNameOverwrite" select="''"/>
    <!-- Select all objects matching the subject and predicate pattern -->
    <xsl:for-each select="//sr:result[sr:binding[@name='subject']/* = $subject and
                      sr:binding[@name='pAsQName']/sr:literal = $predicate]/sr:binding[@name='object']">
      <xsl:choose>
        <!-- plain literals, should be resources -->
        <xsl:when test="./sr:literal and not(gn-fn-dcat-ap:resolve-datatype(./sr:literal/@datatype) = 'http://www.w3.org/2001/XMLSchema#anyURI')">
          <xsl:comment>Range violation for <xsl:value-of select="$predicate"/>: found a literal and was expecting a
            resource, like:
            &lt;<xsl:value-of select="$predicate"/> rdf:resource="<xsl:value-of
              select="normalize-space(./sr:literal/string())"/>"/&gt;
            or
            <xsl:value-of select="$predicate"/> &lt;<xsl:value-of select="normalize-space(./sr:literal/string())"/>&gt;
          </xsl:comment>
        </xsl:when>
        <!-- URIs -->
        <xsl:when test="./sr:uri">
          <xsl:element name="{if ($xmlNameOverwrite != '') then $xmlNameOverwrite else $predicate}">
            <xsl:attribute name="rdf:resource" select="./sr:uri"/>
          </xsl:element>
        </xsl:when>
        <!-- anyURI literal -->
        <xsl:when test="gn-fn-dcat-ap:resolve-datatype(./sr:literal/@datatype) = 'http://www.w3.org/2001/XMLSchema#anyURI'">
          <xsl:element name="{if ($xmlNameOverwrite != '') then $xmlNameOverwrite else $predicate}">
            <xsl:attribute name="rdf:resource">
              <xsl:value-of select="./sr:literal"/>
            </xsl:attribute>
          </xsl:element>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- dates -->
  <xsl:template name="dates">
    <xsl:param name="subject"/>
    <xsl:param name="predicate"/>
    <!-- Select all objects matching the subject and predicate pattern -->
    <xsl:for-each select="//sr:result[sr:binding[@name='subject']/* = $subject and
                      sr:binding[@name='pAsQName']/sr:literal = $predicate]/sr:binding[@name='object']">
      <xsl:if test="./sr:literal">
        <xsl:element name="{$predicate}">
          <xsl:if test="gn-fn-dcat-ap:resolve-datatype(./sr:literal/@datatype)">
            <xsl:attribute name="rdf:datatype">
              <xsl:value-of select="gn-fn-dcat-ap:resolve-datatype(./sr:literal/@datatype)"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./sr:literal/text()"/>
        </xsl:element>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!-- mails -->
  <xsl:template name="mail-properties">
    <xsl:param name="subject"/>
    <xsl:param name="predicate"/>
    <!-- Select all objects matching the subject and predicate pattern -->
    <xsl:for-each select="//sr:result[sr:binding[@name='subject']/* = $subject and
                      sr:binding[@name='pAsQName']/sr:literal = $predicate]/sr:binding[@name='object']">
      <xsl:variable name="mail">
        <xsl:choose>
          <xsl:when test="./sr:uri">
            <xsl:value-of select="fn:tokenize(./sr:uri, '/')[fn:last()]"/>
          </xsl:when>
          <xsl:when test="gn-fn-dcat-ap:resolve-datatype(./sr:literal/@datatype) = 'http://www.w3.org/2001/XMLSchema#anyURI'">
            <xsl:value-of select="fn:tokenize(./sr:literal, '/')[fn:last()]"/>
          </xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:if test="normalize-space($mail) != ''">
        <xsl:element name="{$predicate}">
          <xsl:attribute name="rdf:resource" select="if(starts-with($mail, 'mailto:')) then $mail else concat('mailto:', $mail)"/>
        </xsl:element>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>


  <xsl:function name="gn-fn-dcat-ap:resolve-datatype">
    <xsl:param name="datatype" as="xs:string?"/>
    <xsl:choose>
      <xsl:when test="starts-with($datatype, $xsdNs)">
        <xsl:value-of select="$datatype"/>
      </xsl:when>
      <xsl:when test="normalize-space($datatype) != '' and contains($datatype, ':')">
        <xsl:value-of select="concat($xsdNs, tokenize($datatype, ':')[2])"/>
      </xsl:when>
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>
