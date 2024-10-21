# DCAT-AP Schema Plugin for GeoNetwork

This repository contains a [DCAT-AP VL v2.0](https://joinup.ec.europa.eu/collection/semantic-interoperability-community-semic/solution/dcat-application-profile-data-portals-europe/release/200) schema plugin for [GeoNetwork](http://geonetwork-opensource.org/).

## Reference documents
* [W3C Data Catalog Vocabulary (DCAT)](https://www.w3.org/TR/vocab-dcat/), Fadi Maali, John Erickson, 2014.
* [DCAT Application profile for data portals in Europe (DCAT-AP) v2.0](https://joinup.ec.europa.eu/collection/semantic-interoperability-community-semic/solution/dcat-application-profile-data-portals-europe/release/200)
* Interoperability between metadata standards: a reference implementation for metadata catalogues, Geraldine Nolf, W3C SDSVoc 2016. [[paper](https://www.w3.org/2016/11/sdsvoc/SDSVoc16_paper_11)] [[slides](https://www.w3.org/2016/11/sdsvoc/SDSVoc16_PPT_v02)]

## Description

This plugin has the following features:

* **XML Schema for DCAT-AP**: GeoNetwork is capable of storing metadata in XML format. The plugin therefore defines its own XML Schema (see the [schema](/src/main/plugin/dcat-ap/schema) folder) for DCAT-AP that is used for the internal representation of DCAT-AP fields. To limit the data conversion needed, the XML Schema was designed to fully resemble an XML/RDF syntax of DCAT-AP.
* **indexing**: The plugin maximally populates GeoNetwork's existing index fields for a consistent search experience.
* **editing**:  A custom form was created following the guidance in the GeoNetwork [form customization guide](http://geonetwork-opensource.org/manuals/trunk/eng/users/customizing-application/editor-ui/creating-custom-editor.html). The form uses the controlled vocabularies required by DCAT-AP. These are located in the folder[thesauri](/src/main/plugin/dcat-ap/thesauri) and can be imported in to GeoNetwork as SKOS [classification systems](https://geonetwork-opensource.org/manuals/3.6.x/is/administrator-guide/managing-classification-systems/index.html) using standard GeoNetwork functionality.
* **viewing**: A custom 'full view' to visualise DCAT-AP records. 
* **multilingual metadata support**: The editor, view, and search benefit from the already existing multilingual capabilities of GeoNetwork.
* **validation (XSD and Schematron)**: Validation steps are first XSD validation made on the schema, then the schematron validation defined in folder  [dcat-ap/schematron](/src/main/plugin/dcat-ap/schematron). Two rule sets are available: schematron-rules-dcat-ap, and schematron-rules-metadata-dcat-recommendations.

## Installing the plugin

### Adding the plugin to the source code

To include this schema plugin in a build, copy the dcat-ap schema folder in the schemas folder, add it to the schemas/pom.xml and add it to the copy-schemas execution in `web/pom.xml`.

The best approach is to add the plugin as a submodule into GeoNetwork schema module.

```shell
cd schemas
git submodule add <dcat-ap remote URL> dcat-ap
git submodule init
git submodule update
```

Add the new module to the `schemas/pom.xml`:

```xml
<modules>
  <!-- ... -->
  <module>dcat-ap</module>
</modules>
```

Add the dependency in the web module in `web/pom.xml`:

```xml
<dependency>
  <groupId>org.geonetwork-opensource.schemas</groupId>
  <artifactId>gn-schema-dcat-ap</artifactId>
  <version>${project.version}</version>
</dependency>
```

*Note* that versions need to be updated to correspond to GeoNetwork version updates. This is applicable in `dcat-ap/pom.xml` and can be automated by running `mvn versions:update-child-modules` after merges of GeoNetwork:

```xml
<parent>
  <artifactId>gn-schemas</artifactId>
  <groupId>org.geonetwork-opensource.schemas</groupId>
  <version>x.y.z</version>
</parent>
```

Add the module to the webapp in `web/pom.xml`:

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
        <artifactId>gn-schema-dcat-ap</artifactId>
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
# go to top-level core-geonetwork
cd ..
git am --ignore-space-change --ignore-whitespace --reject --whitespace=fix schemas/dcat-ap/core-geonetwork-patches/*.patch
```

Build and run the application following the
[Software Development Documentation](https://github.com/geonetwork/core-geonetwork/tree/main/software_development). You'll need to have Java JDK 11 and [Maven](https://maven.apache.org/install.html) installed.

Samples and templates can be imported via the 'Admin Console' > 'Metadata and Templates' > 'dcat-ap' menu.

Make sure to import the thesauri located in `schemas/dcat-ap/resources/thesauri` as they are required for editing dcat-ap records.

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

## How to create profile? 

### Profile identification

Using the `conformsTo` element in the  `CatalogRecord` element, the profile is identified. 

```xml
      <dcat:record>
         <dcat:CatalogRecord rdf:about="http://localhost:8080/geonetwork/srv/api/records/f356eaa6-506f-4510-93f8-0e449c28805a">
            <foaf:primaryTopic rdf:resource="http://localhost:8080/geonetwork/srv/resources/services/b273f602-0e29-4094-b02c-d72dbdd4e3ed"/>
            <dct:modified>2024-10-21</dct:modified>
            <dct:conformsTo>
               <dct:Standard rdf:about="https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03">
```

When the profile is adding couple of elements to potentially one or more existing profiles (eg. HVD adds `hvdCategory` element), 
then the profile extension should declare those new elements and each target profiles needs to embed it into their editor views.


### Schema

New profile elements need to be added to the [schema XSD](src/main/plugin/dcat-ap/schema/dcat.xsd) using cardinality `0..unbounded`.
Cardinality is checked using schematron, XSD define the elements and types (see validation).


```xml
   <xs:element ref="dct:rightsHolder" minOccurs="0" maxOccurs="unbounded"/>
```

If elements are defined in a new schema, add the schema in [XSD profile folder](src/main/plugin/dcat-ap/schema/profiles) or the top folder if they are generic (eg. `foaf`).



### Vocabularies

If some profile elements rely on vocabularies, add them to the [thesauri folder](resources/thesauri) using SKOS format.
Those vocabularies are imported when the application starts.


### Editor configuration

If the profile require a complete new editor, create a new view in the [editor configuration](src/main/plugin/dcat-ap/layout/config-editor.xml). 

See [customizing editor](https://docs.geonetwork-opensource.org/4.4/customizing-application/editor-ui/creating-custom-editor/) for more information.

First, add a view:

 ```xml
    <view name="profile-vl-mdcat"
              displayIfRecord="count(//dcat:CatalogRecord/dct:conformsTo/dct:Standard[@rdf:about = 'https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22']) > 0"
 ```

TODO: check default view using `default='true'`. What happens if more than one default?

Add one or more tab to the view:

```xml
 <tab id="profile-vl-mdcat-tabDataset" 
 ```

When creating tabs, make tab id attribute unique in the config-editor



TODO: Describe cases:
* new elements in new namespace
* element 



#### Translations

Add translations for editor fields in [translation files](src/main/plugin/dcat-ap/loc/eng/strings.xml) and other languages.


#### Using a vocabulary for a field

To use a vocabulary for a particular field, configure it in the editor configuration top section (TODO: check if can be only configured in the editor view?)

```xml
<for name="mdcat:MAGDA-categorie" use="thesaurus-list-picker" profile="metadata-dcat">
      <directiveAttributes
        thesaurus="external.theme.magda-domain"
        xpath="/mdcat:MAGDA-categorie"
        max=""
        labelKey="mdcat.addMagdaCategorie"/>
    </for>
```

#### Field with URI


```xml
    <for name="mdcat:landingspaginaVoorStatusinformatie" templateModeOnly="true" forceLabel="true" label="key">
      <template>
        <values>
          <key label="key" xpath="@rdf:resource" tooltip="mdcat:landingspaginaVoorStatusinformatie" required="true"/>
        </values>
        <snippet>
          <mdcat:landingspaginaVoorStatusinformatie rdf:resource="{{key}}"/>
        </snippet>
      </template>
    </for>
  ```

#### TODO: Other type of fields?


### Validation

Validation results are displayed in the side panel of the editor form (see [more information](https://docs.geonetwork-opensource.org/4.4/user-guide/workflow/validation/))

Validation is relying on 2 levels of validation:
* XSD validation
* Schematron validation


XSD is checking elements and types. Cardinatlities and profile's rules are checked using schematron rules.


Schematron rules can be enabled/disabled depending on the profile. See [configuring validation levels](https://docs.geonetwork-opensource.org/4.4/administrator-guide/managing-metadata-standards/configure-validation/).

TODO: Check how to enable/disable schematron rules for a profile with an example.


### Combination of profiles

TODO: 
* one view per profile (HVD = 1 field)
* or import profile into a tab or a section in an existing editor form
eg. HVD

```xml

          <import id="hvd-form"/>
          <import id="mobilty-form"/>
          <action
             type="button"
             name="HVD dataset"/>

          <section name="HVD" displayIfRecord="">

          </section>
             
```


TODO : Check
*     <for name="mdcat:landingspaginaVoorStatusinformatie" templateModeOnly="true" forceLabel="true" label="key"> add XSD for schema editor


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

The work on this schema plugin was funded by and carried out in close collaboration with [Digitaal Vlaanderen](https://www.vlaanderen.be/digitaal-vlaanderen).
