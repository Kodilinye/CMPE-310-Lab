.section .bss
.lcomm ram,256

.section .text
.globl _start

_start:
    mov $10, %ecx
    mov $1, %eax
    mov $0, %edx

    ret
    
fill_loop:
    add %eax, %edx
    inc %eax
    dec %ecx
    jne fill_loop

    mov $ram+0x50, %ebx
    mov %edx, (%ebx)

    ret

.section .note.GNU-stack,"",@progbits
