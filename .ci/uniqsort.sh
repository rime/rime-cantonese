#!/usr/bin/env bash
# Remove duplicates && Sort entries BY PRONUNCIATION (if available);
#                         else, BY CHINESE CHARACTERS

# Base list--to be 'uniquified'
candidates=($( ls *.dict.yaml ))

# Add files to this list if they are ALSO READY TO BE SORTED
goodToSort=(
  # jyut6ping3.phrase.dict.yaml # Under development, do not sort
  jyut6ping3.maps.dict.yaml
  # jyut6ping3.dict.yaml
  # jyut6ping3.lettered.dict.yaml
)

# Set sort order by locale (default: "C"=radical-stroke)
if [ -z "$LC_ALL" ]; then LC_ALL=C; fi

chmod u+w ${candidates[@]}

for file in ${candidates[@]}; do
  echo ===============================
  echo $file
  awk '{
    if (!x["..."]) {
      print > "a.tmp";
      if ($0=="...") x["..."]++
    } else if ($0=="" || !x[$0]++) {
      print > "b.tmp"
    }
  }' $file && echo "  : uniquified" || continue
  if [[ $(echo ${goodToSort[@]} | grep -w $file) ]]; then
    /usr/bin/sort -k2,2 -k1,1 -o b.tmp b.tmp && echo "  : sorted" || continue
  fi
  cat a.tmp b.tmp > $file && echo "  - changes merged"
  rm a.tmp b.tmp
done
echo ===============================

# Clean up
rm *tmp 2> /dev/null 
