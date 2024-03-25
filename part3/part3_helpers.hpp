/* 046266 Compilation Methods, EE Faculty, Technion                        */

#ifndef _PART3_HELPER_H_
#define _PART3_HELPER_H_

#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <sstream>
#include <algorithm>

#define LEXICAL_ERROR 1
#define SYNTAX_ERROR 2
#define SEMANTIC_ERROR 3
#define OPERATIONAL_ERROR 9

using namespace std;

typedef enum {int_t = 1 , float_t = 2, void_t = 0} Type;

// make a string out of an int
string intToString(double num);

// merge two lists for backpatching
template <typename T>
vector<T> merge(vector<T>& lst1, vector<T>& lst2);

// Definition of a token's fields
typedef struct {
    // Name of the token (in case it represents an identifier)
    string str;
    // Type of the token
    Type type;
    // Offset in memory
    int offset;
    vector<int> nextList; 
    vector<int> trueList;
    vector<int> falseList;
    // Number of line the token's expression will be printed at in the .rsk file
    int quad;
    // Number of the register the token is assigned
    int regNum;
    // List of parameters types in function's definition
    vector<Type> paramTypes;
    // List of parameters registers numbers in function's definition
    vector<int> paramRegs; 
} yystype;

// Definition of Symbol struct
class Symbol {
    public:
        map<int, Type> type; // the type of the symbol in each depth
        map<int, int> offset;// the offset of the symbol in each depth
        int depth; //the depth in which the most inner symbol is defined in.
};

// Definition of Function class
class Function {
    public:
        // The address of the implementation of the function in the buffer
        int address;
        // The return type of the function
        Type returnType;
        // The types of the parameters of the function
        vector<Type> paramTypes;
        // List of all the addresses of the function calls
        vector<int> callingAddresses;
        // Indicator for if the function has been defined or not
        bool defined;
        

        // might need to add more to support optional parameters
};

// Definition of Buffer class
class Buffer {
        vector<string> data;
    public:
        // Constructor of Buffer class
        Buffer();
        // Emit a command as a new line at the end of the buffer
        void emit(const string& str);
        // Emit a command as a new line at the beginning of the buffer
        void emit_front(const string& str);
        // Backpatch a list of lines with a new line
        void backpatch(vector<int> lst, int line);
        // Return the next empty line in the buffer
        int nextquad();
        // Print all the data in the buffer
        string printBuffer();
};

// Global variables
// buffer for the code generation
static Buffer * buffer;
// buffer for the main function
static Buffer mainBuffer;
static map<string, Symbol> symbolTable;
static map<string, Function> functionTable;
static int currentReturnType;
/*
* I0 - reserved for return address
* I1 - reserved for the beginning of the stack frame
* I2 - reserved for the top of the the stack frame
*/
static int currectScopeRegsNumInt = 3;
/*
* F0 - reserved for return address
* F1 - reserved for the beginning of the stack frame
* F2 - reserved for the top of the the stack frame
*/
static int currectScopeRegsNumFloat = 3;
// offset of the current scope
static int currentScopeOffset = 0; 
// offset of the previous scope
static int previousScopeOffset = 0;
// depth of the current block
static int currentBlockDepth = 0;
// order of the parameters in the current function
static vector<string> currentParamInsertionOrder;
// temporary order of the parameters in the current function
static vector<string> tmpParamInsertionOrder;

#define YYSTYPE yystype 
#endif