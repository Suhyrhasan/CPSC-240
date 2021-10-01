#!/bin/bash

#Author name: Floyd Holliday
#Author email: holliday@fullerton.edu

#Program name: Show GPRs Utility

echo "Remove old object files"
rm *.o

echo "Remove old executable files"
rm *.out

echo "Assemble the showgprs utility program"
nasm -f elf64 -o gprs.o -l showgprs.lis showgprs.asm

echo "Assemble the discovery test program"
nasm -f elf64 -l discover.lis -o discov.o discover.asm

echo "Compile the test driver testgprs.cpp"
g++ -c -m64 -std=c++14 -Wall -o test.o test-gprs.cpp -fno-pie -no-pie

echo "Link together the two object files"
g++ -m64 -std=c++14 -o go.out test.o gprs.o discov.o -fno-pie -no-pie

echo "Run the test program"
./go.out

echo "The script file has terminated"
