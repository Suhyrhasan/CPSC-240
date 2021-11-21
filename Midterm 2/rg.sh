#!/bin/bash

#Student: Suhyr Hasan
#Student Class: CPSC240 -01
#Student Email: suhyrhasan@csu.fullerton.edu
#Program Name:  Area of Triangle

echo "Assemble huron.asm"
nasm -f elf64 -o huron.o huron.asm -l huron.lst -gdwarf

echo "Compile triangle.c"
gcc -c -m64 -Wall -fno-pie -no-pie -l triangle.lis -o triangle.o triangle.c -std=c11 -g

echo "Compile output_area.c"
gcc -c -m64 -Wall -fno-pie -no-pie -l output_area.lis -o output_area.o output_area.c -std=c11 -g

echo "Compile output_error_message.c"
gcc -c -m64 -Wall -fno-pie -no-pie -l output_error_message.lis -o output_error_message.o output_error_message.c -std=c11 -g

echo "Compile isfloat.cpp"
g++ -c -m64 -Wall -no-pie -o isfloat.o -std=c++17 isfloat.cpp -g

echo "Link the object files"
gcc -m64 -std=c11 -o a.out huron.o triangle.o output_area.o output_error_message.o isfloat.o -fno-pie -no-pie -g

echo "------Program Start------"
gdb ./a.out

echo "------Program End------"
rm *.o
rm *.lst
rm *.out