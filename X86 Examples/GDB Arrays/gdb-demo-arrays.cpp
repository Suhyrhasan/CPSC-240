//Author: F. H.
//Email: holliday@fullerton.edu

//Program name: GDB demonstration for arrays (Program #2 of a series)
//Purpose: Serve as a foundation for demonstrating gdb commands acting on memory (arrays)

//Compile: g++ -c -m64 -Wall -no-pie -o gdb-demo.o -std=c++17 gdb-demo-simple.cpp
//Link: g++ -m64 -no-pie -o gdb-simple.out gdb-demo.o -std=c++17 -Wall

#include <iostream>
#include <iomanip>


using namespace std;

int main(int argc, char* argv[])
{cout << "Welcome to GDB" << endl;
 cout << "The purpose of this program is to serve as a demonstration platform for the use of the open source debugger \"Gnu De Bugger\" "
      << "known universally as GDB.  Second program." << endl;
 //Declare array of many types.
 double a[6] = {2.2,3.3,4.4,5.5,6.6};
 float  b[5] = {-1.5,10.5,-20.5,30.5,-40.5};
 long   c[4] = {5,500,5000,5000000};
 int    d[3] = {-6,-2,+3};
 short  e[7] = {11,12,13,14,15,16,33};
 char   f[6] = {'H','e','l','l','o','\0'};
 bool   g[5] = {true,false,false,true,true};

 //Output the first value in each of these arrays
 cout << "a[0] = " << setw(10) << setprecision(8) << showpoint << setfill('0') << right << a[0] << endl;
 cout << "b[0] = " << setw(10) << setprecision(8) << showpoint << setfill('0') << right << b[0] << endl;
 cout << "c[0] = " << setw(10) << setfill(' ') << right << c[0] << endl;
 cout << "d[0] = " << setw(10) << setfill(' ') << right << d[0] << endl;
 cout << "e[0] = " << setw(10) << setfill(' ') << right << e[0] << endl;
 cout << "f[0] = " << setw(10) << setfill(' ') << right << f[0] << endl;
 cout << "g[0] = " << setw(10) << setfill(' ') << right << g[0] << endl;

 //Output the address where each array begins.  The name of the array contains that starting address.
 cout << "a = "  << hex << right << a << endl;
 cout << "b = "  << hex << right << b << endl;
 cout << "c = "  << hex << right << c << endl;
 cout << "d = "  << hex << right << d << endl;
 cout << "e = "  << hex << right << e << endl;
 //Special case: to find the address of array f we must employ the unusual casting technique below.
 void * p = &f;
 unsigned long * q = static_cast<unsigned long *>(p);
 cout << "f = "  << hex << right << q << endl;
 cout << "g = "  << hex << right << g << endl;

 printf("That's all. Have fun with your floats.\n");
 return 0;
}
//End of function main in file gdb-demo-simple.cpp
	

