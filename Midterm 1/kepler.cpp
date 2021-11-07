/*****************************************************************************************************************************
 * Author information
 *    Author name:  Suhyr Hasan
 *    Author class: CPSC240 -01
 *    Author email: SuhyrHasan@csu.fullerton.edu
 *
 * Program information Program name: The Electricity Program
 *    Programming languages X86 with one module in C++
 *
 * Project information
 *    Files: copernicus.cpp, copernicus.asm, r.sh
 * ************ Begin code area  ********************************************************************************************/
#include <stdio.h>
#include <iostream> 
using namespace std;   

                                 
extern "C" char* copernicus(); 

int main()
{
    cout << "\nWelcome to High Voltage System Programming brought to you by Suhyr Hasan.\n";
    char* title = copernicus();
    cout << "Goodbye "<< title;
    cout << " Have a nice research party.\n";
    cout <<"Zero is returned to the operating system\n";

    return 0; 
}
/******End of program copernicus.cpp *********************************************************************************************/
