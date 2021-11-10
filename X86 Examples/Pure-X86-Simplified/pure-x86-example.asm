;****************************************************************************************************************************
;Program name: "Pure X86 Simplified".  This program demonstrates how to create and use an X86 program in an environment     *
;devoid of all supporting functions written originally in a non-X86 language.  Copyright (C) 2018  Floyd Holliday           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************





;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;Author information
;   Author name: Floyd Holliday
;   Author's email: holliday@fullerton.edu

;Program information
;   Program name: Pure X86 Simplified
;   Programming languages use:  X86 only.
;   Date program development began: 2019-Nov-11
;   Date of last update of source code: 2019-Nov-12
;   Date of last modification of comments: 2019-Nov-18
;   Files in this program: pure-x86-io.asm, run.sh
;   Status: The program executes correctly.  The program does not accept user inputs.

;Purpose
;   Demonstrate one example of x86 program which performs as follows:
;      #Is not called by any function originally written in a non-X86 language
;      #Does not call any other function written in a non-X86 programming language whatsoever.

;   Academic lessons learned:
;   1. How to make an X86 program without using a driver program.  
;   2. How to output string data using a system call (directly to the kernel). 

;   Sequence of input parameters for syscalls: rax, rdi, rsi, rdx, r10, r8, and r9.  The return value is in rax, if needed.

;   References:  http//en/wikibooks.org/wiki/X86_Assembly/Interfacing_with_Linux.
;   Textbook (ebook):  Jorgensen, X86-64 Assembly Language Programming, Chapter 13.

;Module information
;   Language: X86-64
;   Syntax: Intel
;   Purpose: This module is the "main".  Execution starts here.
;   File name: pure-x86-example.asm

;Translator information
;   Linux assembler: nasm -f elf64 -o x86-io.o -l x86-io.lis x86-io.asm
;   Linux linker:    ld  -o x86-io.out x86-io.o
;   Note that the switch "-f elf64" indicates compilation for a Linux environment.  If this software is ported to a Windows environment
;   then that switch must be modified.

;Conclusion directed to programmers enrolled in the 240 class.
;   I don't think that programming X86 in isolation (without C or C++ included) is the way to learn X86 programming.  It is an 
;   interesting academic exercise to see an assembly program that does not need a driver, but that's not the way to learn this tech-
;   nology.  Dr Paul Carter had it right (www.drpaulcarter.com) when he taught X86 using a C driver, and of course, using all the 
;   functions in the C library.  Dr Carter's website still has a free ebook that he wrote and used in his course long ago

;===== Begin main assembly program here ===================================================================================================================================
global _start                                               ;The global declaration is required by the linker.  Without this declaration the linker will fail.

section .data                                  
newline db 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0xa           ;Declare an array of 8 bytes where each byte is initialize with ascii value 10 (newline)                                   
tab db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20       ;Declare an array of 8 bytes where each byte is initialize with 32 (blank space).  Thus, this array equals 
                                                            ;one standard tab.
hello       db "Hello. I am a Computer Science Major."
programming db "I selected this major because I like programming."
special     db "I specialize in hardware/software interface issues."
plans       db "I plan to write device drivers for Radeon video cards in my future career."
bye         db "This program will cannot return you to a driver because there is no driver.  Have a nice evening.  Bye."

section .bss                                                ;This section is currently empty.

section .text                                               ;The executable area begins here.
_start:                                                     ;Main entry point.  Execution begins here.  The name must be _start.  
;                                                           ;This is a requirement since there is no driver program.

;There is no backup of registers because there is not caller.  We only backup registers to protect the data belonging to the caller.

;===== Next perform some test cases ======

;Output the first 15 bytes of string hello
mov        rax, 1                                           ;1 is the code number of the kernel function to be called.
mov        rdi, 1                                           ;1 = number of stdout
mov        rsi, hello                                       ;The starting address of the string hello is in rdi.
mov        rdx, 15                                          ;15 = number of bytes to output
syscall

;Output a newline
mov        rax, 1
mov        rdi, 1
mov        rsi, newline
mov        rdx, 1
syscall

;Output the 14 bytes of the string programming beginning with the char number 30
mov        rax, 1
mov        rdi, 1
mov        rsi, programming
add        rsi, 30
mov        rdx, 14
syscall

;Output a newline
mov        rax, 1
mov        rdi, 1
mov        rsi, newline
mov        rdx, 1
syscall

;Output the string special starting at char number 34 for a total of 32 char
mov        rax, 1
mov        rdi, 1
mov        rsi, special
add        rsi, 34
mov        rdx, 32
syscall

;Output a newline
mov        rax, 1
mov        rdi, 1
mov        rsi, newline
mov        rdx, 1
syscall

;Put something meaningful on top of the stack
mov        rax, 0x1021796164687472
push       rax
mov        rax, 0x6942207970706148
push       rax
mov        rax, 1
mov        rdi, 1
mov        rsi, rsp
mov        rdx, 16
syscall

;Output a newline
mov        rax, 1
mov        rdi, 1
mov        rsi, newline
mov        rdx, 1
syscall


;=====Now exit from this program and return control to the OS =============================================================================================================
mov        rax, 60                                          ;60 is the number of the syscall subfunction that terminates an executing program.
mov        rdi, 0                                           ;0 is the error code number that will be returned to the OS; 0 means no errors.
syscall
;We cannot use an ordinary ret instruction here because this program was not called by some other module.  The program does not know where to return to.


;===== End of program _start ==============================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**



;Post mortum: What was accomplished?  We discovered how to output a string of contiguous ascii values without using a library function like printf.

;The author's opinion: Forget about syscalls unless you are in an operating system class and you simply have to study the kernel.
;If your goal is simply to learn the basics of programming then be happy for the all the library functions that are available to you.
;Stop trying to be a purist.  Start programming with libraries.
;  --Your prof on Nov 18, 2019.
