/*****************************************************************************************************************************
 * Program name: "Braking Force Calculator". This program will calculate how much force must be applied to the brakes to     *
 * stop a moving vehicle. Copyright (C) 2021  Suhyr Hasan                                                                    * 
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
 *  Author email: suhyrhasan@csu.fullerton.edu
 *
 * Program information 
 *  Program name: Braking Force Calculator
 *  Programming languages X86 with one module in C
 *
 * Purpose
 *  This program will read the inputs m, v, and d, and then compute F. Braking Force formula: F =0.5 x m x v x v/d
 *
 * Project information
 *  Files: clock_speed.asm, driver.c, force.asm, r.sh
 *
 * Translator information
 *  Linux: gcc -c -Wall -m64 -no-pie -o driver.o driver.c -std=c11
 * ************ Begin code area  ********************************************************************************************/
#include <stdio.h>
#include <stdint.h>
#include <math.h>

extern double force();

int main()
{
double result = -999.999;

printf("This is Final exam by Suhyr Hasan.\n");
result = force(); 
printf("%s%5.1lf%s","The main program received ",result," and will just keep it.\n");
printf("Have a nice day.\n");

return 0;

} //End of main