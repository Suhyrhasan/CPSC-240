#/bin/bash

#Program: GDB demonstration for simple variables
#Author: F. Holliday

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file cosmos.asm"
nasm -f elf64 -l cosmos.lis -o cosmos.o cosmos.asm -gdwarf 

echo "Compile the source file gdb-demo-x86.cpp"
g++ -c -m64 -Wall -no-pie -o gdb-demo.o -std=c++17 gdb-demo-x86.cpp -g

echo "Link the object modules to create an executable file: demo.out"
g++ -m64 -no-pie -o demo.out gdb-demo.o cosmos.o -std=c++17 -Wall -g

echo "Execute the program that converts decimal input into IEEE754 output"
gdb ./demo.out

echo "This bash script will now terminate."




