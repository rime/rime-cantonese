#!/usr/bin/env bash
# Android packing script

# Preparing apk
export PATH=/usr/local/android-sdk/build-tools/25.0.2/:$PATH
export APK_NAME=output/android-${TRAVIS_TAG}.apk
wget --output-document=${APK_NAME} ${TRIME_LINK}

# Downloading IME files
mkdir -p assets/rime
export rime_dir=assets/rime
curl -fsSL  https://git.io/rime-install | bash -s -- ${TRIME_PACKAGES}
cp .ci/defaut.custom.yaml $rime_dir

aapt list ${APK_NAME}
aapt add ${APK_NAME} $rime_dir/*

# Installing IME Files...

# aapt2 add output/${ANDROID_PACKAGE_NAME} $rimedir/*
