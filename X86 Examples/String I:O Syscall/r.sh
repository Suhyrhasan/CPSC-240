#!/bin/bash

#Program: String IO Syscall
#Author: F. Holliday

#Delete some un-needed files
rm *.o
rm *.out

echo "The script file for String IO Syscall has begun"

echo "Assemble string-io-syscall.asm"
nasm -f elf64 -o string-io.o string-io-syscall.asm

echo "Link the object files"
ld -o stringio.out string-io.o 

echo "Run the program String IO Syscall:"
./stringio.out

echo "The script file will terminate."

