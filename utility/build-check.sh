#!/bin/bash

set -euo pipefail # safety flags

# Hardcoded debug flag for CI troubleshooting.
DEBUG="true"

# get the absolute path to the dcat-ap project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo ""
echo 'mmmm     mmm    mm  mmmmmmm          mm   mmmmm'
echo '#   "m m"   "   ##     #             ##   #   "#'
echo '#    # #       #  #    #            #  #  #mmm#"'
echo '#    # #       #mm#    #     """    #mm#  #'
echo '#mmm"   "mmm" #    #   #           #    # #'
echo ""
echo "--- Checking compatibility against core-geonetwork ---"
echo ""

echo "[-] Checking dependencies..."

# check if maven is installed
if ! command -v mvn &> /dev/null; then
    echo "ERROR: Maven (mvn) is not installed or not in PATH" >&2
    echo "Please install Maven before running this script" >&2
    exit 1
fi

# check if xmlstarlet is installed
if ! command -v xmlstarlet &> /dev/null; then
    echo "ERROR: xmlstarlet is not installed or not in PATH" >&2
    echo "Please install xmlstarlet before running this script" >&2
    exit 1
fi

# check if rsync is installed
if ! command -v rsync &> /dev/null; then
    echo "ERROR: rsync is not installed or not in PATH" >&2
    echo "Please install rsync before running this script" >&2
    exit 1
fi

# check if git is installed
if ! command -v git &> /dev/null; then
    echo "ERROR: git is not installed or not in PATH" >&2
    echo "Please install git before running this script" >&2
    exit 1
fi

echo "[+] All dependencies available"
echo "[-] Preparing working directory..."

# create a temp working directory in project root
WORK_DIR="$PROJECT_ROOT/.tmp"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

echo "[-] Getting target GeoNetwork version..."

TARGET_GN_VERSION="$(xmlstarlet sel -N x="http://maven.apache.org/POM/4.0.0" \
                    -t -v "/x:project/x:parent/x:version" \
                    "$PROJECT_ROOT/pom.xml")"

if [ -z "$TARGET_GN_VERSION" ]; then
    echo "ERROR: Could not extract GeoNetwork version from pom.xml" >&2
    exit 1
fi

echo "[+] Target GeoNetwork version: $TARGET_GN_VERSION"

# extract release version (remove -0 suffix if present)
GN_RELEASE_VERSION="${TARGET_GN_VERSION%-0}"
echo "[+] Will clone GeoNetwork release: $GN_RELEASE_VERSION"

echo "[-] Cloning core-geonetwork repository..."

if [ -d "core-geonetwork" ]; then
    echo "[-] Removing existing core-geonetwork directory..."
    rm -rf core-geonetwork
fi

git clone --depth 1 --branch "$GN_RELEASE_VERSION" \
    https://github.com/geonetwork/core-geonetwork.git

if [ ! -d "core-geonetwork" ]; then
    echo "ERROR: Failed to clone core-geonetwork repository" >&2
    exit 1
fi

cd core-geonetwork

echo "[+] Successfully cloned core-geonetwork"

echo "[-] Copying dcat-ap plugin to schemas..."

# create schemas directory if needed
mkdir -p schemas/dcat-ap

# copy files from dcat-ap project, excluding git and other non-required
rsync -av --exclude='.git' --exclude='.tmp' --exclude='utility' \
    "$PROJECT_ROOT/" schemas/dcat-ap/

if [ ! -f "schemas/dcat-ap/pom.xml" ]; then
    echo "ERROR: Failed to copy dcat-ap plugin" >&2
    exit 1
fi

echo "[+] Successfully copied dcat-ap plugin"

echo "[-] Applying patches from core-geonetwork-patches..."

