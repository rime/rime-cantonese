<?php

echo '<pre>';
$starttime = microtime(true);

$fp = fopen('/Users/user/GitHub/rime-cantonese/jyut6ping3.dict.yaml', 'r');
$i = 0;
while($line = fgets($fp)) {
	if (trim($line) === '' || $line[0] === '#') goto next;
	if (strpos($line, "\t") === false) goto next;

	list($char, $val) = explode("\t", trim($line), 3);

	$syllable = strtok($val, " ");
	while ($syllable !== false) {
		$tone = substr($syllable, -1);
		if ($tone !== '1' && $tone !== '2' && $tone !== '3' && $tone !== '4' && $tone !== '5' && $tone !== '6') {
			goto error;
		}

		$syllable = substr($syllable, 0, -1);

		if ($syllable == 'm' || $syllable == 'ng' || $syllable == 'hm' || $syllable == 'hng') goto success;

		$syllable = strtr($syllable, [
			'q' => 'qqqq', 'v' => 'qqqq',

			'aang' => 'v', 'aan' => 'v', 'aam' => 'v',
			'aak' => 'v', 'aat' => 'v', 'aap' => 'v',
			'aai' => 'v', 'aau' => 'v', 'aa' => 'v',

			'ang' => 'v', 'an' => 'v', 'am' => 'v',
			'ak' => 'v', 'at' => 'v', 'ap' => 'v',
			'ai' => 'v', 'au' => 'v', 'a' => 'v',

			'em' => 'v', 'eng' => 'v', 'en' => 'v',
			'ep' => 'v', 'ek' => 'v', 'et' => 'v',
			'ei' => 'v', 'eu' => 'v', 'e' => 'v',

			'ing' => 'v', 'in' => 'v', 'im' => 'v',
			'ik' => 'v', 'it' => 'v', 'ip' => 'v',
			'iu' => 'v', 'i' => 'v',

			'oi' => 'v', 'ou' => 'v',
			'ong' => 'v', 'on' => 'v', 'ot' => 'v', 'ok' => 'v', 'om' => 'v',
			'o' => 'v', 

			'eoi' => 'v', 'eon' => 'v', 'eot' => 'v', 
			'oeng' => 'v', 'oet' => 'v', 'oek' => 'v', 'oe' => 'v', 
			'yun' => 'v', 'yut' => 'v', 'yu' => 'v',
			
			'ui' => 'v', 'ung' => 'v', 'un' => 'v', 'ut' => 'v', 'uk' => 'v', 
			'u' => 'v', 
		]);

		$syllable = strtr($syllable, [
			'gw' => 'q', 'kw' => 'q',
			'b' => 'q', 'p' => 'q', 'm' => 'q', 'f' => 'q',
			'd' => 'q', 't' => 'q', 'n' => 'q', 'l' => 'q',
			'g' => 'q', 'k' => 'q', 'ng' => 'q', 'h' => 'q',
			'z' => 'q', 'c' => 'q', 's' => 'q',
			'j' => 'q', 'w' => 'q'
		]);

		if ($syllable !== 'qv' && $syllable !== 'v') {
			echo $syllable . " ";
			goto error;
		}
		

		success:
		$syllable = strtok(" ");
		continue;

		error:
		echo "Invalid Jyutping detected on line $i: $line" . "\r\n";
		$syllable = strtok(" ");
	}

	next:
	$i++;
}

echo "Time used: " . (microtime(true) - $starttime) . ' s';
