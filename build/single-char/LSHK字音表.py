# -*- coding: utf-8 -*-

def LSHK字音表():
	import os
	import pandas
	import urllib.request

	def download_file_if_not_exist(url, name):
		if not os.path.exists(name):
			urllib.request.urlretrieve(url, name)

	download_file_if_not_exist('https://raw.githubusercontent.com/laubonghaudoi/cantonese_orthography/master/LSHK%20Jyutping%20-%20Char%20-%20JP.csv', 'build/single-char/data/0-LSHK字音表.csv')

	if not os.path.exists('build/single-char/data/1-LSHK字音表.csv'):
		df = pandas.read_csv('build/single-char/data/0-LSHK字音表.csv', na_filter=False, usecols=['Hanzi', 'JP'])
		df.columns = ['字頭', '粵拼讀音']
		df.to_csv('build/single-char/data/1-LSHK字音表.csv', index=False, header=False)