# count patch files
PATCH_DIR="schemas/dcat-ap/core-geonetwork-patches"
PATCH_COUNT=$(ls -1 "$PATCH_DIR"/*.patch 2>/dev/null | wc -l)

if [ "$PATCH_COUNT" -eq 0 ]; then
    echo "WARNING: No patch files found in core-geonetwork-patches/" >&2
else
    echo "[+] Found $PATCH_COUNT patch file(s) to apply"

    git config user.email "build-check@example.invalid"
    git config user.name "build-check"

    echo "[-] Running: git am --ignore-space-change --ignore-whitespace --reject --whitespace=fix $PATCH_DIR/*.patch"
    if ! git am --ignore-space-change --ignore-whitespace --reject --whitespace=fix "$PATCH_DIR"/*.patch; then
        echo "ERROR: Failed to apply patches using git am" >&2
        echo "Try checking patch compatibility with GeoNetwork $GN_RELEASE_VERSION and run: git am --abort" >&2
        exit 1
    fi

    echo "[+] All patches applied successfully (git am)"
fi


echo "[-] Wiring dcat-ap into GeoNetwork build (schemas + web)..."

SCHEMAS_POM="schemas/pom.xml"
WEB_POM="web/pom.xml"
SPRING_CONFIG="web/src/main/webResources/WEB-INF/config-spring-geonetwork.xml"

if [ ! -f "$SCHEMAS_POM" ]; then
    echo "ERROR: Expected schemas pom not found: $SCHEMAS_POM" >&2
    exit 1
fi

if [ ! -f "$WEB_POM" ]; then
    echo "ERROR: Expected web pom not found: $WEB_POM" >&2
    exit 1
fi

MAVEN_NS="http://maven.apache.org/POM/4.0.0"

echo "[-] Ensuring <module>dcat-ap</module> is present in schemas/pom.xml..."
MODULE_EXISTS="$(xmlstarlet sel -N x="$MAVEN_NS" -t -v "count(/x:project/x:modules/x:module[.='dcat-ap'])" "$SCHEMAS_POM")"
if [ "${MODULE_EXISTS:-0}" = "0" ]; then
    xmlstarlet ed -P -L -N x="$MAVEN_NS" \
        -s "/x:project/x:modules" -t elem -n "module" -v "dcat-ap" \
        "$SCHEMAS_POM"
    echo "[+] Added dcat-ap module to schemas/pom.xml"
else
    echo "[=] dcat-ap module already present in schemas/pom.xml"
fi

echo "[-] Ensuring gn-schema-dcat-ap dependency is present in web/pom.xml..."
DEP_EXISTS="$(xmlstarlet sel -N x="$MAVEN_NS" -t -v "count(/x:project/x:dependencies/x:dependency[x:groupId='org.geonetwork-opensource.schemas' and x:artifactId='gn-schema-dcat-ap'])" "$WEB_POM")"
if [ "${DEP_EXISTS:-0}" = "0" ]; then
    xmlstarlet ed -P -L -N x="$MAVEN_NS" \
        -s "/x:project/x:dependencies" -t elem -n "x:dependency" -v "" \
        -s "/x:project/x:dependencies/x:dependency[last()]" -t elem -n "x:groupId" -v "org.geonetwork-opensource.schemas" \
        -s "/x:project/x:dependencies/x:dependency[last()]" -t elem -n "x:artifactId" -v "gn-schema-dcat-ap" \
        -s "/x:project/x:dependencies/x:dependency[last()]" -t elem -n "x:version" -v "\${project.version}" \
        "$WEB_POM"
    echo "[+] Added gn-schema-dcat-ap dependency to web/pom.xml"
else
    echo "[=] gn-schema-dcat-ap dependency already present in web/pom.xml"
fi

echo "[-] Ensuring gn-schema-dcat-ap is unpacked in web/pom.xml (unpack-schemas)..."
UNPACK_XPATH_ALL="//x:execution[x:id='unpack-schemas']/x:configuration/x:artifactItems"
UNPACK_NODE_COUNT="$(xmlstarlet sel -N x="$MAVEN_NS" -t -v "count($UNPACK_XPATH_ALL)" "$WEB_POM")"
if [ "${UNPACK_NODE_COUNT:-0}" = "0" ]; then
    echo "ERROR: Could not locate maven-dependency-plugin unpack-schemas artifactItems block in web/pom.xml" >&2
    exit 1
fi
if [ "${UNPACK_NODE_COUNT:-0}" != "1" ]; then
    echo "WARNING: Found $UNPACK_NODE_COUNT unpack-schemas artifactItems blocks; updating the first one only" >&2
fi
UNPACK_XPATH="($UNPACK_XPATH_ALL)[1]"

UNPACK_ITEM_EXISTS="$(xmlstarlet sel -N x="$MAVEN_NS" -t -v "count($UNPACK_XPATH/x:artifactItem[x:groupId='org.geonetwork-opensource.schemas' and x:artifactId='gn-schema-dcat-ap'])" "$WEB_POM")"
if [ "${UNPACK_ITEM_EXISTS:-0}" = "0" ]; then
    xmlstarlet ed -P -L -N x="$MAVEN_NS" \
        -s "$UNPACK_XPATH" -t elem -n "artifactItem" -v "" \
        -s "$UNPACK_XPATH/x:artifactItem[last()]" -t elem -n "groupId" -v "org.geonetwork-opensource.schemas" \
        -s "$UNPACK_XPATH/x:artifactItem[last()]" -t elem -n "artifactId" -v "gn-schema-dcat-ap" \
        -s "$UNPACK_XPATH/x:artifactItem[last()]" -t elem -n "type" -v "zip" \
        -s "$UNPACK_XPATH/x:artifactItem[last()]" -t elem -n "overWrite" -v "false" \
        -s "$UNPACK_XPATH/x:artifactItem[last()]" -t elem -n "outputDirectory" -v "\${schema-plugins.dir}" \
        "$WEB_POM"
    echo "[+] Added gn-schema-dcat-ap artifactItem to unpack-schemas in web/pom.xml"
else
    echo "[=] gn-schema-dcat-ap artifactItem already present in unpack-schemas"
fi

if [ -f "$SPRING_CONFIG" ]; then
    DCAT_CODELIST_VALUE='standards/dcat-ap/codelists/dcat:Resource'
    if ! grep -qF "$DCAT_CODELIST_VALUE" "$SPRING_CONFIG"; then
        echo "[-] Adding DCAT codelists to translation packs (config-spring-geonetwork.xml)..."
        # Insert into both translation packs described in the README (search + editor) using minimal, idempotent text edits.
        if command -v perl >/dev/null 2>&1; then
            perl -0777 -i -pe "s#(<entry\\s+key=\"search\"\\s*>\\s*<util:list>)(?!.*?\\Q$DCAT_CODELIST_VALUE\\E)(.*?)</util:list>#\\1\\2  <!--  DCAT codelists  -->\\n  <value>$DCAT_CODELIST_VALUE</value>\\n</util:list>#s" "$SPRING_CONFIG" || true
            perl -0777 -i -pe "s#(<entry\\s+key=\"editor\"\\s*>\\s*<util:list>)(?!.*?\\Q$DCAT_CODELIST_VALUE\\E)(.*?)</util:list>#\\1\\2  <!--  DCAT codelists  -->\\n  <value>$DCAT_CODELIST_VALUE</value>\\n</util:list>#s" "$SPRING_CONFIG" || true
        else
            echo "WARNING: perl not available; skipping translation pack auto-wiring" >&2
        fi
        if grep -qF "$DCAT_CODELIST_VALUE" "$SPRING_CONFIG"; then
            echo "[+] Added DCAT codelist translation pack entries"
        else
            echo "WARNING: Could not auto-insert DCAT codelist translation pack entries; build will still continue" >&2
        fi
    else
        echo "[=] DCAT codelist translation pack entries already present"
    fi
else
    echo "WARNING: Spring config not found (skipping translation pack wiring): $SPRING_CONFIG" >&2
fi

if [ "${DEBUG}" = "true" ]; then
    echo ""
    echo "[-] DEBUG: Files modified by this script:"
    SCRIPT_CONFIG_FILES=("$SCHEMAS_POM" "$WEB_POM" "$SPRING_CONFIG")

    for f in "${SCRIPT_CONFIG_FILES[@]}"; do
        if [ -f "$f" ] && ! git diff --quiet -- "$f"; then
            cat "$f"
        fi
    done
    echo ""
fi

echo "[-] Building GeoNetwork with dcat-ap plugin..."
echo "[-] Running: mvn clean install -DskipTests"
echo ""


if ! mvn clean install -DskipTests; then
    echo "" >&2
    echo "ERROR: Maven build failed" >&2
    echo "Please check the build output above for errors" >&2
    exit 1
fi

echo ""
echo "[+] Build completed successfully!"

echo "[-] Verifying dcat-ap was unpacked into the webapp..."
if [ ! -d "web/src/main/webapp/WEB-INF/data/config/schema_plugins/dcat-ap" ]; then
    echo "ERROR: dcat-ap schema plugin was not unpacked into web module (schema_plugins/dcat-ap missing)" >&2
    exit 1
fi
echo "[+] dcat-ap schema plugin present in web module"

cd ..

echo "[-] Cleaning up temporary directory..."
cd "$PROJECT_ROOT"
rm -rf "$WORK_DIR"

echo ""
echo "=========================================="
echo "SUCCESS! Build check completed."
echo "=========================================="
echo ""
echo "The dcat-ap plugin builds successfully against GeoNetwork $GN_RELEASE_VERSION"
echo ""
