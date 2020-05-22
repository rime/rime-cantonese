#!/bin/bash

mkdir -p build/windows/data
# Download IME files (and 32-bit OpenCC)
export rime_dir=build/windows/data
curl -fsSL  https://git.io/rime-install | bash -s -- ${WEASEL_PACKAGES}
# Prepare Windows installation script, installer exe
wget -P ./build/windows ${WEASEL_LINK}
cp .ci/windows-install.bat ./build/windows
wget https://github.com/tanxpyox/7z.sfx-backup/raw/master/7zS.sfx
7z a windows-installer.7z ./build/windows/*
7z a output/windows-${TRAVIS_TAG}-installer.zip ./build/windows/*
cat 7zS.sfx .ci/config.txt windows-installer.7z > output/windows-sfx-${TRAVIS_TAG}-installer.exe
