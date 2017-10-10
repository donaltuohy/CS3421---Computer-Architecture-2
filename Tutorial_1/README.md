<h1>Tutorial 1</h1>
<h2>Combining C++ and IA32 Assembly</h2>

<p>The following code was converted into IA32 Assembly</p>

```cpp
int g = 4;

// A function that takes in 3 integers and returns the smallest value
int min(int a, int b, int c) {
  int v = a;
  if (b < v)
    v = b;
  if (c < v)
    v = c;
  return v;
}

// A function that uses the min function to calculate the min of 4 parameters and a global int g
int p(int i, int j, int, k, int l) {
  return min(min(g, i, j), k, l);
}

// A recursive function that takes two integer parameter and returns the greatest common divisor
int gcd(int a, int b) {
  if (b == 0) {
    return a;
  } else {
  return gcd(b, a % b);
  }
}
```

<h2>min(int a, int b, int c)</h2>

```Assembly
min:
		;Storing enviroment
		push	ebp			; Push the original frame pointer
		mov		ebp, esp	; Move the stack pointer into the frame pointer
		sub		esp, 4		; This is making space for v, the local variable
	  
                 ;Start of function
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
```

<h2>p(int a, int b, int c, int d)</h2>

```Assembly
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
    ```
    
    <h2>gcd(int a, int b)</h2>
    
    ```Assembly
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
   
   ``` 
