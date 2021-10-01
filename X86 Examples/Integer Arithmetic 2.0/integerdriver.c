//****************************************************************************************************************************
//Program name: "Input Integer Validation".  This program demonstrates how to validate input received from scanf as valid    *
//integer data.  Copyright (C) 2020 Floyd Holliday                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************
//Program name: "Input Integer Validation".  This program demonstrates how to validate input received from scanf as valid    *
//integer data.  Copyright (C) 2020 Floyd Holliday   

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Floyd Holliday
//  Author email: holliday@fullerton.edu
//
//Program information
//  Program name: Input Integer Validation
//  Programming languages: One modules in C, two modules in X86, one module in C++
//  Date program began:     2020-Sep-02
//  Date program completed: 2020-Sep-06
//  Date comments upgraded: 2020-Sep-07
//  Files in this program: integerdriver.c, arithmetic.asm, atol.asm (lib), validate-decimal-digits.cpp (lib)
//  Status: Complete.  Tested with a dozen different inputs.  No error uncovered during that testing session.
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
//
//Purpose
//  Show how to validate incoming data as valid long integers or invalid long integers.
//
//This file
//   File name: integerdriver.c
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -fno-pie -no-pie -o driver.o integerdriver.c
//   Link: gcc -m64 -fno-pie -no-pie -o current.out driver.o arithmetic.o    //Ref Jorgensen, page 226, "-no-pie"
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper     
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//
//
//===== Begin code area ===========================================================================================================



#include <stdio.h>
#include <stdint.h>

long int arithmetic();

int main()
{long int result_code = -999;
 result_code = arithmetic();
 printf("%s%ld\n","The result code is ",result_code);
 return 0;
}//End of main
