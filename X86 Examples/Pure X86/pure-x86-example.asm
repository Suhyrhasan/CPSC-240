;***************************************************************************************************************************
;Program name: "Pure X86 String-IO".  This program demonstrates how to create and use an X86 program in an environment      *
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
;   Program name: Pure X86 String-IO
;   Programming languages use:  X86 only.
;   Date program development began: 2015-Feb-11
;   Date of last update of source code: 2015-Feb-12
;   Date of last modification of comments: 2019-April-06
;   Files in this program: pure-x86-io.asm, run.sh
;   Status: Temporarily on hold.  More features will be added when time allows.  Example: IO of integers, floats,long floats without
;           calling library functions.

;Purpose
;   Demonstrate one example of x86 program which performs as follows:
;      #Is not called by any function originally written in a non-X86 language
;      #Does not call any other function written in a non-X86 programming language whatsoever.

;   Academic lessons learned:
;   1. How to make an X86 program without using a driver program.  The result is clean 100% X86-coded source file(s).  The downside is 
;      that you must link with the nasm linker ld, and then there is no access to the C-library of functions like printf and scanf.
;   2. How to call a local subprogram.  That is, how to call a subprogram that is located in the same source file as the caller.
;   3. How to output string data using a system call (directly to the kernel).  Also, the input parameters passed to the system call 
;      are shown here.
;   4. A compact form of iteration for scanning through a string of ascii characters.
;   Academic lessons to be learned in the near future.
;   1. How to input a string using syscall in place of scanf.
;   2. How to output an integer using syscall in place of printf.
;   3. How to input an integer using syscall in place of scanf.
;   4. How to output a float using syscall in place of printf.
;   5. How to input a float using syscall in place of scanf.
;   Solving any of the above will require some online research.  Anyone reading this is welcomed to research and solve any of the problems 1 through 5 above.
;   Be aware that interrupt 80, written in source code as "int 0x80", is also an instruction sent to the kernel for immediate action.  Interrupt 80 can perform most or all
;   the actions performed by syscall; however, interrupt 80 uses a different order of incoming parameters.  For syscall the parameter sequence is rax holds the syscall 
;   function number followed by rdi, rsi, rdx, r10, r8, and r9, and the return value is in rax.  For interrupt 80 the parameter sequence is rax holds the subfunction 
;   number followed by rbx, rcx, rdx, rsi, rdi, and rbp, and the return value is in rax.  For a beginner's guide to calling the kernel consult the information at this site:
;   http//en/wikibooks.org/wiki/X86_Assembly/Interfacing_with_Linux. 

;Module information
;   Language: X86-64
;   Syntax: Intel
;   Purpose: This module is the "main".  Execution starts here.  This module will call macro subprograms.
;   File name: pure-x86-example.asm

;Translator information
;   Linux assembler: nasm -f elf64 -o x86-io.o -l x86-io.lis x86-io.asm
;   Linux linker:    ld  -o x86-io.out x86-io.o
;   Note that the switch "-f elf64" indicates compilation for a Linux environment.  If this software is ported to a Windows environment
;   then that switch must be modified.
;References
;   Some essential ideas were obtain from sample programs posted at www.stackoverflow.com.  Those ideas were then expanded based on 
;   the programmer's general knowledge of macros, the nasm linker, and stdout.
;Format information
;   This source code is intended to be viewable on a monitor supporting 136 columns of width, or on paper in landscape orientation using 7 point monospaced font.
;   All comments begin in column 61.
;Conclusion directed to programmers enrolled in the 240 class.
;   I don't think that programming X86 in isolation (without C or C++ included) is the way to learn X86 programming.  It is an 
;   interesting academic exercise to see an assembly program that does not need a driver, but that's not the way to learn this tech-
;   nology.  Dr Paul Carter had it right (www.drpaulcarter.com) when he taught X86 using a C driver, and of course, using all the 
;   function in the C library.  Dr Carter's website still has a free ebook that he wrote and used in his course.

;===== Begin main assembly program here ===================================================================================================================================
global _start                                               ;The global declaration is required by the linker.  Without this declaration the linker will fail.

section .data                                  
newline db 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0        ;Declare an array of 8 bytes where each byte is initialize with ascii value 10 (newline)                                   
tab db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0    ;Declare an array of 8 bytes where each byte is initialize with 32 (blank space).  Thus, this array equals 
                                                            ;one standard tab.
hello       db "Hello. I am a Computer Science Major.", 0xa, 0
programming db "I selected this major because I like programming.", 0xa, 0
special     db "I specialize in hardware/software interface issues.", 0xa, 0
plans       db "I plan to write device drivers for Radeon video cards in my future career.", 0xa, 0
bye         db "This program will not return you to a driver because there is no driver.  Have a nice evening.  Bye.", 0xa, 0

