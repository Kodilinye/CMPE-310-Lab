.section .text
.globl sum_array

sum_array:
    xor %eax, %eax

    xor %rcx, %rcx

sum_loop:
    cmp %rsi, %rcx

    jge done

    add (%rdi,%rcx,4), %eax

    inc %rcx

    jmp sum_loop

done:
    ret

.section .note.GNU-stack,"",@progbits
