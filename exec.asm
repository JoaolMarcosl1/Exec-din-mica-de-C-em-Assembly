format PE64 console
entry main

include "win64ax.inc"

section ".idata" import data readable
    library libtcc, "libtcc.dll", kernel32, "kernel32.dll"
    import libtcc, tcc_new, "tcc_new", tcc_delete, "tcc_delete", tcc_set_output_type, "tcc_set_output_type", tcc_compile_string, "tcc_compile_string", tcc_relocate, "tcc_relocate", tcc_get_symbol, "tcc_get_symbol"
    import kernel32, ExitProcess, "ExitProcess"

section ".data" data readable
    code0 db '#include <stdio.h>', 10
    code1 db 'int main(){ puts("seu raki voador"); }', 0
    mainfunc db "main", 0
    
section ".text" code readable executable
main:
    and rsp, -16
    call [tcc_new]
    mov r12, rax
    mov rcx, r12
    mov rdx, 1
    call [tcc_set_output_type]
    mov rcx, r12
    mov rdx, code0
    call [tcc_compile_string]
    mov rcx, r12
    mov rdx, 1
    call [tcc_relocate]
    mov rcx, r12
    mov rdx, mainfunc
    call [tcc_get_symbol]
    call rax
    mov rcx, r12
    call [tcc_delete]
    xor rcx, rcx
    call [ExitProcess]
