#!/usr/bin/env bash
# Android packing script


export ANDROID_PACKAGE_NAME=android-${TRAVIS_TAG}.apk
wget ${TRIME_LINK} -o output/${ANDROID_PACKAGE_NAME}
mkdir -p assets/rime
export rime_dir=assets/rime
curl -fsSL  https://git.io/rime-install | bash -s -- ${WEASEL_PACKAGES}
aapt add output/${ANDROID_PACKAGE_NAME} $rimedir/*

aapt list output/${ANDROID_PACKAGE_NAME}
