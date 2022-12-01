# Solution for day 1 part 2
#
# This works the same as d1p1 except it tracks the three highest values, summing them at the end.
# At the end of a block, the block counter is 'sorted' into the set of greatest values.
# At the end of input, these three values are summed.

.global _start

.extern show_qword
.extern input
.extern input_length

.text

_start:
    mov rax, 0 # current counter
    mov r9, 0 # max counter
    mov r10, 0 # 2nd max counter
    mov r11, 0 # 3rd max counter
    lea rsi, [rip + input] # Load calories ptr
    mov dx, [rip + input_length] # load length

loop_start:
    test rdx, rdx # check the counter
    jz loop_end # if zero, stop
    dec rdx # decrement counter

    mov ecx, [rsi] # load next calorie value
    add rsi, 4 # increment pointer

    test rcx, rcx # check loaded value
    jz end_of_block # if zero, its the end of a value block

    add rax, rcx # otherwise, add it to the counter
    jmp loop_start # go back to start of loop

end_of_block:
    mov r8, rax # copy counter out of rax
    mov rax, 0 # clear the counter

    cmp r8, r9
    jle check_second_max
    mov r11, r10
    mov r10, r9
    mov r9, r8
    jmp loop_start
check_second_max:
    cmp r8, r10
    jle check_third_max
    mov r11, r10
    mov r10, r8
    jmp loop_start
check_third_max:
    cmp r8, r11
    jle loop_start
    mov r11, r8
    jmp loop_start

loop_end:
    mov rdi, r9
    add rdi, r10
    add rdi, r11
    call show_qword # Print total of max counters to stdout.

    # Exit system call
    mov rax, 60
    mov rdi, 0
    syscall
