//Author: F. H.
//Email: holliday@fullerton.edu

//Program name: GDB demonstration for arrays (Program #4 of a series)
//Purpose: Serve as a foundation for demonstrating gdb commands acting on memory (arrays)

//Compile: g++ -c -m64 -Wall -no-pie -o gdb-demo.o -std=c++17 gdb-demo-simple.cpp
//Link: g++ -m64 -no-pie -o gdb-simple.out gdb-demo.o -std=c++17 -Wall

#include <iostream>
#include <iomanip>
using namespace std;

extern "C" double cosmos(double [], int, long);  //The second parameter type int was intentional.

using namespace std;

int main(int argc, char* argv[])
{cout << "Welcome to GDB" << endl;
 cout << "The purpose of this program is to serve as a demonstration platform for the use of the open source debugger \"Gnu De Bugger\" " << endl;
 cout << "First create some data to pass to the called function written in assembly." << endl;

 //Create some data;
 double a[5] = {2.2, 3.37, 4.412, 5.5861, 6.60938};
 int m = 5;
 double x = 3.745;
 double outcome;

 //Verify the stored values
 for (int z = 0; z<5; z++)
      cout << showpoint << setprecision(4) << a[z] << "  ";
 cout << endl;
 cout << "m = " << m << endl;
 cout << "x = " << showpoint << right << setw(6) << setprecision(4) << x << endl;

 //Call the function cosmos
 cout << "Next call the function cosmos." << endl;
 outcome = cosmos(a,m,x);

 //Show the return value
 cout << "The caller function received this number: " << showpoint << setprecision(7) << dec << outcome << endl;

 printf("That's all. Have fun with your floats.\n");
 return 0;
}
//End of function main in file gdb-demo-x86.cpp
	

