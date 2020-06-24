#!/bin/bash
# Windows installer packing script

mkdir -p build/windows/data
# Prepare update installation script template version number
cat .ci/windows-install-template.bat | envsubst > ./build/windows/windows-install.bat

# Download IME files (and 32-bit OpenCC)
export rime_dir=build/windows/data
curl -fsSL  https://git.io/rime-install | bash -s -- ${WEASEL_PACKAGES}

# Prepare installer exe
wget -P ./build/windows ${WEASEL_LINK} --no-check-certificate

# Packing sfx installer...
wget https://github.com/tanxpyox/7z.sfx-backup/raw/master/${SFXHEADER}
7z a windows-installer.7z ./build/windows/*
cat ${SFXHEADER} .ci/config.txt windows-installer.7z > output/windows-sfx-${TRAVIS_TAG}-installer.exe

# Packing installer files into a separate zip
7z a output/windows-${TRAVIS_TAG}-installer.zip ./build/windows/*
