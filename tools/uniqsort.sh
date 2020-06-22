#!/usr/bin/env bash
# Remove duplicates && Sort entries BY PRONUNCIATION (if available); else, BY CHINESE CHARACTERS

# Base list--to be 'uniquified'
candidates=($( ls *.dict.yaml ))

# Add files to this list if they are ALSO READY TO BE SORTED
goodToSort=(
  jyut6ping3.phrase.dict.yaml
  # Do not use this script on the following dictionaries, as they contain
  # new entries that are not yet good to merge
  ## jyut6ping3.dict.yaml
  ## jyut6ping3.lettered.dict.yaml
)

# Override Win32 sort.exe if on Git Bash
if [ $OSTYPE=="msys" ]; then
  PATH="/usr/bin:$PATH"
fi

# Set sort order by locale (default: "C"=radical-stroke)
if [ -z ${LC_ALL} ]; then LC_ALL="C"; fi

chmod u+w ${candidates[@]}

echo ===============================
for file in ${candidates[@]}; do
  echo $file
  awk '{
    if (!x["..."] && $0!="...") {
      print > "a.tmp";
    } else if ($0=="...") {
      print > "a.tmp"
      x["..."]++
    } else if ($0=="" || !x[$0]++) {
      print > "b.tmp"
    }
  }' $file &&\
    echo  "  : uniquified"
  if [ $(echo $goodToSort | grep -w $file) ]; then
    sort -k2,2 -k1,1 -o b.tmp b.tmp &&\
      echo "  : sorted"
  fi
  cat a.tmp b.tmp > $file &&\
    echo  "  - changes merged"
  rm a.tmp b.tmp
  echo ===============================
done
