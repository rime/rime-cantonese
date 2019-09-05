#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import json
import urllib.request

source_url = 'https://raw.githubusercontent.com/sgalal/rensyuugi/b13a3ad433e863eab8c798e86a9f966eaac870ab/index.files/cantonese/data.json'
source = urllib.request.urlopen(source_url).read().decode('utf-8')
data = json.loads(source)

single_chars = []
multiple_chars = []

for k, vs in data.items():
	for v in vs:
		if len(k) == 1:
			single_chars.append((k, v))
		else:
			multiple_chars.append((k, v))

for single_char in single_chars:
	print('%s\t%s' % single_char)

for multiple_char in multiple_chars:
	print('%s\t%s' % multiple_char)
