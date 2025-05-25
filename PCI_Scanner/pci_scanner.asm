BITS 32

section .data
    newline db 0xA, 0
    hex_digits db "0123456789ABCDEF"

section .bss
    device_count resd 1
    buffer resb 20

section .text
global _start

_start:
    xor ebx, ebx            ; bus = 0
.bus_loop:
    xor ecx, ecx            ; device = 0
.device_loop:
    xor esi, esi            ; function = 0
.function_loop:

    ; config address = (1 << 31) | (bus << 16) | (device << 11) | (function << 8)
    mov eax, ebx
    shl eax, 16             ; bus << 16
    mov edi, ecx
    shl edi, 11             ; device << 11
    or eax, edi
    mov edi, esi
    shl edi, 8              ; function << 8
    or eax, edi
    or eax, 0x80000000      ; Enable bit

    ; write to 0xCF8
    mov dx, 0xCF8
    out dx, eax

    ; read from 0xCFC
    mov dx, 0xCFC
    in eax, dx

    ; check vendor ID (lower 16 bits)
    cmp ax, 0xFFFF
    je .next_function       ; not present

    ; print: FOUND bus:device:function
    push eax                ; save device id + vendor id
    push ebx                ; bus
    push ecx                ; device
    push esi                ; function

    ; You can optionally do syscall to print info here
    ; we'll skip actual printing for minimal kernel-safe example

    pop esi
    pop ecx
    pop ebx
    pop eax

.next_function:
    inc esi
    cmp esi, 8
    jl .function_loop

    inc ecx
    cmp ecx, 32
    jl .device_loop

    inc ebx
    cmp ebx, 256
    jl .bus_loop

.exit:
    mov eax, 1      ; sys_exit
    xor ebx, ebx
    int 0x80
