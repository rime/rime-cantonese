#!/usr/bin/env python3
import argparse
import cbor2
import re

#CBOR_URL = 'https://tools-static.wmflabs.org/templatehoard/dump/latest/zh-pron.cbor'
OUT_FILE_NAME = "jyut6ping3.enwiktionary.%s.txt"

def is_lettered(text):
	return re.match(r'[A-Za-z0-9]', text)

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

			type = ('lettered' if is_lettered(entry['title']) else 'main')
			#print(entry['title'])
			for template in entry['templates']:
				if 'c' in template['parameters']:
					args_c = template['parameters']['c']
					args_c = re.sub(r'(\d)-(\d)', r'\2', args_c) # 移除變調前聲調
					args_c = args_c.split(',')
					out[type][entry['title']] = args_c
					#print(args_c)

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
