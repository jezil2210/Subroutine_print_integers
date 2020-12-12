
section .bss	
	digitSpace resb 100
	digitSpacePos resb 8

section .text
	global _start

_start:
	mov rax, 22102002
	call _printRAX
	
 	mov rax, 60
	mov rdi, 1
        syscall

_printRAX:
	mov rcx, digitSpace
	mov rbx, 10  ; -->  new line /n 
	mov [rcx], rbx
 	inc rcx
	mov [digitSpacePos], rcx

_printRAXLoop:
	mov rdx, 0   ; --> rdx must be 0 using div, go to explanation 1
 	mov rbx, 10
	div rbx
       
	push rax      ; --> saving rax
        add rdx, 48   ; --> rdx contains the last digit(remainder) from the division
                      ; adding 48 to convert to character.
        mov rcx, [digitSpacePos]
        mov [rcx], dl ; --> the lowest 8 bits from rdx which is the character 
        inc rcx
        mov [digitSpacePos], rcx

        pop rax
        cmp rax, 0   ; go to Explanation 2
        jne _printRAXLoop

_printRAXLoop2:
        mov rcx, [digitSpacePos]

        mov rax, 1
        mov rdi, 1
        mov rsi, rcx
        mov rdx, 1
        syscall
    
        mov rcx, [digitSpacePos]
        dec rcx
        mov [digitSpacePos], rcx

        cmp rcx, digitSpace
        jge _printRAXLoop2

        ret 


; Explanation 1:
; mov rax, 24
; mov rbx, 2
; mov rdx, 0  --> rdx must be 0, otherwise it's going to concat rax:rdx
; div rbx
;
; rdx = remainder from the division, in this case 0
;------------------------------------------------------------------------------------------------
;Explanation 2:
;
; 123 / 10 = 12 remainder 3
;               store 3
; 12 / 10 = 1 remainder 2
;               store 2
; 1 / 10 = 0 remainder 1
;               store 1
; and finally is going to be 0.
