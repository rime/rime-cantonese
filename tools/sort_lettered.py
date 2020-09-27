# Usage: python tools/sort_lettered.py

def do(file_path):
	headers = []
	words = set()

	with open(file_path) as f:
		for line in f:
			if line == '...\n':
				headers.append(line)
				break
			headers.append(line)

		for line in f:
			line = line.rstrip('\n')
			if not line or line.startswith('#'):
				continue
			ch, py, *extra = line.split('\t')
			words.add((ch, py, tuple(extra)))

	words = sorted(words, key=lambda xyz: (ord(xyz[0][0].lower()) if ord(xyz[0][0]) <= 128 else 129, xyz[1], xyz[0], xyz[2]))

	with open(file_path, 'w') as f:
		for line in headers:
			f.write(line)
		f.write('\n')

		f.write('# 含數字或英文嘅詞彙\n\n')

		for ch, py, extra in words:
			print(ch, py, *extra, sep='\t', file=f)

do('jyut6ping3.lettered.dict.yaml')
