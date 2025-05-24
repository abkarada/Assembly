	mov ecx, msg
	mov ebx, 1
	mov eax, 4
	int 0x80

	mov edx, 9
	mov ecx, s2
	mov ebx, 1
	mov eax, 4
	int 0x80 

	mov eax, 1
	int 0x80

section .data
msg db 'Display nine stars', 0xa ; a message
len equ $ - msg ; length of message
s2 times 9 db '*'
