#!/bin/bash

#Student: Suhyr Hasan
#Student Class: CPSC240 -01
#Student Email: suhyrhasan@csu.fullerton.edu
#Program Name:  Area of Triangle

echo "Assemble huron.asm"
nasm -f elf64 -l huron.lis -o huron.o huron.asm

echo "Compile triangle.c"
gcc -c -Wall -m64 -no-pie -o triangle.o triangle.c -std=c11

echo "Compile output_area.c"
gcc -c -Wall -m64 -no-pie -o output_area.o output_area.c -std=c11

echo "Compile output_error_message.c"
gcc -c -Wall -m64 -no-pie -o output_error_message.o output_error_message.c -std=c11

echo "Compile isfloat.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o isfloat.o isfloat.cpp -std=c++17

echo "Link the object files"
gcc -m64 -no-pie -o a.out -std=c11 huron.o triangle.o output_area.o output_error_message.o isfloat.o

echo "----- Run the program -----"
./a.out

echo "------- End Program -------"
rm *.o
rm *.lis
rm *.out