//****************************************************************************************************************************
//Program name: "String I/O Demonstration".  This program demonstrates how to input and output a string with embedded white  *
//space.  Copyright (C) 2017  Floyd Holliday                                                                                 *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************




//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
//Author information
//  Author name: Floyd Holliday
//  Author email: holliday@fullerton.edu or activeprofessor@yahoo.com or both
//
//Program information
//  Program name: String I/O
//  Programming languages X86 with one module in C++
//  Date program began 2017-Dec-29
//  Date program completed 2017-Dec-30
//
//Purpose
//  This program will serve to introduce X86 programming to new programmers.
//
//Project information
//  Files: good_morning.cpp, hello.asm, run.sh
//  Status: The program has been tested extensively with no detectable errors.
//
//Translator information
//  Gnu compiler: g++ -c -m64 -Wall -l good-moring.lis -o good_morning.o good_morning.cpp
//  Gnu linker:   g++ -m64 -o good.out good_morning.o hello.o 
//
//Execution: ./good.out
//
//References and credits
//  No references: this module is standard C++
//
//Format information
//  Page width: 172 columns
//  Begin comments: 61
//  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
//
//===== Begin code area ===================================================================================================================================================

#include <stdio.h>
#include <stdint.h>                                         //To students: the second, third, and fourth header files are probably not needed.
#include <ctime>
#include <cstring>

extern "C" double hello_world();                            //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(int argc, char* argv[]){

  double return_code = -99.99;                              //-99.99 is an arbitrary number; that initial value could have been anything.

  printf("%s","Welcome to X86 programming.\n");
  return_code = hello_world();
  printf("%s%1.18lf%s\n","The driver received return code ",return_code,".\nThe driver will now return 0 to the OS.  Bye.");

  return 0;                                                 //'0' is the traditional code for 'no errors'.

}//End of main
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**

