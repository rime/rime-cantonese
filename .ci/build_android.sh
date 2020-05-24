#!/usr/bin/env bash
# Android packing script

# Preparing apk
export PATH=/usr/local/android-sdk/build-tools/25.0.2/:$PATH
export ORI_NAME=android.apk
export APK_NAME=output/android-${TRAVIS_TAG}.apk
wget --output-document=${ORI_NAME} ${TRIME_LINK}

# Downloading IME files
mkdir -p assets/rime
export rime_dir=assets/rime
curl -fsSL  https://git.io/rime-install | bash -s -- ${TRIME_PACKAGES}
cp .ci/default.custom.yaml $rime_dir

# add IME files
aapt add ${ORI_NAME} $rime_dir/*
aapt remove ${ORI_NAME} $rime_dir/opencc/*
aapt add ${ORI_NAME} $rime_dir/opencc/*
echo Finished adding files, check:
aapt list ${ORI_NAME}

# zipalign
zipalign -v 4 ${ORI_NAME} ${APK_NAME}

# Sign apk
export KEYPASS=$( openssl rand -base64 12 )
export STOREPASS=$( openssl rand -base64 12)

keytool -genkey -alias key \
    -keyalg RSA -keystore keystore.jks \
    -dname "CN=tanxpyox, OU=JavaSoft, O=Sun, L=Cupertino, S=California, C=US" \
    -storepass ${STOREPASS} -keypass ${KEYPASS}

apksigner sign --ks keystore.jks $APK_NAME
