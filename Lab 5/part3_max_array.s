.section .data

Numbers:
    .long 1
    .long 15
    .long 4
    .long 2
    .long 7
    .long 9
    .long 23
    .long 7
    .long 3
    .long 11
Array_length:
    .long 10

format:
    .string "Maximum value: %d\n"

.section .text
.globl main
.extern printf

main:
    pushq %rbp
    movq %rsp, %rbp

    leaq Numbers(%rip), %rdi
    movl Array_length(%rip), %ecx
    movl (%rdi), %eax
    movl $1, %edx

while_loop:
    cmpl %ecx, %edx
    jge done

    movl (%rdi,%rdx,4), %esi
    cmpl %eax, %esi
    jle next
    movl %esi, %eax

next:
    incl %edx
    jmp while_loop

done:
    movl %eax, %esi
    leaq format(%rip), %rdi
    xorl %eax, %eax
    call printf@PLT

    movl $0, %eax
    popq %rbp
    ret

.section .note.GNU-stack,"",@progbits