//****************************************************************************************************************************
//Program name: "Input Array using C++".  This is a single function distributed without accompanying software.  This function*
//reads a equence of long ints separated by white space places and places each inputted value into consecutive cells of an   *
//arrray.  The input process stops when the pair <enter><cntl+d> is encountered.  Copyrighted (C) 2018 Floyd Holliday        *
//
//This is a library function distributed without accompanying software.                                                      *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public   *
//License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be   *
//useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.*
//See the GNU General Public License for more details.  A copy of the GNU Lesser General Public License 3.0 should have been *
//distributed with this function.  If the LGPL does not accompany this software then it is available here:                   *
//<https:;www.gnu.org/licenses/>.                                                                                            *
//****************************************************************************************************************************

//To students in CPSC240:  This is my opinion.  I have studied the the available licenses for software especially the GPL,
//the LGPL, and the Affero GPL.  This is what I have learned about the LGPL used with this function "input_array using C++".
//   The section above the blank line is called the "copyright notice".
//   The section below the blank line is called the "license notice".
//   LGPL is for use on software typically found in software libraries.
//   This LGPL license applies only to the specific function named in the license.
//   This library may be used within another application covered by other licenses (or EULAs).
//   This license requires that source code of this function be distributed with the application (even if other parts of the
//       application are not required to be distributed with source code).
//   This LGPL allows you to re-distribute the function (provided the original LGPL remains).
//   This LGPL allows you to modify the function (provided the original LGPL remains).
//   This LGPL allows you to distribute (or sell) your modified versions to anyone (provided the original LGPL remains). 
//   When you distribute this software to other people a copy of the LGPL is suppose to accompany the source code in a 
//       separate file.  If that separate file becomes lost (by human error) license still has legal standing.
//
//References: 
//   How to correctly place a software license in a source file: https://www.gnu.org/licenses/gpl-howto.html
//   Complete text of LGPl in html format: https://www.gnu.org/licenses/lgpl-3.0.html
//   Complete text of GPL in html format: https://www.gnu.org/licenses/gpl-3.0.html
//
//This opinion is included here for educational purposes in the course CPSC240.  You must remove this opinion statement 
//when you use this library function in other application programs such as homework.
//
//To students in 240:  You must remove this block of opinion statements when you use this function in your program.  If this
//block remains when I grade your program then automatically your program is not professional.
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//Author information
//  Author name: Floyd Holliday
//  Author email: holliday@fullerton.edu
//
//This file
//  Program name: Input Array using C++
//  File name: input_array.cpp
//  Date development began: 2018-Sep-2
//  Date of last update:  2018-Sep-6
//  Comments reorganized: 2020-Sep-26
//  This is a library function.  It does not belong to any one specific application.  The function is available for inclusion 
//  in other applications.  If it is included in another application and there are no modifications made to the executing 
//  statements in this file then do not modify the license and do not modify any part of this file; use it as is.
//  Language: C++
//  Max page width: 132 columns
//  Optimal print specification: 7 point font, monospace, 132 columns, 8½x11 paper
//  Testing: This function was tested successfully on a Linux platform derived from Ubuntu.
//  Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o input_array.o input_array.cpp -std=c++17
//  Classification: Library
//
//How to call this library function from C++ or C:
// 
//  long specialarray[200];                //Declare an array of long integers:
//  long actualsize;                       //Declare an integer that will hold the count of number in the array
//  actualsize = input_array(specialarray,200);   //Call input_array
//
//How to call this library function from X86
//  segment .bss
//  specialarray resq 200                 ;Create an array to be filled
//  segment .text
//  ;Begin block that will call input_array
//  mov rax,0
//  mov rdi,specialarray
//  mov rsi,200
//  call input_array
//  mov r13,rax         ;Save the number of elements in the array.


#include <iostream>

using namespace std;
extern "C" long input_array(double *, long );

long input_array(double * arr, long size)
{ cout << "Input a sequence of long integers separated by ws.  Enter <enter><cntl+d> to terminate." << endl;
  long index = 0;
  while (!cin.eof() && index<size)
  {cin >> arr[index];
   index++;
  }
 cin.ignore();
 return index - 1;
}
