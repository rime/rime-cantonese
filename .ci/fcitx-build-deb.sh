#!/bin/bash
## Build deb package for ubuntu Linux.user.

# Clear old pkg content
rm -rf deb/

# Create temp folder to collect files
mkdir -p deb/DEBIAN/
mkdir -p deb/usr/share/rime-data/
# deb package related file
cp ./fcitx-deb/control ./fcitx-deb/postinst ./fcitx-deb/postrm deb/DEBIAN/
# taigi
cp ../*.yaml deb/usr/share/rime-data/
# copyright
cat ../LICENSE* > deb/DEBIAN/copyright

# Build pkg
mkdir -p output/
dpkg -b deb/ output/rime-cantonese.deb

