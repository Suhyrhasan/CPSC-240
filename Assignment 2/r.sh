#!/bin/bash

#Author: Suhyr Hasan
#Program name:  The Right Triangles Program
#Purpose: This is a Bash script file whose purpose is to compile and run the program "Right Triangles".
rm *.out
echo "Assemble the X86 file triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm
echo "Compile the C++ file  pythagoras.c"
gcc -c -m64 -Wall -fno-pie -no-pie -l  pythagoras.lis -o  pythagoras.o  pythagoras.c -std=c11
echo "Link the two 'O' files  pythagoras.o triangle.o"
gcc -m64 -fno-pie -no-pie -std=c11 -o a.out  pythagoras.o triangle.o 
echo "----- The program will run -----"
./a.out
echo "----- The program is finished -----"
rm *.o
rm *.lis