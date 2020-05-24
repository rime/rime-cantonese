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
cp .ci/default.custom.yaml $rime_dir

# add IME files
aapt add ${APK_NAME} $rime_dir/*
aapt remove ${APK_NAME} $rime_dir/opencc/*
aapt add ${APK_NAME} $rime_dir/opencc/*
echo Finished adding files, check:
aapt list ${APK_NAME}

# zipalign
zipalign -f ${APK_NAME}

# Sign apk
echo y | keytool -genkeypair -dname "cn=Tanxpyox, ou=Rime-Cantonese, o=RCWorkGroup, c=HK" -alias business -keypass ${KEYPASS} -keystore ./key.ks -storepass ${STOREPASS} -validity 20000
apksigner sign --ks key.ks $APK_NAME
