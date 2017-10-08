;	Author:				Donal Tuohy	
;	Student Number:		14313774
;	Assignment:			Tutorial 1
;	Course:				CS3421 Computer Architecture 2
;	Degree:				Computer Engineering
;	College:			Trinity College Dublin

.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive

 .data
 g DWORD 4

.code
public	min		

;Function to calculate the min of 3 parameters
min:
		;Storing enviroment
		push	ebp			; Push the original frame pointer
		mov		ebp, esp	; Move the stack pointer into the frame pointer
		sub		esp, 4		; This is making space for v, the local variable
		

		mov eax, [ebp + 8]	; eax = a
		mov [ebp - 4], eax	; v = eax

		;Start of first if statement
		mov eax, [ebp + 12] ; eax = b
		cmp eax, [ebp - 4]	; compare b and v
		jge min0			; if b is greater than b, branch (Skip if loop)
		mov eax, [ebp + 12]	; eax = b	
		mov [ebp-4], eax	; v = eax	

min0:
		;Start of second if statement
		mov eax, [ebp + 16]	; eax = c
		cmp eax, [ebp - 4]	; compare c and v
		jge min1
		mov eax, [ebp + 16] ; eax = c
		mov [ebp - 4], eax	; v = eax

min1:
		;Returning eax
		mov eax, [ebp -4]	; eax = v

		;Closing the function
		mov esp, ebp		; Point the stack back to the original frame
		pop ebp				; Pop the frame pointer from the stack
		ret 0

public	p

; function to calculate the min of 4 parameters using another function
; p(i, j, k, l)
p:		
;		;Storing the enviroment
		push ebp			; Save original frame pointer
		mov ebp, esp		; Move stack pointer into frame pointer
		sub esp, 4			; Make space for local variable v

		;Push the parameters for min(g, i, j)
		push [ebp + 12]		; push j to the stack
		push [ebp + 8]		; push i to  the stack
		push g				; push g to the stack
		call min
		mov [ebp - 4], eax	; Move result into local variable v
		add esp, 12			; Move the stack pointer back up to before the params were added
	
		;Push the parameter for min(v, k, l)
		push [ebp + 20]		; Push l to the stack
		push [ebp + 16]		; Push k to the stack
		push [ebp - 4]		; Push v to the stack
		call min			; This puts min(v, k, l) in eax
		 

		;Closing the function 
		mov esp, ebp
		pop ebp
		ret 0

public gcd

gcd:	
		; Store the enviroment
		push ebp			; Save old ebp	
		mov ebp, esp		; Move stack pointer to ebp
		push ebx			; Save ebx

		; First if statement
		mov eax, [ebp + 12]	; eax = b
		test eax, eax		; Test if b = 0
		jne bNotZero		; Branch if b isn't zero

		; Return a if b is 0
		mov eax, [ebp + 8]	; eax = a
		pop ebx				; Return ebx
		mov esp, ebp		; Restore stack pointer
		pop ebp				; Return old ebp
		ret 0

bNotZero:
		;Segment calling recursive function
		mov eax, [ebp + 8]	; ebx = a
		and	edx, 0			; Clear edx
		mov ebx, [ebp + 12]	; eax = b
		div ebx				; eax = ebx/ebx & edx = ebx%eax
		push edx			; Push a%b
		push ebx			; Push b
		call gcd			; Call function gcd(b,a%b)
		add esp, 8			; Pop the two parameters

		;Return result and close function
		pop ebx
		mov esp, ebp		; Move the ebp to the stack pointer
		pop ebp				; Return the old frame pointer
		ret 0

end

