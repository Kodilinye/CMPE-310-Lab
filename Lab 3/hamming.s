.section .bss

.lcomm str1,256
.lcomm str2,256
.lcomm outbuf,32

.section .rodata

prompt1:
    .ascii "Enter first string: "
prompt1_len = . - prompt1

prompt2:
    .ascii "Enter second string: "
prompt2_len = . - prompt2

result_msg:
    .ascii "Hamming distance: "
result_msg_len = . - result_msg

newline:
    .ascii "\n"

.section .text
.globl _start

_start:
    mov $1, %rax
    mov $1, %rdi
    lea prompt1(%rip), %rsi
    mov $prompt1_len, %rdx
    syscall

    lea str1(%rip), %rsi
    mov $255, %rdx
    call read_line
    mov %rax, %r12

    mov $1, %rax
    mov $1, %rdi
    lea prompt2(%rip), %rsi
    mov $prompt2_len, %rdx
    syscall

    lea str2(%rip), %rsi
    mov $255, %rdx
    call read_line
    mov %rax, %r13

    mov %r12, %r14
    cmp %r13, %r14
    jbe length_ready
    mov %r13, %r14

length_ready:
    xor %r15, %r15
    xor %rbx, %rbx

compare_loop:
    cmp %r14, %rbx
    jae print_result

    movzbq str1(%rbx), %rax
    movzbq str2(%rbx), %rdx
    xor %rdx, %rax

bit_loop:
    test %rax, %rax
    jz next_byte

    lea -1(%rax), %rdx
    and %rdx, %rax
    inc %r15
    jmp bit_loop

next_byte:
    inc %rbx
    jmp compare_loop

print_result:
    mov $1, %rax
    mov $1, %rdi
    lea result_msg(%rip), %rsi
    mov $result_msg_len, %rdx
    syscall

    mov %r15, %rax
    lea outbuf+32(%rip), %rsi
    xor %rcx, %rcx

    cmp $0, %rax
    jne convert_loop

    dec %rsi
    movb $'0', (%rsi)
    mov $1, %rcx
    jmp write_number

convert_loop:
    xor %rdx, %rdx
    mov $10, %rbx
    div %rbx
    add $'0', %dl
    dec %rsi
    mov %dl, (%rsi)
    inc %rcx
    test %rax, %rax
    jne convert_loop

write_number:
    mov $1, %rax
    mov $1, %rdi
    mov %rcx, %rdx
    syscall

    mov $1, %rax
    mov $1, %rdi
    lea newline(%rip), %rsi
    mov $1, %rdx
    syscall

    mov $60, %rax
    xor %rdi, %rdi
    syscall

read_line:
    push %rbx
    push %r12
    push %r13

    mov %rsi, %rbx
    mov %rdx, %r12
    xor %r13, %r13

read_loop:
    cmp %r12, %r13
    jae read_done

    mov $0, %rax
    mov $0, %rdi
    lea (%rbx,%r13,1), %rsi
    mov $1, %rdx
    syscall

    cmp $1, %rax
    jne read_done

    cmpb $10, (%rbx,%r13,1)
    je read_done

    inc %r13
    jmp read_loop

read_done:
    mov %r13, %rax

    pop %r13
    pop %r12
    pop %rbx
    ret

.section .note.GNU-stack,"",@progbits
