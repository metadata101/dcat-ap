#!/bin/bash
# define functions
setup() {
echo "Setting up transifex configuration..."
rm -fr .tx
mkdir .tx
cat <<EOF > .tx/config
[main]
host = https://app.transifex.com

[o:geonetwork:p:metadata101:r:dcat-ap_loc_labels]
file_filter = translations/dcat-ap_loc_labels/<lang>.xml
source_file = translations/dcat-ap_loc_labels/en_US.xml
type = ANDROID
EOF
}

download() {
  echo "Downloading translations..."
  tx pull -l nl,fr --force --mode sourceastranslation
}

upload() {
  echo "Uploading source files..."
  tx push
}

apply() {
  # general setup
  l=(
      'nl::dut'
      'fr::fre'
      'en_US::eng'
  )
  TRANSLATION_DIR=translations
  SRC_DIR=../src/main/plugin/dcat-ap

  # convert each downloaded and specified file into the correct output format, at the right location
  echo "Converting files..."
  for index in "${l[@]}" ; do
      KEY="${index%%::*}"
      VALUE="${index##*::}"
    source=$TRANSLATION_DIR/dcat-ap_loc_labels/$KEY.xml
    target=$SRC_DIR/loc/$VALUE/labels.xml
    echo " > Language ($VALUE) Source ($source) Target ($target)"
    xsltproc transform/loc.labels.xslt "$source" | xmllint --format - > "$target"
  done
}

# get user input
usage="$(basename "$0") [-h] [-b bump]
--------------------------------------------------
Execute some basic transifex functionality in order to manage translations for this plugin.

where:
    -h  show this help text
    -d  download the translations from transifex
    -a  apply the downloaded translations to the src directory
    -u  upload the source files to transifex"
while getopts ':huda' option; do
  case "$option" in
    h) echo "$usage"
         exit
         ;;
    u) upload
       exit
       ;;
    a) apply
       exit
       ;;
    d) download
       exit
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

