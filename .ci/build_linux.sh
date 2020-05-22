#!/bin/bash

mkdir -p build/mac
# Download Mac installation script, Mac package and unzip
wget $SQUIRREL_LINK
7z e Squirrel*.zip -obuild/mac/
cp .ci/mac-install.sh ./build/mac
# Build archives
7z a output/mac-${TRAVIS_TAG}-installer.zip ./build/mac/*
cp .ci/ibus-install.sh output/
cp .ci/default.custom.yaml output/
