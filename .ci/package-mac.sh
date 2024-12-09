#!/bin/bash
if [ -z "$SQUIRREL_VERSION" ]; then
  echo 'Error: Please specify the Squirrel version to package in the SQUIRREL_VERSION variable' >&2
  exit 1
fi
if [ -z "$SCHEMA_DIR" ]; then
  echo 'Error: Please specify the path to the schema directory in the SCHEMA_DIR variable' >&2
  exit 1
fi
if [ -z "$SIGNING_IDENTITY" ]; then
  echo 'Error: Please specify the SIGNING_IDENTITY variable for code resigning' >&2
  exit 1
fi
set -e

# Modify the package with the solution from https://stackoverflow.com/a/11299907
# First, download the package and extract it
wget https://github.com/rime/squirrel/releases/download/${SQUIRREL_VERSION}/Squirrel-${SQUIRREL_VERSION}.pkg
pkgutil --expand Squirrel-${SQUIRREL_VERSION}.pkg package
pushd package

# Extract the application
tar -xzf Payload
pushd Squirrel.app/Contents

# Remove all default rime schemas but keep opencc data and app config
# Then, download the latest schemas we need and amend the `default.yaml`
GLOBIGNORE=SharedSupport/squirrel.yaml
rm SharedSupport/*.*
cp -rf "$SCHEMA_DIR/"* SharedSupport
popd

# Resign the application
codesign --sign "$SIGNING_IDENTITY" --timestamp --deep --force Squirrel.app

# Compress back the application
find Squirrel.app | cpio -o | gzip -c > Payload
mkbom Squirrel.app Bom
rm -rf Squirrel.app
popd

# Finally, compress back the package
mkdir output
pkgutil --flatten package output/Squirrel-${SQUIRREL_VERSION}-rime-cantonese.pkg
