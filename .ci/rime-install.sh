#!/bin/bash
curl -fsSL https://git.io/rime-install | bash -s -- prelude essay cantonese emoji-cantonese cangjie stroke luna-pinyin CanCLID/rime-loengfan lotem/rime-octagram-data lotem/rime-octagram-data@hant

if [ -n "$rime_dir" ]; then
  pushd "$rime_dir"
  sed '/^schema_list:$/,/^$/c\
installed_from: rime-cantonese\
\
schema_list:\
  - schema: jyut6ping3\
  - schema: cangjie5\
  - schema: stroke\
  - schema: luna_pinyin\
' default.yaml > default.yaml  # avoid behavioral difference of the --in-place option
  sed 's/page_size: [0-9]\+/page_size: 8/' default.yaml > default.yaml
  rm emoji_cantonese_suggestion.yaml
  popd
fi
