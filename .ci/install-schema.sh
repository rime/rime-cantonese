#!/bin/bash
git clone https://github.com/TypeDuck-HK/schema "$rime_dir"

if [ -n "$rime_dir" ]; then
  pushd "$rime_dir"
  rm -rf .git .gitignore trime.yaml jyut6ping3_mobile*.yaml *_longpress*.yaml *.custom.yaml
  popd
fi
