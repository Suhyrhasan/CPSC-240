
/****************************************************************************************************************************
 * Program name: "Power Unlimited". This program will compute power with the circuit. The X86 function calcutes the power   *
 * using the resistance and current.The C++ file validates the user's input then return a 0 or 1. The C file receives and   *
 * outputs the power with the circuit. Copyright (C) 2021  Suhyr Hasan                                                      *
 * This program is free software:you can redistribute it and/or modify it under the terms of the GNU General Public License * 
 * version 3 as published by the Free Software Foundation.                                                                  *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied       * 
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.   *
 * A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                         *
 *****************************************************************************************************************************/

/*****************************************************************************************************************************
 * Author information
 *    Author name: Suhyr Hasan
 *    Author email: suhyrhasan@csu.fullerton.edu
 *
 * Program information Program name: Power Unlimited Program
 *    Programming languages X86 with one module in C
 *    Date development of version 1.5 began 2021-Oct-01
 *    Date development of version 1.5 completed 2021-Oct-21
 *
 * Purpose
 *    This assignment teaches you to validate string input then convert it into a float.
 * 
 * Project information
 *    Files: maxwell.c, hertz.asm, isfloat.cpp, r.sh
 * 
 * Translator information
 *    Gnu compiler: gcc -c -m64 -Wall -fno-pie -no-pie -l  maxwell.lis -o  maxwell.o  maxwell.c -std=c11
 *    Gnu linker:   gcc -m64 -fno-pie -no-pie -std=c11 -o a.out hertz3.o maxwell.o isfloat.o
 * 
 * Execution: ./a.out
 * 
 * References and credits
 *    No references: this module is standard C
 * ************ Begin code area  ********************************************************************************************/
#include <stdio.h>
#include <stdint.h>
#include <math.h>

extern double hertz();

int main()
{
double result = -999.999;

printf("Welcome to Power Unlimited programmed by Suhyr Hasan.\n");
result = hertz(); 
printf("%s%2.5lf%s","The main function received this number ",result," and plans to keep it.\n");
printf("Next zero will be returned to the OS. Bye\n");

return 0;

} //End of main