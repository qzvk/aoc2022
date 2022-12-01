.global show_qword

# Print the unsigned integer in RDI to STDOUT.
show_qword:
    test rdi, rdi # check if the input is 0
    jnz nonzero_case # if not, do normal routine

    # Zero case:
    # Write syscall to print 0.
    mov rax, 1 # syscall number
    mov rdi, 1 # file descriptor
    lea rsi, [rip + zero] # buffer
    mov rdx, 2 # count
    syscall
    ret

nonzero_case:
    mov rax, rdi # move input to rax, for use as dividend
    mov r8, 0 # counter for how many bytes we've pushed onto the stack

decode_loop_start:
    test rax, rax # check if number is zero
    jz decode_loop_end # if zero, stop

    mov rdx, 0 # clear upper 64 bits of dividend
    mov rcx, 10
    div rcx # divide RAX by 10
    # RAX contains quotient
    # RDX contains remainder
    add rdx, 48 # add '0' to digit, convert to ASCII char
    push dx # store word on stack
    inc r8 # increase number of bytes pushed

    jmp decode_loop_start
decode_loop_end:

print_loop_start:
    test r8, r8 # check the counter
    jz print_loop_end # exit the loop on zero

    # Print digit
    mov rax, 1 # syscall number
    mov rdi, 1 # file descriptor
    lea rsi, [rsp] # buffer
    mov rdx, 1 # count
    syscall

    add rsp, 2 # pop stack, discard value
    dec r8 # decrement counter
    jmp print_loop_start

print_loop_end:
    # Print newline
    mov rax, 1 # syscall number
    mov rdi, 1 # file descriptor
    lea rsi, [rip + newline] # buffer
    mov rdx, 1 # count
    syscall

    ret

zero:
    .ascii "0"
newline:
    .ascii "\n"
