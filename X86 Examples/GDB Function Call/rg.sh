#/bin/bash

#Program: GDB demonstration for calling a function.
#Author: F. Holliday

#Delete some un-needed files
rm *.o
rm *.out

echo "Compile the source file gdb-demo-functions.cpp with g++"
g++ -c -m64 -Wall -no-pie -o gdb-demo-functions.o -std=c++17 gdb-demo-functions.cpp -g


g++ -c -m64 -Wall -no-pie -o mathematics.o -std=c++17 mathematics.cpp -g


echo "Link system module to gdb-demo-functions.o to create an executable file: fun.out"
g++ -m64 -no-pie -o fun.out gdb-demo-functions.o mathematics.o -std=c++17 -Wall -g


echo "Execute the program that converts decimal input into IEEE754 output"
gdb ./fun.out

echo "This bash script will now terminate."



#gcc -c -Wall -m64 -no-pie -o current-time.o current-time.c -std=gnu11       Note the uncommon standard "GNU of 2011"
