/* 046266 Compilation Methods, EE Faculty, Technion                        */

#include "part3_helpers.hpp"

extern void yylex_destroy();
extern int yyparse (void);
extern void printOperationalError(string error);
extern FILE *yyin;
extern int yydebug;

/**************************************************************************/
/*                           helper functions                             */
/**************************************************************************/

string intToString(double num) {
    stringstream ss;
    ss << num;
    return ss.str();
}

template <typename T>
vector<T> merge(vector<T>& lst1, vector<T>& lst2) {
    vector<T> result = lst1;
    result.insert(result.end(), lst2.begin(), lst2.end());
    return result;
}

/**************************************************************************/
/*                        Buffer Implementation                           */
/**************************************************************************/

Buffer::Buffer(){
    data.clear();
}

void Buffer::emit(const string& str) {
    data.push_back(str);
}

void Buffer::emit_front(const string& str) {
    data.insert(data.begin(), str);
}

void Buffer::backpatch(vector<int> lst, int line) {
    for (unsigned i=0; i < lst.size(); ++i) {
        // -1 because the list is 1-based
        int index = lst[i] - 1;
        data[index] += intToString(line) + " ";
    }
}

int Buffer::nextquad() {
    return data.size() + 1;
}

string Buffer::printBuffer() {
    string out = "";
    for (int i=0; i<data.size(); ++i) {
        out += data[i] + "\n";
    }
    return out;
}


/**************************************************************************/
/*                           Main of parser                               */
/**************************************************************************/
int main(int argc, char *argv[])
{

    if (argc != 2) {
		printOperationalError("invalid number of arguments");
	}
	string inputFileName = argv[1];

	extern FILE *yyin;
	// Open the input file 
	yyin = fopen(argv[1], "r");
	if (yyin == NULL) {
		printOperationalError("cannot open input file");
	}
	size_t lastindex;

	lastindex = inputFileName.find_last_of(".");
	if (inputFileName.substr(lastindex) != ".cmm") {
		printOperationalError("invalid file type. expecting '.cmm' extension");
	}
	
    // Initialize the buffer
	buffer = &mainBuffer;

    int rc;

    rc = yyparse();
    if (rc == 0) { // Parsed successfully

        mainBuffer.emit_front("</header>");

        string imp = "<implemented>";
        string uimp = "<unimplemented>";

        for(map<string, Function>::iterator it = functionTable.begin(); it != functionTable.end(); it++) {
            if (it->second.defined) {
                // Add the function to the implemented list (function name, address of implementation)
                imp += " " + it->first + "," + intToString(it->second.address);
            }
            else {
                // Add the function to the unimplemented list (function name, list of calling addresses)
                uimp += " " + it->first;
                for (int i = 0; i < it->second.callingAddresses.size(); i++) {
                    uimp += "," + intToString(it->second.callingAddresses[i]);
                }
            }
        }

        mainBuffer.emit_front(imp);
        mainBuffer.emit_front(uimp);

        mainBuffer.emit_front("<header>");

        ofstream rskFile;
        string outputFileName;
        outputFileName = inputFileName.substr(0, lastindex) + ".rsk";
        size_t found = outputFileName.find_last_of("/\\");
        outputFileName = outputFileName.substr(found+1);

        rskFile.open(outputFileName.c_str());

        rskFile << mainBuffer.printBuffer();
        rskFile.close();

    }
    yylex_destroy();
    return rc;
}
