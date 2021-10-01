#!/bin/bash

#Author: F. Holliday
#Program: Exponential Expressions 2.0

echo "Exponential Expressions 2.0"

nasm -f elf64 -l exponential-expressions.lis -o exponential-expressions.o exponential-expressions.asm

g++ -c -m64 -Wall -std=c++2a -o exponential-expressions-driver.o exponential-expressions-driver.cpp -fno-pie -no-pie

g++ -m64 -o exp-express.out exponential-expressions.o exponential-expressions-driver.o -fno-pie -no-pie -std=c++2a

./exp-express.out

#The year 2020 is the year of a new release of the C++ compiler standard.  When a Gnu compiler implementing the C++2020 
#standard then the expression -std=c++2a should be changed to -std=c++20.  When a language standard released there is 
#a time gap between the publication of the standard and the release of compliant C++ compilers by the various 
#organizations making compilers. 
