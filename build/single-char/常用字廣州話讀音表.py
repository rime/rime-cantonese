# -*- coding: utf-8 -*-

def 常用字廣州話讀音表():
	import os
	import pandas
	import urllib.request

	def download_file_if_not_exist(url, name):
		if not os.path.exists(name):
			urllib.request.urlretrieve(url, name)

	download_file_if_not_exist('https://raw.githubusercontent.com/jyutnet/cantonese-books-data/master/1992_%E5%B8%B8%E7%94%A8%E5%AD%97%E5%BB%A3%E5%B7%9E%E8%A9%B1%E8%AE%80%E9%9F%B3%E8%A1%A8/C02_%E6%AD%A3%E6%96%87(%E6%8C%89%E8%AE%80%E9%9F%B3%E5%88%97%E5%87%BA).txt', 'build/single-char/data/0-常用字廣州話讀音表.txt')

	if not os.path.exists('build/single-char/data/1-常用字廣州話讀音表.csv'):
		with open('build/single-char/data/0-常用字廣州話讀音表.txt') as fin:
			next(fin)  # Skip 資料庫版本 on the first line
			pandas.read_csv(fin, sep='\t', na_filter=False, usecols=['字', '粵拼讀音']).to_csv('build/single-char/data/1-常用字廣州話讀音表.csv', index=False, header=False)
