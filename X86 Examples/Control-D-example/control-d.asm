;****************************************************************************************************************************
;Program name: "Control-D Example".  This program demonstrates the use of cntl+d to terminate an input sequence.            *
;Copyright (C) 2018  Floyd Holliday                                                                                         *
;                                                                                                                           *
;This file is part of the software program "Control-D Example".                                                             *                         
;"Control-D Example" is free software: you can redistribute it and/or modify it under the terms of the GNU General Public   *
;License version 3 as published by the Free Software Foundation.                                                            *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 has been distributed with this software.  If not found it is available here:   *
;<https://www.gnu.org/licenses/>.   The copyright holder may be contacted here: holliday@fullerton.edu                      *
;****************************************************************************************************************************
;
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu
;
;Program information
;  Program name: Control D Example
;  Programming languages: One modules in C++, one module in X86-64, and one module in Bash.
;  Date program began: 2018-Feb-12
;  Date of last update: 2018-Feb-13
;  Files in this program: control-d-main.cpp, control-d.asm, r.sh
;  Status: This program was tested over a dozen times on Debian9.3.0 (Feb 2018) without errors.
;  Purpose: The intent of this program is to show how to terminate an input loop with the Cntl-D input.
;
;This file
;  Name: control-d.asm
;  Language: X86-64
;  Syntax: Intel
;  Assemble: nasm -f elf64 -l control-d.lis -o control-d.o control-d.asm
;  Purpose: Set up a loop that terminates on a control-d signal from the keyboard.
;  Max page width: 132 columns
;  Begin comments: column 61
;  Optimal print specification: 132 columns wide, monospace, 8½x11 paper
;
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;===== Begin code area ============================================================================================================

;%include "debug.inc"                                        ;The debug tool was used during the development of this program.

extern printf                                               ;External C++ function for writing to standard output device

extern scanf                                                ;External C++ function for reading from the standard input device

global control_d                                            ;Enable this program to be called from outside this file.

segment .data                                               ;Place initialized data here

;===== Declare some messages ======================================================================================================
;The identifiers in this segment are quadword pointers to ascii strings stored in heap space.  They are not variables.  They are 
;not constants.  There are no constants in assembly programming.  There are no variables in assembly programming: the registers 
;assume the role of variables.

initialmessage db "This X86 program will demonstrate the use of Control-D to terminate a loop.", 10, 0

promptmessage db "Enter a sequence of floating point numbers in base 10 separate each number with white space.  After the last "
              db "valid input press 'enter' followed by a control+D to terminate: ", 10, 0

count_message db "You have entered %1ld floating point numbers.", 10, 0

goodbye db "I hope you like working with 8-byte numbers.  Enjoy your programming.", 10, 0

stringformat db "%s", 0                                     ;general string format

eight_byte_format db "%lf", 0                               ;general 8-byte float format

segment .bss                                                ;Declare pointers to un-initialized space in this segment.

;This segment is empty.

;==================================================================================================================================
;===== Begin the application here: show how to input and output floating point numbers ============================================
;==================================================================================================================================

segment .text                                               ;Place executable instructions in this segment.

control_d:                                                  ;Entry point.  Execution begins here.

;The next two instructions should be performed at the start of every assembly program.
push       rbp                                              ;This marks the start of a new stack frame belonging to this execution
                                                            ;of this function.
mov        rbp, rsp                                         ;rbp holds the address of the start of this new stack frame.  When 
                                                            ;this function returns to its caller rbp must hold the same value it
                                                            ;holds now.
push qword 0                                                ;To stay on the 16-byte boundary pushes (and pops) should be done in
                                                            ;pairs.  This is the other member of the pair pushes: "push rbp" and
                                                            ;"push qword 0".
;=========== Show the initial message =============================================================================================
;Note that at this point there are no vital data in registers to be saved.  Therefore, there is no back up process at this time.

mov qword  rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, initialmessage                              ;"This X86 program will demonstrate the use of Control-D ..."
call       printf                                           ;Call a library function to make the output

;=========== Prompt for a sequence of floating point numbers to be inputted =======================================================

mov qword  rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, promptmessage                               ;"Enter a sequence of floating point numbers in base 10 separate ..."
call       printf                                           ;Call a library function to make the output

;===== Loop to input floating point numbers until Control+D =======================================================================

mov        r15, 0                                           ;Initialize the counter to 0
begin_loop:

push qword 0                                                ;Reserve 8 bytes of storage for the incoming number
mov qword  rax, 0                                           ;SSE is not involved in this scanf operation
mov        rdi, eight_byte_format                           ;"%lf"
mov        rsi, rsp                                         ;Give scanf a pointer to the reserved storage
call       scanf                                            ;Call a library function to do the input work

;|------------Obsolete code removed---------------------------Obsolete code removed---------------------------------|
;|cdq                                                         ;Place into rdx sign-extension of that 32-bit number  |
;|shl rdx, 32                                                 ;Shift the sign extension 32 bits to the left         |
;|or rax, rdx                                                 ;Perform the operation rax = rax or rdx               |
;|------------End of obsolete code removed--------------------End of obsolete code removed--------------------------|

;+++++++++++++Modern code replaced obsolete code++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++|
cdqe                                                        ;Sign extend the integer in eax to all of rax     |
                                                            ;Reference: Ed jorgensen book (Sept 2018), page 79|
;+++++++++++++End of modern code replacing obsolete code++++++++++++++++++++++++++++++++++++++++++++++++++++++|

cmp        rax, -1                                          ;Compare rax with -1
je         loop_finished                                    ;if rax == -1 then exit from the loop
movsd      xmm15, [rsp]                                      ;Copy the inputted number to xmm15, where it will be abandoned.
pop        rax                                              ;Make free the storage that was used by scanf
inc        r15                                              ;Add 1 to the loop counter
jmp        begin_loop                                       ;Repeat the loop one more time.

loop_finished:
pop        rax                                              ;Remove that last remaining push resulting from the loop.
pop        rax                                              ;Remove the 0 that put us on the boundary.
;===== Output the count of numbers entered ========================================================================================

mov qword  rax, 0
mov        rdi, count_message                               ;"You have entered %1ld floating point numbers."
mov        rsi, r15                                         ;Copy the number of inputs to rsi
call       printf                                           ;Call a function in the C language library

;===== Output the good-bye message ================================================================================================

mov        rax, 0
mov        rdi, stringformat                                ;"%s"
mov        rsi, goodbye                                     ;"I hope you like working with 8-byte numbers..."
call       printf                                           ;Call a function in the C language library

;===== For an improved learning experience we'll return to the caller module the last numbered entered. ===========================

movsd       xmm0, xmm15

;===== Restore the pointer to the start of the stack frame before exiting from this function ======================================

pop        rbp                                              ;Now the system stack is in the same state it was when this function
                                                            ;began execution.

ret                                                         ;Pop a qword from the stack into rip, and continue executing..
;========== End of program control-d.asm ==========================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
