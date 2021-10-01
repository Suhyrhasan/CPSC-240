//Author name: Floyd Holliday
//Author email: holliday@fullerton.eduu

//Program name: Show GPRs Utility
//Programming languages: X86 (algorithm)
//Date program began: April 2, 2017
//Date of last update: February 17, 2019
//Files in this program: stack-driver.cpp, stackdump.asm, r.sh, showgprs.asm
//Calling structure: test-gprs ==> discover ==> showgprs.
//Status: Done.  No more work will be done on this program apart from fixing any reported errors.

//References: Jorgensen, X86-64 Assembly Language Programming with Ubuntu

//Purpose: Run some test cases with showgprs.  "showgprs" is a library function.  It can be an assistance to other programmers
//who may need to know the content of generall purpose registers.  The other functions accompanying showgprs are here to tools
//for testing this llibrary function 

//This file name: test-gprs.cpp
//Compile: g++ -c -m64 -std=c++98 -Wall -o test.o test-gprs.cpp -fno-pie -no-pie
//Link:    g++ -m64 -std=c++98 -o go.out test.o gprs.o discov.o -fno-pie -no-pie

#include <iostream>

using namespace std;

//Prototypes:
extern "C" void showgprs();
extern "C" long discovery();


int main(int argc, char* argv[])
{cout << "Next the C++ driver will call discovery which will in turn call showgprs" << endl;
 long sum = discovery();
 sum = 2*sum;
 cout << "\nNext showgprs will be called directely from within a C++ function" << endl;
 showgprs();
 cout << "\nThe driver program will make one last call to discovery which will call showgprs" << endl;
 sum = discovery();
 cout << "sum = " << sum << " Have a nice day.  The driver program is terminating." << endl;
 return 0;
}

