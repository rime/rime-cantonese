#awk -f osm-placenames.awk /tmp/rime-cantonese.osm_hk_ways.cut.

BEGIN {
	# readings
	rs["昂坪360"] = "ngong4 ping4 saam1 luk6 ling4/ngong5 ping4 saam1 luk6 ling4";
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