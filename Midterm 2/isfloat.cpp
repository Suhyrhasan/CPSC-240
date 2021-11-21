/****************************************************************************************************************************
 * Program name: "isfloat".  This is a single function distributed without accompanying software.  This function scans a
 * char array seeking to confirm that all characters in the array are in the range of ascii characters '0' .. '9'.Furthermore, 
 * this function confirms that there is exactly one decimal point in the string.  IF both conditions are true then a boolean 
 * true is returned, otherwise a boolean false is returned.  Copyright (C) 2020 Floyd Holliday 
 * 
 * This is a library function distributed without accompanying software.
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public
 * License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU Lesser General Public License for more details.  A copy of the GNU Lesser General Public License 3.0 should
 * have been distributed with this function.  If the LGPL does not accompany this software then it is available here:
 * <https:;www.gnu.org/licenses/>.  
 ******************************************************************************************************************************/
 
/****************************************************************************************************************************
 * Author information
 *  Author name: Floyd Holliday
 *  Author email: unavailable
 * 
 * This file
 *  Program name: isfloat
 *  File name: isfloat.cpp
 *  Date development began: 2020-Dec-12
 * Date of last update:  2020-Dec-14
 * Comments reorganized: 2020-Dec-14
 * This is a library function. It does not belong to any one specific application. The function is available for inclusion in 
 * other applications. If it is included in another application and there are no modifications made to the executing statements 
 * in this file then do not modify the license and do not modify any part of this file; use it as is.
 * 
 * Language: C++    
 *  Max page width: 132 columns
 *  Optimal print specification: monospace, 132 columns, 8½x11 paper
 *  Testing: This function was tested successfully on a Linux platform derived from Ubuntu.
 *  Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o isfloat.o isfloat.cpp -std=c++17
 *  Classification: Library
 * 
 * Purpose 
 *  Scan a contiguous segment of memory from the starting byte to the null character and determine if the string of chars is 
 *  properly formatted for conversion to a valid float number.  This function, isfloat, does not perform the conversion itself. 
 *  That task is is done by a library function such as atof.
 * 
 * Future project
 * Re-write this function in X86 assembly.
******************************************************************************************************************************/
#include <cstdlib>                      // Header to include atof function in area.asm.
#include <ctype.h>                      // Header to include isdigit function.

using namespace std;

// Declare and extern function to make it callable by other linked files.
extern "C" bool isfloat(char []);

// Definition of ispositivefloat function.
bool isfloat(char w[]) 
{
    bool result = true;                 // Assume floating number until proven otherwise.
    bool found = false;                 // Checks if only 1 decimal is entered.
    int start = 0;
    if (w[0] == '+') start = 1;         // Checks to see if a valid plus sign is entered and
    unsigned long int k = start;        // increments the starting index for loop.
    while( !(w[k]=='\0') && result )
    {
        // Checks for decimal character in string with only 1 occurence.
        if ((w[k] == '.') && !found) { found = true; 
        }
        else { 
            // Sets result to true only if character at index k is a digit.
            result = result && isdigit(w[k]);   
        }
        k++;
    }
    // Returns true if all characters in string are digits with exactly 1 decimal.
    return result && found;             
}