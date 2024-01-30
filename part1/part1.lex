%{
#include <stdio.h>
void showToken(char *);
void printString();
void yyerror();
%}

%option yylineno noyywrap
%option outfile="part1.c" header-file="part1.h"

whitespace  ([\t\r\n ])
reserved    (int|float|void|write|read|optional|while|do|if|then|else|return)
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
signs       (\(|\)|\{|\}|,|:|;)
comment     (#.*)

%%
{reserved}                  printf("<%s>", yytext);
{signs}                     printf("%s", yytext);
{id}                        showToken("id");
{integernum}                showToken("integernum");
{realnum}                   showToken("realnum");
{str}                       printString();
{relop}                     showToken("relop");
{addop}                     showToken("addop");
{mulop}                     showToken("mulop");
{assign}                    showToken("assign");
{and}                       showToken("and");
{or}                        showToken("or");
{not}                       showToken("not");
{whitespace}                printf("%s", yytext);
{comment}                   ;
.                           yyerror();
%%

void showToken(char *name)
{
    printf("<%s,%s>", name, yytext);
}


// magic number are bad
void printString()
{
    int length = strlen(yytext);
    char *newStr = malloc(length - 1);
    strncpy(newStr, yytext + 1, length - 2);
    newStr[length - 2] = '\0';
    printf("<str,%s>", newStr);
    free(newStr);
}

void yyerror()
{
    printf("\nLexical error: '%s' in line number %d\n", yytext, yylineno);
    exit(1);
}