section .bss                                                ;This section is currently empty.

section .text                                               ;The executable area begins here.
_start:                                                     ;Main entry point.  Execution begins here.  The name must be _start.  
;                                                           ;This is a requirement since there is no driver program.

;Next perform some test cases.

mov        rdi, hello                                       ;The starting address of the string hello is in rdi.
mov        rsi, 7                                           ;7 is the position within hello where output will begin.
call       showstring

mov        rdi, hello                                       ;Test case; try negative input
mov        rsi, -100                                        ;Negative starting position acts as 0 starting position.
call       showstring

mov        rdi, hello                                       ;Test case: the position number is greater than the string length.  Nothing will be outputted.
mov        rsi, 88                                          ;Nothinng or random noise will be outputted.
call       showstring

mov        rdi, programming                                 ;Test case: the string is programming.
mov        rsi, 2                                           ;The start position is 2.  The first 2 char of the string will be omitted.
call       showstring

mov        rdi, newline
mov        rsi, 7                                           ;The 7 in rsi will cause the value in cell #7 to be outputted.  #7 is the last data cell of the array.
call       showstring

mov        rdi, special                                     ;Test case: nothing or noise will be outputted because start position is beyond the end of the string.
mov        rsi, 100
call       showstring

mov        rdi, special                                     ;Test case: entire string is outputted.
mov        rsi, 0
call       showstring

mov        rdi, tab
mov        rsi, 0                                           ;The 0 copied to rsi will cause a tab (8 horizontal columns) to be inserted before the next output.
call       showstring

mov        rdi, plans                                       ;The string plans will be outputted starting at cell #60
mov        rsi, 60
call       showstring

mov        rdi, bye                                         ;Test case: entire string is outputted.  
mov        rsi, -1                                          ;A negative value in rsi will perform the same as a value 0.
call       showstring

;=====Now exit from this program and return control to the OS =============================================================================================================
mov        rax, 60                                          ;60 is the number of the syscall subfunction that terminates an executing program.
mov        rdi, 0                                           ;0 is the code number that will be returned to the OS.
syscall
;We cannot use an ordinary ret instruction here because this program was not called by some other module.  The program does not know where to return to.


;===== End of program _start ==============================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**










;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;===== Subprogram (or function) strlen ====================================================================================================================================
;Author information
;   Author name: Floyd Holliday
;   Author emai: holliday@fullerton.edu or activeprofessor@yahoo.com
;   Author location: Room 104
;Course information
;   Course number CPSC240
;   Assignment number: To be entered soon
;   Due date: To be entered soon
;Project information
;   Project title: String length function
;   Purpose: Make a utility function to be save in the software library.
;   Date project began: 20150212
;   Date of latest update: 20150212
;   Status: This project is in development.  
;   Future development: This function will do only one simple task which is compute the length of a string.
;Module information
;   Language: X86-64
;   Syntax: Intel
;   Purpose: Count the number of characters in a null terminated string without counting the null itself.
;   Date project began: 20150212
;   File name: Not applicable
;   Status: Finished.  Released for use in other projects.
;   Future: No more development work.  This module is very focused on doing one specific task.
;System requirements
;   This program uses 64-bit GPRs (general purpose registers).  A 64-bit X86 processor is required.
;   During development the project was tested in a Linux environment.
;Translator information
;   Does not a apply because this module is included in the same file that uses it.  This module is not currently assembled separately.
;References
;   Some essential ideas were obtain from sample programs posted at www.stackoverflow.com.  Those ideas were then expanded based on the programmer's general knowledge of
;   standard parameter passing in a C or C++ environment
;Format information
;   This source code is best viewed on a monitor supporting 172 columns of width, or on paper in landscape orientation using 7 point monospaced font.
;   All comments begin in column 61.
;Preconditions
;   rdi holds the starting address of the string of which the length will be computed
;Postconditions
;   rax will hold the computed length
;Side effects
;   None: When this function returns to a caller all registers will contain original values except possibly rax.
;===== Begin program area =================================================================================================================================================
;
section .data
;This section is empty.

section .bss
;This section is empty.

section .text
strlen:

;===== Backup segment =====================================================================================================================================================
;No floating point data are used in this program.  Therefore, state components FPU, SSE, AVX are not backed up.

;=========== Back up all the GPR registers except rax, rsp, and rip =======================================================================================================

