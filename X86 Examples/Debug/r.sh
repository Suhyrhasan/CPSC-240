#!/bin/bash




echo "Remove old binary files if any still exist"
rm *.out
rm *.o

echo "Assemble the file debug.asm"
nasm -f elf64 -l debug.lis -o debug.o debug.asm

echo "Assemble explore.asm"
nasm -f elf64 -l exp.lis -o exp.o explore.asm

echo "Compile the C++ file stack-driver.cpp"
g++ -c -m64 -Wall -no-pie -fno-pie -o mainprog.o -std=c++17 mainprogram.cpp

echo "Link together the recently created object files"
g++ -m64 -no-pie -fno-pie -o go.out -std=c++17 mainprog.o  exp.o debug.o

echo "Run the program named View System Stack"
./go.out

echo "The Bash file has finished"

