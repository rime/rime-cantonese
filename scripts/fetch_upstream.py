import datetime
import pytz
from glob import iglob
from os.path import join
import sys

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
    word, romans, rest = entry
    return len(word), romans, word, rest

chars_list = []
words_list = []

for filename in iglob(join(upstream_dir, '*.csv')):
    with open(filename) as f:
        next(f)  # skip header

        for line in f:
            word, romans, *rest = line.rstrip('\n').split(',', 3)

            romans_list = romans.replace(']', '').split('[')  # handle aaa[bbb][ccc]

            for romans in romans_list:
                target_list = chars_list if len(word) == 1 else words_list
                target_list.append((word, romans, rest))

chars_list.sort(key=sort_criteria)
words_list.sort(key=sort_criteria)

with open('jyut6ping3.chars.dict.yaml', 'w') as f:
    print(generate_header('chars'), file=f)
    for word, romans, rest in chars_list:
        print(word, romans, *rest, sep='\t', file=f)

with open('jyut6ping3.words.dict.yaml', 'w') as f:
    print(generate_header('words'), file=f)
    for word, romans, rest in words_list:
        print(word, romans, *rest, sep='\t', file=f)
