#!/usr/bin/env python3

from collections import defaultdict

d = defaultdict(int)

with open('essay-cantonese.txt') as f:
    for line in f:
        w, f = line.rstrip().split('\t')
        d[w] += int(f)

with open('essay-cantonese.txt', 'w') as f:
    for k, v in d.items():
        print(k, v, sep='\t', file=f)
