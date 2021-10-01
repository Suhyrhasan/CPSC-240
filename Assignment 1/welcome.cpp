
/*****************************************************************************************************************************
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License *
 * version 3 as published by the Free Software Foundation.                                                                   *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
 * A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                          *
 *****************************************************************************************************************************/

/*****************************************************************************************************************************
 * Author information
 *    Author name: Suhyr Hasan
 *    Author email: SuhyrHasan@csu.fullerton.edu
 *
 * Program information Program name: The Hello World Program
 *    Programming languages X86 with one module in C++
 *    Date development of version 1.5 began 2021-Aug-25
 *    Date development of version 1.5 completed 2021-Sep-09
 * 
 * Purpose
 *    This assignment welcomes you to the world of programming called “X86 Assembly Programming”.
 * 
 * Project information
 *    Files: welcome.cpp, hello.asm, run.sh
 * 
 * Translator information
 *    Gnu compiler: g++ -c -m64 -Wall -fno-pie -no-pie -l welcome.lis -o welcome.o welcome.cpp -std=c++2a
 *    Gnu linker:   g++ -m64 -std=c++2a -o a.out hello.o welcome.o -fno-pie -no-pie 
 * 
 * Execution: ./a.out
 * ************ Begin code area  ********************************************************************************************/
#include <stdio.h>
#include <iostream> 
using namespace std;   
                                     
extern "C" char* hello(); //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main()
{
    cout << "\nWelcome to this friendly ‘Hello’ program created by Suhyr Hasan.\n";
    char* name = hello();
    cout << "\nStay away from viruses "<< name << ".\nBye. The integer zero will now be returned to the operating system\n";

    return 0;  //'0' is the traditional code for 'no errors'.
}
/******End of program welcome.cpp *********************************************************************************************/
