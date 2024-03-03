# Makefile for part2
all: part2

part2: lex.yy.o part2.tab.o part2_helpers.o
	g++ -o $@ $^

lex.yy.o: lex.yy.c part2.hpp part2.tab.hpp
	g++ -c -o $@ lex.yy.c

lex.yy.c: part1.lex
	flex part1.lex

part2.tab.o: part2.tab.cpp part2.tab.hpp
	g++ -c -o $@ part2.tab.cpp

part2.tab.cpp part2.tab.hpp: part2.ypp part2.hpp part2_helpers.h
	bison -d part2.ypp

part2_helpers.o: part2_helpers.c part2_helpers.h
	g++ -c -o $@ part2_helpers.c

.PHONY: clean
clean:
	rm -f part2 *.o *.tab.* lex.yy.c
