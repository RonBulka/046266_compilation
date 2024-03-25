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
{int}                       {yylval.str = NULL;
                                return INT;}
{float}                     {yylval.str = NULL;
                                return FLOAT;}
{void}                      {yylval.str = NULL;
                                return VOID;}
{write}                     {yylval.str = NULL;
                                return WRITE_;}
{read}                      {yylval.str = NULL;
                                return READ_;}
{optional}                  {yylval.str = NULL;
                                return OPTIONAL;}
{while}                     {yylval.str = NULL;
                                return WHILE;}
{do}                        {yylval.str = NULL;
                                return DO;}
{if}                        {yylval.str = NULL;
                                return IF;}
{then}                      {yylval.str = NULL;
                                return THEN;}
{else}                      {yylval.str = NULL;
                                return ELSE;}
{return}                    {yylval.str = NULL;
                                return RETURN_;}
{lparen}                    {yylval.str = NULL; 
                                return LPAREN;}
{rparen}                    {yylval.str = NULL; 
                                return RPAREN;}
{lbrace}                    {yylval.str = NULL; 
                                return LBRACE;}
{rbrace}                    {yylval.str = NULL; 
                                return RBRACE;}
{comma}                     {yylval.str = NULL; 
                                return COMMA;}
{colon}                     {yylval.str = NULL; 
                                return COLON;}
{semicolon}                 {yylval.str = NULL;
                                return SEMICOLON;}
{id}                        {yylval.str = strdup(yytext); 
                                return ID;}
{integernum}                {yylval.str = strdup(yytext); 
                                return INTEGERNUM;}
{realnum}                   {yylval.str = strdup(yytext); 
                                return REALNUM;}
{str}                       {yylval.str = strdup(removeQuotes().c_str()); 
                                return STR;}
{relop}                     {yylval.str = strdup(yytext); 
                                return RELOP;}
{addop}                     {yylval.str = strdup(yytext); 
                                return ADDOP;}
{mulop}                     {yylval.str = strdup(yytext); 
                                return MULOP;}
{assign}                    {yylval.str = strdup(yytext); 
                                return ASSIGN;}
{and}                       {yylval.str = strdup(yytext); 
                                return AND;}
{or}                        {yylval.str = strdup(yytext); 
                                return OR;}
{not}                       {yylval.str = strdup(yytext); 
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