import datetime
import pytz
from os.path import join
import sys
from itertools import product
from bracket_expand import bracket_expand, punct_expand

# header

try:
    upstream_dir = sys.argv[1]
except IndexError:
    print('Error: Please provide upstream directory as a command line argument.', file=sys.stderr)
    sys.exit(-1)

current_date = datetime.datetime.now(pytz.timezone('Asia/Hong_Kong')).strftime('%Y.%m.%d')  # stick to HKT to avoid confusion

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

with open(join(upstream_dir, 'char.csv')) as f:
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

with open('jyut6ping3.chars.dict.yaml', 'w') as f:
    print(generate_header('chars'), file=f)
    for char, jyutping, pron_rank in chars_list:
        line = (char, jyutping, pron_rank) if pron_rank else (char, jyutping)
        print(*line, sep='\t', file=f)

# word

words_list = []

for filename in ('fixed_expressions.csv', 'phrase_fragment.csv', 'trending.csv', 'word.csv'):
    with open(join(upstream_dir, filename)) as f:
        next(f)  # skip header

        for line in f:
            # todo: handle comma in fixed_expressions.csv
            char, jyutping = line.rstrip('\n').split(',')
            for entry in product(bracket_expand(char), bracket_expand(jyutping)):
                words_list += punct_expand(entry)

for filename in ('onomatopoeia.csv'):
    with open(join(upstream_dir, filename)) as f:
        next(f)  # skip header

        for line in f:
            type, jyutping, char = line.rstrip('\n').split(',')
            words_list.append((char, jyutping))

words_list.sort(key=sort_criteria)

with open('jyut6ping3.words.dict.yaml', 'w') as f:
    print(generate_header('words'), file=f)
    for char, jyutping in words_list:
        print(char, jyutping, sep='\t', file=f)
