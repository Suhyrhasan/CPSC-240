;******************************************************************************************************************************
;Program name: "Area of Triangle". This program will input 3 float numbers representing the lengths of three sides of one     *
;triangle. Then it uses Huron’s formula to obtain the area. Copyright (C) 2021  Suhyr Hasan                                   *
;                                                                                                                             *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License    *
;version 3 as published by the Free Software Foundation.                                                                      *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied           *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.       *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                             *
;******************************************************************************************************************************
;========1=========2=========3=========4=========5=========6========1=========2=========3=========4=========5=========6========**
;Author information
; Author name: Suhyr Hasan
; Author class: CPSC240 -01
; Author email: Suhyrhasan@csu.fullerton.edu
;
;Program information
; Program name: Area of Triangle
; Programming languages X86 with one module in C++ and 3 modules in C
;
;Purpose
; This program will read in 3 float numbers representing the lengths of three sides of one triangle. Then it uses
; Huron’s formula to obtain the area. Huron’s formula: semi perimeter = (a+b+c)/2 , area = sqrt(s(s-a)(s-b)(s-c))
;
;Project information
; Files: isfloat.cpp, output_area.c, output_error_message.c, triangle.c, huron.asm, r.sh, rg.sh
;
;Translator information
; Linux: nasm -f elf64 -l huron.lis -o huron.o huron.asm
;===== Begin code area ==========================================================================================================
extern printf                 ;External C++ function for writing to standard output device
extern scanf                  ;External C++ function for reading from the standard input device
extern strlen                 ;Function borrowed from one of the C libraries.
extern stdin                  ;Standard I/O streams

extern isfloat                ;External C++ function for validating string input
extern output_area            ;External C++ function for outputing the area
extern output_error_message   ;External C++ function for outputing an error message
extern atof                   ;Converts a string as a floating point number

global huron                  ;This makes huron callable by functions outside of this file.

max_input_size equ 32         ;Maximum number of characters accepted for input

segment .data                 ;Place initialized data here
const_two dq 2.0              ;Constant 64-bit floating point 2.0
const_zero dq 0.0             ;Constant 64-bit floating point 0.0
;=========== Declare some messages ==============================================================================================
intro db "We find any area." , 10,0

firstprompt db  "Please enter the length of the first side:  ",0
secondprompt db "Please enter the length of the second side: ",0
thirdprompt db  "Please enter the length of the third side:  ",0

sides db "The three sides are %1.5lf   %1.5lf   %1.5lf.",10,0
semiperimeter db "The semi-perimeter is %1.6lf.",10,0 
goodbye db "The area will be returned to the driver.",10,0

stringformat db "%s", 0       ;general string format
floatformat db " %lf",0       ;general  8-byte float format

segment .bss                  ;Declare pointers to un-initialized space in this segment.
first resb max_input_size     ;Create char of size max_name_size bytes
second resb max_input_size    ;Create char of size max_input_size bytes
third resb max_input_size     ;Create char of size max_input_size bytes

;=========== Begin the application here:  =======================================================================================
segment .text                 ;Place executable instructions in this segment.
huron:                        ;Entry point.  Execution begins here.

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
;Note that at this point there are no vital data in registers to be saved. Therefore, there is no back up process at this time.

;Ouputs intro message
mov  rdi, stringformat        ;"%s"
mov  rsi, intro               ;"We find any area."
call printf                   ;Call a library function to make the output

;=========== First Side Input ===================================================================================================
side1_input:                  ;Entry point for input side 1 function

mov  rdi, stringformat        ;"%s"
mov  rsi, firstprompt         ;"Please enter the length of the first side: "
call printf                   ;Call a library function to do the output 

;Obtains the first input
mov  rdi, stringformat        ;"%s"
mov  rsi, first               ;Place a pointer to the first input in rsi
call scanf                    ;Call a library function to do the input work

;Check if first input is valid
mov rdi, first                ;Copy to rdi the pointer to the start of the array of 32 bytes 
call isfloat                  ;Checks if first input is a valid input
cmp rax, 0                    ;Compares isfloat's return value to 0
je invalid_input1             ;Jump to the invalid input 1 function if isfloat's return equals 0

;Converts string input to float
mov rdi, first                ;Copy to rdi the pointer to the start of the array of 32 bytes 
call atof                     ;Convert first input from string to float 
movq xmm10, xmm0              ;Move the value of xmm0 to xmm10
jmp side2_input               ;Jump to the input side 2 function

;----------------------------- Invalid Input 1 -----------------------------
invalid_input1:               ;Entry point for invalid input 1 function
jmp side1_input              ;Jump to the input side 1 function

;=========== Second Side Input ==================================================================================================
side2_input:                  ;Entry point for input side 2 function

mov  rdi, stringformat        ;"%s"
mov  rsi, secondprompt        ;"Please enter the length of the second side: "
call printf                   ;Call a library function to make the output

;Obtains the second input
mov  rdi, stringformat        ;"%s"
mov  rsi, second              ;Place a pointer to the second input in rsi
call scanf                    ;Call a library function to do the input work

;Check if second input is valid
mov rdi, second               ;Copy to rdi the pointer to the start of the array of 32 bytes 
call isfloat                  ;Checks if second input is a valid input
cmp rax, 0                    ;Compares isfloat's return value to 0
je invalid_input2             ;Jump to the invalid input 2 function if isfloat's return equals 0

