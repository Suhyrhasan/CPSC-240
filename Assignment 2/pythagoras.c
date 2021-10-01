
/*****************************************************************************************************************************
 * Program name: "The Right Triangles Program". This program demonstrates how to input and output a float in assembly with   *
 * proper formatting. The X86 function calcutes the area and hypotenuse of a right triangle, and the C++ receives and        *
 * outputs the hypotenuse with changes included.  Copyright (C) 2021  Suhyr Hasan                                            *
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License *
 * version 3 as published by the Free Software Foundation.                                                                   *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
 * A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                          *
 *****************************************************************************************************************************/

/*****************************************************************************************************************************
 * Author information
 *    Author name: Suhyr Hasan
 *    Author email: suhyrhasan@csu.fullerton.edu
 *
 * Program information Program name: The Right Triangles Program
 *    Programming languages X86 with one module in C++
 *    Date development of version 1.5 began 2021-Sep-17
 *    Date development of version 1.5 completed 2021-Sep-20
 *
 * Purpose
 *    In this assignment teaches you how to input and output a float in assembly with proper formatting
 * 
 * Project information
 *    Files: pythagoras.c, triangle.asm, run.sh
 * 
 * Translator information
 *    Gnu compiler: gcc -c -m64 -Wall -fno-pie -no-pie -l  pythagoras.lis -o  pythagoras.o  pythagoras.c -std=c11
 *    Gnu linker:   gcc -m64 -fno-pie -no-pie -std=c11 -o a.out  pythagoras.o triangle.o 
 * 
 * Execution: ./a.out
 * 
 * References and credits
 *    No references: this module is standard C
 * ************ Begin code area  ********************************************************************************************/
#include <stdio.h>
#include <stdint.h>
#include <math.h>

extern double floating();    //change from int to double

int main()
{
  double hypotenuseNumber = -99.999;
  printf("%s","\nWelcome to the Right Triangles program maintained by Suhyr Hasan.\n");
  printf("%s","If errors are discovered please report them to Suhyr Hasan at suhyrhasan@csu.fullerton.edu for a quick fix.\n");
  printf("%s","At Columbia Software the customer comes first.\n");
  hypotenuseNumber = floating();
  printf("%s%5.4lf%s","\nThe main function received this number ",hypotenuseNumber,
         " and plans to keep it.");
   printf("\nAn integer zero will be returned to the operating system. Bye\n\n");

    return 0;  //'0' is the traditional code for 'no errors'.
}
/******End of program pythagoras.c *********************************************************************************************/