//Author: F. H.
//Email: holliday@fullerton.edu

//Program name: GDB demonstration with function call (Program #3 of a series)
//Purpose: Serve as a foundation for demonstrating gdb commands that access statements inside a called function.

//Function: math
//Language: C++

//Compile: g++ -c -m64 -Wall -no-pie -o mathematics.o -std=c++17 mathematics.cpp
//Link: g++ -m64 -no-pie -o fun.out gdb-demo-functions.o mathematics.o -std=c++17 -Wall

#include<iostream>
#include<iomanip>
using namespace std;



extern "C" long math(double,float,long[],int,float[],int);

long math(double w,float x,long y[], int size3, float z[], int size4)
{long sum = -99;
 cout << "Math function begins" << endl;
 cout << "The first parameter received = " << dec << w << endl;
 cout << "The second parameter received = " << dec << x  << endl;
 cout << "The third parameter is an array of long ints: " << endl;
 for (int index = 0;index<size3;index++)
      cout << y[index] << "   ";
 cout << endl;
 cout << "The fifth parameter is an array of floats: " << endl;
 for (int ind=0;ind<size4;ind++)
      cout << z[ind] << "   ";
 cout << endl;
 sum = long(w) + long(x) + y[0] + long(z[0]);
 cout << "This value will be returned to the caller: " << sum << endl;
 return sum;
}






//Conclusion:  The user of this program can make a simple to confirm the following conclusions:
//GDB commands 'n' and 's' will both enter and debug the called function math, which is an integral part of this program.
//The distinction between these two commands is as follows:
//    'n' will not enter called library functions whereas 's' will enter and debug called library functions
//Reminder: library functions are those defined in iostream, iomanip, and other included libraries.
//Therefore, 's' will enter functions like sqrt, setprecision, setw, <<, >>, and hundreds of others.



