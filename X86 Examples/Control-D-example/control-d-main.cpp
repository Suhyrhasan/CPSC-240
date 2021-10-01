//****************************************************************************************************************************
//Program name: "Control-D Example".  This program demonstrates the use of cntl+d to terminate an input sequence.            *
//Copyright (C) 2018  Floyd Holliday                                                                                         *
//                                                                                                                           *
//This file is part of the software program "Control-D Example".                                                             *                         
//"Control-D Example" is free software: you can redistribute it and/or modify it under the terms of the GNU General Public   *
//License version 3 as published by the Free Software Foundation.                                                            *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 has been distributed with this software.  If not found it is available here:   *
//<https://www.gnu.org/licenses/>.   The copyright holder may be contacted here: holliday@fullerton.edu                      *
//****************************************************************************************************************************



//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//Author information
//  Author name: Floyd Holliday
//  Author email: holliday@fullerton.edu
//
//Program information
//  Program name: Control D Example
//  Programming languages: One modules in C++, one module in X86-64, and one module in Bash.
//  Date program began: 2018-Feb-12
//  Date of last update: 2019-Feb-13
//  Files in this program: control-d-main.cpp, control-d.asm, r.sh
//  Status: This program was tested over a dozen times on Debian9.3.0 (Feb 2018) without errors.
//
//Purpose
//  The intent of this program is to show how to terminate an input loop with the Cntl-D signal.
//
//This file
//   File name: conttrol-d-main.cpp
//   Language: C++
//   Max page width: 132 columns
//   Comments begin in column: 61.
//   Compile: g++ -c -m64 -Wall -l control-d-main.lis -o control-d-main.o -fno-pie -no-pie control-d-main.cpp
//   Link:   g++ -m64 -fno-pie -no-pie -o d.out control-d-main.o control-d.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//===== Begin code area ============================================================================================================

#include <stdio.h>
#include <stdint.h>                               //To students: the second, third, and fourth header files are probably not needed.
#include <ctime>
#include <cstring>

extern "C" double control_d();                    //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(int argc, char* argv[]){

  double return_code = -99.99;                    //-99.99 is an arbitrary number; that initial value could have been anything.

  printf("%s","Welcome to a demonstration of the use of Cntl+D.\n");
  return_code = control_d();
  printf("%s%1.18lf%s\n","The driver received return code ",return_code,".  The driver will now return 0 to the OS.  Bye.");

  return 0;                                       //'0' is the traditional code for 'no errors'.

}//End of main
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
