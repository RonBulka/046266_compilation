# Makefile for truthval example
all: truthval

truthval: lex.yy.o truthval.tab.o
	g++ -o $@ $^

lex.yy.o: lex.yy.c attributes.h truthval.tab.hpp
	g++ -c -o $@ lex.yy.c

lex.yy.c: truthval.lex
	flex truthval.lex

truthval.tab.o: truthval.tab.cpp truthval.tab.hpp
	g++ -c -o $@ truthval.tab.cpp

truthval.tab.cpp truthval.tab.hpp: truthval.ypp attributes.h
	bison -d truthval.ypp

.PHONY: clean
clean:
	rm -f truthval *.o *.tab.* lex.yy.c
