.PHONY: all clean

all: one

clean:
	rm -r $(shell ls | grep -v Makefile)

one: one.o show_qword.o
	ld.lld $^ -o $@

%.o: ../%.S
	clang -nostdlib -masm=intel -g -c $^ -o $@
