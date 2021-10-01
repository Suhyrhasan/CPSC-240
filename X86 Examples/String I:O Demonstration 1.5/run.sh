#!/bin/bash

#Author: Floyd Holliday
#Program name: String I/O Demonstration
#Purpose: This is a Bash script file whose purpose is to compile and run the program "String I/O 1.5".

echo "Remove old executable files if there are any"
rm *.out

echo "Assemble the X86 file hello.asm"
nasm -f elf64 -l hello.lis -o hello.o hello.asm

echo "Compile the C++ file good_morning.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l good-moring.lis -o good_morning.o good_morning.cpp -std=c++2a

echo "Link the two 'O' files good_morning.o hello.o"
g++ -m64 -std=c++2a -o go.out hello.o good_morning.o -fno-pie -no-pie
#Note: "c++2a" is an early release of the "c++20" compiler.  
#When the compiler c++20 becomes available then replace "c++2a" with "c++20".

echo "Next the program ""String I/O"" will run"
./go.out

