#!/bin/bash

set -euo pipefail # safety flags

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

echo "[+] Successfully cloned core-geonetwork"

echo "[-] Copying dcat-ap plugin to core-geonetwork/schemas..."

# create schemas directory if needed
mkdir -p core-geonetwork/schemas/dcat-ap

# copy files from dcat-ap project, excluding git and other non-required
rsync -av --exclude='.git' --exclude='.tmp' --exclude='utility' \
    "$PROJECT_ROOT/" core-geonetwork/schemas/dcat-ap/

if [ ! -f "core-geonetwork/schemas/dcat-ap/pom.xml" ]; then
    echo "ERROR: Failed to copy dcat-ap plugin" >&2
    exit 1
fi

echo "[+] Successfully copied dcat-ap plugin"

echo "[-] Applying patches from core-geonetwork-patches..."

cd core-geonetwork

# count patch files
PATCH_DIR="$PROJECT_ROOT/core-geonetwork-patches"
PATCH_COUNT=$(ls -1 "$PATCH_DIR"/*.patch 2>/dev/null | wc -l)

if [ "$PATCH_COUNT" -eq 0 ]; then
    echo "WARNING: No patch files found in core-geonetwork-patches/" >&2
else
    echo "[+] Found $PATCH_COUNT patch file(s) to apply"

    # apply each patch file
    for patch_file in "$PATCH_DIR"/*.patch; do
        if [ -f "$patch_file" ]; then
            echo "[-] Applying $(basename "$patch_file")..."

            if ! git apply --check "$patch_file" 2>&1; then
                echo "ERROR: Patch $(basename "$patch_file") does not apply cleanly" >&2
                echo "Please check the patch file and the GeoNetwork version compatibility" >&2
                exit 1
            fi

            git apply "$patch_file"
            echo "[+] Successfully applied $(basename "$patch_file")"
        fi
    done

    echo "[+] All patches applied successfully"
fi

cd ..

echo "[-] Building GeoNetwork with dcat-ap plugin..."
echo "[-] Running: mvn clean install -DskipTests"
echo ""

cd core-geonetwork

if ! mvn clean install -DskipTests; then
    echo "" >&2
    echo "ERROR: Maven build failed" >&2
    echo "Please check the build output above for errors" >&2
    exit 1
fi

echo ""
echo "[+] Build completed successfully!"

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