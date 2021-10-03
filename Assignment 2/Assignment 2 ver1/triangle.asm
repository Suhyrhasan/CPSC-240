;******************************************************************************************************************************
;Program name: "The Right Triangles Program". This program demonstrates how to input and output a float in assembly with      *
;proper formatting. The X86 function calcutes the area and hypotenuse of a right triangle, and the C++ receives and outputs   *
;the hypotenuse with changes included.  Copyright (C) 2021  Suhyr Hasan                                                       *
;                                                                                                                             *
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
; Program name: The Right Triangles Program
;  Programming languages X86 with one module in C
;  Date development of version 1.5 began 2021-Sep-10
;  Date development of version 1.5 completed 2021-Sep-21
;
;Purpose
;  In this assignment teaches you how to input and output a float in assembly with proper formatting
;
;Project information
;  Files: pythagoras.c, triangle.asm, run.sh
;
;Translator information
;  Linux: nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm
;
;References and credits
;  Jorgensen, Chapter 18
;===== Begin code area =======================================================================================================
extern printf                 ;External C++ function for writing to standard output device
extern scanf                  ;External C++ function for reading from the standard input device
extern fgets                  ;Function borrowed from one of the C libraries.
extern strlen                 ;Function borrowed from one of the C libraries.
extern stdin                  ;Standard I/O streams                               
extern strtod                 ;Interprets a string as a floating point number and return its value as a double

global floating               ;This makes floating callable by functions outside of this file.                        

max_name_size equ 32          ;Maximum number of characters accepted for name input
max_title_size equ 15         ;Maximum number of characters accepted for title input
two_point_zero equ 0x4000000000000000  ;Use the hex expression for 64-bit floating point 2.0

segment .data                  ;Place initialized data here
;=========== Declare some messages ==============================================================================================
;The identifiers in this segment are quadword pointers to ascii strings stored in heap space.They are not variables.  
;They are not constants. There are no constants in assembly programming.  There are no variables in assembly programming: 
;the registers assume the role of variables.

align 16                       ;Insure that the next data declaration starts on a 16-byte boundary.

nameprompt db "Please enter your last name: ", 0
titleprompt db "Please enter your title (Mr, Ms, Nurse, Engineer, etc): ", 0
inputprompt db "Please enter the sides of your triangle separated by ws: ",0
areaprompt db "The areas of this triangle is %5.5lf square units.",10,0 
hypotenuseprompt db "The length of the hypotenuse is %5.9lf units.",10,0
goodbye db "Please enjoy your triangles ",0  

stringformat db "%s", 0       ;general string format
twofloatformat db "%lf %lf",0 ;general 2 8-byte float format
align 64                      ;Insure that the next data declaration starts on a 64-byte boundary.

segment .bss                  ;Declare pointers to un-initialized space in this segment.
name resb max_name_size       ;Create char of size max_name_size bytes
title resb max_title_size     ;Create char of size max_title_size bytes

;=========== Begin the application here: show how to input and output floats ===================================================
segment .text                 ;Place executable instructions in this segment.
floating:                     ;Entry point.  Execution begins here.

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
push qword 0

;=========== Prompt for programmer's name =====================================================================================
;Note that at this point there are no vital data in registers to be saved.  Therefore, there is no back up process at this time.
mov  rax, 0                  ;A zero in rax means printf uses no data from xmm registers.
mov  rdi, nameprompt         ;"Please enter your last name: "
call printf                  ;Call a library function to make the output

;=========== Obtain the user's name ============================================================================================
mov  rdi, name                ;Copy to rdi the pointer to the start of the array of 32 bytes
mov  rsi, max_name_size       ;Provide to fgets the size of the storage made available for input
mov  rdx, [stdin]             ;stdin is a pointer to the device; rdx receives the device itself
call fgets                    ;Call the C function to get a line of text and stop when NULL is encountered or 31 chars have been stored.

;=========== Prompt for programmer's title =====================================================================================
mov  rax, 0                   ;A zero in rax means printf uses no data from xmm registers.
mov  rdi, stringformat        ;"%s"
mov  rsi, titleprompt         ;"Please enter your title (Mr, Ms, Nurse, Engineer, etc): "
call printf                   ;Call a library function to make the output

;=========== Obtain the user's title ============================================================================================
mov  rdi, title               ;Copy to rdi the pointer to the start of the array of 32 bytes
mov  rsi, max_title_size      ;Provide to fgets the size of the storage made available for input
mov  rdx, [stdin]             ;stdin is a pointer to the device; rdx receives the device itself
call fgets                    ;Call the C function to get a line of text and stop when NULL is encountered or 31 chars have been stored.

