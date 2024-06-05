; multi-segment executable file template.

data segment
    S dw ?
    N dw ?
    perenos db 13,10,"$"
    vvod_N db 13,10,"Vvedite N=$" 
    vivod_S db "S=$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax 
    
    xor ax,ax
    mov dx, offset vvod_N
    mov ah,9
    int 21h
    
    mov ah,1
    int 21h
    sub al,30h
    cbw
    mov N,ax
    
    mov cx,N  
    mov dx,0
    mov ax,5
    mov bx,5
    
    @repeat:
    mul bx
    add dx,0
    add S,ax
    loop @repeat
    
    mov dx,S
    
    mov dx, offset perenos
    mov ah,9
    int 21h
    
    mov dx, offset vivod_S
    mov ah,9
    int 21h
    mov ax,S
    
    Lower: 
    push -1   
    mov cx, 10    
    L1: 
    mov dx, 0
    div cx
    push dx
    cmp ax, 0
    jne L1
    mov ah, 2
    L2:   
    pop dx
    cmp dx, -1 
    je sled8 
    add dl, 30h 
    int 21h 
    jmp L2
    
    ; add your code here
    sled8:        
    mov dx, offset perenos
    mov ah, 9
    int 21h        
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
