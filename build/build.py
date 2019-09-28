#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from datetime import datetime

from single_char.build_single_char import build_single_char
from word.build_word import build_word

d_single_char = build_single_char()
d_word = build_word()

header = f'''# Rime dictionary
# encoding: utf-8
#
# Jyut6ping3 - 粵拼詞庫
#
# 字音數據來源
# UNICODE HAN DATABASE (UNIHAN) 
# Version:  Unicode 12.0.0
# Date:  2019-02-15
# http://www.unicode.org/reports/tr38/
#
# LSHK 字音表
# GitHub repo: laubonghaudoi/cantonese_orthography
# URL: https://github.com/laubonghaudoi/cantonese_orthography/blob/master/LSHK%20Jyutping%20-%20Char%20-%20JP.csv
#
# 粵音小鏡
# GitHub repo: laubonghaudoi/cantonese_orthography
# URL: https://github.com/laubonghaudoi/cantonese_orthography/blob/master/%E7%B2%B5%E9%9F%B3%E5%B0%8F%E9%8F%A1(20160723).xls
#
# 廣州話正音字典
# GitHub repo: jyutnet/cantonese-books-data
# URL: https://github.com/jyutnet/cantonese-books-data/tree/master/2004_%E5%BB%A3%E5%B7%9E%E8%A9%B1%E6%AD%A3%E9%9F%B3%E5%AD%97%E5%85%B8
#
# 常用字廣州話讀音表
# GitHub repo: jyutnet/cantonese-books-data
# URL: https://github.com/jyutnet/cantonese-books-data/tree/master/1992_%E5%B8%B8%E7%94%A8%E5%AD%97%E5%BB%A3%E5%B7%9E%E8%A9%B1%E8%AE%80%E9%9F%B3%E8%A1%A8
#
# 粵語審音配詞字庫
# Website: https://humanum.arts.cuhk.edu.hk/Lexis/lexi-can/
# GitHub repo: sgalal/lexi_can_crawler
# URL: https://github.com/sgalal/lexi_can_crawler
#
# 詞條數據來源
# LSHK Jyutping Word List https://corpus.eduhk.hk/JPwordlist/
#
# 製作與校對者
# laubonghaudoi <laubonghaudoi@icloud.com>
# LeiMaau <leimaau@qq.com>
# sgal <1727246457@qq.com>

---
name: jyut6ping3
version: "{datetime.today().strftime('%Y.%m.%d')}"
sort: by_weight
use_preset_vocabulary: true
max_phrase_length: 7
min_phrase_weight: 100
...

'''

with open('jyut6ping3.dict.yaml', 'w') as fout:
	fout.write(header)
	for pronunciation, char in d_single_char:
		print(f'{char}\t{pronunciation}', file=fout)
	for pronunciation, word in d_word:
		print(f'{word}\t{pronunciation}', file=fout)
