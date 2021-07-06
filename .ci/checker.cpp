#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <regex>
#include <algorithm>
#include <cstdio>
using namespace std;

bool valid_jyutping(string a){
	//is alphanumeric
	if (!regex_match(a, (regex) "[a-z]+[1-6]")) return false;
	
	//Add more regex rules here
	
	return true;
}

//Strips down a jyutping string into words
bool process(string a){
	istringstream sin(a);
	string word;
	
	while(sin >> word) {
		if (!valid_jyutping(word)) return false;
	}
	
	return true;
}

//Processes file
int parse(){
	string line;
	int count_invalid = 0;
	int line_no = 1;
	
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
	string dict = "";
	
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