;Converts string input to float
mov rdi, second               ;Copy to rdi the pointer to the start of the array of 32 bytes   
call atof                     ;Convert second input from string to float   
movq xmm11, xmm0              ;Move the value of xmm0 to xmm11
jmp side3_input               ;Jump to the input side 3 function

;----------------------------- Invalid Input 2 -----------------------------
invalid_input2:               ;Entry point for invalid input 2 function
jmp side2_input              ;Jump to the input side 2 function

;=========== Third Side Input ===================================================================================================
side3_input:                  ;Entry point for input side 3 function

mov  rdi, stringformat        ;"%s"
mov  rsi, thirdprompt         ;"Please enter the length of the third side:"
call printf                   ;Call a library function to make the output

;Obtains the third input
mov  rdi, stringformat        ;"%s"
mov  rsi, third               ;Place a pointer to the third input in rsi
call scanf                    ;Call a library function to do the input work

;Check if third input is valid
mov rdi, third                ;Copy to rdi the pointer to the start of the array of 32 bytes 
call isfloat                  ;Checks if third input is a valid input
cmp rax, 0                    ;Compares isfloat's return value to 0
je invalid_input3             ;Jump to the invalid input 3 function if isfloat's return equals 0

;Converts string input to float
mov rdi, third                ;Copy to rdi the pointer to the start of the array of 32 bytes   
call atof                     ;Convert third input from string to float   
movq xmm12, xmm0              ;Move the value of xmm0 to xmm12
jmp valid                     ;Jump to the valid function

;----------------------------- Invalid Input 3 -----------------------------
invalid_input3:               ;Entry point for invalid input 3 function
jmp side3_input               ;Jump to the input side 3 function

;=========== Valid Input Function ===============================================================================================
valid:                        ;Entry point for Huron’s formula calculations

;Outputs the three sides
movsd xmm0, xmm10             ;Store the value of the first  side in xmm0
movsd xmm1, xmm11             ;Store the value of the second side in xmm1
movsd xmm2, xmm12             ;Store the value of the third  side in xmm2

mov rax, 3                    ;3 floating point numbers stored in xmm0,1,and 2 will be outputted
mov rdi, sides                ;"The three sides are %1.5lf   %1.5lf   %1.5lf." 
call printf                   ;Call a library function to do the output

;----------------------------- Calculate the semi-perimeter -----------------------------
;Calculate (a + b + c)/2
movsd  xmm13,[const_zero]     ;Place the constant, 0.0,  in xmm13
addsd  xmm13, xmm10           ;Add side 1 then store it in xmm13
addsd  xmm13, xmm11           ;Add side 2 then store it in xmm13
addsd  xmm13, xmm12           ;Add side 3 then store it in xmm13
divsd  xmm13,[const_two]      ;Divide the sum by the constant, 2.0

;Outputs the semiperimeter
movsd xmm0, xmm13             ;Store the value of the semi-perimeter in xmm0
mov rax, 1                    ;1 floating point numbers stored in xmm0 will be outputted
mov rdi, semiperimeter        ;"The semi-perimeter is %1.6lf." 
call printf                   ;Call a library function to do the output

;---------------------------------- Calculate the area ----------------------------------
;Calculate (s-a)
movsd  xmm7, xmm13           ;Store the value of the semi-perimeter in xmm7
subsd  xmm7, xmm10           ;Subtract the semi-perimeter from side 1

;Calculate (s-b)
movsd  xmm8, xmm13           ;Store the value of the semi-perimeter in xmm8
subsd  xmm8, xmm11           ;Subtract the semi-perimeter from side 2

;Calculate (s-c)
movsd  xmm9, xmm13           ;Store the value of the semi-perimeter in xmm9
subsd  xmm9, xmm12           ;Subtract the semi-perimeter from side 3

;Multiply (s(s-a)(s-b)(s-c))
movsd  xmm14, xmm13          ;Store the value of the semi-perimeter in xmm14
mulsd  xmm14, xmm7           ;Multiply the semi-perimeter by (s-a)
mulsd  xmm14, xmm8           ;Multiply the product by (s-b)
mulsd  xmm14, xmm9           ;Multiply the product by (s-c)

;Verify if triangle is valid
ucomisd xmm14, [const_zero]   ;Compare value in xmm14 to the constant, 0
jb invalid_triangle           ;Jump to invalid_triangle if xmm14 is negative

;If triangle is valid then sqrt(s(s-a)(s-b)(s-c))
sqrtsd xmm14, xmm14           ;Square root the  product to find the area
movsd xmm0, xmm14             ;Store the area in xmm0 so it can return the value to output_area function
call output_area              ;Call output_area function to output area
jmp endprogram                ;Jump to the end of the program 

;=========== If triangle is invalid =============================================================================================
invalid_triangle:             ;Entry point for invalid triangle function

movsd xmm14,[const_zero]      ;Place the constant, 0.0, in xmm15

call output_error_message     ;Calls output_error_message function to output error message
jmp endprogram                ;Jump to the end of the program 

;=========== Returns the area of the triangle to the calling program ============================================================
endprogram:                   ;Entry point for end of program

;Outputs the end of program message
mov  rdi, stringformat        ;"%s"
mov  rsi, goodbye             ;"The area will be returned to the driver."
call printf                   ;Call a library function to do the output
movsd  xmm0, xmm14            ;Store the value of the area in xmm0

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
