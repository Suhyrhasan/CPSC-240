#!/bin/bash

#Program: Clock Speed
#Author: A. Lieberman

#Delete some un-needed files
rm *.o
rm *.out

echo "Begin the bash file for Clock Speed"

echo "Assemble the fiel clock-speed.asm"
nasm -f elf64 -o speed.o clock_speed.asm

echo "Compile the driver function read-clock.c"
g++ -c -m64 -Wall -fno-pie -no-pie -o clock.o -std=c++2a main-clock.cpp

echo "Link the object files clock.o and speed.o"
g++ -m64 -fno-pie -no-pie -o time.out -std=c++2a clock.o speed.o 

#When the C++ 2020 official standard is release then "2a" should be changed to "20".

echo "Call the loader to begin execution."
./time.out

echo "The script file will terminate"





