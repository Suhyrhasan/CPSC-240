;******************************************************************************************************************************
;Program name: "Power Unlimited". This program will compute power with the circuit. The X86 function calcutes the power using *
;the resistance and current.The C++ file validates the user's input then return a 0 or 1. The C file receives and outputs the *
;power with the circuit. Copyright (C) 2021  Suhyr Hasan                                                                      *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License    *
;version 3 as published by the Free Software Foundation.                                                                      *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied           *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.       *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                             *
;******************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=====**
;Author information
;  Author name: Suhyr Hasan
;  Author email: suhyrhasan@csu.fullerton.edu
;
;Program information
;  Program name: Power Unlimited
;  Programming languages X86 with one module in C++
;  Date development of version 1.5 began 2021-Oct-01
;  Date development of version 1.5 completed 2021-Oct-25
;
;Purpose
;  This assignment teaches you to validate string input then convert it into a float.
;
;Project information
;  Files: maxwell.c, hertz.asm, isfloat.cpp, r.sh
;
;Translator information
;  Linux: nasm -f elf64 -l hertz.lis -o hertz.o hertz.asm
;
;===== Begin code area =======================================================================================================
extern printf                 ;External C++ function for writing to standard output device
extern scanf                  ;External C++ function for reading from the standard input device
extern fgets                  ;Function borrowed from one of the C libraries.
extern strlen                 ;Function borrowed from one of the C libraries.
extern stdin                  ;Standard I/O streams                               
extern isfloat                ;External C++ function for validating string input
extern atof                   ;Converts a string as a floating point number

global hertz                  ;This makes hertz callable by functions outside of this file.  

max_name_size equ 32          ;Maximum number of characters accepted for name input
max_input_size equ 32         ;Maximum number of characters accepted for input

segment .data                 ;Place initialized data here
const dq -1.0                 ;Constant 64-bit floating point -1.0

;=========== Declare some messages ==============================================================================================
intro db "We will find your power." , 10,0
nameprompt db "Please enter your name. You choose the format of your name: ", 0
welcome db "Welcome ", 0
resistanceprompt db "Please enter the resistance in your circuit: ",0
currentprompt db "Please enter the current flow in this circuit: ",0
thanks db "Thank you ", 0
powerprompt db ". Your power consumption is %2.5lf watts.",10,0 
invalidprompt db "Invalid input detected. You may run this program again.",10,0

stringformat db "%s", 0       ;general string format
floatformat db " %lf",0       ;general  8-byte float format

segment .bss                  ;Declare pointers to un-initialized space in this segment.
name resb max_name_size       ;Create char of size max_name_size bytes
resistance resb max_input_size ;Create char of size max_input_size bytes
current resb max_input_size    ;Create char of size max_input_size bytes

;=========== Begin the application here:  =======================================================================================
segment .text                 ;Place executable instructions in this segment.
hertz:                        ;Entry point.  Execution begins here.

;=========== Back up all the GPRs whether used in this program or not =========================================================
push  rbp                     ;Save a copy of the stack base pointer
mov   rbp,rsp                 ;We do this in order to be 100% compatible with C and C++.
push  rdi                     ;Backup rdi
push  rsi                     ;Backup rsi
push  rdx                     ;Backup rdx
push  rcx                     ;Backup rcx
push  r8                      ;Backup r8
push  r9                      ;Backup r9
push  r10                     ;Backup r10
push  r11                     ;Backup r11
push  r12                     ;Backup r12
push  r13                     ;Backup r13
push  r14                     ;Backup r14
push  r15                     ;Backup r15
push  rbx                     ;Backup rbx
pushf                         ;Backup rflags      
;Registers rax, rip, and rsp are usually not backed up.

;=========== Program Intro ====================================================================================================
;Note that at this point there are no vital data in registers to be saved.  Therefore, there is no back up process at this time.
;Ouput intro message
mov  rdi, stringformat        ;"%s"
mov  rsi, intro               ;"We will find your power "
call printf                   ;Call a library function to make the output

;Prompt for programmer's name
mov  rdi, stringformat        ;"%s"
mov  rsi, nameprompt          ;"Please enter your  name... "
call printf                   ;Call a library function to make the output

;Obtain the user's name
mov  rdi, name                ;Copy to rdi the pointer to the start of the array of 32 bytes
mov  rsi, max_name_size       ;Provide to fgets the size of the storage made available for input
mov  rdx, [stdin]             ;stdin is a pointer to the device; rdx receives the device itself
call fgets                    ;C function get a line of text and stop when NULL is encountered or 31 chars have been stored.
    
;Ouput welcome message
mov  rdi, stringformat        ;"%s"
mov  rsi, welcome             ;"Welcome "
call printf                   ;Call a library function to do the output

;Compute the length of the name cstring and outputs on the same line as welcome message
mov rdi, stringformat         ;"%s"
mov rsi, name                 ;Place a pointer to the programmer's name in rsi
call printf                   ;Call a library function to do the output 

