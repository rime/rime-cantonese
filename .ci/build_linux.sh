#!/bin/bash
# macOS Installer, default.custom.yaml and ibus-install.sh packing script

# Script to fail when any command returns error
set -e

# Building mac package
mkdir -p build/mac

# Download Mac installation script, Mac package and unzip
wget $SQUIRREL_LINK
7z e Squirrel*.zip -obuild/mac/
cat .ci/mac-install-template.sh | envsubst '${SQUIRREL_PACKAGES}' > ./build/mac/mac-install.sh

# Build archives
7z a output/mac-${GITHUB_REF_NAME}-installer.zip ./build/mac/*

# Copy default.custom.yaml and ibus-install.sh into output queue
cat .ci/ibus-install-template.sh | envsubst '${IBUS_PACKAGES}' > ./output/ibus-install.sh
cp .ci/default.custom.yaml output/
