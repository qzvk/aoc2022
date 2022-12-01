.global _start

.extern show_qword

.text

_start:
    mov rax, 0 # current counter
    mov r8, 0 # max counter
    lea rsi, [rip + calories] # Load calories ptr
    mov rdx, 15 # element counter

loop_start:
    test rdx, rdx # check the counter
    jz loop_end # if zero, stop
    dec rdx # decrement counter

    mov cx, [rsi] # load next calorie value
    add rsi, 2 # increment pointer

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

calories:
    .word 1000
    .word 2000
    .word 3000
    .word 0
    .word 4000
    .word 0
    .word 5000
    .word 6000
    .word 0
    .word 7000
    .word 8000
    .word 9000
    .word 0
    .word 10000
    .word 0
