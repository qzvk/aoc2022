.global _start

.extern rows
.extern row_count
.extern show_qword

_start:
    lea rax, [rows] # Load start pointer &rows[0]
    mov di, [row_count] # Get number of rows
    shl rdi, 1 # Multiply by two (each row has two bytes)
    add rdi, rax # Add pointer to get &rows[row_count]

    mov rbx, 0 # score starts at zero

loop_start:
    cmp rax, rdi # compare start and end pointers
    je loop_end # jump if they're equal

    mov si, [rax] # load from the pointer
    add rax, 2 # increment the pointer

case_5841: # rock - rock
    cmp si, 0x5841
    jne case_5941
    add rbx, 3
    add rbx, 1
    jmp loop_start
case_5941: # rock - paper
    cmp si, 0x5941
    jne case_5A41
    add rbx, 6
    add rbx, 2
    jmp loop_start
case_5A41: # rock - scissors
    cmp si, 0x5A41
    jne case_5842
    # add rbx, 0
    add rbx, 3
    jmp loop_start
case_5842: # paper - rock
    cmp si, 0x5842
    jne case_5942
    # add rbx, 0
    add rbx, 1
    jmp loop_start
case_5942: # paper - paper
    cmp si, 0x5942
    jne case_5A42
    add rbx, 3
    add rbx, 2
    jmp loop_start
case_5A42: # paper - scissors
    cmp si, 0x5A42
    jne case_5843
    add rbx, 6
    add rbx, 3
    jmp loop_start
case_5843: # scissors - rock
    cmp si, 0x5843
    jne case_5943
    add rbx, 6
    add rbx, 1
    jmp loop_start
case_5943: # scissors - paper
    cmp si, 0x5943
    jne case_5A43
    # add rbx, 0
    add rbx, 2
    jmp loop_start
case_5A43: # scissors - scissors
    cmp si, 0x5A43
    jne case_bad
    add rbx, 3
    add rbx, 3
    jmp loop_start

case_bad: # bad data loaded, exit(1) syscall
    mov rax, 60
    mov rdi, 1
    syscall

loop_end:
    mov rdi, rbx # show the total score
    call show_qword

    # exit(0) syscall
    mov rax, 60
    mov rdi, 0
    syscall
