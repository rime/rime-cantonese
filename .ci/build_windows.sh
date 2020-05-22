#!/bin/bash

mkdir -p build/data
mkdir build/windows
# Download IME files (and 32-bit OpenCC)
export rime_dir=build/data
curl -fsSL  https://git.io/rime-install | bash -s -${WEASEL_PACKAGES}
# Prepare Windows installation script, installer exe
wget -P ./build/windows ${WEASEL_LINK}
cp .ci/windows-install.bat ./build/windows
