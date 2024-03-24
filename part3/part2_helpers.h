/* 046266 Compilation Methods, EE Faculty, Technion                        */
/* part2_helpers.h - Helper functions for project part 2 - API definitions */

#ifndef COMMON_H
#define COMMON_H
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <string>
#include <vector>
#include <iostream>
#include <map>

#ifdef __cplusplus
extern "C" {
#endif
using namespace std;



class threeOpCode {
private:
    std::string opcode;
    std::string arg1;
    std::string arg2;
    std::string result;
public:
    threeOpCode(std::string op, std::string arg1,
                std::string arg2, std::string result);
    std::string getOp();
    std::string getArg1();
    std::string getArg2();
    std::string getResult();
};

class SymbolTableEntry {
    private:
        std::string name;
        std::string type;
        std::string value;
        std::string scope;
        std::string offset;
    public:
        SymbolTableEntry(std::string name, std::string type, std::string value, std::string scope, std::string offset) : 
                    name(name), type(type), value(value), scope(scope), offset(offset) {}
        std::string getName();
        std::string getType();
        std::string getValue();
        std::string getScope();
        std::string getOffset();
};

class SymbolTable {
    private:
        std::map<std::string, SymbolTableEntry> table;
    public:
        SymbolTable(std::map<std::string, SymbolTableEntry> table) : table(table) {}
        std::map<std::string, SymbolTableEntry> getTable();
};

class blkTable {
    private:
        map<string, SymbolTableEntry>* fatherTable;
        map<string, SymbolTableEntry>* currTable;
    public:
        blkTable(map<string, SymbolTable>* fatherTable);
        void addEntry(SymbolTableEntry entry);
        bool searchTable(string name);

};

class codeVector {
    private:
        std::vector<threeOpCode> code;
        SymbolTable* functionTable;
    public:
        codeVector(std::vector<threeOpCode> code, SymbolTable* symbolTable) : code(code), symbolTable(symbolTable) {}
        std::vector<threeOpCode> getCode();
        SymbolTable* getSymbolTable();
        void addCode(threeOpCode code);

};

class Register {
    private:
        string name;
    public:
        Register(std::string name);
        string getName();


};

class RegisterVectorI {
    private:
        vector<Register> registers;
    public:
        RegisterVectorI();
        vector<Register> getRegisters();
        void addRegister(Register reg);
        Register popRegister();
};

class RegisterVectorF {
    private:
        vector<Register> registers;
    public:
        RegisterVectorF();
        vector<Register> getRegisters();
        void addRegister(Register reg);
        Register popRegister();
};

class PROGRAMnode{

};

class FDEFSnode{

};

class FUNC_DEC_APInode{

};

class FUNC_DEC_ARGLIST_OPTnode{

};

class DCL_OPTnode{

};

class FUNC_DEF_APInode{

};

class FUNC_DEF_ARGLIST_OPTnode{

};

class DCL_OPT_VALnode{

};

class FUNC_ARGLISTnode{

};

class BLKnode{
    private:
        blkTable* table;
};

class DCLnode{
    private:
        string type;
        vector<string> names;
};

class TYPEnode{
    private:
        string type;
    public:
        TYPEnode(string type);
        string getType();
};

class STMT_LISTnode{

};

class STMTnode{
    private:
        vector<int> nextList;

};

class RETURNnode{

};

class WRITEnode{

};

class READnode{

};

class ASSNnode{

};

class LVALnode{
    private:
        string name;
        string type;
        Register* reg;

};

class CNTRLnode{
    private:
        vector<int> nextList;
};

class BEXPnode{
    private:
        vector<int> trueList;
        vector<int> falseList;
    public:
        BEXPnode(vector<int> trueList, vector<int> falseList) : trueList(trueList), falseList(falseList) {}
        vector<int> getTrueList();
        vector<int> getFalseList();
        void setTrueList(vector<int> trueList);
        void setFalseList(vector<int> falseList);
        void mergeTrueList(vector<int> trueList);
        void mergeFalseList(vector<int> falseList);
};

class EXPnode{
    private:
        string type;
        bool isConst;
        string value;
        Register* reg;

};

class NUMnode{
    private:
        string type;
        string value;
};

class CALLnode{
    private:
        string name;
        vector<string> args;
};

class CALL_ARGSnode{
    private:
        vector<string> args;
};

class CALL_ARGLISTnode{
    private:
        vector<string> args;
};

class Nnode{
    private:
        vector<int> nextList;
};

#ifdef __cplusplus
} // extern "C"
#endif

#endif //COMMON_H
