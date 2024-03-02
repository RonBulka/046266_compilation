# Makefile for example2
all: example2

example2: lex.yy.o example2.tab.o
	g++ -o $@ $^

lex.yy.o: lex.yy.c example2.hpp example2.tab.hpp
	g++ -c -o $@ lex.yy.c

lex.yy.c: example2.lex
	flex example2.lex

example2.tab.o: example2.tab.cpp example2.tab.hpp
	g++ -c -o $@ example2.tab.cpp

example2.tab.cpp example2.tab.hpp: example2.ypp example2.hpp
	bison -d example2.ypp

.PHONY: clean
clean:
	rm -f example2 *.o *.tab.* lex.yy.c
