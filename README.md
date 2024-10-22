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

Using the `conformsTo` element in the  `CatalogRecord` element, the profile is identified: 

```xml
      <dcat:record>
         <dcat:CatalogRecord ...
            <dct:conformsTo>
               <dct:Standard rdf:about="https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03">
```

When the profile is only adding a couple of elements to potentially one or more existing profiles (eg. HVD adds `hvdCategory` element), 
then the profile extension should declare those new elements and each target profiles needs to embed it into their editor views.

### Schema

New profile elements need to be added to the [schema XSD](src/main/plugin/dcat-ap/schema/dcat.xsd) using cardinality `0..unbounded`.

TODO Q: Can we set cardinality `0..1` when we know that it is the case for a profile?

Cardinality is checked using schematron, XSD define the elements and types (see validation).

Define new elements in the XSD:

* New elements from available ontologies

```xml
   <xs:element ref="dct:rightsHolder" minOccurs="0" maxOccurs="unbounded"/>
```

* New elements from a known ontologies. Check the top folder for existing described ontologies (eg. `foaf`).

* New elements specific to the profile:
 
  * Add the schema in [XSD profile folder](src/main/plugin/dcat-ap/schema/profiles)
  * Import the new schema in the base XSD
  * Add the element 

```
<xs:schema xmlns:dcatap="http://data.europa.eu/r5r/"
      ...
      <xs:import namespace="http://data.europa.eu/r5r/" schemaLocation="profiles/eu-dcat-ap-hvd.xsd"/>
                
                
      <xs:complexType name="Dataset_type">
      ...
                <!-- Profile / DCAT-AP-HVD -->
                <xs:element ref="dcatap:hvdCategory" minOccurs="0" maxOccurs="unbounded"/>
```


If the profile define or use new namespaces, they need to be declared in:
* [`src/main/plugin/dcat-ap/layout/evaluate.xsl`](src/main/plugin/dcat-ap/layout/evaluate.xsl) to have correct XPath evaluation.
* [`src/main/plugin/dcat-ap/update-fixed-info.xsl`](src/main/plugin/dcat-ap/update-fixed-info.xsl) in template `<xsl:template name="add-namespaces">`
  

TODO Q: 
* Order of element? important of not? 
* Need to add the element to the reorder update-fixed-info
* 


### Vocabularies

If some profile elements rely on vocabularies, add them to the [thesauri folder](resources/thesauri) using SKOS format.
Those vocabularies are imported when the application starts.

Register the vocabulary in [src/main/plugin/dcat-ap/process/process-utility.xsl](src/main/plugin/dcat-ap/process/process-utility.xsl).

Q: Maybe this can be generic?


### Editor configuration

If the profile require a complete new editor, create a new view in the [editor configuration](src/main/plugin/dcat-ap/layout/config-editor.xml). 

