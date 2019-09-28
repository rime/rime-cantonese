# -*- coding: utf-8 -*-

def 粵語審音配詞字庫():
	import os
	import pandas
	import json
	import urllib.request

	def download_file_if_not_exist(url, name):
		if not os.path.exists(name):
			urllib.request.urlretrieve(url, name)

	download_file_if_not_exist('https://github.com/sgalal/lexi_can_crawler/releases/download/v1.1/data.json', 'build/single_char/data/0-粵語審音配詞字庫.json')

	if not os.path.exists('build/single_char/data/1-粵語審音配詞字庫.csv'):
		with open('build/single_char/data/0-粵語審音配詞字庫.json') as fin:
			lis = json.load(fin)
			pandas.DataFrame(((li['ch'], li['initial'] + li['rhyme'] + li['tone']) for li in lis), columns=('字', '粵拼讀音')).to_csv('build/single_char/data/1-粵語審音配詞字庫.csv', index=False, header=False)
