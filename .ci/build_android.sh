#!/usr/bin/env bash
# Android packing script

# Preparing apk
export PATH=/usr/local/android-sdk/build-tools/25.0.2/:$PATH
export APK_NAME=output/android-${TRAVIS_TAG}.apk
wget ${TRIME_LINK} -o ${APK_NAME}

# Downloading IME files
mkdir -p assets/rime
export rime_dir=assets/rime
curl -fsSL  https://git.io/rime-install | bash -s -- ${TRIME_PACKAGES}

aapt2 dump resources ${APK_NAME}

mkdir compiled
aapt compile $rime_dir -o compiled/
# Installing IME Files...

aapt2 add output/${ANDROID_PACKAGE_NAME} $rimedir/*
