/* 046266 Compilation Methods, EE Faculty, Technion                        */
/* part2_helpers.c - Helper functions for project part 2 - implementation  */

#include "part2_helpers.h"

extern int yyparse (void);
//
threeOpCode::threeOpCode(std::string op, std::string arg1, std::string arg2, std::string result) : 
                        opcode(op), arg1(arg1), arg2(arg2), result(result) {}

std::vector<threeOpCode> threeOpCodeList;


/**************************************************************************/
/*                           Main of parser                               */
/**************************************************************************/
int main(void)
{
    int rc;
#if YYDEBUG
    yydebug=1;
#endif
    rc = yyparse();
    if (rc == 0) { // Parsed successfully
    ;
    }
    return rc;
}
