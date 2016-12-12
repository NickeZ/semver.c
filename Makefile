CC      ?= cc
CFLAGS   = -Wall -Wextra -pedantic -Wno-unused-function -g
VALGRIND = valgrind
RM       = rm -f

%.o: %.c
	$(CC) -std=c89 $(CFLAGS) -c -o $@ $^

test: semver.o semver_test.c
	$(CC) -std=c99 $(CFLAGS) -o $@ $^
	./test

unittest: semver_unit.c
	$(CC) -std=c89 $(CFLAGS) -o $@ $^
	./unittest

valgrind: test
	$(VALGRIND) --leak-check=full --error-exitcode=1 ./$<

clean:
	$(RM) *.o
	$(RM) test

.PHONY: test unittest
