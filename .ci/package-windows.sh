#!/bin/bash
if [ -z "$WEASEL_VERSION" ]; then
  echo 'Error: Please specify the Weasel version to package in the WEASEL_VERSION variable' >&2
  exit 1
fi
if [ -z "$SCHEMA_DIR" ]; then
  echo 'Error: Please specify the path to the schema directory in the SCHEMA_DIR variable' >&2
  exit 1
fi
if ! [ -x "$(command -v makensis.exe)" ]; then
  echo 'Error: Please specify the path to makensis.exe in the PATH' >&2
  exit 1
fi
set -e

# First, download the executable and extract it
wget https://github.com/rime/weasel/releases/download/${WEASEL_VERSION}/weasel-${WEASEL_VERSION}.0-installer.exe --no-check-certificate
7z x weasel-${WEASEL_VERSION}.0-installer.exe -aou -ooutput
cd output

# List all files with name ending with `_1`, compare the content of these files and the files with the same names but does not end with `_1` whether these binaries is 32-bit or 64-bit
# Then, move the ones that are 32-bit to the `Win32` folder and remove `_1` from the name of all the files
mkdir Win32
for file in *_1.*; do
  extension="${file##*.}"
  base_file="${file%_1.*}.$extension"
  if [[ $(file "$base_file") != *"x86-64"* ]]; then
    mv "$base_file" "Win32/$base_file"
  fi
  if [[ $(file "$file") == *"x86-64"* ]]; then
    mv "$file" "$base_file"
  else
    mv "$file" "Win32/$base_file"
  fi
done

# Remove all default rime schemas but keep opencc data, preview images and app config
# Then, download the latest schemas we need and amend the `default.yaml`
GLOBIGNORE=data/weasel.yaml
rm data/*.*
cp -rf "$SCHEMA_DIR/"* data

# Finally, rebuild the installer
mkdir ../resource
wget https://raw.githubusercontent.com/rime/weasel/refs/tags/${WEASEL_VERSION}/resource/weasel.ico -P ../resource
wget https://raw.githubusercontent.com/rime/weasel/refs/tags/${WEASEL_VERSION}/output/install.nsi
mkdir archives
makensis.exe //DWEASEL_VERSION=$WEASEL_VERSION //DPRODUCT_VERSION=$WEASEL_VERSION install.nsi

# Rename the installer
for file in archives/*.exe; do
  mv "$file" "${file/installer/rime-cantonese}"
done
