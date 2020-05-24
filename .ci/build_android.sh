#!/usr/bin/env bash
# Android packing script

# Preparing apk
export PATH=/usr/local/android-sdk/build-tools/25.0.2/:$PATH
export ANDROID_PACKAGE_NAME=android-${TRAVIS_TAG}.apk
wget ${TRIME_LINK} -o output/${ANDROID_PACKAGE_NAME}

# Downloading IME files
mkdir -p assets/rime
export rime_dir=assets/rime
curl -fsSL  https://git.io/rime-install | bash -s -- ${TRIME_PACKAGES}

# Installing IME Files...
aapt2 list output/${ANDROID_PACKAGE_NAME}
aapt2 add output/${ANDROID_PACKAGE_NAME} $rimedir/*
