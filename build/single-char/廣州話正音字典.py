# -*- coding: utf-8 -*-

def 廣州話正音字典():
	import os
	import pandas
	import urllib.request

	def download_file_if_not_exist(url, name):
		if not os.path.exists(name):
			urllib.request.urlretrieve(url, name)

	download_file_if_not_exist('https://raw.githubusercontent.com/jyutnet/cantonese-books-data/master/2004_%E5%BB%A3%E5%B7%9E%E8%A9%B1%E6%AD%A3%E9%9F%B3%E5%AD%97%E5%85%B8/B01_%E8%AE%80%E9%9F%B3%E8%B3%87%E6%96%99.txt', 'build/single-char/data/0-廣州話正音字典.txt')

	def process_row_廣州話正音字典(字頭, 粵拼讀音):
		for 字 in 字頭.split('|'):
			yield 字, 粵拼讀音

	if not os.path.exists('build/single-char/data/1-廣州話正音字典.csv'):
		with open('build/single-char/data/0-廣州話正音字典.txt') as fin:
			next(fin)  # Skip 資料庫版本 on the first line
			df = pandas.read_csv(fin, sep='\t', na_filter=False, usecols=['字頭', '粵拼讀音'])
			pandas.DataFrame((i for 字頭, 粵拼讀音 in df[['字頭', '粵拼讀音']].values for i in process_row_廣州話正音字典(字頭, 粵拼讀音)), columns=('字', '粵拼讀音')).to_csv('build/single-char/data/1-廣州話正音字典.csv', index=False, header=False)
