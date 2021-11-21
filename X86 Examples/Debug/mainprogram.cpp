//Author: F. Holliday
//Email: holliday@fullerton.edu

//Program name: Demonstrate static debugger
//Purpose: Show the three kinds of output from the static debugger TAP

//Compile: g++ -c -m64 -Wall -no-pie -fno-pie -o mainprog.o -std=c++17 mainprogram.cpp
//Link: g++ -m64 -no-pie -fno-pie -o convert.out -std=c++17 mainprog.o  exp.o debug.o

#include <iostream>
#include <iomanip>

using namespace std;

extern "C" long int exploration();

int main(int argc, char* argv[])
{cout << "This program will demonstrate the five forms of output produced by the static debugger" << endl;

 long int w = exploration();

 cout << "The main function received this value: w = " << w << " (decimal) = " << hex << "0x" << w << " (hex)" << endl;

 cout << "The main function will now terminate and return 0 to the operating system" << endl;

 return 0;
}
	

