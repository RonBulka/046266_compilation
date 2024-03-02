%{
#include "part2.hpp"
#include "part2.tab.h"

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
/* reserved    (int|float|void|write|read|optional|while|do|if|then|else|return) */
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
/* signs       (\(|\)|\{|\}|,|:|;) */
rparen      (\))
lparen      (\()
rbrace      (\})
lbrace      (\{)
comma       (,)
colon       (:)
semicolon   (;)
comment     (#.*)

/* 
/* {reserved}                  {yylval.c = strdup(yytext); 
                             return RESERVED;}

{int}                       {yylval.c = strdup(yytext);
                                return INT;}
{float}                     {yylval.c = strdup(yytext);
                                return FLOAT;}
{void}                      {yylval.c = strdup(yytext);
                                return VOID;}
{write}                     {yylval.c = strdup(yytext);
                                return WRITE_;}
{read}                      {yylval.c = strdup(yytext);
                                return READ_;}
{optional}                  {yylval.c = strdup(yytext);
                                return OPTIONAL;}
{while}                     {yylval.c = strdup(yytext);
                                return WHILE;}
{do}                        {yylval.c = strdup(yytext);
                                return DO;}
{if}                        {yylval.c = strdup(yytext);
                                return IF;}
{then}                      {yylval.c = strdup(yytext);
                                return THEN;}
{else}                      {yylval.c = strdup(yytext);
                                return ELSE;}
{return}                    {yylval.c = strdup(yytext);
                                return RETURN_;}
/* {signs}                     {yylval.c = strdup(yytext); 
                             return SIGNS;} 
{lparen}                    {yylval.c = strdup(yytext); 
                                return LPAREN;}
{rparen}                    {yylval.c = strdup(yytext); 
                                return RPAREN;}
{lbrace}                    {yylval.c = strdup(yytext); 
                                return LBRACE;}
{rbrace}                    {yylval.c = strdup(yytext); 
                                return RBRACE;}
{comma}                     {yylval.c = strdup(yytext); 
                                return COMMA;}
{colon}                     {yylval.c = strdup(yytext); 
                                return COLON;}
{semicolon}                 {yylval.c = strdup(yytext); 
                                return SEMICOLON;}
{id}                        {yylval.c = strdup(yytext); 
                                return ID;}
{integernum}                {yylval.i = atoi(yytext); 
                                return INTEGERNUM;}
{realnum}                   {yylval.f = atof(yytext); 
                                return REALNUM;}
{str}                       {yylval.c = removeQuotes().c_str(); 
                                return STR;}
{relop}                     {yylval.c = strdup(yytext); 
                                return RELOP;}
{addop}                     {yylval.c = strdup(yytext); 
                                return ADDOP;}
{mulop}                     {yylval.c = strdup(yytext); 
                                return MULOP;}
{assign}                    {yylval.c = strdup(yytext); 
                                return ASSIGN;}
{and}                       {yylval.c = strdup(yytext); 
                                return AND;}
{or}                        {yylval.c = strdup(yytext); 
                                return OR;}
{not}                       {yylval.c = strdup(yytext); 
                                return NOT;}
{whitespace}                ; /* maybe needed later 
{comment}                   ;
.                           yyerror();
*/

%%
{int}                       {yylval.node = makeNode("int", NULL, NULL);
                                return INT;}
{float}                     {yylval.node = makeNode("float", NULL, NULL);
                                return FLOAT;}
{void}                      {yylval.node = makeNode("void", NULL, NULL);
                                return VOID;}
{write}                     {yylval.node = makeNode("write", NULL, NULL);
                                return WRITE_;}
{read}                      {yylval.node = makeNode("read", NULL, NULL);
                                return READ_;}
{optional}                  {yylval.node = makeNode("optional", NULL, NULL);
                                return OPTIONAL;}
{while}                     {yylval.node = makeNode("while", NULL, NULL);
                                return WHILE;}
{do}                        {yylval.node = makeNode("do", NULL, NULL);
                                return DO;}
{if}                        {yylval.node = makeNode("if", NULL, NULL);
                                return IF;}
{then}                      {yylval.node = makeNode("then", NULL, NULL);
                                return THEN;}
{else}                      {yylval.node = makeNode("else", NULL, NULL);
                                return ELSE;}
{return}                    {yylval.node = makeNode("return", NULL, NULL);
                                return RETURN_;}
{lparen}                    {yylval.node = makeNode("(", NULL, NULL); 
                                return LPAREN;}
{rparen}                    {yylval.node = makeNode(")", NULL, NULL); 
                                return RPAREN;}
{lbrace}                    {yylval.node = makeNode("{", NULL, NULL); 
                                return LBRACE;}
{rbrace}                    {yylval.node = makeNode("}", NULL, NULL); 
                                return RBRACE;}
{comma}                     {yylval.node = makeNode(",", NULL, NULL); 
                                return COMMA;}
{colon}                     {yylval.node = makeNode(":", NULL, NULL); 
                                return COLON;}
{semicolon}                 {yylval.node = makeNode(";", NULL, NULL)
                                return SEMICOLON;}
{id}                        {yylval.node = makeNode("id", yytext, NULL); 
                                return ID;}
{integernum}                {yylval.node = makeNode("integernum", yytext, NULL); 
                                return INTEGERNUM;}
{realnum}                   {yylval.node = makeNode("realnum", yytext, NULL); 
                                return REALNUM;}
{str}                       {yylval.node = makeNode("str", removeQuotes().c_str(), NULL); 
                                return STR;}
{relop}                     {yylval.node = makeNode("relop", yytext, NULL); 
                                return RELOP;}
{addop}                     {yylval.node = makeNode("addop", yytext, NULL); 
                                return ADDOP;}
{mulop}                     {yylval.node = makeNode("mulop", yytext, NULL); 
                                return MULOP;}
{assign}                    {yylval.node = makeNode("assign", yytext, NULL); 
                                return ASSIGN;}
{and}                       {yylval.node = makeNode("and", yytext, NULL); 
                                return AND;}
{or}                        {yylval.node = makeNode("or", yytext, NULL); 
                                return OR;}
{not}                       {yylval.node = makeNode("not", yytext, NULL); 
                                return NOT;}
{whitespace}                ; /* maybe needed later */
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
    printf("\nLexical error: '%s' in line number %d\n", yytext, yylineno);
    exit(1);
}