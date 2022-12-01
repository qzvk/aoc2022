# Solution for day 1 part 1
#
# This works by running over each entry in the data, taking the sum of consecutive values.
# While iterating over the input, a zero is interpreted as an 'end of block.' At this point
# The current sum is compared to a 'max counter' and, if larger, is used as the new max.
#
# By the end, the max counter contains the greatest sum of consecutive values.

.global _start

.extern show_qword
.extern input
.extern input_length

.text

_start:
    mov rax, 0 # current counter
    mov r8, 0 # max counter
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
    mov r9, rax # copy counter out of rax
    mov rax, 0 # clear the counter
    cmp r9, r8 # compare current and max counter
    jle loop_start # if current <= max: go to start of loop
    mov r8, r9 # otherwise, update max value
    jmp loop_start # go back to start

loop_end:
    mov rdi, r8
    call show_qword # Print max counter to stdout.

    # Exit system call
    mov rax, 60
    mov rdi, 0
    syscall
