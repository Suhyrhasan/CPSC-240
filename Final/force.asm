;******************************************************************************************************************************
;Program name: "Braking Force Calculator". This program will calculate how much force must be applied to the brakes to stop a *
;moving vehicle. Copyright (C) 2021  Suhyr Hasan                                                                              *
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
; Program name: Braking Force Calculator
; Programming languages X86 with one modules in C
;
;Purpose
; This program will read the inputs m, v, and d, and then compute F. Braking Force formula: F = 0.5 * m * v * v/d
;
;Project information
; Files: clock_speed.asm, driver.c, force.asm, r.sh
;
;Translator information
; Linux: nasm -f elf64 -l force.lis -o force.o force.asm
;===== Begin code area ==========================================================================================================
extern printf                 ;External C++ function for writing to standard output device
extern scanf                  ;External C++ function for reading from the standard input device
extern strlen                 ;Function borrowed from one of the C libraries.
extern stdin                  ;Standard I/O streams
extern clock_speed            ;External Assembly function that uses cpuid to obtain the base clock speed
extern gettime                ;External Assembly function that uses cpuid to obtain the base clock speed
extern atof                   ;Converts a string as a floating point number

global force                  ;This makes force callable by functions outside of this file.

max_input_size equ 32         ;Maximum number of characters accepted for input

segment .data                 ;Place initialized data here
const_onehalf dq 0.5          ;Constant 64-bit floating point 0.5
const_ten dq 10.0             ;Constant 64-bit floating point 10.0
const_zero dq 0.0             ;Constant 64-bit floating point 0.0
;=========== Declare some messages ==============================================================================================
intro db "Welcome to the Suhyr Braking Program." , 10,0
frequencyprompt db "The frequency (GHz) of the processor in machine is %1.2lf .",10,0

massprompt db     "Please enter the mass of moving vehicle (Kg): ",0
velocityprompt db "Please enter the velocity of the vehicle (meters per second): ",0
distanceprompt db "Please enter the distance (meters) required for a complete stop: ",0

requiredforce db "The required braking force is %1.8lf Newtons.",10,0
computation db "The computation required %ld tics or %1.1lf nanosec.",10,0 
cpuprompt  db "Please enter the cpu frequency (GHz):",0

stringformat db "%s", 0       ;general string format
floatformat db " %lf",0       ;general  8-byte float format

segment .bss                  ;Declare pointers to un-initialized space in this segment.
mass  resb max_input_size     ;Create char of size max_input_size bytes
velocity resb max_input_size  ;Create char of size max_input_size bytes
distance resb max_input_size  ;Create char of size max_input_size bytes
cpu_input resb max_input_size ;Create char of size max_input_size bytes
;=========== Begin the application here:  =======================================================================================
segment .text                 ;Place executable instructions in this segment.
force:                        ;Entry point.  Execution begins here.

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
mov  rsi, intro               ;"Welcome to the Suhyr Braking Program."
call printf                   ;Call a library function to make the output
mov  rdi, stringformat        ;"%s"
;Ouputs the base clock speed
call clock_speed              ;Obtains the base clock speed 
movq xmm5, xmm0                ;Store the value of the clock speed in r15
mov rax, 1                    ;1 floating point numbers stored in xmm0 will be outputted
mov rdi, frequencyprompt      ;"The frequency (GHz) of the processor in machine is %1.2lf ."
call printf                   ;Call a library function to do the output

;=========== Mass Input =========================================================================================================
mov  rdi, stringformat        ;"%s"
mov  rsi, massprompt          ;"Please enter the mass of moving vehicle (Kg): "
call printf                   ;Call a library function to do the output 

;Obtains the mass input
mov  rdi, stringformat        ;"%s"
mov  rsi, mass                ;Place a pointer to the mass input in rsi
call scanf                    ;Call a library function to do the input work

;Converts string input to float
mov rdi, mass                 ;Copy to rdi the pointer to the start of the array of 32 bytes 
call atof                     ;Convert mass input from string to float 
movq xmm10, xmm0              ;Move the value of xmm0 to xmm10

;=========== Velocity Input =====================================================================================================
mov  rdi, stringformat        ;"%s"
mov  rsi, velocityprompt      ;"Please enter the velocity of the vehicle (meters per second): "
call printf                   ;Call a library function to make the output

;Obtains the velocity input
mov  rdi, stringformat        ;"%s"
mov  rsi, velocity            ;Place a pointer to the velocity input in rsi
call scanf                    ;Call a library function to do the input work

;Converts string input to float
mov rdi, velocity             ;Copy to rdi the pointer to the start of the array of 32 bytes   
call atof                     ;Convert velocity input from string to float   
movq xmm11, xmm0              ;Move the value of xmm0 to xmm11

