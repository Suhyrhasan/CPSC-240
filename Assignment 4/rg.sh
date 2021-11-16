#!/bin/bash

#Author: Suhyr Hasan
#Program name: Power Unlimited
#Purpose: This is a Bash script file whose purpose is to compile and run the program "Power Unlimited".
rm *.out
echo "Assemble hertz.asm"
nasm -f elf64 -o hertz.o hertz.asm -l hertz.lst -gdwarf

echo "Compile maxwell.c"
gcc -c -m64 -Wall -fno-pie -no-pie -l hertz.lis -o maxwell.o maxwell.c -std=c11 -g

echo "Compile isfloat.cpp"
g++ -c -m64 -Wall -no-pie -o isfloat.o -std=c++17 isfloat.cpp -g

echo "Link 2 object files"
gcc -m64 -std=c11 -o a.out hertz.o maxwell.o isfloat.o -fno-pie -no-pie -g

echo "------Program Start------"
gdb ./a.out

echo "------Program End------"
rm *.o
rm *.lis
rm *.lst
rm *.out