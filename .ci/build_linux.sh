#!/bin/bash
# macOS Installer, default.custom.yaml and ibus-install.sh packing script

# Building mac package
mkdir -p build/mac

# Download Mac installation script, Mac package and unzip
wget $SQUIRREL_LINK
7z e Squirrel*.zip -obuild/mac/
cp .ci/mac-install.sh ./build/mac
# Build archives
7z a output/mac-${TRAVIS_TAG}-installer.zip ./build/mac/*

# Copy default.custom.yaml and ibus-install.sh into output queue
cp .ci/ibus-install.sh output/
cp .ci/default.custom.yaml output/
