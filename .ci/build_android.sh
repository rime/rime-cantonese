#!/usr/bin/env bash
# Android packing script

export PATH=/usr/local/android-sdk/build-tools/25.0.2/:$PATH
export ANDROID_PACKAGE_NAME=android-${TRAVIS_TAG}.apk
wget ${TRIME_LINK} -o output/${ANDROID_PACKAGE_NAME}
mkdir -p assets/rime
export rime_dir=assets/rime
curl -fsSL  https://git.io/rime-install | bash -s -- ${TRIME_PACKAGES}
aapt add output/${ANDROID_PACKAGE_NAME} $rimedir/*
aapt list output/${ANDROID_PACKAGE_NAME}
