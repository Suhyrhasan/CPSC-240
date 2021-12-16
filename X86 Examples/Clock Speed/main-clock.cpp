//Program Name        : Clock Speed
//Pogramming Language: x86 Assembly
//Program Description : This file contain a C language main function used 
//                    : used for testing the clock-speed function.
//
//Author              : Aaron Lieberman
//Email               : AaronLieberman@csu.fullerton.edu
//Institution         : California State University, Fullerton
//
//Copyright (C) 2020 Aaron Lieberman
//This program is free software: you can redistribute
//it and/or modify it under the terms of the GNU General Public License
//version 3 as published by the Free Software Foundation. This program is
//distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY
//without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A
//PARTICULAR PURPOSE. See the GNU General Public License for more details.
//A copy of the GNU General Public License v3 is available here:
//<https://www.gnu.org/licenses/>.




//
//This file
//   File name: read_clock.c
//   Language: C
//   Compile: gcc -c -m64 -Wall -fno-pie -no-pie -o drive.o validate-driver.cpp -std=c++2a
//   Link: g++ -m64 -fno-pie -no-pie -o code.out -std=c++17 scan.o valid.o drive.o

//===== Begin code area ===============================================================================================





#include <iostream>

extern "C" double clock_speed();

int main(int argc, char* argv[])
{printf("The name of this program is \"Clock Speed\".\n"); 
 printf("The program will show the highest rated speed of the clock in the processor.\n");
 printf("The clock_speed function will be called from this C++ main function.\n");
 double speed = clock_speed();
 printf("The CPU speed is %7.5lf GHz.\n",speed);
 printf("Check for accuracy by entering the bash command \"lscpu\" in the terminal window.\n");
 printf("The values for frequency obtained from the two sources should match.\n"); 
 return 0;
}