;=========== Distance Input =====================================================================================================

mov  rdi, stringformat        ;"%s"
mov  rsi, distanceprompt      ;"Please enter the distance (meters) required for a complete stop: "
call printf                   ;Call a library function to make the output

;Obtains the distance input
mov  rdi, stringformat        ;"%s"
mov  rsi, distance            ;Place a pointer to the distance input in rsi
call scanf                    ;Call a library function to do the input work

;Converts string input to float
mov rdi, distance             ;Copy to rdi the pointer to the start of the array of 32 bytes   
call atof                     ;Convert distance input from string to float   
movq xmm12, xmm0              ;Move the value of xmm0 to xmm12

;------------------------------ Read CPU clock -----------------------------
cpuid                         ;Identify your CPU	
rdtsc                         ;Gets number of tics. Read Time Stamp Counter			
shl rdx, 32                   ;Shifts the 32 bits of rdx to the the.
add rax, rdx                  ;Store results into rax
mov r13, rax                  ;Store the number of tics in r13 

;=========== Calculate the Braking Force ========================================================================================
; xmm10 = mass, xmm11 = velocity, xmm12 = distance 
;Calculate (0.5 * m * v * v)/d
mulsd  xmm11, xmm11           ;Multiply the velocity by velocity
mulsd  xmm10,[const_onehalf]  ;Multiply the mass by 0.5
mulsd  xmm10, xmm11           ;Multiply the two products
divsd  xmm10, xmm12           ;Divide the result by the distance

;------------------------------ Read CPU clock -----------------------------
cpuid                         ;Identify your CPU	
rdtsc                         ;Gets number of tics. Read Time Stamp Counter			
shl rdx, 32                   ;Shifts the 32 bits of rdx to the the.
add rax, rdx                  ;Store results into rax
mov r14, rax                  ;Store the number of tics in r14

;-------------------------- Output Breaking Force --------------------------
;Outputs the breaking force
movsd xmm0, xmm10             ;Store the value of the breaking force in xmm0
mov rax, 1                    ;1 floating point numbers stored in xmm0 will be outputted
mov rdi, requiredforce        ;"The required braking force is %1.8lf Newtons."
call printf                   ;Call a library function to do the output

;----------------------------- Check CPU Clock -----------------------------
;Checks if clock_speed equals tp zero
call clock_speed              ;Obtains the base clock speed 
ucomisd xmm0, [const_zero]    ;Compare value in xmm0 to const 0
je invalid_cpu                ;Jump to the invalid function if cpu equals 0

jmp valid_cpu                 ;Jump to the valid cpu frequency 

;------------------------------- Invalid CPU -------------------------------
invalid_cpu:                  ;Entry point for invalid cpu frequency 

;Ask for the cpu frequency 
mov  rdi, stringformat        ;"%s"
mov  rsi, cpuprompt           ;"Please enter the cpu frequency (GHz): "
call printf                   ;Call a library function to do the output

;Obtains the cpu input
mov  rdi, stringformat        ;"%s"
mov  rsi, cpu_input           ;Place a pointer to the cpu input in rsi
call scanf                    ;Call a library function to do the input work

;Converts string input to float
mov rdi, cpu_input            ;Copy to rdi the pointer to the start of the array of 32 bytes   
call atof                     ;Convert velocity input from string to float   
movq xmm13, xmm0              ;Move the value of xmm0 to xmm11
jmp valid_cpu                 ;Jump to the valid cpu frequency 

;-------------------------------- Valid CPU --------------------------------
valid_cpu:                    ;Entry point for valid cpu frequency 
mov rax, r14                  ;Copy r14 to rax 
sub rax, r13                  ;Subtract the rax by r13
cvtsi2sd xmm15, rax
mov r15, rax                  ;Copy r15 to rax 
call clock_speed              ;Obtains the base clock speed 
movsd xmm13, xmm0             ;Store the value of xmm13 in xmm0
divsd xmm15, xmm13            ;Divide the xmm15 by the xmm13
movsd xmm8, xmm15             ;Store the value of xmm15 in xmm8
movsd xmm9, xmm15             ;Store the value of xmm15 in xmm9
divsd xmm9, [const_ten]       ;Divide the xmm9 by the const_ten
movsd xmm15, xmm9             ;Store the value of xmm9 in xmm15
mov rax, 1                    ;1 floating point numbers will be outputted
mov rdi, computation          ;"The computation required %ld tics or %1.1lf nanosec."
mov rsi, r15                  ;Place a pointer to r15 in rsi
movsd xmm0, xmm8              ;Pass ticks and nanosecond into elapsedTics to print.
call printf                   ;Call a library function to do the output

movsd xmm0, xmm15             ;Store the value of the nanosecond in xmm0

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
