;****************************************************************************************************************************
;Program name: "Date and Time".  This program demonstrates multiple techniques of extracting the date and the time from an  *
;operating system and how to display those value in standard output. Copyright (C) 2019 Floyd Holliday                      *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu
;
;Program information
;  Program name: Date and Time
;  Programming languages: One modules in C and one module in X86
;  Date program began: 2019-Jan-05
;  Date of last update: 2019-Jan-05
;  Date of reorganization of comments: 2019-Nov-08
;  Files in this program: current-time.c, data_and_time.asm
;  Status: There are no user inputs.  The program performs correctly.
;
;This file
;   File name: current-time.c
;   Language: C
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l date_and_time.lis -o date_and_time.o date_and_time.asm


;===== Begin code area ==============================================================================================================

%define CLOCK_REALTIME 0x00000000
;CLOCK_REALTIME is a constant probably stored in <time.h> [The author has not verified this.]  The program 
;current-time.c establishes that the constant has length 4 bytes and value 0.

extern printf
extern gettimeofday
extern clock_gettime

global x86datetime

segment .data

welcome db "The asm function 'x86datetime' has begun executing.", 10, 0
format_tv db "The time elapsed since the epoch is %lu.%06lu seconds (accuracy to nearest microsecond).",10,0
format_tv_nano db "The time elapsed since the epoch is %lu.%09lu seconds (accuracy to nearest nanosecond).",10,0
error_memo db "The call to extern function clock_gettime resulted in an error: no numeric value outputted",10,0
;format_tz db "Local location is %d minutes west of UTC and daylight saving time is %d",10,0                 ;Not used
;format_tv_sys db "Syscall produced: elapsed time since epoch is %lu.%06lu seconds.",10,0                    ;Not used
;format_tz_sys db "Syscall produced: location is %d minutes west of UTC and daylight saving time is %d",10,0 ;Not used

segment .bss  ; Reserved for uninitialized data

segment .text

x86datetime:

;Prolog
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

;Display a welcome message to the viewer.
mov rax, 0            ;A zero in rax means printf uses no data from xmm registers
mov rdi, welcome
call printf

;Get date and time from the system and display them.
;Reference: Ed Jorgensen's book, page 327, SYS_gettimeofday.
;  struct timeval
;         {time_t    tv_sec;   //Seconds:      8 bytes
;          suseconds tv_usec;  //Microseconds; 8 bytes
;         }
;  struct timezone
;         {int tz_minuteswest;
;          int tz_dsttime;
;         }
;Prototype:  int gettimeofday(struct timeval *,struct timezone *);
;rdi <- struct timeval *
;rsi <- struct timezone *

;===== Obtain seconds elapsed since epoch with resolution microseconds ============================

;Block of instructions to call gettimeofday.  This produces clock resolution of μs
mov rax, 0
push qword 0
push qword 0
mov rdi, rsp      ;rdi points to 16 bytes of avail storage
mov rsi, 0        ;second parameter receives the null pointer
call gettimeofday

;Block of instructions to display the values produced by gettimeofday
mov rax, 0
mov rdi, format_tv
pop rsi
pop rdx
call printf

;===== Obtain seconds elapsed since epoch with resolution nanoseconds =============================

;Block of instruction to call clock_gettime
mov rax, 0
push qword 0
push qword 0                 ;16 bytes of storage are available
mov rdi, 0
mov edi, CLOCK_REALTIME      ;CLOCK_REALTIME is a 4 byte constant
mov rsi, rsp                 ;rsi points to 16 bytes of storage
call clock_gettime

;Block of instructions to output the number of seconds elapsed since the epoch with resolution = 1 ns
cmp rax,0
jne error_message
mov rax, 0
mov rdi, format_tv_nano
pop rsi                      ;rsi holds the integral part of the answer
pop rdx                      ;rdx holds the fractional part of the answer
call printf
jmp continue

error_message:
mov rax, 0
mov rdi, error_memo
call printf

continue:

mov rax, 5            ;long int return number: 0 is the typical return value indicating success.

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
ret

;========================================================================================
