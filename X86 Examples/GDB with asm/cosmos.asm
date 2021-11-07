;****************************************************************************************************************************
;Program name: "GDB demo x86 assembly".  This program provides a platform where the user can learn how to use the universal *
;debugger "gdb".  The program includes a call to a function written in x86 assembly so that the user can experience how the *
;function call works using gdb.  Copyright (C) 2020  Floyd Holliday                                                         *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu
;
;Program information
;  Program name: GDB demo x86 assembly
;  Programming languages: One module in C++ and one in X86.
;  Date program began: 2020-Apr-20
;  Date of last update: 2020-Apr-22
;  Files in this program: gdb-demo-x86.cpp, cosmos.asm, rg.sh
;
;Purpose
;  This program is a starting point for those learning gdb.  Specifically the user can walk into the assembly function using gdb 
;  commands.
;
;This file:
;  File name: cosmos.asm
;  Language: X86-64
;  Max page width: 132 columns
;  Status: 
;  Assemble: nasm -g dwarf -l opcode.lis -o opcode.o opcode.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: double cosmos(double [], int, long);
;
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

extern printf

extern scanf

global cosmos

segment .data

welcome db "The function cosmos written in x86 assembly has begun", 10, 0
formatdouble db "%1.4lf",10,0
longformat db "The passed in long integer is %ld.",10,0
good_bye db "The cosmos function will now return data to the caller.",10,0
;integersum db "The sum of %ld and %ld is %ld.", 10, 0
;integersubtraction db "The difference of %ld minus %ld is %ld.", 10, 0
;integermultiplication db "The product of %ld times %ld is %ld (least significant bits only).", 10, 0
;integerdivision db "The quotient of %ld divided by %ld is %ld with a remainder %ld.",10,0
;flagmessage db "The value in rflags is 0x%016lx which equals %ld.",10,0
;overflowmessage db "The sum of %ld and %ld is %ld.",10,0

segment .bss

segment .text

cosmos:

;===== Perform standard update of the general purpose registers ===========================================================

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


;Save the incoming data into more 'stable' locations
mov r13, rdi                            ;The array is stored in r13
mov r14d, esi                           ;The size of the array is the lower half of r14 officially known as r14d.
mov r15, rdx                            ;The incoming long integer is store in r15

;Inform the human user that the assembly portion of the program has begun
mov rax, 0
mov rdi, welcome
call printf

;Display the array that was passed in
mov qword r12, 0                         ;r9 is the for loop counter
mov eax,r14d
cdqe
mov r14,rax                             ;The size of the array was extended to all of r14
topofloop:
   cmp r12, r14
   jge bottomofloop
   mov rax, 1
   mov rdi, formatdouble
   movsd xmm0, [r13+8*r12]
   call printf
   inc r12
   jmp topofloop
bottomofloop:

;Show the long integer that was passed in
mov rax, 0
mov rdi, longformat
mov rsi, r15
call printf

;Good-bye message
mov rax,0
mov rdi,good_bye
call printf

;We will send back to the caller the product of the first two numbers in the array.
movsd xmm8,[r13]
movsd xmm9,[r13+8]
mulsd xmm8,xmm9
movsd xmm0,xmm8


;===== Restore all the registers backed up at the start of this function ==========================================================

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

pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret
;End of the discover function =====================================================================================================

