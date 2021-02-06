function parse(str) {
	var result = {normal: [], lettered: [], errors: []};
	str.split(/\r?\n|\r/).forEach(function(item) {
		var [left, right] = item.split("\t"), target = /\w/.test(left) ? "lettered" : "normal", word = [], pron = [], isInner = false, alt = [], i, ori, dup, tmp, matches = [], regex = /(([a-z]{1,6})(\d)(?:-(\d)|\(-?(\d)\))?|[()]) */giy, line, len = 0;
		left = [...left];
		for (i = left.length - 1; i >= 0; i--) {
			if (isInner) {
				if (left[i] == "(") {
					ori = dup = "";
					while (tmp = alt.shift()) {
						if (!i--) target = "errors";
						ori = (left[i] || "") + ori;
						dup += tmp;
						len++;
					}
					word.unshift([ori, dup]);
					isInner = false;
				} else alt.unshift(left[i]);
			} else if (left[i] == ")") isInner = true;
			else word.unshift([left[i]]) && len++;
		}
		isInner = false;
		while (tmp = regex.exec(right)) matches.push(tmp);
		right = matches;
		for (i = right.length - 1; i >= 0 && right[i][1] == "("; i--);
		for (; i >= 0; i--) {
			if (isInner) {
				if (right[i][1] == "(") {
					ori = [];
					dup = [];
					while (tmp = alt.shift()) {
						if (!i-- || right[i][4] || right[i][5] || tmp[4] || tmp[5]) target = "errors";
						ori.unshift(right[i] && right[i][1] || "");
						dup.push(tmp[1]);
						len--;
					}
					pron.unshift([ori.join(" "), dup.join(" ")]);
					isInner = false;
				} else alt.unshift(right[i]);
			} else if (right[i][1] == ")") isInner = true;
			else pron.unshift(right[i][4] || right[i][5] ? [right[i][2] + right[i][3], right[i][2] + (right[i][4] || right[i][5])] : [right[i][1]]) && len--;
		}
		if (pron.length) for (i = pron.length - 1; i; i--) pron.splice(i, 0, [" "]);
		if (!pron.length || len) target = "errors";
		line = word.concat([["\t"]], pron);
		function combinations(old, row, col) {
			var out = old + line[row][col];
			if (row == line.length - 1) result[target].push(out);
			if (row < line.length - 1) combinations(out, row + 1, 0);
			if (col < line[row].length - 1) combinations(old, row, col + 1);
		}
		combinations("", 0, 0);
	});
	return result;
}