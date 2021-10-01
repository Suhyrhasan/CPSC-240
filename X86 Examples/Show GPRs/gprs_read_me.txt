Instructions for using utility program "showgprs.asm"

Purpose: The subprogram showgprs.asm will show the contents of the 16 general purpose X86 registers at an instant in time.

Assemble statement for inclusion in the bash script file:  nasm -f elf64 -o gprs.o -l showgprs.lis showgprs.asm

Be sure to put "gprs.o" is the list of object files in the linker statement.

The subprogram showgprs neither receives data nor returns data.  It only outputs to the standard output device.


===== C++ language
Prototype for inclusion in a C++ function: extern "C" void showgprs();

Calling statement in a C++ function: showgprs();


===== C language
Prototype for inclusion in a C function: void showgprs();

Calling statement in a C function: showgprs();


===== X86 assembly
Declaration for inclusion in an X86 function: extern showgprs

Calling statement in an X86 function: call showgprs
