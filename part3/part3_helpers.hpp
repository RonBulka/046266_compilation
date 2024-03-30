/* 046266 Compilation Methods, EE Faculty, Technion                        */

#ifndef _PART3_HELPERS_H_
#define _PART3_HELPERS_H_

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

typedef enum {
    void_t = 0,
    int_t = 1, 
    float_t = 2 
} Type;

// make a string out of an int
string intToString(double num);

// merge two lists for backpatching
template <typename T>
vector<T> merge(vector<T>& lst1, vector<T>& lst2){
    vector<T> result = lst1;
    result.insert(result.end(), lst2.begin(), lst2.end());
    return result;
}

// Definition of a token's fields
typedef struct {
    string str; // Name of the token (in case it represents an identifier)
    Type type;  // Type of the token
    int offset; // Offset in memory
    int quad; // Number of line the token's expression will be printed at in the .rsk file
    int regNum; // Number of the register the token is assigned
    string value; // Value of the token (in case it represents a constant)
    // function related attributes
    vector<Type> paramTypes;    // List of parameters types in function's definition
    vector<int> paramRegs;      // List of parameters' registers number in function's definition
    vector<string> paramIds;    // List of parameters' ids in function's definition

    // Exp attributes
    vector<int> nextList;
    vector<int> trueList;
    vector<int> falseList;
} yystype;

// Definition of Symbol struct
class Symbol {
    public:
        map<int, Type> type; // the type of the symbol in each depth
        map<int, int> offset;// the offset of the symbol in each depth
        int depth; //the depth in which the most inner symbol is implemented in.
};

// Definition of Function class
class Function {
    public:
        // Indicator for if the function has been implemented or not
        bool implemented;
        // The address of the implementation of the function in the buffer
        int address;
        // the starting index of optional parameters
        int optionalParamsStart;
        // max number of optional parameters
        int optionalParamsNum;
        // The types of the parameters of the function
        vector<Type> paramTypes;
        // List of all the addresses of the function calls
        vector<int> callingAddresses;
        // list of optional parameters types
        vector<Type> optionalParamsTypes;
        // list of optional parameters values
        // vector<string> optionalParamsValues;
        // The return type of the function
        Type returnType;
};

// Definition of Buffer class
class Buffer {
        vector<string> data;
    public:
        // Constructor of Buffer class
        Buffer();
        // Destructor of Buffer class
        ~Buffer();
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

/*******************************************GLOBALS*******************************************/
static Buffer * buffer; // buffer for the code generation
static Buffer mainBuffer; // buffer for the main function
static map<string, Symbol> symbolTable; // Table that contains all symbols implemented in prog
static map<string, Function> functionTable; // Table that contains all functions - each function with it's members
static Type currentReturnType;

/*
* I0 - reserved for return address
* I1 - reserved for the beginning of the stack frame
* I2 - reserved for the top of the the stack frame
*/
static int currentScopeRegsNumInt = 3;

/*
* F0 - reserved for return address
* F1 - reserved for the beginning of the stack frame
* F2 - reserved for the top of the the stack frame
*/
static int currentScopeRegsNumFloat = 3;

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
// order of the optional parameters in the current function
static vector<string> currentOptionalParamInsertionOrder;
// temporary order of the optional parameters in the current function
static vector<string> tmpOptionalParamInsertionOrder;
// values of the optional parameters in the current function
static vector<string> currentOptionalParamValues;
// temporary values of the optional parameters in the current function
static vector<string> tmpOptionalParamValues;
/**********************************************************************************************/

#define YYSTYPE yystype
#endif