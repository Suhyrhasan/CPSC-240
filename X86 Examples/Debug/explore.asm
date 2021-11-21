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
;Date of last update: December 17, 2019
;Files in this program: mainprogram.cpp, explore.asm, debug.asm, debug.inc, r.sh
;Status: Done.  No more updates will be performed.

;Purpose: Demonstrate the ability of the static debugger named TAP to display data at runtime.
;This will be a tool for assembly programming fans everywhere.


;Protoype of this test function: long discovery();

;This file
;   File name: explore.asm
;   Language: X86
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l exp.lis -o exp.o explore.asm
;   Calling name: discovery
;   Parameters passed in: none
;   Parameter passed out: one 64-bit integer


;===== Begin code area ==============================================================================================================
%include "debug.inc"                                      ;Debug tool not used in this program.
extern printf

extern getchar

extern showgprs

global exploration

segment .data

welcome db "The X86 module exploration has begun executing.  No parameters were received by this asm module.", 10, 10, 0

gpr_message db "The static debug function that shows GPRs will be called.",10,0

press_enter_key db "Press the enter key one time to continue",0

stack_message db "The static debug function that shows the region at the top of the system stack will be called.",10,0

xmm_message db "The static debug function that shows the xmm registers will be called.",10,0

ymm_message db "The static debug function that shows the ymm registers will be called.",10,0

newline db 10,0

goodbye db "This X86 module discovery will now gently terminate by returning control to the caller.", 10, 0

intformat db "%016lx\n",0

segment .bss  ; Reserved for uninitialized arrays
;Empty

segment .text

exploration:

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
push qword 0                                                ;Artificial push in order that the total number of pushes is even (16)

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
mov r8, 9
mov r9, 10
mov r10, 11
mov r11, 12
mov r12, 13
mov r13, 14
mov r14, 15
mov r15, 16



;===== Call showregisters ========================================================================================================

;Explain that all general purpose registers will be displayed.
mov rax, 0
mov rdi, gpr_message
call printf

showregisters 13      ;Show the values in all general purpose registers

;Output a blank separator line
mov rax, 0
mov rdi, newline
call printf

mov rax, 0
mov rdi, press_enter_key
call printf

call getchar

;===== Call dumpstack ============================================================================================================

;Explain that the system stack will be displayed near the top of the stack.
mov rax, 0
mov rdi, stack_message
call printf

;Push some integers on the stack so that we can view them using dumpstack
push qword -1
push qword 15
push qword 100
push qword 256

;By default dumpstack is based at rbp.  We assign to rbp the address where we want to center dumpstack
mov rbp, rsp
dumpstack 29, 3, 9    ;29 is arbitrary, 3 = qwords with addresses < rbp, 9 = qwords with addresses > rbp 

;Output a blank separator line
mov rax, 0
mov rdi, newline
call printf

;Remove from the stack 4 previous pushes.
pop rax                                                     ;Discard push 256
pop rax                                                     ;Discard push 100
pop rax                                                     ;Discard push 15
pop rax                                                     ;Discard push -1

mov rax, 0
mov rdi, press_enter_key
call printf

call getchar

;===== Call showxmmregisters =====================================================================================================

;Explain that the SSE registers known by the name xmm will be displayed next.
mov rax, 0
mov rdi, xmm_message
call printf

; Put some floating numbers in low-numbered registers 

mov rax, 0x4023800000000000
push rax
movsd xmm0, [rsp]
pop rax

mov rax, 0x404F000000000000
push rax
movsd xmm1,[rsp]
pop rax

showxmmregisters 55   ;55 is an arbitrary integer

;Output a blank separator line
mov rax, 0
mov rdi, newline
call printf

mov rax, 0
mov rdi, press_enter_key
call printf

call getchar

;===== Call showymmregisters =====================================================================================================

;Explain the the AVX registers known as ymm will be displayed next.
mov rax, 0
mov rdi, ymm_message
call printf

;First we'll put some numbers in a ymm vector and then ask showymmregisters to confirm those numbers were placed correctly.
mov rax, 0x3fff000000000000
push rax
mov rax, 0x4018000000000000
push rax
mov rax, 0x4029000000000000
push rax
mov rax, 0x404c000000000000
push rax
vmovupd ymm3, [rsp]     ;Now there are 4 numbers in ymm3.  Next we clean up the stack.
pop rax
pop rax
pop rax
pop rax
;Next we ask showymmregisters to confirm that the 4 float numbers are really in ymm3.

showymmregisters 92   ;92 is an arbitrary integer

mov rax, 0
mov rdi, press_enter_key
call printf

call getchar

;===== Call showfpuregisters =====================================================================================================

;Place a few floating point numbers on the FPU stack so that we can see then with showfpu
push qword 0x0000000000004003
push qword 0
mov dword [rsp+4], 0xaaaabbbb
mov dword [rsp], 0xccccdddd
fld tword [rsp]                           ;Load the 80-bit float number 0x4003aaaabbbbccccdddd into slot st0
fld1                                      ;Load the float number 1.0 into st0, previous st0 advances to st1
push qword 8                              ;Place the integer 8 on to the system stack
fild qword [rsp]                          ;Convert integer 8 to 8.0 and load it into register st1; all others advance 1 register.

;Next ask showfpuregisters to show us the content of the eight FPU registers.
showfpuregisters 999

pop rax             ;Reverse an earlier push
pop rax             ;Reverse an earlier push
pop rax             ;Reverse an earlier push

;End of demonstrating 5 debugging tools: showregisters, dumpstack, showxmmregisters, showymmregisters, showfpu

pop rax                                                     ;Discard the artificial push
;===== Select a value to send to the caller ======================================================================================

;What shall we send to the caller?  How about sending 101 (decimal)?

mov rax, 0x65

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


