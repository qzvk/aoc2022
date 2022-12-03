.PHONY: all clean

all: one one_part_two two two_part_two

clean:
	rm -r $(shell ls | grep -v Makefile)

one: one.o one_data.o show_qword.o
	ld.lld $^ -o $@

one_part_two: one_part_two.o one_data.o show_qword.o
	ld.lld $^ -o $@

two: two.o two_data.o show_qword.o
	ld.lld $^ -o $@

two_part_two: two_part_two.o two_data.o show_qword.o
	ld.lld $^ -o $@

%.o: ../%.S
	clang -nostdlib -masm=intel -g -c $^ -o $@
