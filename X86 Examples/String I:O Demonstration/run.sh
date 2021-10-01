#!/bin/bash

#Author: Floyd Holliday
#Program name: String I/O Demonstration
#Purpose: This is a Bash script file whose purpose is to compile and run the program "String I/O".

echo "Assemble the X86 file hello.asm"
nasm -f elf64 -l hello.lis -o hello.o hello.asm

echo "Compile the C++ file good_morning.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l good-moring.lis -o good_morning.o good_morning.cpp -std=c++17

echo "Link the two 'O' files good_morning.o hello.o"
g++ -m64 -fno-pie -no-pie -std=c++17 -o good.out good_morning.o hello.o 

echo "Next the program ""String I/O"" will run"
./good.out

