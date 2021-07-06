#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <regex>
#include <algorithm>
#include <cstdio>
#define JYUT phonemes[0]
#define INITIAL phonemes[1]
#define STEM phonemes[2]
#define FINAL phonemes[3]
#define TONER phonemes[4]
using namespace std;

string word, line, dict;
smatch phonemes;

bool valid_jyutping(string a){

	
	//has a jyutping-like structure; if cannot be decomposed exactly into 4 groups, treat as invalid
	if (!regex_match(a, phonemes, (regex) "(gw?|kw?|ng?|sh?|[bpmfdtlhzcjw])?(aa?|eo?|oe?|[iu]|yu|ng|m)([iumptk]|ng?)?([1-6])")) return false;
	
	/* Note: after the first regex_match, the jyutping string will be decomposed into phonemes acc to the following:
		phonemes[0] = JYUT = full jyutping string
		phonemes[1] = INITIAL = initial (empty if none)
		phonemes[2] = STEM = stem (aa / a / e / i / o / u / eo / oe / yu / ng / m)
		phonemes[3] = FINAL = final (empty if none; including -i and -u; thus -aai will be treated as -aa + -i)
		phonemes[4] = TONE = tone 
	*/
	
	
	/* ------ CHECKING RULES ------ */
	
	// eo followed by t / i / n
	if (STEM == "eo") {
		if (!(FINAL == "t" || FINAL == "i" || FINAL == "n")) return false;
	}
	
	// catch failed matches of /m/ and /ng/
	if ((STEM == "m" || STEM == "ng") && (INITIAL != "" && INITIAL != "h")) return false;
	if ((STEM == "m" || STEM == "ng") && FINAL != "") return false;
	
	return true;
}

//Strips down a jyutping string into words
bool process(string a){
	istringstream sin(a);
	
	while(sin >> word) {
		if (!valid_jyutping(word)) return false;
	}
	
	return true;
}

//Processes file
int parse(){
	int count_invalid = 0;
	int line_no = 0;
	
	// Discard lines until '...' (i.e. end of header block)
	while (true){
		getline(cin, line);
		line_no++;
		if (line == "...") break;
	} 
	
	// Real checking
	while(getline(cin, line)){
		line_no++;
		string word =        line.substr(0,                 line.find('\t'));
		string jyut_string = line.substr(line.find('\t')+1, line.find('\t', line.find('\t')+1) - line.find('\t'));
		if (!process(jyut_string)) {
			cerr << "[L" << line_no << "] Invalid Jyutping detected: " << jyut_string << endl;
			count_invalid++;
		} 
	}

	return count_invalid;
}

int main (int argc, char** argv) {
	
	ios_base::sync_with_stdio();
	
	if (argc == 2){
		dict = argv[1];
		cout << "Loading " << dict << endl;
	} else {
		cerr << "Invalid input format" << endl;
		cerr << "Use ./checker input_file_name.yaml" << endl;
		return 1;
	}
	
	freopen(dict.c_str(), "r", stdin ); // redirect file to stdin stream
	return parse();
}
