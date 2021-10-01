;****************************************************************************************************************************
;Program name: "Show GPRS Utility".  This program demonstrates how an X86 module can show its own General Purpose Registers *
;by calling to this utillity.  Copyright (C) 2019 Floyd Holliday                                                            *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Floyd Holiday
;  Author email: holliday@fullerton.edu
;
;Program name: ShowGPRs Utility
;Programming languages of the utility: X86 
;Date program began: April 2, 2017
;Date of last update: February 17, 2019
;Files in this program: showgprs.asm (utility), test-gprs.cpp, discover.asm, r.sh
;Status: Done.  No more updates will be performed.

;Purpose: Test the utility program showgprs.  A piece of software is said to be a utility program if that software has no specific
;purpose of its own.  It only exists to help someone else achieve a goal.  That is the case with showgprs.

;Protoype of this test function: long discovery();

;This file
;   File name: discover.asm
;   Language: X86
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l discover.lis -o discov.o discover.asm
;   Calling name: discovery
;   Parameters passed in: none
;   Parameter passed out: one 64-bit integer


;===== Begin code area ==============================================================================================================
;;%include "debug.inc"                                      ;Debug tool not used in this program.
extern printf

extern showgprs

global discovery


segment .data

welcome db "The X86 module discovery has begun executing.  No parameters were received by this asm module.", 10, 0

numbers_in_the_array db "The array contains:",10,"%ld",10,"%ld",10,"%ld",10,"%ld",10,"%ld",10,"%ld",10,"%ld",10,0

goodbye db "This X86 module discovery will now gently terminate.", 10, 0

segment .bss  ; Reserved for uninitialized arrays
;Empty

segment .text

discovery:

;===== Backup all the GPRs ========================================================================================================
push rbp                                                    ;Backup the base pointer
mov  rbp,rsp                                                ;Advance the base pointer to start of the current stack frame
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11: printf often changes r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;Registers rax, rip, and rsp are usually not backed up.


;===== Output initial messages ====================================================================================================

mov rax, 0
mov rdi, welcome
call printf


;===== Assign to GPRs some numbers we can track ===================================================================================

mov rax, 1
mov rbx, 2
mov rcx, 3
mov rdx, 4
mov rsi, 5,
mov rdi, 6
mov rbp, 7
;mov rsp, 8 <==Don't do this: the program will crash.
mov r8, 9
mov r9, 10
mov r10, 11
mov r11, 12
mov r12, 13
mov r13, 14
mov r14, 15
mov r15, 16


call showgprs  ;Call the subprogram that will show us the content of all 16 general purpose registers.



;===== Time to exit from this X86 module =========================================================================================

mov rax, 0
mov rdi, goodbye                                            ;"This X86 module will now gently terminate by re-setting rbp to ..."
call printf


;===== Select a value to send to the caller ======================================================================================

;What shall we send to the caller?  How about sending one hundred?

mov rax, 100


;===== Restore original values to integer registers ===============================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret


