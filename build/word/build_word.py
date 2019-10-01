# -*- coding: utf-8 -*-

def build_word():
	from opencc import OpenCC
	import os
	import re
	from sortedcontainers import SortedSet
	import urllib.request

	if not os.path.exists('build/word/data'):
		os.mkdir('build/word/data')

	def download_file_if_not_exist(url, name):
		if not os.path.exists(name):
			urllib.request.urlretrieve(url, name)

	download_file_if_not_exist('https://raw.githubusercontent.com/sgalal/lshk-word-list-crawler/master/sanitized.txt', 'build/word/data/香港語言學學會粵拼詞表.txt')

	with open('build/word/data/香港語言學學會粵拼詞表.txt') as 香港語言學學會粵拼詞表:
		cc = OpenCC('hk2tp')
		pattern = re.compile(r'(?P<詞>.+)\t(?P<粵拼讀音>.+)\n')

		word = SortedSet()

		for line in 香港語言學學會粵拼詞表:
			match = pattern.match(line)
			詞, 粵拼讀音 = match['詞'], match['粵拼讀音']
			if len(詞) > 1:
				word.add((粵拼讀音, cc.convert(詞)))

		return word
