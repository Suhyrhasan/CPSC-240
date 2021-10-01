#/bin/bash

#Program: GDB demonstration for simple variables
#Author: F. Holliday

#Delete some un-needed files
rm *.o
rm *.out

echo "Compile the source file conversion.cpp with g++"
g++ -c -m64 -Wall -no-pie -o gdb-demo.o -std=c++17 gdb-demo-simple.cpp -g


echo "Link system module to conversion.o to create an executable file: conv.out"
g++ -m64 -no-pie -o gdb-simple.out gdb-demo.o -std=c++17 -Wall -g


echo "Execute the program that converts decimal input into IEEE754 output"
gdb ./gdb-simple.out

echo "This bash script will now terminate."



#gcc -c -Wall -m64 -no-pie -o current-time.o current-time.c -std=gnu11       Note the uncommon standard "GNU of 2011"
