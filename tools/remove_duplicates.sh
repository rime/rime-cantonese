#!/usr/bin/env bash

export candidates=(
  jyut6ping3.dict.yaml
  jyut6ping3.lettered.dict.yaml
  jyut6ping3.phrase.dict.yaml
)

for file in ${candidates[@]}
do
  awk '($0 == "") || (!x["..."] && $0 != "...") || !x[$0]++' $file > processed.tmp
  mv processed.tmp $file
done
