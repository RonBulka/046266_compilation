%{
#include <stdio.h>
void showToken(char *);
%}

%option yylineno noyywrap
%option   outfile="flex_example1.c" header-file="flex_example1.h"

digit       ([0-9])
letter      ([a-zA-Z])
whitespace  ([\t\n ])
reserved    (int|float|void|write|read|optional|while|do|if|then|else|return)
id          ({letter}({letter}|{digit}|_)*)
integernum  ({digit}+)
realnum     ({digit}+\.{digit}+)
str         ()
relop       (==|<>|<|<=|>|>=)
addop       (\+|-)
mulop       (\*|/)
assign      (=)
and         (&&)
or          (\|\|)
not         (!)
signs       (\(|\)|\{|\}|,|:|;)

// need to do:
// strings
// errors
// comments
// choose the correct option for nums


%%
{reserved}                  printf("<%s>", yytext);
{integernum}                showToken("integernum");
{realnum}                   showToken("realnum");
{id}                        showToken("id");
{relop}                     showToken("relop");
{addop}                     showToken("addop");
{mulop}                     showToken("mulop");
{assign}                    showToken("assign");
{and}                       showToken("and");
{or}                        showToken("or");
{not}                       showToken("not");
{str}                       showToken("str");
{signs}                     printf(yytext);
{whitespace}                printf(yytext);
.                           printf("lex fails to recognize this (%s)!\n", yytext);
%%

void showToken(char *name)
{
    printf("<%s,%s>", name, yytext);
}