;=========== Prompt for the user asking for inputs =============================================================================
push qword 99                 ;Get on the boundary
mov  rax, 0                   ;A zero in rax means printf uses no data from xmm registers
mov  rdi, inputprompt         ;"Please enter the sides of your triangle separated by ws: "
call printf                   ;Call a library function to make the output
pop  rax                      ;Reverse the push in the scanf block
push qword 99                 ;Get on boundary

;=========== Obtain the sides of the user's triangle ============================================================================
push qword -1                 ;Create space for 2 float numbers
push qword -2                 ;Create space for 2 float numbers
mov rax, 0                    ;A zero in rax means printf uses no data from xmm registers
mov rdi, twofloatformat       ;"%lf%lf"
mov rsi, rsp                  ;rsi points to first quadword on the stack
mov rdx, rsp                 
add rdx, 8                    ;rdx points to second quadword on the stack
call scanf                    ;Call a library function to do the input work

;=========== Stores the user's sides input ======================================================================================
movsd xmm12, [rsp]            ;Place user float input for side 1 in xmm12
movsd xmm13, [rsp+8]          ;Place user float input for side 2 in xmm13

movsd xmm8,  [rsp]            ;Place user float input for side 1 in xmm8
movsd xmm9,  [rsp+8]          ;Place user float input for side 2 in xmm13

pop rax                       ;Reverse the previous "push qword -2"
pop rax                       ;Reverse the previous "push qword -1"
pop rax                       ;Reverse the previous "push qword 99"
push qword 99                 ;Get on boundary  

;=========== Calculate the area =================================================================================================    
mulsd xmm8, xmm9              ;Multiple side 1 and side 2
mov r10 , two_point_zero      ;Place the constant, 2.0, in r15
push r10                      ;Now r15 is on top of the stack
divsd xmm8, [rsp]             ;Divide the input numbers by the constant, 2.0
pop r10                       ;Return the stack to its former state
movsd xmm0, xmm8              ;Stores the value of area in xmm0

;=========== Output the area ====================================================================================================
mov rax, 1                    ;1 floating point number stored in xmm0 will be outputted
mov rdi, areaprompt           ;"The areas of this triangle is %5.5lf square units.
call printf                   ;Call a library function to do the output

;=========== Calculate the a hypotenuse =========================================================================================  
mulsd  xmm12, xmm12           ;Square side 1 by multipling side 1 and side 1
mulsd  xmm13, xmm13           ;Square side 2 by multipling side 2 and side 2
addsd  xmm12, xmm13           ;Add (side 1)^2 (side 2)^2 then store it in xmm12
sqrtsd xmm12, xmm12           ;Square root/hypotenuse
movsd xmm0, xmm12             ;Store the value of hypotenuse in xmm0

;=========== Outputs the a hypotenuse ===========================================================================================
mov rax, 1                    ;1 floating point number stored in xmm0 will be outputted
mov rdi, hypotenuseprompt     ;"The length of the hypotenuse is %5.9lf units."    
call printf                   ;Call a library function to do the output

pop rax                       ;Rverse previous "push qword 99"
pop rax                       ;Reverse the push near the beginning of this asm function.

;=========== Show farewell message ==============================================================================================            
mov qword  rax, 0             ;No data from SSE will be printed
mov  rdi, stringformat        ;"%s"
mov  rsi, goodbye             ;"Please enjoy your triangles "
call printf                   ;Call a library function to do the output
    
;=========== Compute the length of the title cstring ============================================================================
mov qword  rax, 0             ;No data from SSE will be printed
mov  rdi, title               ;Copy to rdi the pointer to the start of the array of 32 bytes        
call strlen                   ;Call a library function to do the input work
mov  r13, rax                 ;The length of the string is saved in r13
    
;=========== Outputs title on the same line as good_bye =========================================================================
mov  rdi, stringformat        ;"%s"
mov  rsi, title               ;Place a pointer to the programmer's title in rsi
mov byte [rsi + r13 - 1], " " ;replaces newline character with a space
call printf                   ;Call a library function to do the output 

;=========== Compute the length of the name cstring =============================================================================
mov  rdi, name                ;Copy to rdi the pointer to the start of the array of 32 bytes       
call strlen                   ;Call a library function to do the input work
mov  r13, rax                 ;The length of the string is saved in r13

;=========== Outputs name on the same line as good_bye ==========================================================================
mov rdi, stringformat         ;"%s"
mov rsi, name                 ;Place a pointer to the programmer's title in rsi
mov byte [rsi + r13 -1], " "  ;replaces newline character with a space
call printf                   ;Call a library function to do the output 

;=========== Returns hypotenuse to the calling program ==========================================================================
movsd xmm0, xmm12              ;Select the largest value for return to caller.

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
ret     
;========== End of program triangle.asm =========================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========**
