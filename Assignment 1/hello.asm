;******************************************************************************************************************************
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
; Program name: The Hello World Program
;  Programming languages X86 with one module in C++
;  Date development of version 1.5 began 2021-Aug-25
;  Date development of version 1.5 completed 2021-Sep-09
;
;Purpose
;  This assignment welcomes you to the world of programming called “X86 Assembly Programming”.
;
;Project information
;  Files: good_morning.cpp, hello.asm, run.sh
;
;Translator information
;  Linux: nasm -f elf64 -l hello.lis -o hello.o hello.asm
;
;===== Begin code area =======================================================================================================
extern printf                                   ;External C++ function for writing to standard output device
extern scanf                                    ;External C++ function for reading from the standard input device
extern fgets                                    ;Function borrowed from one of the C libraries.
extern strlen                                   ;Function borrowed from one of the C libraries.
extern stdin                                    ;Standard I/O streams
global hello                                    ;This makes hello callable by functions outside of this file.

max_name_size equ 32                            ;Maximum number of characters accepted for name input
max_title_size equ 15                           ;Maximum number of characters accepted for title input
max_response_size equ 15                        ;Maximum number of characters accepted for response input

segment .data                                   ;Place initialized data here

;===== Declare some messages =================================================================================================
;The identifiers in this segment are quadword pointers to ascii strings stored in heap space.They are not variables.  
;They are not constants. There are no constants in assembly programming.  There are no variables in assembly programming: 
;the registers assume the role of variables.

align 16                                                ;Insure that the next data declaration starts on a 16-byte boundary.

nameprompt db "Please enter your first and last name: ", 0
titleprompt db "Please enter your title (Ms, Mr, Engineer, Programmer, Mathematician, Genius, etc): ", 0
responseprompt1 db "Hello, ", 0
responseprompt2 db ". How has your day been so far?: ", 0
outputmessage db "is really nice.", 10, 0
goodbye db "This concludes the demonstration of the Hello program written in x86 assembly.", 10, 0

stringformat db "%s", 0                        ;general string format
align 64                                       ;Insure that the next data declaration starts on a 64-byte boundary.
segment .bss                                   ;Declare pointers to un-initialized space in this segment.
programmers_name resb max_name_size            ;Create char of size max_name_size bytes
programmers_title resb max_title_size          ;Create char of size max_title_size bytes
response resb max_response_size                ;Create char of size max_response_size bytes

;===== Begin the application here: show how to input and output strings ======================================================
segment .text                                  ;Place executable instructions in this segment.

hello:                                         ;Entry point.  Execution begins here.

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

;=========== Prompt for programmer's name ====================================================================================
;Note that at this point there are no vital data in registers to be saved.  Therefore, there is no back up process at this time.
mov qword  rax, 0                             ;No data from SSE will be printed
mov      rdi, stringformat                    ;"%s"
mov      rsi, nameprompt                      ;"Please enter your first and last name:"
call     printf                               ;Call a library function to make the output

;===== Obtain the user's name ================================================================================================
mov qword  rax, 0                             ;No data from SSE will be printed
mov      rdi, programmers_name                ;Copy to rdi the pointer to the start of the array of 32 bytes
mov      rsi, max_name_size                   ;Provide to fgets the size of the storage made available for input
mov      rdx, [stdin]                         ;stdin is a pointer to the device; rdx receives the device itself
call     fgets                                ;Call the C function to get a line of text and stop when NULL is encountered or 31 chars have been stored.

