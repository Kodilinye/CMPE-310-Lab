# Lab 9

This lab uses 8086 assembly and the 8255 programmable peripheral interface to scroll "SHE" back and forth across an eight-digit seven-segment display.

## Code
lab9.s configures the 8255, sends letter patterns through Port B, and selects display digits through Port A.

## Assemble
as --32 -o lab9.o lab9.s

## Run
Use the course's 8086 simulator or hardware with the display at I/O address 0x640.