# -*- coding: utf-8 -*-

def 粵音小鏡():
	import os
	import pandas
	import urllib.request

	def download_file_if_not_exist(url, name):
		if not os.path.exists(name):
			urllib.request.urlretrieve(url, name)

	download_file_if_not_exist('https://raw.githubusercontent.com/laubonghaudoi/cantonese_orthography/master/%E7%B2%B5%E9%9F%B3%E5%B0%8F%E9%8F%A1(20160723).xls', 'build/single_char/data/0-粵音小鏡.xls')

	def change_initial(s):
		'''Change Guangzhou scheme to LSHK scheme
		From: https://humanum.arts.cuhk.edu.hk/Lexis/lexi-can/initials.php
		'''
		return { 'b': 'b', 'c': 'c', 'd': 'd', 'f': 'f', 'g': 'g', 'gu': 'gw', 'h': 'h', 'j': 'z'
			, 'k': 'k', 'ku': 'kw', 'l': 'l', 'm': 'm', 'n': 'n', 'ng': 'ng', 'p': 'p', 'q': 'c'
			, 's': 's', 't': 't', 'w': 'w', 'x': 's', 'y': 'j', 'z': 'z', '': ''}[s]

	def change_rhyme(s):
		'''Change Guangzhou scheme to LSHK scheme
		From: https://humanum.arts.cuhk.edu.hk/Lexis/lexi-can/finals.php
		'''
		return { 'a': 'aa', 'ai': 'aai', 'ao': 'aau', 'am': 'aam', 'an': 'aan', 'ang': 'aang', 'ab': 'aap', 'ad': 'aat'
			, 'ag': 'aak', 'ei': 'ai', 'eo': 'au', 'em': 'am', 'en': 'an', 'eng': 'ang', 'eb': 'ap', 'ed': 'at'
			, 'eg': 'ak', 'é': 'e', 'éi': 'ei', 'éng': 'eng', 'ég': 'ek', 'i': 'i', 'iu': 'iu', 'im': 'im'
			, 'in': 'in', 'ing': 'ing', 'ib': 'ip', 'id': 'it', 'ig': 'ik', 'o': 'o', 'oi': 'oi', 'ou': 'ou'
			, 'on': 'on', 'ong': 'ong', 'od': 'ot', 'og': 'ok', 'ê': 'oe', 'êng': 'oeng', 'êg': 'oek', 'êü': 'eoi'
			, 'ên': 'eon', 'êd': 'eot', 'u': 'u', 'ui': 'ui', 'un': 'un', 'ung': 'ung', 'ud': 'ut', 'ug': 'uk'
			, 'ü': 'yu', 'ün': 'yun', 'üd': 'yut', 'm': 'm', 'ng': 'ng'}[s]

	def process_row_粵音小鏡(row):
		粵拼讀音 = change_initial(row['粵-聲']) + change_rhyme(row['粵-韻']) + row['粵-調']
		for 字 in row['粵-同音字']:
			yield 字, 粵拼讀音

	if not os.path.exists('build/single_char/data/1-粵音小鏡.csv'):
		df = pandas.read_excel('build/single_char/data/0-粵音小鏡.xls', sheet_name='粵-同音字', na_filter=False, usecols=['粵-聲', '粵-韻', '粵-調', '粵-同音字'], dtype='str')
		pandas.DataFrame((i for _, row in df.iterrows() for i in process_row_粵音小鏡(row)), columns=('字', '粵拼讀音')).to_csv('build/single_char/data/1-粵音小鏡.csv', index=False, header=False)
