%{
#include <iostream>
#include "attributes.h"
#include "truthval.tab.hpp"
using namespace std;
%}

%option yylineno
%option noyywrap

%%

"true"	{ yylval.constVal = 1; return tkconst; }
"false"	{ yylval.constVal = 0; return tkconst; }
"and"	return tkand;
"or"	return tkor;
"("	return tklp;
")"	return tkrp;
";" return ';';
[ \n\t]	;	// Whitespace
. { cerr << "Invalid input: `" << yytext << "'" << endl; }
%%
