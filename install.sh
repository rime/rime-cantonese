#!/bin/bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${DIR}"

symlink() {
  local src="$1"
  local dest="$2"
  echo "Symlink ${dest} -> ${src}"
  mkdir -p "$(dirname ${dest})"
  rm -rf "${dest}"
  ln -s "${src}" "${dest}"
}

RIME_DIR="${HOME}/.config/ibus/rime"
if [ `uname` == "Darwin" ]; then
  RIME_DIR="${HOME}/Library/Rime"
fi
mkdir -p "${RIME_DIR}"

[ -f "${RIME_DIR}/default.custom.yaml" ] && { mv "${RIME_DIR}/default.custom.yaml" "${RIME_DIR}/default.custom.yaml.bak"; }

SYMLINK_CONFIGS=(
    "jyut6ping3.dict.yaml"
    "jyut6ping3.lettered.dict.yaml"
    "jyut6ping3.phrase.dict.yaml"
    "jyut6ping3.schema.yaml"
    "jyut6ping3_ipa.schema.yaml"
)

for file in "${SYMLINK_CONFIGS[@]}"; do
  symlink "${DIR}/${file}" "${RIME_DIR}/${file}"
done

echo "Please manually deploy rime again."
