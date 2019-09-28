# -*- coding: utf-8 -*-

def build_single_char():
	'''Return a sorted dictionary containing data of single characters'''
	from collections import defaultdict
	from itertools import chain
	import json
	import os
	import re
	from sortedcontainers import SortedSet

	from single_char.LSHK字音表 import LSHK字音表
	from single_char.粵音小鏡 import 粵音小鏡
	from single_char.廣州話正音字典 import 廣州話正音字典
	from single_char.常用字廣州話讀音表 import 常用字廣州話讀音表
	from single_char.粵語審音配詞字庫 import 粵語審音配詞字庫

	if not os.path.exists('build/single_char/data'):
		os.mkdir('build/single_char/data')

	LSHK字音表()
	粵音小鏡()
	廣州話正音字典()
	常用字廣州話讀音表()
	粵語審音配詞字庫()

	def isTraditional(ch):
		'''檢查某個字元是否為繁體漢字（不完善）'''
		if re.match(r'[\u4e00-\u9fff]', ch, re.UNICODE):  # 若是 Unicode 基本區漢字
			try:
				ch.encode('cp950')
			except UnicodeEncodeError:
				return False
			return True  # 若能使用 Big5 (cp950) 編碼 -> 是繁體字
		elif re.match(r'[\u3400-\u4dbf\U00020000-\U0002a6df\U0002a700-\U0002b73f\U0002b740-\U0002b81f\U0002b820-\U0002ceaf\U0002ceb0-\U0002ebef\U00030000-\U0003134f]', ch, re.UNICODE):  # 若是 Unicode 其他漢字區（除兼容區外）漢字 -> 是繁體字
			return True
		else:
			return False

	with open('build/single_char/data/0-Unihan.json') as unihan, open('build/single_char/data/1-LSHK字音表.csv') as LSHK字音表, open('build/single_char/data/1-粵音小鏡.csv') as 粵音小鏡, open('build/single_char/data/1-廣州話正音字典.csv') as 廣州話正音字典, open('build/single_char/data/1-常用字廣州話讀音表.csv') as 常用字廣州話讀音表, open('build/single_char/data/1-粵語審音配詞字庫.csv') as 粵語審音配詞字庫:
		pattern = re.compile(r'(?P<字>.),(?P<粵拼讀音>.+)\n')
		d = defaultdict(set)
		for line in chain(LSHK字音表, 粵音小鏡, 廣州話正音字典, 常用字廣州話讀音表, 粵語審音配詞字庫):
			match = pattern.match(line)
			字, 粵拼讀音 = match['字'], match['粵拼讀音']
			d[字].add(粵拼讀音)

		lis = json.load(unihan)

		final = SortedSet()

		for li in lis:  # 對於 Unihan 中的某個字
			char, kCantonese = li['char'], li['kCantonese']

			if not isTraditional(char):  # 若不是繁體字，捨棄
				continue

			assert len(kCantonese) != 0
			if len(kCantonese) == 1:  # 若只有一音 -> 收錄
				final.add((kCantonese[0], char))
			else:  # 若有多個音
				res = d.get(char)
				if res is not None:  # 若五份資料中任意一份有此字
					cnt = 0
					for pronunciation in kCantonese:  # 若其中某幾個發音見於五份資料中任意一份 -> 收錄這幾個發音
						if pronunciation in res:
							final.add((pronunciation, char))
							cnt += 1
					if cnt == 0:  # 若每個音都不見於五份資料中任意一份 -> Unihan 和五份資料中的發音均收錄
						for pronunciation in chain(kCantonese, res):
							final.add((pronunciation, char))
				else:  # 若五份資料中每份均無此字 -> 全部收錄
					for pronunciation in kCantonese:
						final.add((pronunciation, char))

		return final
