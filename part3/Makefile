# Makefile for part2
all: rx-cc

rx-cc: lex.yy.o part3.tab.o part3_helpers.o
	g++ -o $@ $^

part3_helpers.o: part3_helpers.c part3_helpers.hpp
	g++ -c -o $@ part3_helpers.cpp

part3.tab.o: part3.tab.cpp part3.tab.hpp
	g++ -c -o $@ part3.tab.cpp

lex.yy.o: lex.yy.c part3.tab.hpp
	g++ -c -o $@ lex.yy.c

lex.yy.c: part1.lex part3.tab.hpp part3_helpers.hpp
	flex part1.lex

part3.tab.cpp part3.tab.hpp: part2.ypp part3_helpers.hpp
	bison -d part3.ypp

.PHONY: clean
clean:
	rm -f rx-cc *.o *.tab.* lex.yy.c
