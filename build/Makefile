.PHONY: all clean

all: one

clean:
	rm -r $(shell ls | grep -v Makefile)

one: ../one.S
	clang -masm=intel -nostdlib $^ -o $@
