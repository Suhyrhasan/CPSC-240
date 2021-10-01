#!/bin/bash

#Author: Floyd Holliday
#Program name: Control D Example
#Language: Bash

rm *.o, *.lis, *.out

echo "Assemble the X86 file control-d.asm"
nasm -f elf64 -l control-d.lis -o control-d.o control-d.asm

echo "Compile the C++ file control-d-main.cpp"
g++ -c -m64 -Wall -std=c++14 -o control-d-main.o -fno-pie -no-pie control-d-main.cpp

echo "Link the 'O' files control-d-main.o, control-d.o"
g++ -m64 -std=c++14 -fno-pie -no-pie -o d.out control-d-main.o control-d.o

echo "Run the Control-d program"
./d.out




#Information about C++ standards.  The current standard as of 2019 is 14.
#The standard document for 2017 has been issued.  As far as this author knows it has
#not yet been implemented with a switch such as "-std=c++17".
