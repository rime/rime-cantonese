#awk -f osm-placenames.awk /tmp/rime-cantonese.osm_hk_ways.cut.

BEGIN {
	# 讀音
	rs["昂坪360救援徑"] = "ngong4 ping4 saam1 luk6 ling4 gau3 wun4 ging3/ngong5 ping4 saam1 luk6 ling4 gau3 wun4 ging3";
	rs["石𬒔"] = "sek6 gang2";
}

# 含非基本區字
/[^一-鿿]/ {
	# 若無其讀音
	if ($0 in rs == 0) {
		# 除之
		next;
	}
}

{
	if ($0 in rs) {
		split(rs[$0], rs_0, "/");
		for (r in rs_0) {
			print $0 "\t" rs_0[r];
		}
	} else {
		print $0;
	}
}