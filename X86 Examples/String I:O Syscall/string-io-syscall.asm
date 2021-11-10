;***************************************************************************************************************************
;Program name: "String I/O Syscall".  This program demonstrates how to input and output string data using only system      *
;services.  Copyright (C) 2020 Floyd Holliday.                                                                             *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License *
;version 3 as published by the Free Software Foundation.                                                                   *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                          *
;***************************************************************************************************************************

;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu
;
;Program information
;  Program name: String I/O Syscall
;  Programming languages: X86 exclusive: no calls to function in non-X86 libraries
;  Date program began:     2020-Jan-15
;  Date program completed: 2020-Jan-16
;  Date of last update:    2020-Jan-19
;  Files in this program: string-io-syscall.asm, r.sh
;  Status: Complete.  No errors found after extensive testing.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Chapter 13
;  Robert Plantz, X86 Assembly Programming.  [No longer available as a free download]  Do a websearch for this ebook.
;
;Purpose
;  Show simple examples of the use of activating kernel function via 'syscall'
;  Demonstrate to assembly programmers how tedious programming would be if there were no libraries of pre-programmed functions.
;  Remind students enrolled in 240: do not program with syscalls in 240.  Use syscalls in a future course such as 351.
;
;Actions performed by this program (without resorting to functions in libraries
;  Output a string
;  Input a string
;  Remove any possible line feed character and insert a null char after printable inputted chars
;  Discard extraneous chars that exceed the storage capacity of destination string (array).
;
;This file
;   File name: string-io-syscall.asm
;   Language: X86-64 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l stromg-io-syscall.lis -o string-io.o string-io-syscall.asm
;   Link: ld -o stringio.out string-io.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper


;========= Begin source code ===============================

;Declare the names of programs called from this X86 source file, but whose own source code is not in this file.
; None

;Declare the scope of the current module
global _start

;Declare constants
system_read equ 0
system_write equ 1
standard_in equ 0
standard_out equ 1
max_input_length equ 20
string_length equ max_input_length + 1

null equ 0
line_feed equ 10
welcome_length equ 58
instruction_length equ 34
reply_length equ 25
pointer_to_line_feed_length equ 1
success equ 0
exit equ 60

segment .data                                     ;Initialized data are placed in this segment
welcome db "This program demonstrates string input and string output.", line_feed, null
instructions db "Enter string data up to 20 chars: ", null
good_bye db "This program containing syscalls is now going to terminate.  Good-bye.", line_feed, null
reply db "You entered these chars: ", null
pointer_to_line_feed db line_feed, null

segment .bss                                      ;Uninitialized data are declared in this segment
align 16
user_name resb string_length                      ;The array has 1 additional byte to hold the expected line feed from the user.
one_char resb 1

segment .text                                     ;Instructions are placed in this segment
_start:                                           ;Entry point for execution of this program.

;Output the welcome message                       ;This is a group of instructions jointly performing one task.
mov rax, system_write
mov qword rdi, standard_out
mov qword rsi, welcome
mov qword rdx, welcome_length
syscall

;Output instructions for inputting an ascii string
mov rax, system_write
mov qword rdi, standard_out
mov qword rsi, instructions
mov qword rdx, instruction_length
syscall

;Input string data from standard input (keyboard).
mov rax, system_read
mov rdi, standard_in
mov rsi, user_name
mov rdx, max_input_length   ;string_length
syscall

;rax holds number of char inputted including line_feed.  Save this number in a safe place
mov r15, rax

;If (r15 >= max_input_length) then [user_name + max_input_length] <-- line_feed and empty buffer.
cmp r15,max_input_length
jl continue

mov [user_name+max_input_length],byte null
inc r15

;If the user inputted more chars than the size of the array then discard those extra inputted chars.
;Reference for the loop that follows: Jorgensen, page 200.
begin_loop_to_clear_input_buffer_until_line_feed_is_read:
   mov rax,system_read
   mov rdi,standard_in
   mov rsi,one_char
   mov rdx,1 ;1=size of a byte
   syscall
   mov al, byte [one_char]
   cmp al, byte line_feed
   jne begin_loop_to_clear_input_buffer_until_line_feed_is_read
;End of loop to clear input buffer

jmp output

continue:
mov [user_name+r15-1],byte null

output:
;Output a message.
mov rax, system_write
mov rdi, standard_out
mov rsi, reply
mov rdx, reply_length
syscall

;Output the inputted string to confirm the correctness of execution to this point.
mov rax, system_write
mov rdi, standard_out
mov rsi, user_name
mov rdx, r15
syscall

;Output a line feed
mov rax, system_write
mov rdi, standard_out
mov rsi, pointer_to_line_feed
mov rdx, pointer_to_line_feed_length
syscall

;Gently terminate this program and return success = 0 to the operating system.
mov rax, exit
mov rdi, success
syscall

;That's all folks: there is no 'ret' instruction.
