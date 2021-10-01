//****************************************************************************************************************************
//Program name: "String to Long Integer Conversion".  This program demonstrates the use of the library function atolong,     *
//which converts a well-formed character array to a long integer.  Copyright (C) 2020 Floyd Holliday                         *
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
//
//Program information
//  Program name: String to Long Integer Conversion
//  Programming languages: Main function in C++; atolong function in X86-64
//  Date program began: 2020-Sep-04
//  Date of last update: 2020-Sep-08
//  Comments reorganized: 2020-Sep-09
//  Files in the program: atol-main.cpp, atol.asm, run.sh
//
//Purpose
//  The purpose of this program is to demonstrate how to use the library function atolong, which converts well-formed
//  character arrays to ordinary long integers.  For educational purposes there is an interesting issue of how to add a
//  1-byte integer to an 8-byte integer.  A technique for making the addition is shown in the atolong function itself.
//
//Names
//  The function "atolong" was intended to be called atol, however there already is a function in the C++ standard library
//  with that name.  To avoid any possible conflict this function received the longer name, namely: atolong.  A simple web
//  search will produce lots of information about the original atol.

//This file
//  File name: atol-main.cpp
//  Language: C++
//  Max page width: 132 columns.  Well, we try to keep the width less than 132.
//  Optimal print specification: 7 point font, monospace, 132 columns, 8½x11 paper
//  Compile: g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o atol-main.o atol-main.cpp
//  Link: g++ -m64 -std=c++14 -fno-pie -no-pie -o convert.out atol-main.o atol.o
//
//References:
//  Jorgensen: X86-64 Assembly Language Programming with Ubuntu (free download)
//
//===== Begin code area ===========================================================================================================
//
#include <iostream>

using namespace std;

extern "C" long atolong(char []);                   //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(int argc, char* argv[]){
  long result;
  cout << "Begin driver function that will test the atol module." << endl;
  char a[] = {'5','\0'};
  char b[] = "17";
  char c[] = "+503";
  char d[] = "1234567890";
  char e[] = "1234567890123456789012";
  char f[] = "-444555666777";
  char g[] = "-1";
  char h[] = "12";                                  //Empty string
  char i[] = "34W6";                              //Contains an intentional error

  cout << "a = " << '\"' << a << '\"' << endl;
  result = atolong(a);
  cout << "result obtained from atolong = " << result << endl << endl;

  cout << "b = " << '\"' << b << '\"' << endl;
  result = atolong(b);
  cout << "result obtained from atolong = " << result << endl << endl;

  cout << "c = " << '\"' << c << '\"' << endl;
  result = atolong(c);
  cout << "result obtained from atolong = " << result << endl << endl;

  cout << "d = " << '\"' << d << '\"' << endl;
  result = atolong(d);
  cout << "result obtained from atolong = " << result << endl << endl;

  cout << "e = " << '\"' << e << '\"' << endl;
  result = atolong(e);
  cout << "result obtained from atolong = " << result << endl;
  cout << "Footnote: the orginal array holds too many digits.  The computed value will overflow" << endl;
  cout << "a 64-bit register resulting in an erroneous displayed value." << endl<< endl;

  cout << "f = " << '\"' << f << '\"' << endl;
  result = atolong(f);
  cout << "result obtained from atolong = " << result << endl << endl;

  cout << "g = " << '\"' << g << '\"' << endl;
  result = atolong(g);
  cout << "result obtained from atolong = " << result << endl << endl;

  cout << "h = " << '\"' << h << '\"' << endl;
  result = atolong(h);
  cout << "result obtained from atolong = " << result << endl << endl;

  cout << "i = " << '\"' << i << '\"' << endl;
  result = atolong(i);
  cout << "result obtained from atolong = " << result << endl;
  cout << "Footnote: the orginal string contained invalid data.  Expect to see an incorrect value displayed." << endl << endl;

  printf("%s\n","The main C++ driver function will now terminate.");

  return 0;                                                 //'0' is the traditional code for 'no errors'.

}//End of main
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6**

