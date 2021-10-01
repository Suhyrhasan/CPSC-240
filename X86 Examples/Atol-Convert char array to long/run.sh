#!/bin/bash

#Author: Floyd Holliday
#Program name: String to Long Integer Conversion

rm *.o, *.lis, *.out
echo " " #Blank line



echo "Message from bash file: Welcome to 'String to Long Integer Conversion' "

echo "Bash file: Assemble the X86 file atol.asm"
nasm -f elf64 -o atol.o atol.asm

echo "Bash file: Compile the C++ file atol-main.cpp"
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o atol-main.o atol-main.cpp

echo "Bash file: Link the 'O' files atol-main.o and atol.o"
g++ -m64 -std=c++14 -fno-pie -no-pie -o convert.out atol-main.o atol.o

echo "Bash file: Run the program String to Long Integer Conversion"
./convert.out

echo "Bash file: The script file will now terminate.  Bye."


