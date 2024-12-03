#!/bin/bash
set -e
SCRIPT_DIR="$PWD/.ci"

# First, download the executable and extract it
wget https://github.com/rime/weasel/releases/download/${WEASEL_VERSION}/weasel-${WEASEL_VERSION}.0-installer.exe --no-check-certificate
7z x weasel-${WEASEL_VERSION}.0-installer.exe -aou -ooutput
cd output

# List all files with name ending with `_1`, compare the content of these files and the files with the same names but does not end with `_1` whether these binaries is 32-bit or 64-bit
# Then, move the ones that are 32-bit to the `Win32` folder and remove `_1` from the name of all the files
mkdir Win32
for file in $(find . -name '*_1.*'); do
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

# Remove all default rime schemas but keep opencc data and preview images
# Then, download the latest schemas we need and amend the `default.yaml`
rm data/*.*
export rime_dir=data
"$SCRIPT_DIR/rime-install.sh"

# Finally, rebuild the installer
mkdir ../resource
wget https://raw.githubusercontent.com/rime/weasel/refs/tags/${WEASEL_VERSION}/resource/weasel.ico -P ../resource
wget https://raw.githubusercontent.com/rime/weasel/refs/tags/${WEASEL_VERSION}/output/install.nsi
makensis.exe /DWEASEL_VERSION=$WEASEL_VERSION /DPRODUCT_VERSION=$WEASEL_VERSION install.nsi

# Rename the installer
for file in archive/*.exe; do
  mv "$file" "${file/installer/rime-cantonese}"
done
