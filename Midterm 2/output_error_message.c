/*****************************************************************************************************************************
 * Program name: "Area of Triangle". This program will input 3 float numbers representing the lengths of three sides of one  *
 * triangle. Then it uses Huron’s formula to obtain the area. Copyright (C) 2021  Suhyr Hasan                                *
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License *
 * version 3 as published by the Free Software Foundation.                                                                   *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
 * A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                          *
 *****************************************************************************************************************************/
/*****************************************************************************************************************************
 * Author information
 *  Author name:  Suhyr Hasan
 *  Author class: CPSC240 -01
 *  Author email: SuhyrHasan@csu.fullerton.edu
 *
 * Program information 
 *  Program name: Area of Triangle
 *  Programming languages X86 with one module in C++ and 3 modules in C
 *
 * Purpose
 *  This function is called when the user input's doesn't form a triangle.
 *
 * Project information
 *  Files: isfloat.cpp, output_area.c, output_error_message.c, triangle.c, huron.asm, r.sh, rg.sh
 *
 * Translator information
 *  Linux: gcc -c -Wall -m64 -no-pie -o output_error_message.o output_error_message.c -std=c11
 * ************ Begin code area  ********************************************************************************************/
#include <stdio.h>

extern void output_error_message();

void output_error_message() {
    printf("The inputted numbers do not form a triangle. The area is set to zero.\n");
}