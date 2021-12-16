#!/bin/bash

#Student: Suhyr Hasan
#Student Class: CPSC240 -01
#Student Email: suhyrhasan@csu.fullerton.edu
#Program Name:  Braking Force Calculator

echo "Assemble force.asm"
nasm -f elf64 -l force.lis -o force.o force.asm

echo "Assemble clock_speed.asm"
nasm -f elf64 -l clock_speed.lis -o clock_speed.o clock_speed.asm

echo "Compile driver.c"
gcc -c -Wall -m64 -no-pie -o driver.o driver.c -std=c11

echo "Link the object files"
gcc -m64 -no-pie -o a.out -std=c11 force.o driver.o clock_speed.o

echo "----- Run the program -----"
./a.out

echo "------- End Program -------"
rm *.o
rm *.lis
rm *.out