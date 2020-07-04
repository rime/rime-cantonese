#!/usr/bin/env bash

# https://github.com/rime/rime-cantonese/issues/69

date=$(date -I)
overpass_api="https://lz4.overpass-api.de/api/interpreter?data=%s"
queries=(
	"osm_hk_ways"
	"
		[out:csv(\"name:zh\", \"alt_name:zh\", \"old_name:zh\", \"name:en\", ::id)][timeout:25];

		relation(913110);out;map_to_area->.mySearchArea;
		(
			way[\"highway\"][\"name:zh\"](area.mySearchArea);
		)->.myWays;

		.myWays out tags;
	"
)
queries_len=$((${#queries[@]} - 1))
rime_dictionary_file_name="jyut6ping3.%s.dict.yaml"
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

main () {
	for ((i = 0; i <= queries_len; i += 2))
	do
		local name=${queries[${i}]}
		local query=${queries[$((i + 1))]}
		local url=$(printf "${overpass_api}" "${query}")
		echo "${name}"
		echo "${query}"
		echo "----"

		local wget_temp_out=$(mktemp)
		echo "${wget_temp_out}"
		wget "${url}" -O "${wget_temp_out}"
		echo "----"

		local cut_temp_out=$(mktemp)
		echo "${cut_temp_out}"
		cut "${wget_temp_out}" --fields=1,2,3 --output-delimiter=$'\n' | sort | uniq > "${cut_temp_out}"
		echo "----"

		local cjk_range=$'\u4e00-\u9fff'
		# must be LANG=C. en_US.UTF-8: grep does not like \u9fff.
		LANG=C grep -E "[^${cjk_range}]" "${cut_temp_out}" | less 
		echo "----"

		local rime_dictionary_file_name="/tmp/"$(printf "${rime_dictionary_file_name}" "${name}")
		echo "${rime_dictionary_file_name}"
		printf "${rime_dictionary_header}" "${name}" "${date}" >> "${rime_dictionary_file_name}"
		cat "${cut_temp_out}" >> "${rime_dictionary_file_name}"
		echo "----"
	done
}

main
