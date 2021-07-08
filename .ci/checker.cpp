#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <boost/regex.hpp>
#include <algorithm>
#include <cstdio>
#define JYUT phonemes[0]
#define INITIAL phonemes[1]
#define STEM phonemes[2]
#define FINAL phonemes[3]
#define TONE phonemes[4]
using namespace boost;

std::string word, line, dict;
smatch phonemes;

regex expr("(gw?|kw?|ng?|sh?|[bpmfdtlhzcjw])?(aa?|eo?|oe?|[iu]|yu|ng|m)([iumptk]|ng?)?([1-6])");

// CHANGE THIS -- a function to check if a jyutping word is valid 
bool valid_jyutping(std::string a){

	// Has a jyutping-like structure -- catches most invalid spellings ('ch-', 'eu-', etc)
	//      If cannot be decomposed into exactly 4 groups, treat as invalid
	if (!regex_match(a, phonemes, expr)) return false;
	
	/* Note: after the first regex_match, the jyutping string will be decomposed into phonemes acc to the following:
		phonemes[0] = JYUT = full jyutping string
		--------------------------------
		phonemes[1] = INITIAL = initial (empty if none)
		phonemes[2] = STEM = stem (aa / a / e / i / o / u / eo / oe / yu / ng* / m*)
		phonemes[3] = FINAL = final (empty if none; including -i and -u; thus -aai will be treated as -aa + -i)
		phonemes[4] = TONE = tone 

		*Only applies to /ng/ and /m/
	*/
	
	/* ------ ADDITIONAL CHECKING RULES ------ */
	
	// eo followed by t / i / n
	if (STEM == "eo" && !(FINAL == "t" || FINAL == "i" || FINAL == "n")) return false;
	
	// i / yu must begin with an initial, but allow ik1 and ik6 (hiccups)
	if (JYUT == "ik1" || JYUT == "ik6") return true;
	else if (INITIAL == "" && (STEM == "i" || STEM == "yu")) return false;

	// Add more rules here...

	// catch invalid matches of /m/ and /ng/
	if ((STEM == "m" || STEM == "ng") && (INITIAL != "" && INITIAL != "h")) return false;
	if ((STEM == "m" || STEM == "ng") && FINAL != "") return false;
	
	return true;
}

//Strips down a jyutping string into words and passes to valid_jyutping() for checking
//Can probably optimise
bool process(std::string a){
	std::istringstream sin(a);
	
	while(sin >> word) {
		if (!valid_jyutping(word)) return false;
	}
	
	return true;
}

//Processes file and keeps track of discovered errors
int parse(){
	int count_invalid = 0;
	int line_no = 0;
	
	// Discard lines until '...' (i.e. end of header block)
	while (true){
		std::getline(std::cin, line);
		line_no++;
		if (line == "...") break;
	} 
	
	// Real checking
	while(getline(std::cin, line)){
		line_no++;
		int temp = line.find('\t');
		std::string jyut_string = line.substr(temp+1, line.find('\t', temp + 1) - temp);
		if (!process(jyut_string)) {
			std::cerr << "[L" << line_no << "] Invalid Jyutping detected: " << jyut_string << std::endl;
			count_invalid++;
		} 
	}

	return count_invalid;
}

// Wrapper for command line interface
int main (int argc, char** argv) {
	
	std::ios_base::sync_with_stdio(false);
	std::cin.tie(NULL);
	
	if (argc == 2){
		dict = argv[1];
		std::cout << "Loading " << dict << std::endl;
	} else {
		std::cerr << "Invalid input format" << std::endl;
		std::cerr << "Use ./checker input_file_name.yaml" << std::endl;
		return 1;
	}
	
	std::freopen(dict.c_str(), "r", stdin); // redirect file to stdin stream
	return parse();
}
