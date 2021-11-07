#!/bin/bash

#Student: Suhyr Hasa
#Student Email: suhyrhasan@csu.fullerton.edu
#Student class: CPSC240 -01
#Program name: The Electricity Program

rm *.out
echo "Assemble the X86 file copernicus.asm"
nasm -f elf64 -l copernicus.lis -o copernicus.o copernicus.asm
echo "Compile the C++ file kepler.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l kepler.lis -o kepler.o kepler.cpp -std=c++17
echo "Link the two 'O' files kepler.o kepler.o"
g++ -m64 -fno-pie -no-pie -std=c++17 -o a.out kepler.o copernicus.o 
echo "----- The program will run -----"
./a.out
echo "----- The program is finished -----"
rm *.o
rm *.lis
