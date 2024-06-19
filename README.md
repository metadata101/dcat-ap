# DCAT-AP Schema Plugin for GeoNetwork

This repository contains a [DCAT-AP VL v2.0](https://joinup.ec.europa.eu/collection/semantic-interoperability-community-semic/solution/dcat-application-profile-data-portals-europe/release/200) schema plugin for [GeoNetwork](http://geonetwork-opensource.org/).

## Reference documents
* [W3C Data Catalog Vocabulary (DCAT)](https://www.w3.org/TR/vocab-dcat/), Fadi Maali, John Erickson, 2014.
* [DCAT Application profile for data portals in Europe (DCAT-AP) v2.0](https://joinup.ec.europa.eu/collection/semantic-interoperability-community-semic/solution/dcat-application-profile-data-portals-europe/release/200)
* Interoperability between metadata standards: a reference implementation for metadata catalogues, Geraldine Nolf, W3C SDSVoc 2016. [[paper](https://www.w3.org/2016/11/sdsvoc/SDSVoc16_paper_11)] [[slides](https://www.w3.org/2016/11/sdsvoc/SDSVoc16_PPT_v02)]

## Description

This plugin has the following features:

* **XML Schema for DCAT-AP**: GeoNetwork is capable of storing metadata in XML format. The plugin therefore defines its own XML Schema (see the [schema](/src/main/plugin/dcat2/schema) folder) for DCAT-AP that is used for the internal representation of DCAT-AP fields. To limit the data conversion needed, the XML Schema was designed to fully resemble an XML/RDF syntax of DCAT-AP.
* **indexing**: The plugin maximally populates GeoNetwork's existing index fields for a consistent search experience.
* **editing**:  A custom form was created following the guidance in the GeoNetwork [form customization guide](http://geonetwork-opensource.org/manuals/trunk/eng/users/customizing-application/editor-ui/creating-custom-editor.html). The form uses the controlled vocabularies required by DCAT-AP. These are located in the folder[thesauri](/src/main/plugin/dcat2/thesauri) and can be imported in to GeoNetwork as SKOS [classification systems](https://geonetwork-opensource.org/manuals/3.6.x/is/administrator-guide/managing-classification-systems/index.html) using standard GeoNetwork functionality.
* **viewing**: A custom 'full view' to visualise DCAT-AP records. 
* **multilingual metadata support**: The editor, view, and search benefit from the already existing multilingual capabilities of GeoNetwork.
* **validation (XSD and Schematron)**: Validation steps are first XSD validation made on the schema, then the schematron validation defined in folder  [dcat2/schematron](/src/main/plugin/dcat2/schematron). Two rule sets are available: schematron-rules-dcat2, and schematron-rules-metadata-dcat-recommendations.

## Installing the plugin

### Adding the plugin to the source code

To include this schema plugin in a build, copy the dcat2 schema folder in the schemas folder, add it to the schemas/pom.xml and add it to the copy-schemas execution in web/pom.xml.

The best approach is to add the plugin as a submodule into GeoNetwork schema module.

```shell
cd schemas
git submodule add <dcat2 remote URL> dcat2
git submodule init
git submodule update
```

Add the new module to the schemas/pom.xml:

```xml
<modules>
  <!-- ... -->
  <module>iso19139</module>
  <module>dcat2</module>
</modules>
```

Add the dependency in the web module in web/pom.xml:

```xml
<dependency>
  <groupId>org.geonetwork-opensource.schemas</groupId>
  <artifactId>gn-schema-dcat2</artifactId>
  <version>[DCAT PLUGIN VERSION]</version>
</dependency>
```

Add the module to the webapp in web/pom.xml:

```xml
<execution>
  <id>unpack-schemas</id>
  <phase>process-resources</phase>
  <goals><goal>unpack</goal></goals>
  <configuration>
    <encoding>UTF-8</encoding>
    <artifactItems>
      <!-- ... -->
      <artifactItem>
        <groupId>org.geonetwork-opensource.schemas</groupId>
        <artifactId>gn-schema-dcat2</artifactId>
        <type>zip</type>
        <overWrite>false</overWrite>
        <outputDirectory>${schema-plugins.dir}</outputDirectory>
      </artifactItem>
    </artifactItems>
  </configuration>
</execution>
```

Commit these changes.

Apply the [patches](/core-geonetwork-patches) to the geonetwork core. You may need to manually apply specific hunks of a patch.
```
cd ..   (core-geonetwork)
git am --ignore-space-change --ignore-whitespace --reject --whitespace=fix schemas/dcat2/core-geonetwork-patches/*.patch
```

Build and run the application following the
[Software Development Documentation](https://github.com/geonetwork/core-geonetwork/tree/main/software_development). You'll need to have Java JDK 11 and [Maven](https://maven.apache.org/install.html) installed.

Samples and templates can be imported via the 'Admin Console' > 'Metadata and Templates' > 'dcat2' menu.

Make sure to import the thesauri located in `schemas/dcat2/resources/thesauri` as they are required for editing dcat2 records.

## Compatibility matrix

| DCAT plugin version | Tested GeoNetwork version |
|:--------------------|:--------------------------|
| 1.0.x               | 4.4.5                     |

## Metadata rules: metadata identifier

The plugin uses dct:identifier to store a uuid that is used as (internal) metadata identifier. 
The metadata identifier is stored in the element dcat:CatalogRecord/dct:identifier. 
When saving a record, this uuid is appended to the dataset URI, provided that the metadata (template) contains a dataset URI that ends with a uuid and the record is not harvested.


```xml
<dcat:CatalogRecord rdf:about="https://metadata.vlaanderen.be/srv/api/records/818c2174-4f26-48b6-8f76-b51bb9cbc4e8">
  <dct:identifier>818c2174-4f26-48b6-8f76-b51bb9cbc4e8</dct:identifier>
  <!-- ... -->
</dcat:CatalogRecord>
```

## Community

Comments and questions to the issue tracker.

## More work required

This plugin would merit further improvements in at least the following areas:
* **Default view**: the default view currently does not display all the relevant information

## Contributors

* Dirk Debaere (Digitaal Vlaanderen)
* Mathias De Schrijver (Digitaal Vlaanderen)
* Geraldine Nolf (Digitaal Vlaanderen) 
* Bart Cosyn (Digitaal Vlaanderen)
* Stijn Van Speybroeck (Digitaal Vlaanderen)
* Joachim Nielandt (Digitaal Vlaanderen)
* Gustaaf Vandeboel (GIM)
* Mathieu Chaussier (GIM)
* Stijn Goedertier (GIM)
* Mathieu Van Wambeke (GIM)
* An Heirman (GIM)

## Acknowledgement

The work on this schema plugin was funded by and carried out in close collaboration with Digitaal Vlaanderen ([DV](https://www.vlaanderen.be/digitaal-vlaanderen)).  
