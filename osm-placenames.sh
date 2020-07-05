#!/usr/bin/env bash

# https://github.com/rime/rime-cantonese/issues/69

date=$(date -I)
overpass_api="https://lz4.overpass-api.de/api/interpreter?data=%s"
queries=(
	"osm_hk_ways"
	"
		[out:csv(\"name:zh\", \"alt_name:zh\", \"old_name:zh\", \"name:en\", ::id; false)][timeout:25];

		relation(913110);map_to_area->.mySearchArea;
		(
			way[\"highway\"][\"name:zh\"](area.mySearchArea);
		)->.myWays;

		.myWays out tags;
	"
)
queries_len=${#queries[@]}
rime_dictionary_file_name="/tmp/jyut6ping3.%s.dict.yaml"
rime_dictionary_header="# Rime dictionary
# encoding: utf-8
#
# Jyut6ping3 - 粵拼詞庫
#
# 碼表製作與校對人員
# sgal <ayaka@mail.shn.hk>
# chaaklau <chaakming@gmail.com>
# LeiMaau <leimaau@qq.com>
# laubonghaudoi <laubonghaudoi@icloud.com>
# tanxpyox <tanxpyox@gmail.com>
#
# Data © OpenStreetMap and its contributors.
# Data licensed under the Open Data Commons Open Database License (ODbL).

---
name: jyut6ping3.%s
version: \"%s\"
sort: by_weight
use_preset_vocabulary: true
...
"
cjk_range=$'\u4e00-\u9fff'

for ((i = 0; i <= $((queries_len - 1)); i += 2))
do
	name=${queries[${i}]}
	query=${queries[$((i + 1))]}
	url=$(printf "${overpass_api}" "${query}")
	echo "${name}"
	echo "${query}"
	echo "----"

	wget_temp_out=$(mktemp -t "rime-cantonese.${name}.wget.$$.XXX")
	echo "${wget_temp_out}"
	wget "${url}" -O "${wget_temp_out}"
	echo "----"

	cut_temp_out=$(mktemp -t "rime-cantonese.${name}.cut.$$.XXX")
	echo "${cut_temp_out}"
	cut "${wget_temp_out}" --fields=1,2,3 --output-delimiter=$'\n' | sed "s/;/\n/g" | LANG=C sort | uniq > "${cut_temp_out}"
	echo "----"

	# must be LANG=C. en_US.utf8: grep does not like \u9fff.
	LANG=C grep -E "[^${cjk_range}]" "${cut_temp_out}" | less
	echo "----"

	out=$(printf "${rime_dictionary_file_name}" "${name}")
	echo "${out}"
	printf "${rime_dictionary_header}" "${name}" "${date}" >> "${out}"
	cat "${cut_temp_out}" >> "${out}"
	echo "----"
done