push       rbp                                              ;Save a copy of the stack base pointer
mov        rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
push       rbx                                              ;Back up rbx
push       rcx                                              ;Back up rcx
push       rdx                                              ;Back up rdx
push       rsi                                              ;Back up rsi
push       rdi                                              ;Back up rdi
push       r8                                               ;Back up r8
push       r9                                               ;Back up r9
push       r10                                              ;Back up r10
push       r11                                              ;Back up r11
push       r12                                              ;Back up r12
push       r13                                              ;Back up r13
push       r14                                              ;Back up r14
push       r15                                              ;Back up r15
pushf                                                       ;Back up rflags

;===== Application strlen begins here =====================================================================================================================================

;Set up registers needed by the repnz instruction.
;dri already holds the starting address of the array of char (the string).
xor        rcx, rcx                                         ;This is a fast technique that zeros out rcx
not        rcx                                              ;This is a fast instruction that flips all bits in rcx.  rcx now holds 0xFFFFFFFFFFFFFFFF, which is both -1 and 
;                                                           ;the largest unsigned integer.  The same result could have been obtained by "mov rcx, 0xFFFFFFFFFFFFFFFF", but 
;                                                           ;that is a slower operation.
xor        al, al                                           ;Set the lowest 8 bits (1 byte) of rax to zero.  There is no need to use extra machine time to zero out all of 
;                                                           ;rax because repnz only uses the lowest 8 bits of rax.
cld                                                         ;Clear the direction flag, which is a single bit inside of rflags register.  The term "clear" means "give it a
;                                                           ;value of 0.  When the direction bit is zero the register rdi will increment by 1 in each iteration of the 
;                                                           ;loop; otherwise, rdi will decrement in each iteration.
repnz      scasb                                            ;This is a compact loop construction.  In pseudocode it does the following::
;                                                           ;repeat
;                                                           ;    {rcx--;
;                                                           ;     rdx++;
;                                                           ;    }
;                                                           ;until (rcx == 0 || [rdi] == al);
;Since it is very unlikely that rcx will decement to zero the loop effectively continues until [rdi] equals null (the value in the lowest 1 byte or rax).  Notice that the
;null character is counted in the number of iterations of the loop.  In the next statements the count will be adjusted to compensate for the extra iteration.

not        rcx                                              ;Invert all the bits in rcx.  The result is the number of iterations of the loop
dec        rcx                                              ;Decrement rcx by one in order to avoid counting the null character.
mov        rax, rcx                                         ;Copy the count into rax, which is the standard register for returning integers to a caller.

;=========== Restore GPR values and return to the caller ==================================================================================================================

popf                                                        ;Restore rflags
pop        r15                                              ;Restore r15
pop        r14                                              ;Restore r14
pop        r13                                              ;Restore r13
pop        r12                                              ;Restore r12
pop        r11                                              ;Restore r11
pop        r10                                              ;Restore r10
pop        r9                                               ;Restore r9
pop        r8                                               ;Restore r8
pop        rdi                                              ;Restore rdi
pop        rsi                                              ;Restore rsi
pop        rdx                                              ;Restore rdx
pop        rcx                                              ;Restore rcx
pop        rbx                                              ;Restore rbx
pop        rbp                                              ;Restore rbp
;Notice that rax is not restored because it holds the value to be returned to the caller.

ret;                                                        ;ret will pop the system stack into rip.  The value obtained is an address where the next instruction to be 
                                                            ;executed is stored.
;===== End of subprogram strlen ===========================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**










;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;===== Subprogram showstring ===============================================================================================================================================
;Author information
;   Author name: Floyd Holliday
;   Author emai: holliday@fullerton.edu or activeprofessor@yahoo.com
;   Author location: Room 104
;Course information
;   Course number CPSC240
;   Assignment number: To be entered soon
;   Due date: To be entered soon
;Project information
;   Project title: Show string function
;   Purpose: Make a utility function to be save in the software library.
;   Date project began: 20150212
;   Date of latest update: 20150212
;   Status: This project is in development.  
;   Future development: This function will do only one simple task which is to output a null terminated string.
;Module information
;   Language: X86-64
;   Syntax: Intel
;   Purpose: Given a string (array of char) and a non-negative integer n output to stdout the string starting at character number n without the use of printf.
;   Date project began: 20150212
;   File name: Not applicable
;   Status: Finished.  Released for use in other projects.
;   Future: No more development work.  This module is planned to have one functionality only, namely: output a string.
;System requirements
;   This program uses 64-bit GPRs (general purpose registers).  A 64-bit X86 processor is required.
;   During development the project was extensively tested in a Linux environment.
;Translator information
;   Does not a apply because this module is included in the same file that uses it.  This module is not currently assembled separately.
;References
;   Some essential ideas were obtain from sample programs posted at www.stackoverflow.com.  Those ideas were then expanded based on the programmer's general knowledge of
;   standard parameter passing in a C or C++ environment
;Format information
;   This source code is best viewed on a monitor supporting 172 columns of width, or on paper in landscape orientation using 7 point monospaced font.
;   All comments begin in column 61.
;Preconditions
;   rdi holds the starting address of the string of which the length will be computed.
;   rsi holds the position in the array where output will begin.
;Postconditions
;   rax will hold 0 if 1 or more characters were displayed, and will hold a non-zero integer (usually 1) if no characters were displayed.
;Side effects
;   None: When this function returns to a caller all registers will contain original values except possibly rax.
;===== Begin program area =================================================================================================================================================
;global showstring                                           ;This global declaration is needed if a program outside this file wants to call this subprogram.
;
section .data
;This section is empty.

