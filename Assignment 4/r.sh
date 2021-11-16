#!/bin/bash

#Author: Suhyr Hasan
#Program name: Power Unlimited
#Purpose: This is a Bash script file whose purpose is to compile and run the program "Power Unlimited".

echo "Assemble hertz.asm"
nasm -f elf64 -l hertz.lis -o hertz.o hertz.asm

echo "Compile maxwell.c"
gcc -c -Wall -m64 -no-pie -o maxwell.o maxwell.c -std=c11

echo "Compile isfloat.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o isfloat.o isfloat.cpp -std=c++17

echo "Link the object files"
gcc -m64 -no-pie -o a.out -std=c11 hertz.o maxwell.o isfloat.o

echo "\n----- Run the program -----"
./a.out

echo "----- End Program -----"
rm *.o
rm *.lis
rm *.out
