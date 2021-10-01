#!/bin/bash

#Author: Suhyr Hasan
#Program name: The Hello World Program
#Purpose: This is a Bash script file whose purpose is to compile and run the program "Hello World".
rm *.out
echo "Assemble the X86 file hello.asm"
nasm -f elf64 -l hello.lis -o hello.o hello.asm
echo "Compile the C++ file welcome.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l welcome.lis -o welcome.o welcome.cpp -std=c++17
echo "Link the two 'O' files welcome.o hello.o"
g++ -m64 -fno-pie -no-pie -std=c++17 -o a.out welcome.o hello.o 
echo "----- The program will run -----"
./a.out
echo "----- The program is finished -----"
rm *.o
rm *.lis
