#!/bin/bash

mkdir -p build/data
mkdir build/windows
mkdir build/mac
# Download IME files (and 32-bit OpenCC)
export rime_dir=build/data
curl -fsSL  https://git.io/rime-install | bash -s -${WEASEL_PACKAGES}
# Prepare Windows installation script, installer exe
wget -P ./build/windows ${WEASEL_LINK}
cp .ci/windows-install.bat ./build/windows
# Download Mac installation script, Mac package and unzip
wget $SQUIRREL_LINK
7z e Squirrel*.zip -obuild/mac/
cp .ci/mac-install.sh ./build/mac
# Build archives
7z a output/windows-${TRAVIS_TAG}-installer.zip ./build/data ./build/windows/*
7z a output/mac-${TRAVIS_TAG}-installer.zip ./build/mac/*
