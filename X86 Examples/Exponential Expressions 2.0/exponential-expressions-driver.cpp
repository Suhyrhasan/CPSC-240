//****************************************************************************************************************************
//Program name: "Exponential Expressions 2.0".  This program accepts a significand and an exponent of a number and then      *
//an equivalent number in IEEE754 format.  Copyright (C) 2013, 2021 Floyd Holliday                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************
//
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//Author information
//  Author name: Floyd Holliday
//  Author email: holliday@fullerton.edu
//  Author phone (in CS building): (657)278-7021
//
//Program information
//  Program name: Exponential Expressions 2.0
//  Programming languages: Main function in C++; exponential-expressions.asm in X86.
//  Date version 1.0 began: 2013-February-14
//  Date version 1.0 finished: 2013-February-22
//  Date version 1.1 (upgrade comments) completed: 2019-March-02
//  Date version 2.0 (restructure source) completed: 2021-Sep-06
//  Files in the program: exponential-expressions-driver.cpp, exponential-expressions.asm, r.sh
//  System requirements: A platform with a Bash shell, g++ installed, nasm installed.
//  Know issues: The author knows of no performance issues.  Feedback from the public is always welcomed.
//
//Purpose
//  This program will input two numbers: a floating point decimal number representing a significand and a decimal integer
//  representing an exponent.  The output will be a floating point number in IEEE754 form equivalent to the original inputs.
//
//This file (module)
//  File name: exponential-expressions-driver.cpp
//  Language: C++
//  Invocations: This module calls function exponentialnumbers in the file exponential-expressions.asm.  
//  No data are passed during the call.  A long integer is returned during the return operation.
//  Max page width: 132 columns.  Well, we try to keep the width less than 132.

//Translation information
//  Compile: g++ -c -m64 -Wall -std=c++2a -o exponential-expressions-driver.o exponential-expressions-driver.cpp -fno-pie -no-pi
//  Link: g++ -m64 -o exp-express.out exponential-expressions.o exponential-expressions-driver.o -fno-pie -no-pie -std=c++2a
//  Execute: ./exp-express.out


//========== Begin source code ==========

#include <stdio.h>
#include <stdint.h>

extern "C" long int exponentialnumbers();

int main()
{long int return_code = -99;
 printf("%s","Welcome to EFP (Expontial Floating Point) numbers.\n");
 return_code = exponentialnumbers();
 printf("%s%ld%s\n","The result code is ",return_code,".  Enjoy your programming.");
 return 0;
}//End of main

