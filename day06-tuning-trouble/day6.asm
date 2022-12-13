SECTION .bss
        fileBuf: resb 15
        counter: resq 1
        compsize: resq 1
    SECTION .data
        newline db 0ah, 0
        message db "Marker: %d", 0ah, 0
        debugbuf db "Buf: %c, %c, %c, %c", 0ah, 0
        size    dq 14
    SECTION .text
        global _start
        extern printf
    _start:

        nop

      init:
            mov r10, 0
            mov qword [counter], r10
            mov qword [compsize], r10
            mov rax, [size] ; loop counter
      floop:
            cmp rax, 0
            je flend
            dec rax
            mov byte [fileBuf+rax], 0
            jmp floop
      flend:

      read: 
            mov ecx, fileBuf
            mov eax, 3 ; sys_read
            mov ebx, 0 ; standard input
            mov edx, 1
            int 80h
            cmp eax, 0 ; ensure havn't read eof
            je exit
            
            ; show what the [start of the] buffer looks like
            
            mov r8, [fileBuf+3]
            mov rcx, [fileBuf+2]
            mov rdx, [fileBuf+1]
            mov rsi, [fileBuf]
            mov rdi, debugbuf
            call printf

     compare:
            mov r8b, [fileBuf] ; load r8b
            mov r12, qword [compsize]
            inc r12 ; last + 1
            mov r14, 1 ; loop counter
            mov r13, [size]
     cloop:
            cmp r14, r13
            je result

            cmp r8b, [fileBuf+r14] ; char
            je next
            mov r9, r14
            cmp r9, r12 ; compsize
            je next
            
            inc r14
            jmp cloop

     result:
            mov r10, qword [counter]
            inc r10
            mov rdx, qword 0
            mov rsi, r10
            mov rdi, message
            call printf
            jmp exit

      next: 
            mov qword [compsize], r14
            
            mov r10, [size] ; loop counter
      shift:
            cmp r10, 0
            je shend
            mov rcx, r10
            dec rcx
            mov al, [fileBuf+rcx]
            mov [fileBuf+r10], al
            dec r10
            jmp shift
      shend:

      write:; write chars from input, get next char
            ;mov eax, 4 ; sys_write
            ;mov ebx, 1 ; standard output
            ;mov ecx, fileBuf
            ;mov edx, 1
            ;int 80h
            mov r10, qword [counter]
            inc r10
            mov qword [counter], r10
            jmp read

     exit: mov eax, 1 ; wrap it up
           mov ebx, 0
           int 80h

