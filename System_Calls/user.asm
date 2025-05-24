section .data
	userMsg db 'Please enter a number:'
	lenUserMsg equ $-userMsg
	dispMsg db 'You have entered: '
	lenDispMsg equ $-dispMsg

section .bss
	num resb 5

section .text
	global _start

_start:
; User Prompt
	mov eax, 4 ;sys_write 
	mov ebx, 1 ;fd 1 ->STDOUT
	mov ecx, userMsg ;message
	mov edx, lenUserMsg ;message len
	int 80h ; kernel call

; Read and store the user input
	mov eax, 3
	mov ebx, 0
	mov ecx, num
	mov edx, 5
	int 80h	

		
  ;Output the message 'The entered number is: '
   mov eax, 4
   mov ebx, 1
   mov ecx, dispMsg
   mov edx, lenDispMsg
   int 80h  

  ;Output the number entered
   mov eax, 4
   mov ebx, 1
   mov ecx, num
   mov edx, 5
   int 80h  

; Exit Code
	mov eax, 1
	mov ebx, 0
	int 80h
	
