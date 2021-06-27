#!/bin/bash
## Build deb package for ubuntu Linux.user.

# Clear old pkg content
rm -rf .ci/deb/

# Create temp folder to collect files
mkdir -p .ci/deb/DEBIAN/
mkdir -p .ci/deb/usr/share/rime-data/
# deb package related file
cp .ci/fcitx-deb/control .ci/fcitx-deb/postinst .ci/fcitx-deb/postrm .ci/deb/DEBIAN/
# taigi
cp *.yaml .ci/deb/usr/share/rime-data/
# copyright
cat LICENSE* > .ci/deb/DEBIAN/copyright

# Build pkg
mkdir -p output/
dpkg -b .ci/deb/ output/rime-cantonese.deb

