;****************************************************************************************************************************
;Program name: "String I/O Demonstration 1.5".  This program demonstrates how to input and output a string with embedded    *
;shite space.  Copyright (C) 2021  Floyd Holliday                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu or activeprofessor@yahoo.com or both
;
;Program information
; Program name: String I/O 1.5
;  Programming languages X86 with one module in C++
;  Date development of version 1.5 began 2021-Aug-19
;  Date development of version 1.5 completed 2021-Aug-19
;
;Purpose
;  This program will serve to introduce X86 programming to new programmers.
;
;Project information
;  Files: good_morning.cpp, hello.asm, run.sh
;  Status: The program has been tested extensively with no detectable errors.
;
;Translator information
;  Linux: nasm -f elf64 -l hello.lis -o hello.o hello.asm
;References and credits
;  Seyfarth, Chapter 11

;Format information
;  Page width: 172 columns
;  Begin comments: 61
;  Optimal print specification: Landscape, 7 points, monospace, 8Â½x11 paper
;
;===== Begin code area ====================================================================================================================================================

extern printf                                               ;External C++ function for writing to standard output device

extern scanf                                                ;External C++ function for reading from the standard input device

extern fgets                                                ;Function borrowed from one of the C libraries.

extern stdin                                                ;Symbolic name of the standard input device.  Usually refers to keyboard.

extern strlen                                               ;Function borrowed from one of the C libraries.

global hello_world                                          ;This makes hello_world callable by functions outside of this file.

max_name_size equ 32                                        ;Maximum number of characters accepted for input

three_point_five equ 0x400C000000000000                     ;3.5 in decimal..

segment .data                                               ;Place initialized data here

;===== Declare some messages ==============================================================================================================================================
;The identifiers in this segment are quadword pointers to ascii strings stored in heap space.  They are not variables.  They are not constants.  There are no constants in
;assembly programming.  There are no variables in assembly programming: the registers assume the role of variables.

align 16                                                   ;Insure that the next data declaration starts on a 16-byte boundary.

initialmessage db "Hello programmer", 10, 0

promptmessage db "What is your name? ", 0

string_length_information db "The number of characters in your name is %2ld",10,0

outputmessage db "It is nice to meet you ", 0

goodbye db "I hope to meet you again.  Enjoy your X86 programming.", 10, 0

stringformat db "%s", 0                                     ;general string format

align 64                                                    ;Insure that the next data declaration starts on a 64-byte boundary.

segment .bss                                                ;Declare pointers to un-initialized space in this segment.

programmers_name resb max_name_size                         ;Create char of size max_name_size bytes

;==========================================================================================================================================================================
;===== Begin the application here: show how to input and output strings ===================================================================================================
;==========================================================================================================================================================================

segment .text                                               ;Place executable instructions in this segment.

hello_world:                                                ;Entry point.  Execution begins here.

;Prolog  Back up the GPRs.  There are 15 pushes here.
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

;=========== Show the initial message =====================================================================================================================================
;Note that at this point there are no vital data in registers to be saved.  Therefore, there is no back up process at this time.

mov qword  rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, initialmessage                             ;"Hello programmer"
call       printf                                           ;Call a C library function to make the output

;=========== Prompt for programmer's name =================================================================================================================================

mov qword  rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, promptmessage                              ;"What is your name? "
call       printf                                           ;Call a library function to make the output

;===== Obtain the user's name =============================================================================================================================================

;------------Old style---------------------------------------------------------------------------------------------------------------------------------------|
;mov qword  rax, 0                                          ;SSE is not involved in this scanf operation                                                     |
;mov        rdi, stringformat                               ;"%s"                                                                                            |
;mov        rsi, hello_world.programmers_name               ;Give scanf a pointer to the reserved storage                                                    |
;call       scanf                                           ;Call a library function to do the input the string; however, this function stops on white space.|
;-----------End of old style---------------------------------------------------------------------------------------------------------------------------------|

mov qword rax, 0                                            ;SSE is not involved in this scanf operation
mov       rdi, programmers_name                             ;Copy to rdi the pointer to the start of the array of 32 bytes
mov       rsi, max_name_size                                ;Provide to fgets the size of the storage made available for input
mov       rdx, [stdin]                                      ;stdin is a pointer to the device; rdx receives the device itself
call      fgets                                             ;Call the C function to get a line of text and stop when NULL is encountered or 31 chars have been stored.

;Compute the length of the inputted cstring.
mov qword rax, 0
mov       rdi, programmers_name
call      strlen
mov       r13, rax                                          ;The length of the string is saved in r13

;Output the length of the user's name cstring
mov qword rax, 0
mov       rdi, string_length_information
mov       rsi, r13
call      printf

;===== Reply to the user ==================================================================================================================================================

mov        rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, outputmessage                               ;"It is nice to meet you "
call       printf                                           ;Call a library function to do the output

mov        rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, programmers_name                            ;Place a pointer to the programmer's name in rsi
call       printf                                           ;Call a library function to do the output

;======= Show farewell message ============================================================================================================================================

mov qword rax, 0                                            ;No data from SSE will be printed
mov       rdi, stringformat                                 ;"%s"
mov       rsi, goodbye                                      ;"I hope to meet you again.  Enjoy your X86 programming."
call      printf                                            ;Call a library function to do the output

;======= Return the nice number, that is now stored in a named constant, to the calling program. ===========================================================

mov       rax, qword three_point_five                       ;The goal is to put a copy of 3.5 in xmm0
push      rax                                               ;Now three_point_five is on top of the stack
movsd     xmm0, [rsp]                                       ;Now there is a copy of 3.5 in xmm0
pop       rax                                               ;Return the stack to its former state

;===== Restore the pointer to the start of the stack frame before exiting from this function ===============================================================

;Epilogue: restore data to the values held before this function was called.
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp               ;Restore the base pointer of the stack frame of the caller. 
;Now the system stack is in the same state it was when this function began execution.

ret                                                         ;Pop a qword from the stack into rip, and continue executing.
;========== End of program hello_world.asm ================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
