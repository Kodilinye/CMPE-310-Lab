# Lab 5

This lab compares C and C++ generated assembly code, compiler optimization, while-loop structure, and an assembly program that finds the maximum value in an array.

## Part IA
gcc -O0 -S -m32 part1.c -o part1_0.s

## Part IB
gcc -O4 -S -m32 part1.c -o part1_4.s

## Part II
gcc -O0 -S HelloWorld.c -o HelloWorld.s
g++ -O0 -S HelloWorldCpp.cpp -o HelloWorldCpp.s

## Part III
gcc -O0 -S while_loop.c -o while_loop.s
gcc part3_max_array.s -o max_array

## Run
./max_array
