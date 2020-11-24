#!/usr/bin/env python3
import argparse
import cbor2
import re

#CBOR_URL = 'https://tools-static.wmflabs.org/templatehoard/dump/latest/zh-pron.cbor'
OUT_FILE_NAME = "jyut6ping3.enwiktionary.%s.txt"

def is_lettered(text):
	return re.findall(r'[A-Za-z0-9Α-Ωα-ω]', text)

def get_latest_dump():
	# TODO
	return {
		date: '',
		cbor_path: '/tmp/zh-pron.cbor',
	}

def main(args):
	cbor_path = args.cbor_path

	out = {
		'main': {},
		'lettered': {},
	}

	# CBOR stream
	# https://github.com/agronholm/cbor2/issues/30
	with open(cbor_path, 'rb') as file:
		decoder = cbor2.CBORDecoder(file)
		while file.peek(1):
			entry = decoder.decode()

			title = entry['title']

			# [[水/derived terms]]
			title = title.replace('/derived terms', '')

			# classify
			type = ('lettered' if is_lettered(title) else 'main')

			for template in entry['templates']:
				if 'c' in template['parameters']:
					args_c = template['parameters']['c']

					# remove commas for phrases
					# (double-duty commas. i really hate this)
					# [[金玉其外，敗絮其中]] [[司馬昭之心——路人皆知]]
					if '，' in title or '——' in title:
						args_c = args_c.replace(', ', ' ')
					# remove spaces surrounding commas elsewhere
					# (this is bad formatting)
					args_c = re.sub(r' *, *', r',', args_c)
					# remove HTML comments
					# [[𡚸]] [[林口]] [[搶]]
					args_c = re.sub(r'<!--(.*)-->', r'', args_c)
					# remove tone before change
					args_c = re.sub(r'(\d)-(\d)', r'\2', args_c)

					# ignore entries with empty |c=
					# [[㓱]]
					if args_c == '':
						continue

					# ignore entries with ellipsis
					# [[一會……一會……]]
					if '…' in title:
						continue

					# split by comma
					args_c = args_c.split(',')

					# save
					# [[嘅]] ge3 ge2
					if not title in out[type]:
						out[type][title] = []
					out[type][title] += args_c

	for type in out:
		with open(OUT_FILE_NAME % (type), 'w') as file:
			for entry in out[type]:
				for reading in out[type][entry]:
					file.write(entry + '\t' + reading + '\n')

if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument(
		'cbor_path',
		metavar = 'INFILE.cbor',
	)
	parser.add_argument(
		'-d',
		dest= 'bool_download_latest_dump',
		help = 'download and use latest dump',
		action = 'store_true',
	)
	args = parser.parse_args()

	main(args)
