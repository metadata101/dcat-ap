-- insert test records
DO
$$
  DECLARE
    -- use a specific id high enough to not conflict with templates that are automatically loaded
    -- increment it after adding a record
    _recordid int := 10000;
  BEGIN
    -- a dcat-ap-vl (dcat 2) record with some sane default values - uuid 345f47ef-abd5-4f2f-9ab7-d723565cccea
    INSERT INTO public.metadata (id, "data", changedate, createdate, displayorder, doctype, extra, popularity, rating, root,
                                 schemaid, title, istemplate, isharvested, harvesturi, harvestuuid, groupowner, "owner",
                                 "source", "uuid")
    VALUES (_recordid, '<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:spdx="http://spdx.org/rdf/terms#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:adms="http://www.w3.org/ns/adms#" xmlns:locn="http://www.w3.org/ns/locn#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:dct="http://purl.org/dc/terms/" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:dcat="http://www.w3.org/ns/dcat#" xmlns:schema="http://schema.org/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcatap="http://data.europa.eu/r5r/" xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#" xmlns:mobilitydcatap="https://w3id.org/mobilitydcat-ap" xmlns:geodcatap="http://data.europa.eu/930/" xmlns:oa="http://www.w3.org/ns/oa#" xmlns:dqv="http://www.w3.org/ns/dqv#" xmlns:cnt="http://www.w3.org/2011/content#">
  <dcat:Catalog rdf:about="http://localhost:8080/geonetwork/srv/resources/catalogs/eb248be8-549d-493f-b323-1dba08bb5417">
    <dcat:contactPoint>
      <vcard:Organization>
        <vcard:organization-name>My organization</vcard:organization-name>
      </vcard:Organization>
    </dcat:contactPoint>
    <dcat:dataset>
      <dcat:Dataset rdf:about="http://localhost:8080/srv/resources/datasets/16752832-7ef7-4539-9869-5236400cf249">
        <dcat:contactPoint>
          <vcard:Organization>
            <vcard:fn>name 1</vcard:fn>
            <vcard:organization-name xml:lang="nl">organisation name 1</vcard:organization-name>
            <vcard:hasEmail rdf:resource="mailto:name@one.one" />
            <vcard:hasTelephone>1234567890</vcard:hasTelephone>
          </vcard:Organization>
        </dcat:contactPoint>
        <dcat:distribution>
          <dcat:Distribution rdf:about="http://localhost:8080/srv/resources/distributions/b0b45c7d-1b67-45b4-8979-733b25744603">
            <dcat:accessURL rdf:resource="" />
            <dct:description xml:lang="nl" />
            <dct:title xml:lang="nl" />
            <dct:identifier>b0b45c7d-1b67-45b4-8979-733b25744603</dct:identifier>
          </dcat:Distribution>
        </dcat:distribution>
        <dcat:keyword xml:lang="nl">custom keyword 1</dcat:keyword>
        <dcat:keyword xml:lang="nl">custom keyword 2</dcat:keyword>
        <dcat:landingPage rdf:resource="https://a.landing.page" />
        <dcat:theme>
          <skos:Concept rdf:about="http://vocab.belgif.be/auth/datatheme/CULT">
            <skos:prefLabel xml:lang="nl">Cultuur en sport</skos:prefLabel>
            <skos:inScheme rdf:resource="http://vocab.belgif.be/auth/datatheme" />
          </skos:Concept>
        </dcat:theme>
        <adms:versionNotes xml:lang="nl">version notes A</adms:versionNotes>
        <dct:accessRights>
          <skos:Concept rdf:about="http://publications.europa.eu/resource/authority/access-right/PUBLIC">
            <rdf:type rdf:resource="http://purl.org/dc/terms/RightsStatement" />
            <skos:prefLabel xml:lang="nl">publiek</skos:prefLabel>
            <skos:inScheme rdf:resource="http://publications.europa.eu/resource/authority/access-right" />
          </skos:Concept>
        </dct:accessRights>
        <dct:accrualPeriodicity>
          <skos:Concept rdf:about="http://publications.europa.eu/resource/authority/frequency/DAILY">
            <rdf:type rdf:resource="http://purl.org/dc/terms/Frequency" />
            <skos:prefLabel xml:lang="nl">dagelijks</skos:prefLabel>
            <skos:inScheme rdf:resource="http://publications.europa.eu/resource/authority/frequency" />
          </skos:Concept>
        </dct:accrualPeriodicity>
        <dct:description xml:lang="nl">dataset description</dct:description>
        <dct:identifier>16752832-7ef7-4539-9869-5236400cf249</dct:identifier>
        <dct:issued rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2025-12-26</dct:issued>
        <dct:modified rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2025-12-25</dct:modified>
        <dct:publisher>
          <foaf:Agent>
            <foaf:name xml:lang="nl">organisation name</foaf:name>
            <dct:type>
              <skos:Concept rdf:about="http://purl.org/adms/publishertype/Company">
                <skos:prefLabel xml:lang="nl">Bedrijf</skos:prefLabel>
                <skos:inScheme rdf:resource="http://purl.org/adms/publishertype/1.0" />
              </skos:Concept>
            </dct:type>
          </foaf:Agent>
        </dct:publisher>
        <dct:temporal>
          <dct:PeriodOfTime>
            <schema:startDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2025-12-22</schema:startDate>
            <schema:endDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2025-12-27</schema:endDate>
          </dct:PeriodOfTime>
        </dct:temporal>
        <dct:title xml:lang="nl">dataset title</dct:title>
        <dct:created rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2025-12-24</dct:created>
        <mdcat:MAGDA-categorie>
          <skos:Concept rdf:about="https://data.vlaanderen.be/id/concept/MAGDA-categorie/Onderwijs">
            <skos:prefLabel xml:lang="nl">Onderwijs</skos:prefLabel>
            <skos:inScheme rdf:resource="https://data.vlaanderen.be/id/conceptscheme/MAGDA-categorie" />
          </skos:Concept>
        </mdcat:MAGDA-categorie>
        <mdcat:statuut>
          <skos:Concept rdf:about="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATA">
            <skos:prefLabel xml:lang="nl">Vlaamse Open data</skos:prefLabel>
            <skos:prefLabel xml:lang="en">Vlaamse Open data</skos:prefLabel>
            <skos:prefLabel xml:lang="fr">Vlaamse Open data</skos:prefLabel>
            <skos:prefLabel xml:lang="de">Vlaamse Open data</skos:prefLabel>
            <skos:inScheme rdf:resource="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden" />
          </skos:Concept>
        </mdcat:statuut>
        <owl:versionInfo>version 1.0</owl:versionInfo>
      </dcat:Dataset>
    </dcat:dataset>
    <dcat:record>
      <dcat:CatalogRecord rdf:about="http://localhost:8080/srv/api/records/345f47ef-abd5-4f2f-9ab7-d723565cccea">
        <foaf:primaryTopic rdf:resource="http://localhost:8080/srv/resources/datasets/16752832-7ef7-4539-9869-5236400cf249" />
        <dct:modified>2025-12-24</dct:modified>
        <dct:conformsTo>
          <dct:Standard rdf:about="https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03">
            <dct:identifier>https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03</dct:identifier>
            <dct:title xml:lang="nl">DCAT-AP Vlaanderen</dct:title>
            <dct:title xml:lang="fr">DCAT-AP Flandre</dct:title>
            <dct:title xml:lang="de">DCAT-AP Flandern</dct:title>
            <dct:title xml:lang="en">DCAT-AP Flanders</dct:title>
            <dct:description xml:lang="nl">Dit applicatieprofiel beschrijft Open Data Catalogi in Vlaanderen. DCAT-AP Vlaanderen (DCAT-AP VL) is een verdere specialisatie van DCAT-AP. De applicatie waarop dit profiel betrekking heeft is een Open Data Portaal in Vlaanderen. Open Data portalen zijn catalogussen van Open Data datasets. Ze hebben als belangrijkste doelstelling het vindbaar maken van data en hierdoor het hergebruik ervan te stimuleren. Open Data portalen vervullen een centrale rol in de overheidsopdracht om de toegankelijkheid tot overheidsinformatie te realiseren. Met dit applicatieprofiel bevorderen we de uniformiteit van de beschikbare informatie over datasets. Tevens vereenvoudigen we het aggregatie proces van meerdere Open Data Catalogi. Dit document bevat de verplichte elementen en bijkomende elementen waarover DCAT-AP Vlaanderen een uitspraak doet. Aanbevolen en optionele informatie waarvoor geen bijkomende afspraken in de context van DCAT-AP Vlaanderen zijn, zijn niet opgenomen in dit document. Hiervoor verwijzen we naar de DCAT-AP specificatie zelf.</dct:description>
            <dct:description xml:lang="fr">Ce profil d''application décrit les catalogues de données ouvertes en Flandre. DCAT-AP Flandre (DCAT-AP VL) est une spécialisation supplémentaire de DCAT-AP. L''application concernée par ce profil est un portail de données ouvertes en Flandre. Les portails de données ouvertes sont des catalogues de jeux de données ouvertes. Leur objectif principal est de faciliter la découverte des données et ainsi de stimuler leur réutilisation. Ils jouent un rôle central dans la mission du gouvernement visant à garantir l''accessibilité des informations gouvernementales. Avec ce profil d''application, nous favorisons l''uniformité des informations disponibles entre les jeux de données. Nous simplifions également le processus d''agrégation de plusieurs catalogues de données ouvertes. Ce document contient les éléments obligatoires et les éléments supplémentaires sur lesquels DCAT-AP Flandre émet une déclaration. Les informations recommandées et facultatives pour lesquelles aucun accord supplémentaire n''existe dans le cadre de DCAT-AP Flandre ne sont pas incluses dans ce document. Pour cela, nous nous référons à la spécification DCAT-AP elle-même.</dct:description>
            <dct:description xml:lang="de">Dieses Anwendungsprofil beschreibt Open Data-Kataloge in Flandern. DCAT-AP Flandern (DCAT-AP VL) ist eine lokale Ableitung von DCAT-AP. Die Anwendung, auf die sich dieses Profil bezieht, ist ein Open Data-Portal in Flandern. Open Data-Portale sind Kataloge mit Open Data-Datensätzen. Ihr Hauptzweck besteht darin, Daten auffindbar zu machen und so ihre Wiederverwendung zu fördern. Open Data-Portale spielen eine zentrale Rolle beim Auftrag der Regierung, Zugang zu Regierungsinformationen erreichbar zu machen. Mit diesem Anwendungsprofil fördern wir die Einheitlichkeit der verfügbaren Informationen über alle Datensätze hinweg. Wir vereinfachen außerdem den Aggregationsprozess mehrerer Open Data-Kataloge. Dieses Dokument enthält die obligatorischen Elemente und zusätzliche Elemente, die spezifisch für DCAT-AP Flandern beschrieben werden. Empfohlene und optionale Informationen, für die im Rahmen von DCAT-AP Flandern keine zusätzlichen Vereinbarungen bestehen, sind in diesem Dokument nicht enthalten. Hierzu verweisen wir auf die DCAT-AP-Spezifikation selbst.</dct:description>
            <dct:description xml:lang="en">This application profile describes Open Data Catalogues in Flanders. DCAT-AP Flanders (DCAT-AP VL) is a further specialization of DCAT-AP. The application to which this profile relates is an Open Data Portal in Flanders. Open Data Portals are catalogs of Open Data datasets. Their main purpose is to make data discoverable and thus stimulate its reuse. Open Data Portals play a central role in the government''s mission to achieve accessibility to government information. With this application profile, we promote the uniformity of available information across datasets. We also simplify the aggregation process of multiple Open Data Catalogs. This document contains the mandatory elements and additional elements on which DCAT-AP Flanders provides a statement. Recommended and optional information for which no additional agreements exist within the context of DCAT-AP Flanders are not included in this document. For this, we refer to the DCAT-AP specification itself.</dct:description>
            <owl:versionInfo>2.0</owl:versionInfo>
          </dct:Standard>
        </dct:conformsTo>
        <dct:language>
          <skos:Concept rdf:about="http://publications.europa.eu/resource/authority/language/NLD">
            <rdf:type rdf:resource="http://purl.org/dc/terms/LinguisticSystem" />
            <skos:prefLabel xml:lang="nl">Nederlands</skos:prefLabel>
          </skos:Concept>
        </dct:language>
        <dct:identifier>345f47ef-abd5-4f2f-9ab7-d723565cccea</dct:identifier>
        <dct:created rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2025-12-24</dct:created>
      </dcat:CatalogRecord>
    </dcat:record>
    <dct:description xml:lang="nl">Deze catalogus bevat datasets ontsloten door My organization</dct:description>
    <dct:identifier>eb248be8-549d-493f-b323-1dba08bb5417</dct:identifier>
    <dct:issued>2019-09-01</dct:issued>
    <dct:language>
      <skos:Concept rdf:about="http://publications.europa.eu/resource/authority/language/NLD">
        <rdf:type rdf:resource="http://purl.org/dc/terms/LinguisticSystem" />
        <skos:prefLabel xml:lang="nl">Nederlands</skos:prefLabel>
        <skos:inScheme rdf:resource="http://publications.europa.eu/resource/authority/language" />
      </skos:Concept>
    </dct:language>
    <dct:license>
      <dct:LicenseDocument rdf:about="https://data.vlaanderen.be/id/licentie/creative-commons-zero-verklaring/v1.0">
        <dct:type>
          <skos:Concept rdf:about="http://purl.org/adms/licencetype/PublicDomain">
            <skos:prefLabel xml:lang="nl">Werk in het publiek domein</skos:prefLabel>
            <skos:inScheme rdf:resource="http://purl.org/adms/licencetype/1.0" />
          </skos:Concept>
        </dct:type>
        <dct:title xml:lang="nl">Creative Commons Zero verklaring</dct:title>
        <dct:description xml:lang="nl">De instantie doet afstand van haar intellectuele eigendomsrechten voor zover dit wettelijk mogelijk is. Hierdoor kan de gebruiker de data hergebruiken voor eender welk doel, zonder een verplichting op naamsvermelding. Deze is de welbekende CC0 licentie.</dct:description>
        <dct:identifier>https://data.vlaanderen.be/id/licentie/creative-commons-zero-verklaring/v1.0</dct:identifier>
      </dct:LicenseDocument>
    </dct:license>
    <dct:modified>2019-09-01</dct:modified>
    <dct:publisher>
      <foaf:Agent rdf:about="http://localhost:8080/geonetwork/srv/resources/organizations/My%20organization">
        <foaf:name xml:lang="nl">My organization</foaf:name>
        <dct:type>
          <skos:Concept rdf:about="http://purl.org/adms/publishertype/LocalAuthority">
            <skos:prefLabel xml:lang="nl">Lokaal bestuur</skos:prefLabel>
            <skos:inScheme rdf:resource="http://purl.org/adms/publishertype/1.0" />
          </skos:Concept>
        </dct:type>
      </foaf:Agent>
    </dct:publisher>
    <dct:title xml:lang="nl">Open Data Catalogus van My organization</dct:title>
    <foaf:homepage>
      <foaf:Document rdf:about="http://localhost:8080/srv/eng/">
        <foaf:name xml:lang="nl">My GeoNetwork catalogue</foaf:name>
      </foaf:Document>
    </foaf:homepage>
  </dcat:Catalog>
</rdf:RDF>', '2025-12-24T14:01:05.102345Z', '2025-12-24T13:58:49.42111Z', 0, NULL, NULL, 0, 0, 'rdf:RDF', 'dcat-ap',
            NULL, 'n', 'n', NULL, NULL, 2, 1, 'eb248be8-549d-493f-b323-1dba08bb5417',
            '345f47ef-abd5-4f2f-9ab7-d723565cccea');

    -- mobilityDCAT-AP 1.1.0 test record - uuid d2e57ef8-2bff-41bd-b2ff-3ceb90dc4dd9
    _recordid := _recordid+1;
    INSERT INTO public.metadata
    (id, "data", changedate, createdate, displayorder, doctype, extra, popularity, rating, root, schemaid, title, istemplate, isharvested, harvesturi, harvestuuid, groupowner, "owner", "source", "uuid")
    VALUES(_recordid, '<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:spdx="http://spdx.org/rdf/terms#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:adms="http://www.w3.org/ns/adms#" xmlns:locn="http://www.w3.org/ns/locn#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:dct="http://purl.org/dc/terms/" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:dcat="http://www.w3.org/ns/dcat#" xmlns:schema="http://schema.org/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcatap="http://data.europa.eu/r5r/" xmlns:mdcat="https://data.vlaanderen.be/ns/metadata-dcat#" xmlns:mobilitydcatap="https://w3id.org/mobilitydcat-ap" xmlns:geodcatap="http://data.europa.eu/930/" xmlns:oa="http://www.w3.org/ns/oa#" xmlns:dqv="http://www.w3.org/ns/dqv#" xmlns:cnt="http://www.w3.org/2011/content#">
  <dcat:Catalog rdf:about="https://localhost:8080/geonetwork/srv/resources/catalogs/c678d0fb-894d-403f-b146-4b96706a1a16">
    <dcat:contactPoint>
      <vcard:Organization>
        <vcard:organization-name>agentschap Digitaal Vlaanderen</vcard:organization-name>
        <vcard:hasEmail rdf:resource="mailto:digitaal.vlaanderen@vlaanderen.be" />
        <vcard:hasURL rdf:resource="https://www.vlaanderen.be/digitaal-vlaanderen" />
      </vcard:Organization>
    </dcat:contactPoint>
    <dcat:dataset>
      <dcat:Dataset rdf:about="http://localhost:8080/srv/resources/datasets/7dfbb97c-96bc-4cfb-a1fd-6529c3ce2fdc">
        <dcat:contactPoint>
          <vcard:Organization>
            <vcard:fn>contact name</vcard:fn>
            <vcard:organization-name xml:lang="en">organisation name</vcard:organization-name>
            <vcard:hasAddress>
              <vcard:Address>
                <vcard:street-address xml:lang="en">contact point</vcard:street-address>
                <vcard:locality xml:lang="en">contact point locality</vcard:locality>
                <vcard:postal-code>contact point postal code</vcard:postal-code>
                <vcard:country-name xml:lang="en">contact point country</vcard:country-name>
              </vcard:Address>
            </vcard:hasAddress>
            <vcard:hasEmail rdf:resource="mailto:contact@poi.nt" />
            <vcard:hasURL rdf:resource="https://contact.point/website" />
            <vcard:hasTelephone>112233</vcard:hasTelephone>
          </vcard:Organization>
        </dcat:contactPoint>
        <dcat:distribution>
          <dcat:Distribution rdf:about="http://localhost:8080/srv/resources/distributions/836af0bc-cbd8-4a10-8d8f-3a5ff4375f03">
            <dcat:accessURL rdf:resource="https://access.url/distribution1" />
            <dct:description xml:lang="en">Distribution 1 description</dct:description>
            <dct:title xml:lang="en">Distribution 1 title</dct:title>
            <dct:identifier>836af0bc-cbd8-4a10-8d8f-3a5ff4375f03</dct:identifier>
          </dcat:Distribution>
        </dcat:distribution>
        <dcat:keyword xml:lang="en">keyword1</dcat:keyword>
        <dcat:landingPage rdf:resource="https://landing.page.be" />
        <dcat:theme>
          <skos:Concept rdf:about="http://publications.europa.eu/resource/authority/data-theme/TRAN">
            <skos:prefLabel xml:lang="en">Transport</skos:prefLabel>
            <skos:inScheme rdf:resource="http://publications.europa.eu/resource/authority/data-theme" />
          </skos:Concept>
        </dcat:theme>
        <adms:identifier>
          <adms:Identifier>
            <skos:notation>notation of other identifier</skos:notation>
          </adms:Identifier>
        </adms:identifier>
        <adms:versionNotes xml:lang="en">version v1 notes</adms:versionNotes>
        <dct:accessRights>
          <skos:Concept rdf:about="http://publications.europa.eu/resource/authority/access-right/PUBLIC">
            <rdf:type rdf:resource="http://purl.org/dc/terms/RightsStatement" />
            <skos:prefLabel xml:lang="en">public</skos:prefLabel>
            <skos:inScheme rdf:resource="http://publications.europa.eu/resource/authority/access-right" />
          </skos:Concept>
        </dct:accessRights>
        <dct:accrualPeriodicity>
          <skos:Concept rdf:about="http://publications.europa.eu/resource/authority/frequency/BIMONTHLY">
            <rdf:type rdf:resource="http://purl.org/dc/terms/Frequency" />
            <skos:prefLabel xml:lang="en">bimonthly</skos:prefLabel>
            <skos:inScheme rdf:resource="http://publications.europa.eu/resource/authority/frequency" />
          </skos:Concept>
        </dct:accrualPeriodicity>
        <dct:description xml:lang="en">Description of MobilityDCAT-AP test record</dct:description>
        <dct:identifier>7dfbb97c-96bc-4cfb-a1fd-6529c3ce2fdc</dct:identifier>
        <dct:issued rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2026-02-19</dct:issued>
        <dct:modified rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2026-02-18</dct:modified>
        <dct:publisher>
          <foaf:Agent>
            <foaf:name xml:lang="en">Publisher 1 name</foaf:name>
            <dct:type>
              <skos:Concept rdf:about="http://purl.org/adms/publishertype/Company">
                <skos:prefLabel xml:lang="en">Company</skos:prefLabel>
                <skos:inScheme rdf:resource="http://purl.org/adms/publishertype/1.0" />
              </skos:Concept>
            </dct:type>
            <foaf:workplaceHomepage rdf:resource="workplace homepage 1" />
            <locn:address>
              <locn:fullAddress>publisher 1 full adress</locn:fullAddress>
              <locn:poBox>publisher 1 po box</locn:poBox>
              <locn:thoroughfare>publisher 1 thoroughfare</locn:thoroughfare>
              <locn:locatorDesignator>publisher 1 locator designator</locn:locatorDesignator>
              <locn:locatorName>publisher 1 locator name</locn:locatorName>
              <locn:addressArea>publisher 1 address area</locn:addressArea>
              <locn:postName>publisher 1 post name</locn:postName>
              <locn:postCode>publisher 1 post code</locn:postCode>
              <locn:adminUnitL2>publisher 1 admin unit l2</locn:adminUnitL2>
              <locn:adminUnitL1>publisher 1 admin unit l1</locn:adminUnitL1>
            </locn:address>
            <foaf:mbox rdf:resource="publisher@the.one" />
            <foaf:firstName xml:lang="en">Publisher firstname</foaf:firstName>
            <foaf:surname xml:lang="en">Publisher surname</foaf:surname>
            <foaf:phone rdf:resource="Publisher 01234556" />
          </foaf:Agent>
        </dct:publisher>
        <dct:rights>
          <dct:RightsStatement>
            <dct:title xml:lang="en">Rights 1 titel</dct:title>
            <dct:description xml:lang="en">Rights 1 description</dct:description>
          </dct:RightsStatement>
        </dct:rights>
        <dct:spatial>
          <dct:Location rdf:about="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Vlaamse-Administratieve-Eenheden/2025/gemeente/oostkamp">
            <locn:geometry rdf:datatype="http://www.opengis.net/ont/geosparql#wktLiteral">POLYGON ((3.150382 51.056301,3.150382 51.186463,3.302226 51.186463,3.302226 51.056301,3.150382 51.056301))</locn:geometry>
            <locn:geometry rdf:datatype="http://www.opengis.net/ont/geosparql#gmlLiteral">&lt;gml:Polygon&gt;&lt;gml:exterior&gt;&lt;gml:LinearRing&gt;&lt;gml:posList&gt;51.056301 3.150382 51.186463 3.150382 51.186463 3.302226 51.056301 3.302226 51.056301 3.150382&lt;/gml:posList&gt;&lt;/gml:LinearRing&gt;&lt;/gml:exterior&gt;&lt;/gml:Polygon&gt;</locn:geometry>
          </dct:Location>
        </dct:spatial>
        <dct:temporal>
          <dct:PeriodOfTime>
            <schema:startDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2026-02-01</schema:startDate>
            <schema:endDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2026-02-28</schema:endDate>
          </dct:PeriodOfTime>
        </dct:temporal>
        <dct:title xml:lang="en">MobilityDCAT-AP test record</dct:title>
        <dct:created rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2026-02-17</dct:created>
        <dct:rightsHolder>
          <foaf:Agent>
            <foaf:name xml:lang="en">rights holder name</foaf:name>
            <dct:type>
              <skos:Concept rdf:about="http://purl.org/adms/publishertype/IndustryConsortium">
                <skos:prefLabel xml:lang="en">Industry consortium</skos:prefLabel>
                <skos:inScheme rdf:resource="http://purl.org/adms/publishertype/1.0" />
              </skos:Concept>
            </dct:type>
          </foaf:Agent>
        </dct:rightsHolder>
        <mdcat:statuut>
          <skos:Concept rdf:about="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/VLOPENDATA">
            <skos:prefLabel xml:lang="en">Vlaamse Open data</skos:prefLabel>
            <skos:inScheme rdf:resource="https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden" />
          </skos:Concept>
        </mdcat:statuut>
        <mobilitydcatap:mobilityTheme>
          <skos:Concept>
            <skos:prefLabel xml:lang="en" />
          </skos:Concept>
        </mobilitydcatap:mobilityTheme>
        <mobilitydcatap:mobilityTheme>
          <skos:Concept rdf:about="https://w3id.org/mobilitydcat-ap/mobility-theme/accidents-and-incidents">
            <skos:prefLabel xml:lang="en">Accidents and incidents</skos:prefLabel>
            <skos:inScheme rdf:resource="https://w3id.org/mobilitydcat-ap/mobility-theme" />
          </skos:Concept>
        </mobilitydcatap:mobilityTheme>
        <mobilitydcatap:mobilityTheme>
          <skos:Concept rdf:about="https://w3id.org/mobilitydcat-ap/mobility-theme/air-and-space-travel">
            <skos:prefLabel xml:lang="en">Air and space travel</skos:prefLabel>
            <skos:inScheme rdf:resource="https://w3id.org/mobilitydcat-ap/mobility-theme" />
          </skos:Concept>
        </mobilitydcatap:mobilityTheme>
        <mobilitydcatap:transportMode>
          <skos:Concept>
            <skos:prefLabel xml:lang="en" />
          </skos:Concept>
        </mobilitydcatap:transportMode>
        <mobilitydcatap:transportMode>
          <skos:Concept rdf:about="https://w3id.org/mobilitydcat-ap/transport-mode/bicycle">
            <skos:prefLabel xml:lang="en">Bicycle</skos:prefLabel>
            <skos:inScheme rdf:resource="https://w3id.org/mobilitydcat-ap/transport-mode" />
          </skos:Concept>
        </mobilitydcatap:transportMode>
        <mobilitydcatap:transportMode>
          <skos:Concept rdf:about="https://w3id.org/mobilitydcat-ap/transport-mode/car">
            <skos:prefLabel xml:lang="en">Car</skos:prefLabel>
            <skos:inScheme rdf:resource="https://w3id.org/mobilitydcat-ap/transport-mode" />
          </skos:Concept>
        </mobilitydcatap:transportMode>
        <mobilitydcatap:networkCoverage>
          <skos:Concept>
            <skos:prefLabel xml:lang="en" />
          </skos:Concept>
        </mobilitydcatap:networkCoverage>
        <mobilitydcatap:networkCoverage>
          <skos:Concept rdf:about="https://w3id.org/mobilitydcat-ap/network-coverage/tern-network">
            <skos:prefLabel xml:lang="en">Trans-European Road Network (TERN)</skos:prefLabel>
            <skos:inScheme rdf:resource="https://w3id.org/mobilitydcat-ap/network-coverage" />
          </skos:Concept>
        </mobilitydcatap:networkCoverage>
        <mobilitydcatap:networkCoverage>
          <skos:Concept rdf:about="https://w3id.org/mobilitydcat-ap/network-coverage/other">
            <skos:prefLabel xml:lang="en">Other</skos:prefLabel>
            <skos:inScheme rdf:resource="https://w3id.org/mobilitydcat-ap/network-coverage" />
          </skos:Concept>
        </mobilitydcatap:networkCoverage>
        <mobilitydcatap:georeferencingMethod>
          <skos:Concept>
            <skos:prefLabel xml:lang="en" />
          </skos:Concept>
        </mobilitydcatap:georeferencingMethod>
        <mobilitydcatap:georeferencingMethod>
          <skos:Concept rdf:about="https://w3id.org/mobilitydcat-ap/georeferencing-method/gml">
            <skos:prefLabel xml:lang="en">GML</skos:prefLabel>
            <skos:inScheme rdf:resource="https://w3id.org/mobilitydcat-ap/georeferencing-method" />
          </skos:Concept>
        </mobilitydcatap:georeferencingMethod>
        <mobilitydcatap:georeferencingMethod>
          <skos:Concept rdf:about="https://w3id.org/mobilitydcat-ap/georeferencing-method/geocoordinates">
            <skos:prefLabel xml:lang="en">Geocoordinates</skos:prefLabel>
            <skos:inScheme rdf:resource="https://w3id.org/mobilitydcat-ap/georeferencing-method" />
          </skos:Concept>
        </mobilitydcatap:georeferencingMethod>
        <mobilitydcatap:intendedInformationService>
          <skos:Concept>
            <skos:prefLabel xml:lang="en" />
          </skos:Concept>
        </mobilitydcatap:intendedInformationService>
        <mobilitydcatap:intendedInformationService>
          <skos:Concept rdf:about="https://w3id.org/mobilitydcat-ap/intended-information-service/dynamic-availability-check">
            <skos:prefLabel xml:lang="en">Dynamic availability check</skos:prefLabel>
            <skos:inScheme rdf:resource="https://w3id.org/mobilitydcat-ap/intended-information-service" />
          </skos:Concept>
        </mobilitydcatap:intendedInformationService>
        <mobilitydcatap:intendedInformationService>
          <skos:Concept rdf:about="https://w3id.org/mobilitydcat-ap/intended-information-service/dynamic-information-service">
            <skos:prefLabel xml:lang="en">Dynamic Information service</skos:prefLabel>
            <skos:inScheme rdf:resource="https://w3id.org/mobilitydcat-ap/intended-information-service" />
          </skos:Concept>
        </mobilitydcatap:intendedInformationService>
        <mobilitydcatap:assessmentResult>
          <dct:issued rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2026-02-20</dct:issued>
          <oa:hasBody rdf:resource="https://assessment.check" />
        </mobilitydcatap:assessmentResult>
        <dqv:hasQualityAnnotation>
          <oa:hasBody rdf:resource="https://quality.annotation" />
        </dqv:hasQualityAnnotation>
        <owl:versionInfo>version v1</owl:versionInfo>
      </dcat:Dataset>
    </dcat:dataset>
    <dcat:record>
      <dcat:CatalogRecord rdf:about="http://localhost:8080/srv/api/records/d2e57ef8-2bff-41bd-b2ff-3ceb90dc4dd9">
        <foaf:primaryTopic rdf:resource="http://localhost:8080/srv/resources/datasets/7dfbb97c-96bc-4cfb-a1fd-6529c3ce2fdc" />
        <dct:modified>2026-02-17</dct:modified>
        <dct:conformsTo>
          <dct:Standard rdf:about="https://w3id.org/mobilitydcat-ap/releases/1.1.0/">
            <dct:identifier>https://w3id.org/mobilitydcat-ap/releases/1.1.0/</dct:identifier>
            <dct:title xml:lang="en">mobilityDCAT-AP 1.1.0</dct:title>
            <owl:versionInfo>1.1.0</owl:versionInfo>
          </dct:Standard>
        </dct:conformsTo>
        <dct:conformsTo>
          <dct:Standard rdf:about="https://joinup.ec.europa.eu/collection/semic-support-centre/solution/dcat-application-profile-data-portals-europe/release/200">
            <dct:identifier>https://joinup.ec.europa.eu/collection/semic-support-centre/solution/dcat-application-profile-data-portals-europe/release/200</dct:identifier>
            <dct:title xml:lang="en">DCAT-AP</dct:title>
            <dct:description xml:lang="en">DCAT Application Profile for data portals in Europe</dct:description>
            <owl:versionInfo>2.0.0</owl:versionInfo>
          </dct:Standard>
        </dct:conformsTo>
        <dct:language>
          <skos:Concept rdf:about="http://publications.europa.eu/resource/authority/language/ENG">
            <rdf:type rdf:resource="http://purl.org/dc/terms/LinguisticSystem" />
            <skos:prefLabel xml:lang="en">English</skos:prefLabel>
            <skos:inScheme rdf:resource="http://publications.europa.eu/resource/authority/language" />
          </skos:Concept>
        </dct:language>
        <dct:identifier>d2e57ef8-2bff-41bd-b2ff-3ceb90dc4dd9</dct:identifier>
        <dct:created rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2026-02-17</dct:created>
      </dcat:CatalogRecord>
    </dcat:record>
    <dct:description xml:lang="en">Deze catalogus bevat datasets ontsloten door agentschap Digitaal Vlaanderen</dct:description>
    <dct:identifier>c678d0fb-894d-403f-b146-4b96706a1a16</dct:identifier>
    <dct:issued>2019-09-01</dct:issued>
    <dct:language>
      <skos:Concept rdf:about="http://publications.europa.eu/resource/authority/language/NLD">
        <rdf:type rdf:resource="http://purl.org/dc/terms/LinguisticSystem" />
        <skos:prefLabel xml:lang="en">Nederlands</skos:prefLabel>
        <skos:inScheme rdf:resource="http://publications.europa.eu/resource/authority/language" />
      </skos:Concept>
    </dct:language>
    <dct:license>
      <dct:LicenseDocument rdf:about="https://data.vlaanderen.be/id/licentie/creative-commons-zero-verklaring/v1.0">
        <dct:type>
          <skos:Concept rdf:about="http://purl.org/adms/licencetype/PublicDomain">
            <skos:prefLabel xml:lang="en">Werk in het publiek domein</skos:prefLabel>
            <skos:inScheme rdf:resource="http://purl.org/adms/licencetype/1.0" />
          </skos:Concept>
        </dct:type>
        <dct:title xml:lang="en">Creative Commons Zero verklaring</dct:title>
        <dct:description xml:lang="en">De instantie doet afstand van haar intellectuele eigendomsrechten voor zover dit wettelijk mogelijk is. Hierdoor kan de gebruiker de data hergebruiken voor eender welk doel, zonder een verplichting op naamsvermelding. Deze is de welbekende CC0 licentie.</dct:description>
        <dct:identifier>https://data.vlaanderen.be/id/licentie/creative-commons-zero-verklaring/v1.0</dct:identifier>
      </dct:LicenseDocument>
    </dct:license>
    <dct:modified>2019-09-01</dct:modified>
    <dct:publisher>
      <foaf:Agent rdf:about="https://localhost:8080/geonetwork/srv/resources/organizations/agentschap%20Digitaal%20Vlaanderen">
        <foaf:name xml:lang="en">agentschap Digitaal Vlaanderen</foaf:name>
        <dct:type>
          <skos:Concept rdf:about="http://purl.org/adms/publishertype/LocalAuthority">
            <skos:prefLabel xml:lang="en">Lokaal bestuur</skos:prefLabel>
            <skos:inScheme rdf:resource="http://purl.org/adms/publishertype/1.0" />
          </skos:Concept>
        </dct:type>
      </foaf:Agent>
    </dct:publisher>
    <dct:title xml:lang="en">Open Data Catalogus van agentschap Digitaal Vlaanderen</dct:title>
    <foaf:homepage>
      <foaf:Document rdf:about="http://localhost:8080/srv/dut/">
        <foaf:name xml:lang="en">Metadata Vlaanderen</foaf:name>
      </foaf:Document>
    </foaf:homepage>
  </dcat:Catalog>
</rdf:RDF>', '2026-02-17T14:47:52.095464Z', '2026-02-17T13:36:18.27919Z', 0, NULL, NULL, 10, 0, 'rdf:RDF', 'dcat-ap', NULL, 'n', 'n', NULL, NULL, 2, 1, 'c678d0fb-894d-403f-b146-4b96706a1a16', 'd2e57ef8-2bff-41bd-b2ff-3ceb90dc4dd9');
  END;
$$ LANGUAGE plpgsql;

