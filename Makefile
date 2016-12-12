CC      ?= cc
CFLAGS   = -std=c99 -Ideps -Wall -Wno-unused-function -U__STRICT_ANSI__
VALGRIND = valgrind

test: semver.c semver_test.c
	@$(CC) $(CFLAGS) -o $@ $^
	@./$@

unittest: semver_unit.c
	@$(CC) $(CFLAGS) -o $@ $^
	@./$@

valgrind: ./test
	@$(VALGRIND) --leak-check=full --error-exitcode=1 $^

%.o: %.c
	$(CC) -std=c89 $(CFLAGS) -c -o $@ $^

.PHONY: test
