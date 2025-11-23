import sys
from datetime import datetime
import pytz
from os.path import basename, join
from glob import iglob
import sys
from operator import itemgetter
from itertools import chain, product
from bracket_expand import bracket_expand, punct_expand

# header

try:
    upstream_dir = sys.argv[1]
except IndexError:
    print('Error: Please provide upstream directory as a command line argument.', file=sys.stderr)
    sys.exit(-1)

current_date = (datetime.fromisoformat(sys.argv[2]).astimezone if len(sys.argv) > 2 else datetime.now)(pytz.timezone('Asia/Hong_Kong')).strftime('%Y.%m.%d')  # stick to HKT to avoid confusion

def generate_header(dictionary_name):
    return f'''# Rime dictionary
# encoding: utf-8
#
# jyut6ping3 - 粵拼詞庫
#
# Source: https://github.com/CanCLID/rime-cantonese-upstream

---
name: jyut6ping3.{dictionary_name}
version: "{current_date}"
sort: by_weight
...
'''

def sort_criteria(entry):
    char, jyutping, *rest = entry
    return len(char), jyutping, char, *rest

# char

chars_list = []

with open(join(upstream_dir, 'char.csv'), encoding='utf-8') as f:
    next(f)  # skip header

    for line in f:
        char, jyutping, pron_rank, tone_var, literary_vernacular, comment = line.rstrip('\n').split(',')
        pron_rank = {
            '預設': '',
            '常用': '5%',
            '罕見': '3%',
            '棄用': '0%',
        }[pron_rank]
        chars_list.append((char, jyutping, pron_rank))

chars_list.sort(key=sort_criteria)

with open('jyut6ping3.chars.dict.yaml', 'w', encoding='utf-8') as f:
    print(generate_header('chars'), file=f)
    for char, jyutping, pron_rank in chars_list:
        line = (char, jyutping, pron_rank) if pron_rank else (char, jyutping)
        print(*line, sep='\t', file=f)

# word

include_cols = ['char', 'jyutping']
words_list = []

for filename in iglob(join(upstream_dir, '*.csv')):
    if basename(filename) != 'char.csv':
        with open(filename, encoding='utf-8') as f:
            cols = next(f).rstrip('\n').split(',')
            if all(col in cols for col in include_cols):
                select_cols = itemgetter(*map(cols.index, include_cols))
                words_list += chain(*(chain(*map(punct_expand, product(*map(bracket_expand, select_cols(line.rstrip('\n').split(',')))))) for line in f))

words_list.sort(key=sort_criteria)

with open('jyut6ping3.words.dict.yaml', 'w', encoding='utf-8') as f:
    print(generate_header('words'), file=f)
    prev_line = None
    for line in words_list:
        if prev_line != line:
            print(*line, sep='\t', file=f)
            prev_line = line
