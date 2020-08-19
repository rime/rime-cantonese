#!/usr/bin/env bash
set -e

# request for HK street names:
#   https://github.com/rime/rime-cantonese/issues/69
# test queries at:
#   https://overpass-turbo.eu/
#   (must unescape quotation marks)

overpass_api="https://lz4.overpass-api.de/api/interpreter?data=%s"
queries=(
	"osm_hk_ways"
	"
		[out:csv(\"name:zh\", \"alt_name:zh\", \"old_name:zh\"; false)][timeout:25];

		relation(913110);map_to_area->.mySearchArea;
		relation(3676813);map_to_area->.HKOceanPark;
		(
			way
				[\"highway\"]
				[\"highway\"!=\"bus_stop\"]
				[\"highway\"!=\"construction\"]
				[\"highway\"!=\"corridor\"]
				[\"highway\"!=\"proposed\"]
				[\"highway\"!=\"steps\"]
				[\"access\"!=\"private\"] // example: way 197288490, located in Disneyland
				[\"area\"!=\"yes\"] // example: way 160323969, a dog park
				[\"name:zh\"]
				(area.mySearchArea)
			;
			- way(area.HKOceanPark); // example: way 657704846, located in Ocean Park
		)->.myWays;

		.myWays out tags;
	"

	"osm_mo_ways"
	"
		[out:csv(\"name:zh\", \"alt_name:zh\", \"old_name:zh\"; false)][timeout:25];

		relation(1867188);map_to_area->.mySearchArea;
		(
			way
				[\"highway\"]
				[\"highway\"!=\"bus_stop\"]
				[\"highway\"!=\"construction\"]
				[\"highway\"!=\"corridor\"]
				[\"highway\"!=\"proposed\"]
				[\"highway\"!=\"steps\"]
				[\"access\"!=\"private\"]
				[\"area\"!=\"yes\"]
				[\"name:zh\"]
				(area.mySearchArea)
			;
		)->.myWays;

		.myWays out tags;
	"

	"osm_cn-gd_ways"
	"
		[out:csv(\"name:zh\", \"alt_name:zh\", \"old_name:zh\"; false)][timeout:25];

		relation(911844);map_to_area->.mySearchArea;
		(
			way
				[\"highway\"]
				[\"highway\"!=\"bus_stop\"]
				[\"highway\"!=\"construction\"]
				[\"highway\"!=\"corridor\"]
				[\"highway\"!=\"proposed\"]
				[\"highway\"!=\"steps\"]
				[\"access\"!=\"private\"]
				[\"area\"!=\"yes\"]
				[\"name:zh\"]
				(area.mySearchArea)
			;
		)->.myWays;

		.myWays out tags;
	"

	"osm_cn-gx_ways"
	"
		[out:csv(\"name:zh\", \"alt_name:zh\", \"old_name:zh\"; false)][timeout:25];

		relation(286342);map_to_area->.mySearchArea;
		(
			way
				[\"highway\"]
				[\"highway\"!=\"bus_stop\"]
				[\"highway\"!=\"construction\"]
				[\"highway\"!=\"corridor\"]
				[\"highway\"!=\"proposed\"]
				[\"highway\"!=\"steps\"]
				[\"access\"!=\"private\"]
				[\"area\"!=\"yes\"]
				[\"name:zh\"]
				(area.mySearchArea)
			;
		)->.myWays;

		.myWays out tags;
	"
)
queries_len=${#queries[@]}
date=$(date "+%Y.%m.%d")
rime_dictionary_file_name="./jyut6ping3.%s.dict.yaml"
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

for ((i = 0; i <= $((queries_len - 1)); i += 2))
do
	name=${queries[${i}]}
	query=${queries[$((i + 1))]}
	url=$(printf "${overpass_api}" "${query}")

	wget_temp_out=$(mktemp -t "rime-cantonese.${name}.wget.$$.XXXX")
	cut_temp_out=$(mktemp -t "rime-cantonese.${name}.cut.$$.XXXX")
	grep_nonHani_temp_out=$(mktemp -t "rime-cantonese.${name}.nonHani.$$.XXXX")
	out=$(printf "${rime_dictionary_file_name}" "${name}")

	# ----

	printf "\\e[97;46m${name}\\e[0m\n"
	echo "${query}"
	echo "----"

	# download OpenStreetMap data from the Overpass API
	echo "${wget_temp_out}"
	wget "${url}" -O "${wget_temp_out}"
	echo "----"

	# sed: convert tab and semicolon to newline
	#      '衛奕信徑;港島徑'→ '衛奕信徑' '港島徑'
	# sed: '青山公路－荃灣段'→'青山公路'
	# sort: sort and uniquify
	echo "${cut_temp_out}"
	cat "${wget_temp_out}" \
		| sed "s/[\t;]/\n/g" \
		| sed -E "s/－.+段//g" \
		| LANG=C sort -u -o "${cut_temp_out}"
	echo "----"

	# print names that contain non-漢字 (基本區)
	# LANG=C is needed. en_US.utf8→grep does not like \u9fff.
	echo "${grep_nonHani_temp_out}"
	LANG=C grep -E [^$'\u4e00'-$'\u9fff'] "${cut_temp_out}" > "${grep_nonHani_temp_out}"
	less "${grep_nonHani_temp_out}"
	echo "----"

	# save complete list to $out
	echo "${out}"
	printf "${rime_dictionary_header}" "${name}" "${date}" >> "${out}"
	cat "${cut_temp_out}" >> "${out}"
	echo "----"
done