See [customizing editor](https://docs.geonetwork-opensource.org/4.4/customizing-application/editor-ui/creating-custom-editor/) for more information.

First, add a view (and use a condition to display it only if the profile is used):

 ```xml
 <views
  displayIfRecord="count(//dcat:CatalogRecord/dct:conformsTo/dct:Standard[@rdf:about = 'https://data.vlaanderen.be/doc/applicatieprofiel/metadata-dcat/erkendestandaard/2021-04-22']) > 0"
>
  <view name="hvd-view">
    <tab id="hvd-tab"  default="true">
        ...
 ```

Q:
* check default view using `default='true'`. What happens if more than one default?
* check which view to load by default? Maybe see EditorController.js

Add one or more tab to the view:

```xml
    <tab id="hvd-tab"  default="true">
 ```

When creating tabs, make tab id attribute unique in the config-editor. A good practice is to use the same prefix for view id, tab id and section and field labels.

If the new element depends on a vocabulary, register the vocabulary:

```xml
<editor...
  <fields...
    <for name="dcatap:hvdCategory" use="thesaurus-list-picker">
      <directiveAttributes
        thesaurus="external.theme.high-value-dataset-category"
        xpath="/dcatap:hvdCategory"
        labelKey="dcatap.hvdCategory"/>
    </for>
```

Then create the form:
* A section with a title
* A field for each existing element
* A button to add one if no element exists

```xml
        <section name="hvd-section">
          <field xpath="/rdf:RDF/dcat:Catalog/dcat:dataset/dcat:Dataset/dcatap:hvdCategory"/>

          <action type="add"
                       or="hvdCategory"
                       in="/rdf:RDF/dcat:Catalog/dcat:dataset/dcat:Dataset"
                       if="count(rdf:RDF/dcat:Catalog/dcat:dataset/dcat:Dataset/dcatap:hvdCategory) = 0">
            <template>
              <snippet>
                <dcatap:hvdCategory>
                  <skos:Concept rdf:about="">
                    <skos:prefLabel xml:lang=""></skos:prefLabel>
                  </skos:Concept>
                </dcatap:hvdCategory>
              </snippet>
            </template>
          </action>
        </section>
      </tab>
    </view>
```

#### Translations

2 types of translations have to be added:

* Translation for new XSD elements. Use [label translation files](src/main/plugin/dcat-ap/loc/eng/labels.xml)
* Add translations for editor view, tabs or custom labels in [translation files](src/main/plugin/dcat-ap/loc/eng/strings.xml)


#### Using a vocabulary for a field

To use a vocabulary for a particular field, configure it in the editor configuration top section 
Q: check if can be only configured in the editor view?

```xml
    <for name="mdcat:MAGDA-categorie" use="thesaurus-list-picker" profile="metadata-dcat">
      <directiveAttributes
        thesaurus="external.theme.magda-domain"
        xpath="/mdcat:MAGDA-categorie"
        max=""
        labelKey="mdcat.addMagdaCategorie"/>
    </for>
```

If the new element use a custom namespace, the namespace needs to be registered in [src/main/plugin/dcat-ap/convert/thesaurus-transformation.xsl](src/main/plugin/dcat-ap/convert/thesaurus-transformation.xsl) 
which converts SKOS thesaurus to the profile schema.

Q: Record in a language not available in vocabulary? to test with https://github.com/geonetwork/core-geonetwork/pull/8268 which may help

#### Field with URI

If the element is a rdf resource URI:

```xml
<dcat:endpointURL rdf:resource="https://www.marineregions.org/webservices.php"/>
```

then register the field using:

```xml

<for name="dcat:endpointURL" templateModeOnly="true" forceLabel="true" label="key">
  <template>
    <values>
      <key label="key" xpath="@rdf:resource" tooltip="dcat:endpointURL" required="true"/>
    </values>
    <snippet>
      <dcat:endpointURL rdf:resource="{{key}}"/>
    </snippet>
  </template>
</for>
  ```


#### Q: Other type of fields?


### Validation

Validation results are displayed in the side panel of the editor form (see [more information](https://docs.geonetwork-opensource.org/4.4/user-guide/workflow/validation/))

Validation is relying on 2 levels of validation:
* XSD validation
* Schematron validation

XSD is checking elements and types. Cardinalities and profile's rules are checked using schematron rules.

Schematron rules can be enabled/disabled depending on the profile. See [configuring validation levels](https://docs.geonetwork-opensource.org/4.4/administrator-guide/managing-metadata-standards/configure-validation/).

Q: Check how to enable/disable schematron rules for a profile with an example.

Validation is also taking care of checking version of a profile as profile do not always declare a new namespace for a new version.


### Indexing

For element using a vocabulary and configured in the editor configuration, indexing will automatically be done and can be used for search and aggregations.

```json
    "th_high-value-dataset-category": [
      {
        "default": "Companies and company ownership",
        "langeng": "Companies and company ownership",
        "link": "http://data.europa.eu/bna/c_a9135398"
      }
    ],
```

For additional elements, create an additional indexing XSLT, import it into the main one and defined custom indexing using the `index-extra-fields` mode:

```xslt
  <xsl:template mode="index-extra-fields"
                match="rdf:RDF[dcat:Catalog/dcat:record/dcat:CatalogRecord/dct:conformsTo/dct:Standard/@rdf:about='https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03']">

    <xsl:call-template name="index-dcat-ap-vl-license"/>
    <xsl:apply-templates mode="index-dcat-ap-vl" select="descendant::dcat:DataService"/>
  </xsl:template>
  ```

### Templates

TODO

### Interactions between profiles

Some limitations or improvements on the existing mechanism:

1. Some profiles can be used in others (eg. HVD can be combined with DCAT-AP, GeoDCAT-AP, ...). How to reuse the editor configuration of a profile in another profile?
    * One view per profile may be limited, as we may have an "HVD" section in a DCAT-AP-VL form
1. Combining all profiles will generate a large `config-editor.xml`
1. Vocabularies are shared between profiles. How to manage them? Should we provide vocabularies in all EU languages when possible?
1. Versioning. Is validation the step which validates the version of a profile?  


### Advanced configuration

#### Thumbnails

By default, thumbnails are encoded using `foaf:page/foaf:Document`.

If the profile requires a different encoding, modify :
* [set-thumbnail.xsl](src/main/plugin/dcat-ap/set-thumbnail.xsl)to add the new encoding
* [extract-relations.xsl](src/main/plugin/dcat-ap/extract-relations.xsl) to extract the new encoding
* adapt [indexing](src/main/plugin/dcat-ap/index-fields/index.xsl) if necessary


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