;=========== Prompt for programmer's title ====================================================================================
mov qword rax, 0                              ;SSE is not involved in this scanf operation
mov       rdi, stringformat                   ;"%s"
mov       rsi, titleprompt                    ;"Please enter your title "
call      printf                              ;Call a library function to make the output
;===== Obtain the user's title ================================================================================================
mov qword rax, 0                              ;SSE is not involved in this scanf operation
mov       rdi, programmers_title              ;Copy to rdi the pointer to the start of the array of 32 bytes
mov       rsi, max_title_size                 ;Provide to fgets the size of the storage made available for input
mov       rdx, [stdin]                        ;stdin is a pointer to the device; rdx receives the device itself
call      fgets                               ;Call the C function to get a line of text and stop when NULL is encountered or 31 chars have been stored.
;===== Prompt for the user ====================================================================================================
mov qword rax, 0                              ;SSE is not involved in this scanf operation
mov       rdi, stringformat                   ;"%s"
mov       rdi, responseprompt1                ;"Hello "
call      printf                              ;Call a library function to do the output
;Compute the length of the title cstring and outputs on the same line as responseprompt1
mov qword rax, 0
mov       rdi, programmers_title              ;Copy to rdi the pointer to the start of the array of 32 bytes        
call      strlen                              ;Call a library function to do the input work
mov       r13, rax                            ;The length of the string is saved in r13
mov       rdi, stringformat                   ;"%s"
mov       rsi, programmers_title              ;Place a pointer to the programmer's title in rsi
mov byte [rsi + r13 - 1], " "                 ;replaces newline character with a space
call      printf                              ;Call a library function to do the output 

;Compute the length of the name cstring and outputs on the same line as responseprompt1 and title
mov       rdi, programmers_name                ;Copy to rdi the pointer to the start of the array of 32 bytes       
call      strlen                               ;Call a library function to do the input work
mov       r13, rax                             ;The length of the string is saved in r13
mov       rdi, stringformat                    ;"%s"
mov       rsi, programmers_name                ;Place a pointer to the programmer's title in rsi
mov byte [rsi + r13 -1], " "                   ;replaces newline character with a space
call      printf                               ;Call a library function to do the output 

mov       rdi, stringformat                    ;"%s."
mov       rsi, responseprompt2                 ;"How has your day been so far?: "
call      printf                               ;Call a library function to do the outputs

;===== Obtain the user's response =============================================================================================
mov       rdi, response                        ;Copy to rdi the pointer to the start of the array of 32 bytes
mov       rsi, max_response_size               ;Provide to fgets the size of the storage made available for input
mov       rdx, [stdin]                         ;stdin is a pointer to the device; rdx receives the device itself
call      fgets                                ;Call the C function to get a line of text and stop when NULL is encountered or 31 chars have been stored.

;===== Reply to the user =====================================================================================================
;Compute the length of the response cstring and outputs on the same line as outputmessage
mov       rdi, response                        ;Copy to rdi the pointer to the start of the array of 32 bytes 
call      strlen                               ;Call a library function to do the input work
mov       r13, rax                             ;The length of the string is saved in r13
mov       rdi, stringformat                    ;"%s"
mov       rsi, response                        ;Place a pointer to the programmer's response in rsi
mov byte [rsi + r13 -1], " "                   ;replaces newline character with a space
call      printf                               ;Call a library function to do the output 

mov       rdi, stringformat                    ;"%s"
mov       rsi, outputmessage                   ;" is really nice"
call      printf                               ;Call a library function to do the output

;======= Show farewell message ===============================================================================================
mov qword rax, 0                               ;No data from SSE will be printed
mov       rdi, stringformat                    ;"%s"
mov       rsi, goodbye                         ;"I hope to meet you again.  Enjoy your X86 programming."
call      printf                               ;Call a library function to do the output

;=========== Returns name to the calling program =============================================================================
mov       rax, programmers_name               ;The goal is to put a copy of name in xmm0
push      rax                                 ;Now name is on top of the stack
movsd     xmm0, [rsp]                         ;Now there is a copy of name in xmm0
pop       rax                                 ;Return the stack to its former state

;===== Restore the pointer to the start of the stack frame before exiting from this function =================================
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
ret                   ;Pop a qword from the stack into rip, and continue executing.
;========== End of program hello.asm ==================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=====**