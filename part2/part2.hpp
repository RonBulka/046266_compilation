#ifndef PART2
#define PART2

    #include <iostream>
    #include <string>
    #include "part2_helpers.h"

    // typedef union
    // {
    //     int i;
    //     float f;
    //     std::string c;
    // }u;
    
    // #define YYSTYPE u

    typedef union {
        ParserNode* node;
    } STYPE;

    #define YYSTYPE STYPE
    
#endif
