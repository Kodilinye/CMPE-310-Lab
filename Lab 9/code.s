letters:
    .byte 0x6d, 0x76, 0x79 # S=acdfg, H=bcefg, E=adefg

.section text
.global lab9_start
.equ PORT_A, 0x640
.equ PORT_B, 0x641
.equ CONTROL, 0x643
.equ HOLD_FRAMES, 150 # Adjust for emulator/processor speed
.equ DWELL_COUNT, 600 # Busy-wait digit dwell not calibrated time

lab9_start:
   # D7=1 selects mode set D6:D5=00: Group A mode 0
   # D4=0: A output D3=0: upper C output
   # D2=0: Group B mode 0 D1=0: B output D0=0: lower C output
    movb $0x80, %al
    movw $CONTROL, %dx
    outb %al, %dx
    movw $PORT_B, %dx
    xorb %al, %al # All segments off during initialization
    outb %al, %dx
    movw $PORT_A, %dx
    movb $0xff, %al # All eight digits disabled
    outb %al, %dx
    xorw %bx, %bx # BX = E's digit index initially zero
    movw $1, %di # DI = movement direction (+1 or -1)

position:
    movw $HOLD_FRAMES, %bp
frame:
    movw $letters, %si # DS:SI points at S, H, E
    movw %bx, %cx
    addw $2, %cx # S at BX+2, H at BX+1, E at BX
    movb $1, %ah
    shlb %cl, %ah # One-hot mask for S's digit
    movw $3, %cx # Three letters per refresh frame
letter:
    movw $PORT_A, %dx
    movb $0xff, %al # Blank digits before changing segment data
    outb %al, %dx
    movw $PORT_B, %dx
    movb (%si), %al
    outb %al, %dx # Send this letter's seven-segment pattern
    movw $PORT_A, %dx
    movb %ah, %al
    notb %al # Exactly one zero selects one digit
    outb %al, %dx
    pushw %cx
    movw $DWELL_COUNT, %cx
wait_digit:
    loop wait_digit
    popw %cx
    incw %si
    shrb $1, %ah # Next character uses the next lower digit
    loop letter
    movb $0xff, %al
    movw $PORT_A, %dx
    outb %al, %dx # End frame with all digits disabled
    decw %bp
    jnz frame
    cmpw $5, %bx # At left edge: S7 H6 E5
    jne check_right
    movw $-1, %di
check_right:
    cmpw $0, %bx # At right edge: S2 H1 E0
    jne move
    movw $1, %di
move:
    addw %di, %bx
    jmp position
