CC = gcc
CCFLAGS = -g -Wall -std=c99
CCLINK = $(CC)
OBJS = part1.o
EXEC = part1
RM = rm -rf *.o part1.c part1.h

$(EXEC): $(OBJS)
	$(CCLINK) $(CCFLAGS) -o $(EXEC) $(OBJS) -ll

part1.o: part1.c part1.h
	$(CC) $(CCFLAGS) -c part1.c

part1.c: part1.lex
	flex part1.lex

clean:
	$(RM)