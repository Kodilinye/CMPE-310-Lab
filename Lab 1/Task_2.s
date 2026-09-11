.section .bss
.globl ram
.lcomm ram, 256

.section .text
.globl fill_ram

fill_ram:
    lea ram+0x50, %rsi
    movb $0xFF, (%rsi)
    lea ram+0x51, %rsi
    movb $0xFF, (%rsi)
    lea ram+0x52, %rsi
    movb $0xFF, (%rsi)
    lea ram+0x53, %rsi
    movb $0xFF, (%rsi)
    lea ram+0x54, %rsi
    movb $0xFF, (%rsi)
    lea ram+0x55, %rsi
    movb $0xFF, (%rsi)
    lea ram+0x56, %rsi
    movb $0xFF, (%rsi)
    lea ram+0x57, %rsi
    movb $0xFF, (%rsi)
    lea ram+0x58, %rsi
    movb $0xFF, (%rsi)

    ret

.section .note.GNU-stack,"",@progbits
