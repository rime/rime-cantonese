#!/usr/bin/env bash
#set -e

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
# sgalal <sgalal.me@outlook.com>
# chaaklau <chaakming@gmail.com>
# LeiMaau <leimaau@qq.com>
# laubonghaudoi <laubonghaudoi@icloud.com>
# tanxpyox <tanxpyox@gmail.com>
# William915 <William915@gmail.com>
# szc126 (@szc126)
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
opencc_config="/usr/share/opencc/s2t.json"

for ((i = 0; i <= $((queries_len - 1)); i += 2))
do
	name=${queries[${i}]}
	query=${queries[$((i + 1))]}
	url=$(printf "${overpass_api}" "${query}")

	dl_out=$(mktemp -t "rime-cantonese.${name}.dl.$$.XXXX")
	tidy_out=$(mktemp -t "rime-cantonese.${name}.tidy.$$.XXXX")
	nonHani_out=$(mktemp -t "rime-cantonese.${name}.nonHani.$$.XXXX")
	awk_out=$(mktemp -t "rime-cantonese.${name}.awk.$$.XXXX")
	opencc_out=$(mktemp -t "rime-cantonese.${name}.opencc.$$.XXXX")
	opencc_diff_out=$(mktemp -t "rime-cantonese.${name}.openccDiff.$$.XXXX")
	out=$(printf "${rime_dictionary_file_name}" "${name}")

	return=""

	# ----

	printf "\\e[97;46m${name}\\e[0m\n"
	echo "${query}"
	echo "----"

	# download OpenStreetMap data from the Overpass API
	echo "${dl_out}"
	wget "${url}" -O "${dl_out}" --user-agent="https://github.com/rime/rime-cantonese"
	echo "----"
	return="${dl_out}"

	# sed: convert tab and semicolon to newline
	#      '衛奕信徑;港島徑'→'衛奕信徑' '港島徑'
	# sed: '青山公路－荃灣段'→'青山公路'
	# sort: sort and uniquify
	echo "${tidy_out}"
	cat "${return}" \
		| sed "s/[\t;]/\n/g" \
		| sed -E "s/－.+段//g" \
		| LANG=C sort -u -o "${tidy_out}"
	echo "----"
	return="${tidy_out}"

	# print entries that contain non-基本區 characters
	# LANG=C is needed. en_US.utf8→grep does not like \u9fff.
	echo "${nonHani_out}"
	LANG=C grep -E [^$'\u4e00'-$'\u9fff'] "${return}" > "${nonHani_out}"
	less "${nonHani_out}"
	echo "----"
	#return=

	# add readings
	# remove entries that contain non-基本區 characters
	echo "${awk_out}"
	awk -f osm-placenames.awk "${return}" > "${awk_out}"
	echo "----"
	return="${awk_out}"

	# convert with OpenCC
	# print difference
	echo "${opencc_out}"
	echo "${opencc_diff_out}"
	echo "${opencc_config}"
	opencc --input "${return}" --config "${opencc_config}" --output "${opencc_out}"
	diff --side-by-side --suppress-common-lines "${return}" "${opencc_out}" > "${opencc_diff_out}"
	less "${opencc_diff_out}"
	echo "----"
	return="${opencc_out}"

	# write dictionary to $out
	echo "${out}"
	printf "${rime_dictionary_header}" "${name}" "${date}" >> "${out}"
	cat "${return}" >> "${out}"
	echo "----"
done