;=========== Resistance Input ===================================================================================================
mov  rdi, stringformat        ;"%s"
mov  rsi, resistanceprompt    ;"Please enter the resistance in.. "
call printf                   ;Call a library function to do the output 

;Obtain the resistance input
mov  rdi, stringformat        ;"%s"
mov  rsi, resistance          ;Place a pointer to the resistance input in rsi
call scanf                    ;Call a library function to do the input work

;Check if resistance input is valid
mov rdi, resistance           ;Copy to rdi the pointer to the start of the array of 32 bytes 
call isfloat                  ;Checks if resistance is a valid input
cmp rax, 0                    ;Compares isfloat's return value to 0
je invalid                    ;Jump to the invalid function if isfloat's return equals 0

;Converts string input to float
mov rdi, resistance           ;Copy to rdi the pointer to the start of the array of 32 bytes 
call atof                     ;Convert current input from string to float 
movq xmm13, xmm0              ;Move the value of xmm14 to xmm0

;=========== Current Input ======================================================================================================
mov  rdi, stringformat        ;"%s"
mov  rsi, currentprompt       ;"Please enter the current flow in this circuit: "
call printf                   ;Call a library function to make the output

;Obtain the current input
mov  rdi, stringformat        ;"%s"
mov  rsi, current             ;Place a pointer to the current input in rsi
call scanf                    ;Call a library function to do the input work

;Checks if current input is a valid
mov rdi, current              ;Copy to rdi the pointer to the start of the array of 32 bytes   
call isfloat                  ;Checks if current is a valid input
cmp rax, 0                    ;Compares isfloat's return value to 0
je invalid                    ;Jump to the invalid function if isfloat's return equals 0

;Converts string input to float
mov rdi, current              ;Copy to rdi the pointer to the start of the array of 32 bytes   
call atof                     ;Convert current input from string to float   
movq xmm14, xmm0              ;Move the value of xmm14 to xmm0
jmp valid                     ;Jump to the valid function

;=========== Invalid Input function =============================================================================================
invalid:                      ;Entry point for invalid input function
mov  rdi, stringformat        ;"%s"
mov  rsi, invalidprompt       ;"Invalid input detected.You may run this program again."  
call printf                   ;Call a library function to make the output
movsd xmm14,[const]           ;Place the constant, -1.0, in xmm14
jmp endprogram                ;Jump to the end of the program

;=========== Valid Input Function ===============================================================================================
valid:                        ;Entry point for power consumption calculations

;Calculates power consumption 
mulsd  xmm14, xmm14           ;Square current by multipling current and current
mulsd  xmm14, xmm13           ;Multiply current squared by resistance
         
;Outputs thank you message
mov  rdi, stringformat        ;"%s"
mov  rsi, thanks              ;"Thank you "
call printf                   ;Call a library function to do the output

;Compute the length of the name cstring and outputs on the same line as thank you
mov  rdi, name                ;Copy to rdi the pointer to the start of the array of 32 bytes    
call strlen                   ;Call a library function to do the input work
mov  r13, rax                 ;The length of the string is saved in r13
mov rdi, stringformat         ;"%s"
mov rsi, name                 ;Place a pointer to the programmer's title in rsi
mov byte [rsi + r13 -1], " "  ;replaces newline character with a space
call printf                   ;Call a library function to do the output 

;Outputs power consumption on the same line as thank you and user's name
movsd  xmm0, xmm14            ;Store the value of power consumption in xmm0
mov rax, 1                    ;1 floating point number stored in xmm0 will be outputted
mov rdi, powerprompt          ;"Your power consumption is %1.8lf watts."  
call printf                   ;Call a library function to do the output

;=========== Returns power consumption to the calling program ===================================================================
endprogram:                   ;Entry point for end of program
movsd  xmm0, xmm14            ;Store the value of power consumption in xmm0

;===== Restore the pointer to the start of the stack frame before exiting from this function ====================================
;Epilogue: restore data to the values held before this function was called.
popf                          ;Restore rflags                                                
pop rbx                       ;Restore rbx                                            
pop r15                       ;Restore r15                                          
pop r14                       ;Restore r14                                        
pop r13                       ;Restore r13                                            
pop r12                       ;Restore r12                                       
pop r11                       ;Restore r11                                           
pop r10                       ;Restore r10                                             
pop r9                        ;Restore r9                                        
pop r8                        ;Restore r8                                       
pop rcx                       ;Restore rcx                                            
pop rdx                       ;Restore rdx                                               
pop rsi                       ;Restore rsi                                            
pop rdi                       ;Restore rdi                                           
pop rbp                       ;Restore rbp                                             
;No parameter with this instruction. This instruction will pop 8 bytes from the integer stack, and jump to the address found on the stack.
ret                   ;Pop a qword from the stack into rip, and continue executing.    
;========== End of program hertz.asm =============================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========**
