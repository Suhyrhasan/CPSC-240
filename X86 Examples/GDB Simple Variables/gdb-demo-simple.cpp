//Author: F. H.
//Email: holliday@fullerton.edu

//Program name: GDB demonstration for simple variables
//Purpose: Serve as a foundation for demonstrating a large number of gdb commands.

//Compile: g++ -c -m64 -Wall -no-pie -o gdb-demo.o -std=c++17 gdb-demo-simple.cpp
//Link: g++ -m64 -no-pie -o gdb-simple.out gdb-demo.o -std=c++17 -Wall

#include <iostream>
#include <iomanip>


using namespace std;

int main(int argc, char* argv[])
{cout << "Welcome to GDB" << endl;
 cout << "The purpose of this program is to serve as a demonstration platform for the use of the open source debugger \"Gnu De Bugger\" "
      << "known universally as GDB" << endl;
 //Declare at least one variable of every type except unsigned and arrays.
 double a = 3.957;
 float  b = 6.3;
 long   c = 8080;
 int    d = -6;
 short  e = 33;
 char   f = 65;
 bool   g = true;

 //Output the variables to confirm assignment of values.
 cout << "a = " << setw(10) << setprecision(8) << showpoint << setfill('0') << right << a << endl;
 cout << "b = " << setw(10) << setprecision(8) << showpoint << setfill('0') << right << b << endl;
 cout << "c = " << setw(10) << right << c << endl;
 cout << "d = " << setw(10) << right << d << endl;
 cout << "e = " << setw(10) << right << e << endl;
 cout << "f = " << setw(10) << right << f << endl;
 cout << "g = " << setw(10) << right << g << endl;

 //Output the addresses of these variables.
 cout << "&a = "  << hex << right << &a << endl;
 cout << "&b = "  << hex << right << &b << endl;
 cout << "&c = "  << hex << right << &c << endl;
 cout << "&d = "  << hex << right << &d << endl;
 cout << "&e = "  << hex << right << &e << endl;
 //Special case: to find the address of variable f we must employ the unusual casting technique below.
 void * p = &f;
 unsigned long * q = static_cast<unsigned long *>(p);
 cout << "&f = "  << hex << right << q << endl;
 cout << "&g = "  << hex << right << &g << endl;

 printf("That's all. Have fun with your floats.\n");
 return 0;
}
//End of function main in file gdb-demo-simple.cpp
	

