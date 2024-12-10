# DCAT-AP Schema Plugin for GeoNetwork

This repository contains a [DCAT-AP](https://joinup.ec.europa.eu/collection/semantic-interoperability-community-semic/solution/dcat-application-profile-data-portals-europe/release/200) schema plugin for [GeoNetwork](http://geonetwork-opensource.org/). The plugin can be used to describe resources using
* DCAT-AP,
* [DCAT-AP-HVD](https://semiceu.github.io/DCAT-AP/releases/2.2.0-hvd/),
* [Mobility-DCAT](https://mobilitydcat-ap.github.io/mobilityDCAT-AP/releases/),
* [DCAT-AP-VL](https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/)

## Reference documents
* [W3C Data Catalog Vocabulary (DCAT)](https://www.w3.org/TR/vocab-dcat/), Fadi Maali, John Erickson, 2014.
* [DCAT Application profile for data portals in Europe (DCAT-AP) v2.0.0](https://joinup.ec.europa.eu/collection/semantic-interoperability-community-semic/solution/dcat-application-profile-data-portals-europe/release/200)
* Interoperability between metadata standards: a reference implementation for metadata catalogues, Geraldine Nolf, W3C SDSVoc 2016. [[paper](https://www.w3.org/2016/11/sdsvoc/SDSVoc16_paper_11)] [[slides](https://www.w3.org/2016/11/sdsvoc/SDSVoc16_PPT_v02)]

## Description

This plugin has the following features:

* **XML Schema for DCAT-AP**: GeoNetwork is capable of storing metadata in XML format. The plugin therefore defines its own XML Schema (see the [schema](src/main/plugin/dcat-ap/schema) folder) for DCAT-AP that is used for the internal representation of DCAT-AP fields. To limit the data conversion needed, the XML Schema was designed to fully resemble an XML/RDF syntax of DCAT-AP.
* **indexing**: The plugin maximally populates GeoNetwork's existing index fields for a consistent search experience.
* **editing**:  A custom form was created following the guidance in the GeoNetwork [form customization guide](https://docs.geonetwork-opensource.org/4.4/customizing-application/editor-ui/creating-custom-editor/). The form uses the controlled vocabularies required by DCAT-AP. These are located in the folder[thesauri](resources/thesauri) and can be imported in to GeoNetwork as SKOS [classification systems](https://docs.geonetwork-opensource.org/4.4/administrator-guide/managing-classification-systems/managing-thesaurus/) using standard GeoNetwork functionality.
* **viewing**: A custom 'full view' to visualise DCAT-AP records. 
* **multilingual metadata support**: The editor, view, and search benefit from the already existing multilingual capabilities of GeoNetwork.
* **validation (XSD and Schematron)**: Validation steps are first XSD validation made on the schema, then the schematron validation defined in folder  [dcat-ap/schematron](src/main/plugin/dcat-ap/schematron). Multiple rulesets are available as `.sch` files with a specific naming convention: `schematron-rules-dcat-ap(-x).sch`. The `-rec` suffix denotes the recommended ruleset, whereas `-cardinalities` denotes all cardinality related validation. The base file (no suffix) is meant for *required* rules.

## Installing the plugin

### Adding the plugin to the source code

To include this schema plugin in a build of GeoNetwork it needs to be added to the `schemas` folder in GeoNetwork. The best approach is to add the plugin as a submodule:

```shell
cd schemas
git submodule add <dcat-ap remote URL> dcat-ap
git submodule init
git submodule update
```

Add the new module to the `schemas/pom.xml` to make sure it is picked up by Maven:

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

*Note* that versions need to be updated to correspond to GeoNetwork version updates. This is applicable to `dcat-ap/pom.xml` and can be automated by running `mvn versions:update-child-modules` after merges of GeoNetwork:

```xml
<parent>
  <artifactId>gn-schemas</artifactId>
  <groupId>org.geonetwork-opensource.schemas</groupId>
  <version>x.y.z</version>
</parent>
```

Add the module to `process-resources` phase of `web/pom.xml` to make sure it is included in the build process:

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

Apply the [patches](core-geonetwork-patches) to the GeoNetwork core. You may need to manually apply specific hunks of a patch.

```
# execute the following in the core-geonetwork root directory 
git am --ignore-space-change --ignore-whitespace --reject --whitespace=fix schemas/dcat-ap/core-geonetwork-patches/*.patch
```

Build and run the application following the
[Software Development Documentation](https://github.com/geonetwork/core-geonetwork/tree/main/software_development). You'll need to have Java JDK 11 and [Maven](https://maven.apache.org/install.html) installed.

Samples and templates can be imported via the `Admin Console` > `Metadata and Templates` > `dcat-ap` menu.

On startup, the application loads the thesauri located in `resources/thesauri` as they are required for editing dcat-ap records.

## Metadata rules: metadata identifier

The plugin uses `dct:identifier` to store a uuid that is used as (internal) metadata identifier. 
The metadata identifier is stored in the element `dcat:CatalogRecord/dct:identifier`.
When saving a record, this uuid is appended to the dataset URI, provided that the metadata (template) contains a dataset URI that ends with a uuid and the record is not harvested.

```xml
<dcat:CatalogRecord rdf:about="https://metadata.vlaanderen.be/srv/api/records/818c2174-4f26-48b6-8f76-b51bb9cbc4e8">
  <dct:identifier>818c2174-4f26-48b6-8f76-b51bb9cbc4e8</dct:identifier>
  <!-- ... -->
</dcat:CatalogRecord>
```

## How to create a profile? 

Various implementations / profiles exist of DCAT-AP, each corresponding to, e.g., a specific use case or national implementation. This section illustrates the necessary steps in order to add such a profile to the plugin.

### Profile identification

Using the `conformsTo` element in the `CatalogRecord` element, the profile is identified: 

```xml
      <dcat:record>
         <dcat:CatalogRecord ...
            <dct:conformsTo>
               <dct:Standard rdf:about="https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03">
```

When the profile is only adding a couple of elements to potentially one or more existing profiles (e.g. HVD adds the `dcatap:hvdCategory` element), 
the profile extension should declare those new elements and each of the target profiles needs to embed it into their editor views.

### Schema

New profile elements need to be added to the [schema XSD](src/main/plugin/dcat-ap/schema/dcat.xsd) using cardinality `0..n`. Cardinality `0..1` could be considered when, for a specific element, we know for a fact that GeoNetwork requires it for a correct functioning. 

Cardinality is otherwise checked using schematron, whereas the XSD schema defines the elements and types (see validation).

Defining new elements in the XSD can be done in the following ways:

* New elements from available ontologies

```xml
<xs:element ref="dct:rightsHolder" minOccurs="0" maxOccurs="unbounded"/>
```

* New elements from known ontologies. Check the top folder for existing described ontologies, e.g. `foaf`
* New elements that are specific to the profile:
  * Add the schema in [XSD profile folder](src/main/plugin/dcat-ap/schema/profiles)
  * Import the new schema in the base XSD
  * Add the element 

```xml
<xs:schema xmlns:dcatap="http://data.europa.eu/r5r/"
      ...
      <xs:import namespace="http://data.europa.eu/r5r/" schemaLocation="profiles/eu-dcat-ap-hvd.xsd"/>
      ...
      <xs:complexType name="Dataset_type">
      ...
                <!-- Profile / DCAT-AP-HVD -->
                <xs:element ref="dcatap:hvdCategory" minOccurs="0" maxOccurs="unbounded"/>
```

If the profile defines or uses new namespaces they need to be declared in:
* [`src/main/plugin/dcat-ap/layout/evaluate.xsl`](src/main/plugin/dcat-ap/layout/evaluate.xsl) to have correct XPath evaluation.
* [`src/main/plugin/dcat-ap/update-fixed-info.xsl`](src/main/plugin/dcat-ap/update-fixed-info.xsl) in template `<xsl:template name="add-namespaces">`

### Vocabularies

If some profile elements rely on vocabularies, add them to the [thesauri folder](resources/thesauri) using the SKOS format. Those vocabularies are imported when GeoNetwork starts.

### Editor configuration

If the profile requires a completely new editor, create a new view in the [editor configuration](src/main/plugin/dcat-ap/layout/config-editor.xml). 

See [customizing editor](https://docs.geonetwork-opensource.org/4.4/customizing-application/editor-ui/creating-custom-editor/) for more information.

First, add a view (and use a condition to display it only if the profile is used in the respective record):

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

Add one or more tabs to the view:

```xml
    <tab id="hvd-tab"  default="true">
 ```

Make sure the tab `id` attribute is unique in the config-editor. A good practice is to use the same prefix for view `id`, tab `id` and section and field labels.

If the new element depends on a vocabulary, register the vocabulary:

```xml
<editor...
  <fields...
    <for name="dcatap:hvdCategory" use="thesaurus-list-picker">
      <directiveAttributes
        thesaurus="external.theme.high-value-dataset-category"
        xpath="/dcatap:hvdCategory"/>
    </for>
```

Then create the form:
* A `section` with a title
* A `field` for each existing element
* An `action` (which generates a button in the UI) to add an element if it does not yet exist

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

Two types of translations have to be added:

* New XSD elements. Use [label translation files](src/main/plugin/dcat-ap/loc/eng/labels.xml)
* Editor view, tabs or custom labels in [translation files](src/main/plugin/dcat-ap/loc/eng/strings.xml)

#### Using a vocabulary for a field

To use a vocabulary for a particular field, configure it in the editor configuration top section or in a specific section when declaring the field.

```xml
    <for name="mdcat:MAGDA-categorie" use="thesaurus-list-picker" profile="metadata-dcat">
      <directiveAttributes
        thesaurus="external.theme.magda-domain"
        xpath="/mdcat:MAGDA-categorie"/>
    </for>
```

If the new element uses a custom namespace, the namespace needs to be registered in [src/main/plugin/dcat-ap/convert/thesaurus-transformation.xsl](src/main/plugin/dcat-ap/convert/thesaurus-transformation.xsl) 
which converts a SKOS thesaurus to the profile schema.

#### Field with URI

If the element is an RDF resource URI ...

```xml
<dcat:endpointURL rdf:resource="https://www.marineregions.org/webservices.php"/>
```

... register the field using:

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


### Validation

Validation results are displayed in the side panel of the editor form (see [more information](https://docs.geonetwork-opensource.org/4.4/user-guide/workflow/validation/)).

Validation is relying on 2 levels of validation:
* XSD validation
* Schematron validation

XSD is checking elements and types. Cardinalities and profiles' rules are checked using schematron rules.

Schematron rules can be enabled/disabled depending on the profile. See [configuring validation levels](https://docs.geonetwork-opensource.org/4.4/administrator-guide/managing-metadata-standards/configure-validation/).

For example: enabling the DCAT-AP-VL validation based on the defined standard within the record can be configured as follows:
- `admin console` > `metadata and templates` > `validation`
- select one of the validation rulesets, e.g., `DCAT-AP-Vlaanderen - Recommended`
- add a rule of type `XPATH` with the following XPath: `//dcat:CatalogRecord//dct:Standard[@rdf:about = 'https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03']`

Validation is also taking care of checking the version of a profile as it does not always declare a new namespace for a new version.

### Indexing

For elements that use a vocabulary and are configured in the editor configuration, indexing will automatically be done and can be used for search and aggregations.

```json
    "th_high-value-dataset-category": [
      {
        "default": "Companies and company ownership",
        "langeng": "Companies and company ownership",
        "link": "http://data.europa.eu/bna/c_a9135398"
      }
    ],
```

For additional elements, create an additional indexing XSLT, import it into the main one and define custom indexing using the `index-extra-fields` mode:

```xml
<xsl:template mode="index-extra-fields"
              match="rdf:RDF[dcat:Catalog/dcat:record/dcat:CatalogRecord/dct:conformsTo/dct:Standard/@rdf:about='https://data.vlaanderen.be/doc/applicatieprofiel/DCAT-AP-VL/erkendestandaard/2019-10-03']">

  <xsl:call-template name="index-dcat-ap-vl-license"/>
  <xsl:apply-templates mode="index-dcat-ap-vl" select="descendant::dcat:DataService"/>
</xsl:template>
  ```

### Templates

[Default templates](src/main/plugin/dcat-ap/templates) are provided for the plugin. They can be imported via the 'Admin Console' > 'Metadata and Templates' > 'dcat-ap' menu.

### Interactions between profiles

Some limitations or improvements on the existing mechanism:

1. Some profiles can be used in others, e.g., HVD can be combined with DCAT-AP or GeoDCAT-AP. How to reuse the editor configuration of a profile in another profile?
    * One view per profile may be limited, as we may have an "HVD" section in a DCAT-AP-VL form
2. Combining all profiles will generate a large `config-editor.xml`
3. Vocabularies are shared between profiles. How to manage them? Should we provide vocabularies in all EU languages when possible?
4. Versioning. Is validation the step which validates the version of a profile?  

### Advanced configuration

#### Thumbnails

By default, thumbnails are encoded using `foaf:page/foaf:Document`.

If the profile requires a different encoding, modify:
* [set-thumbnail.xsl](src/main/plugin/dcat-ap/set-thumbnail.xsl)to add the new encoding
* [extract-relations.xsl](src/main/plugin/dcat-ap/extract-relations.xsl) to extract the new encoding
* adapt [indexing](src/main/plugin/dcat-ap/index-fields/index.xsl) if necessary

## Community

Comments and questions are welcomed on [the issue tracker](https://github.com/metadata101/dcat-ap/issues).

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
