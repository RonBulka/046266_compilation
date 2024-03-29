%{
#include "part3_helpers.hpp"
#include "part3.tab.hpp"

#define CUT_QUOTES 2

using namespace std;

string removeQuotes();
void yyerror();
%}

%option yylineno noyywrap

whitespace  ([\t\r\n ])
int         (int)
float       (float)
void        (void)
write       (write)
read        (read)
optional    (optional)
while       (while)
do          (do)
if          (if)
then        (then)
else        (else)
return      (return)
id          ([a-zA-Z]([a-zA-Z]|[0-9]|_)*)
integernum  ([0-9]+)
realnum     ([0-9]+\.[0-9]+)
str         (\"(\\[nt"]|[^"\\\r\n])*\")
relop       (==|<>|<|<=|>|>=)
addop       (\+|-)
mulop       (\*|\/)
assign      (=)
and         (&&)
or          (\|\|)
not         (!)
rparen      (\))
lparen      (\()
rbrace      (\})
lbrace      (\{)
comma       (,)
colon       (:)
semicolon   (;)
comment     (#.*)



%%
{int}                       { return INT; }
{float}                     { return FLOAT; }
{void}                      { return VOID; }
{write}                     { return WRITE_; }
{read}                      { return READ_; }
{optional}                  { return OPTIONAL; }
{while}                     { return WHILE; }
{do}                        { return DO; }
{if}                        { return IF; }
{then}                      { return THEN; }
{else}                      { return ELSE; }
{return}                    { return RETURN_; }
{lparen}                    { return LPAREN; }
{rparen}                    { return RPAREN; }
{lbrace}                    { cerr << "LBRACE" << endl;
                                return LBRACE; }
{rbrace}                    { return RBRACE; }
{comma}                     { return COMMA; }
{colon}                     { return COLON; }
{semicolon}                 { return SEMICOLON; }
{id}                        {yylval.str = yytext; 
                                return ID;}
{integernum}                {yylval.str = yytext; 
                                return INTEGERNUM;}
{realnum}                   {yylval.str = yytext; 
                                return REALNUM;}
{str}                       {yylval.str = removeQuotes(); 
                                return STR;}
{relop}                     {yylval.str = yytext; 
                                return RELOP;}
{addop}                     {yylval.str = yytext; 
                                return ADDOP;}
{mulop}                     {yylval.str = yytext; 
                                return MULOP;}
{assign}                    {yylval.str = yytext; 
                                return ASSIGN;}
{and}                       {yylval.str = yytext; 
                                return AND;}
{or}                        {yylval.str = yytext; 
                                return OR;}
{not}                       {yylval.str = yytext; 
                                return NOT;}
{whitespace}                ;
{comment}                   ;
.                           yyerror();
%%


string removeQuotes()
{
    string str = yytext;
    str = str.substr(1, str.length() - CUT_QUOTES);
    return str;
}

void yyerror()
{
    printf("Lexical error: '%s' in line number %d\n", yytext, yylineno);
    exit(LEXICAL_ERROR);
}