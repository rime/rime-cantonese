#!/bin/bash
set -e
SCRIPT_DIR="$PWD/.ci"

# Modify the package with the solution from https://stackoverflow.com/a/11299907
# First, download the package and extract it
wget https://github.com/rime/squirrel/releases/download/${SQUIRREL_VERSION}/Squirrel-${SQUIRREL_VERSION}.pkg
pkgutil --expand Squirrel-${SQUIRREL_VERSION}.pkg package
pushd package

# Extract the application
tar -xzf Payload
pushd Squirrel.app/Contents

# Remove all default rime schemas but keep opencc data
# Then, download the latest schemas we need and amend the `default.yaml`
rm SharedSupport/*.*
export rime_dir=SharedSupport
"$SCRIPT_DIR/rime-install.sh"
popd

# Compress back the application
find Squirrel.app | cpio -o | gzip -c > Payload
mkbom Squirrel.app Bom
rm -rf Squirrel.app
popd

# Finally, compress back the package
mkdir output
pkgutil --flatten package output/Squirrel-${SQUIRREL_VERSION}-rime-cantonese.pkg
