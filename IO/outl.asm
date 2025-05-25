; io_test.asm - Saf I/O işlemleri (inb, outb, inl, outl)
BITS 32

section .text
global _start

_start:

    ; -------- outb örneği --------
    mov dx, 0x80        ; Legacy delay port (genelde boş porttur)
    mov al, 0xFF        ; Veri: 0xFF
    out dx, al          ; outb(0x80, 0xFF)

    ; -------- inb örneği --------
    mov dx, 0x61        ; PC speaker port (örnek)
    in al, dx           ; al = inb(0x61)

    ; -------- outl örneği --------
    mov dx, 0xCF8
    mov eax, 0x80000000 ; PCI config address
    out dx, eax         ; outl(0xCF8, 0x80000000)

    ; -------- inl örneği --------
    mov dx, 0xCFC
    in eax, dx          ; eax = inl(0xCFC)

    ; -------- Çıkış (Linux syscall) --------
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; exit code 0
    int 0x80
