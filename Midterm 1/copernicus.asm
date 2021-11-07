;========1=========2=========3=========4=========5=========6=========7=========8**
;Author information
;  Author name: Suhyr Hasan
;  Author class: CPSC240 -01
;  Author email: Suhyrhasan@csu.fullerton.edu
;
;Program information
; Program name: The Electricity Program
;  Programming languages X86 with one module in C++
;
;Project information
;  Files: kepler.cpp, copernicus.asm, r.sh
;
;Translator information
;  Linux: nasm -f elf64 -l copernicus.lis -o copernicus.o copernicus.asm
;===== Begin code area ======================================================
extern printf                 
extern scanf                 
extern fgets            
extern strlen              
extern stdin                  
extern strtod              

global copernicus  

;Maximum number of characters accepted for name and title
max_name_size equ 50        
max_title_size equ 50        

;Use the hex expression for 64-bit floating point 8990000000.0 aka 8.99 x 10^9      
eight_point_zero equ 0x4200BEC41C000000  

segment .data               
;=========== Declare some messages =======================================
align 16   
                    
welcomeprompt db "This program will help you find the force", 10,0

firstParticle db "Please enter the electrical charge on particle 1: ",0

secondParticle db "Please enter the electrical charge on particle 2: ",0

distanceprompt db "Please enter the distance between the particles in meters:", 0

nameprompt db "Please enter your last name: ", 0

titleprompt db "Please enter your title: ", 0

forceprompt db "Thank you. Your force is %5.5lf Neutons.",10, 0 

stringformat db "%s", 0 ; %s means any string
floatformat db "%lf", 0 ; %lf means any digit
align 64
segment .bss   

name resb max_name_size       
title resb max_title_size    

;=========== Begin the application here: show how to input and output floats ==========================================
segment .text                                
copernicus: 

; Back up all registers and set stack pointer to base pointer
push rbp
mov rbp, rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx

push qword 0  ; Extra push to create even number of pushes

;Display a welcome message to the viewer.       
mov rax, 0     
mov rdi, welcomeprompt               
call printf

;Prompt for user's name 
mov rax, 0  
mov  rdi, stringformat        ;"%s"               
mov  rdi, nameprompt         ;"Please enter your last name: "
call printf                  ;Call a library function to make the output
  
;Obtain the user's name  
mov  rdi, name               
mov  rsi, max_name_size      
mov  rdx, [stdin]             
call fgets                    
  
;Prompt for programmer's title 
mov rax, 0  
mov  rdi, stringformat        ;"%s"
mov  rsi, titleprompt         ;"Please enter your title: "
call printf                   ;Call a library function to make the output

;Obtain the user's title 
mov  rdi, title             
mov  rsi, max_title_size     
mov  rdx, [stdin]            
call fgets  

;Display a prompt message asking for the first particle  
push qword 99             ;Get on the boundary   
mov rax, 0  
mov rdi, firstParticle
call printf
pop rax  
push qword 99  

;Obtain the first particle
push qword -1
mov rax, 0
mov rdi, floatformat
mov rsi, rsp     
call scanf           
movsd xmm13, [rsp]  ;xmm13 holding first particle
pop rax

;Display a prompt message asking for the second particle
push qword 99                           ;Get on the boundary
mov rax, 0
mov rdi, secondParticle
call printf
pop rax

;Obtain the second particle
push qword -2 
mov rax, 0 
mov rdi, floatformat
mov rsi, rsp     
call scanf           
movsd xmm12, [rsp]  ;xmm12 holding second particle
pop rax

;Display a prompt message asking for the distance between the particles
push qword 99                   ;Get on the boundary
mov rax, 0
mov rdi, distanceprompt
call printf
pop rax

;Obtain the distance between the particles
push qword -3                           ;Get on the boundary
mov rax, 0
mov rdi, floatformat
mov rsi, rsp     
call scanf           
movsd xmm11, [rsp]  ;xmm11 holding the distance between the particle
pop rax
pop rax

movsd xmm10, xmm13  ;xmm10 now has a copy of p1
movsd xmm9, xmm12		;xmm9 now has a copy of p2
movsd xmm8,  xmm11	;xmm8 now has a copy of r

;Calculate k x q1 x q2
mulsd xmm10, xmm9             ;Multiple particle 1 and particle 2
mov r10 , eight_point_zero     ;Place the constant, 8.99 x 10^9, in r15
push r10                      ;Now r15 is on top of the stack
mulsd xmm10, [rsp]             ;Multiple the input numbers by the constant, 8.99 x 10^9
pop r10                       ;Return the stack to its former state

;Calculate r^2 then (k x q1 x q2) / r2
mulsd  xmm8, xmm8            ;Square r by multipling r and r
divsd  xmm10, xmm8            ;Divide (k x q1 x q2) by r^2
movsd  xmm0, xmm10            ;Store the value of electromagnetic force in xmm0

;Output the value of electromagnetic force
mov rax, 1                    
mov rdi, forceprompt    
call printf 

;Returns name to the calling program 
mov rax, title               ;The goal is to put a copy of name in xmm0
push rax                     ;Now name is on top of the stack
movsd xmm0, [rsp]            ;Now there is a copy of name in xmm0
pop rax                      ;Return the stack to its former state

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