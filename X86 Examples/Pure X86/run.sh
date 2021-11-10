#!/bin/bash

#Author: Floyd Holliday
#Email: holliday@fullerton.edu

#Program name: Pure X86 Example

#Purpose: Demonstrate one example of x86 program which 
#   is not called a module written in another programming language
#   does not call any other function written in any programming language whatsoever.

echo "Welcome to Pure X86 Assembly"

echo "This is an example of how X86 programming would appear if there were on libraries of function such as printf, scanf, etc to call."

echo "Enjoy it while you can"

echo "Eliminate old compiled code if any exists."

rm *.out, *.obj, *.o

echo "Assemble X86 source code"

nasm -f elf64 -o pure-x86-example.o -l pure-x86-example.lis pure-x86-example.asm

echo "link the X86 assembled code"

ld  -o x86-io.out pure-x86-example.o

echo "Run the executable file"

./x86-io.out

echo "The Bash script file says Good-bye".