section .bss
;This section is empty.

section .text
showstring:

;===== Backup segment =====================================================================================================================================================
;No floating point data is used in this program.  Therefore, state components FPU, SSE, AVX are not backed up.

;=========== Back up all the GPR registers except rax, rsp, and rip =======================================================================================================

push       rbp                                              ;Save a copy of the stack base pointer
mov        rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
push       rbx                                              ;Back up rbx
push       rcx                                              ;Back up rcx
push       rdx                                              ;Back up rdx
push       rsi                                              ;Back up rsi
push       rdi                                              ;Back up rdi
push       r8                                               ;Back up r8
push       r9                                               ;Back up r9
push       r10                                              ;Back up r10
push       r11                                              ;Back up r11
push       r12                                              ;Back up r12
push       r13                                              ;Back up r13
push       r14                                              ;Back up r14
push       r15                                              ;Back up r15
pushf                                                       ;Back up rflags

;===== Application showstring begins here =================================================================================================================================

;First obtain the length of the incoming string and store the result in r15
;Preconditions:
   ;rdi holds the starting address of the string to be printed to stdout.
   ;rsi holds the position number where printing will begin.

call strlen                                                 ;The subprogram strlen will place the length in rax

;Postconditions:
   ;rax holds the length
mov        rdx, rax                                         ;Place a copy of the length in a safe place.
cmp        rsi, rdx                                         ;Compare (starting position > string length)?
jg         nothingtooutput                                  ;If (starting position > string length) then continue execution below.

;If the starting position is negative set it to zero.
cmp        rsi, 0                                           ;If (starting position >= 0) then proceed to output the string.
jge        outputstring                                     ;Skip ahead to the setup for string output.
mov        rsi, 0                                           ;Make the starting position zero.

outputstring:                                               ;Prepare parameters to send the string to stdout.
add       rdi, rsi                                          ;rdi = address inside the array where printing will begin
sub       rdx, rsi                                          ;rdx = number of characters to be printed
mov       rsi, rdi                                          ;rsi = number of characters to be printed
mov       rax, 1                                            ;1 = number of the syscall subfunction write()
mov       rdi, 1                                            ;1 = code number of stdout.  The fact that rax and rdi received the same value is coincidental.
syscall                                                     ;Call the kernel to do the work specified in parameter rax, rdi, rsi, rdx

mov       rax, 0                                            ;Return this value to the caller.  Zero indicates an expected result.

jmp       restore                                           ;rax already has the value to be returned to the caller.

nothingtooutput:
mov       rax, 1                                            ;Any nonzero value could have been place in rax.  Nonzero indicates an unexpected result.

restore:                                                    ;Begin section to restore backed up GPRs.
;=========== Restore GPR values and return to the caller ==================================================================================================================

popf                                                        ;Restore rflags
pop        r15                                              ;Restore r15
pop        r14                                              ;Restore r14
pop        r13                                              ;Restore r13
pop        r12                                              ;Restore r12
pop        r11                                              ;Restore r11
pop        r10                                              ;Restore r10
pop        r9                                               ;Restore r9
pop        r8                                               ;Restore r8
pop        rdi                                              ;Restore rdi
pop        rsi                                              ;Restore rsi
pop        rdx                                              ;Restore rdx
pop        rcx                                              ;Restore rcx
pop        rbx                                              ;Restore rbx
pop        rbp                                              ;Restore rbp
;Notice that rax is not restored because it holds the value to be returned to the caller.

ret;                                                        ;ret will pop the system stack into rip.  The value obtained is an address where the next instruction to be 
                                                            ;executed is stored.
;===== End of subprogram showstring ========================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**


