#!/usr/bin/env python3

def load_dict(path):
	with open(path) as f:
		return {k: int(v) for line in f for k, v in (line.rstrip().split('\t'),)}

def write_dict(d, path):
	with open(path, 'w') as f:
		for k, v in d.items():
			print(k, v, sep='\t', file=f)

a = load_dict('essay.txt')
b = load_dict('cifu-freq.txt')
b = {k: int(v * 4822928 / (48693 + 12448)) for k, v in b.items()}  # Align freq: 的 = 的 + 嘅

write_dict({**a, **b}, 'essay-cantonese.txt')
