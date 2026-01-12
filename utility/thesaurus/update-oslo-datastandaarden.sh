#!/bin/bash

TEMP_FILE=update-oslo-datastandaarden-temp.rdf
TARGET_FILE=../../resources/thesauri/theme/oslo-datastandaarden.rdf
SPARQL_FILE=update-oslo-datastandaarden.sparql

# execute sparql query to retrieve latest information
sparql \
  --graph https://data.vlaanderen.be/doc/concept/StandaardType/Applicatieprofiel.ttl \
  --graph https://data.vlaanderen.be/doc/concept/StandaardType/Implementatiemodel.ttl \
  --graph https://data.vlaanderen.be/id/conceptscheme/StandaardType.ttl \
  --graph https://data.vlaanderen.be/standaarden \
  --query $SPARQL_FILE --results RDF/XML > $TEMP_FILE
# reformat to xml-abbrev to prevent nested xml output
riot --output=RDF/XML-ABBREV $TEMP_FILE > $TARGET_FILE
