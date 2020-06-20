#!/bin/bash
# Remove duplicates && Sort entries BY PRONUNCIATION (if available); else, BY CHINESE CHARACTERS

# Base list--to be 'uniquified'
export candidates=(
  jyut6ping3.dict.yaml
  jyut6ping3.lettered.dict.yaml
  jyut6ping3.phrase.dict.yaml
)

# Add files to this list if it is ALSO READY TO BE SORTED
export goodToSort=(
  jyut6ping3.phrase.dict.yaml
  # Do not use this script on the following dictionaries, as they contain
  # new entries that are not yet good to merge
  ## jyut6ping3.dict.yaml
  ## jyut6ping3.lettered.dict.yaml
)

if [ $OSTYPE=="msys" ]; then
  export PATH="/usr/bin:$PATH"
fi

for file in ${candidates[@]}
do
  awk '{if(!x["..."] && $0 != "...") {print > "a.tmp";} else if($0 == "...") {print > "a.tmp";x["..."]++;} else if($0=="" || !x[$0]++) {print > "b.tmp"}}' $file
  if [ $(echo $goodToSort | grep -w $file) ]; then sort -k2,2 -k1,1 -o b.tmp b.tmp; fi
  cat a.tmp b.tmp > $file
  rm a.tmp b.tmp
done
