;Qasim Naveed
;21L-5231
;BCS-3J

;Khawaja Afnan Asif
;21L-1864
;BCS-3J


[org 0x100]
jmp start
score: db 'SCORE = 00000000'
time: db 'TIME = 00:00'
titles: db 'CATCH & SCORE'
press: db 'PRESS ANY KEY TO START'
this1: db 'This will give you 5 score'
this2: db 'This will give you 10 score'
this3: db 'This will give you 15 score'
this4: db 'This is the danger object'
msg1: db 'Oh No! You Lost!'
msg2: db 'Congratulations! You Won!'
msg3: db 'Your total time is = 00:00'
msg4: db 'Your total score is = 00000000'
msg5: db 'Count of 5 point coins = 000'
msg6: db 'Count of 10 point coins = 000'
msg7: db 'Count of 15 point coins = 000'
msg8: db 'Press any key to exit!'
bucketx: dw 37
gamend: dw 0
die: dw 0
random: dw 0
objnumber:dw 0
objtype:dw 0,0,0,0,0,0
objtypex:dw 0,0,0,0,0,0
objtypey:dw 0,0,0,0,0,0
scorevar: dw 0
timevar: dw 0
timevar1: dw 0
timetick: dw 0
random1: dw 33196
random2: dw 32113
random3: dw 21314
oldkbisr: dd 0
oldtimerisr: dd 0
count5: dw 0
count10: dw 0
count15: dw 0

clearscreen: 
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push di
	mov ax, 0xb800
	mov es, ax 
	xor di, di 
	mov ax, 0x1720 
	mov cx, 1760 
	cld 
	rep stosw
	mov ax, 0x4720 
	mov cx, 240
	cld 
	rep stosw
	pop di
	pop cx
	pop ax
	pop es
	mov sp,bp
	pop bp
	ret

printbucket:
	push bp
	mov bp, sp
	;bp+4 mai y cordinate of bucket

	push ax
	push di
	push bx
	push es

	xor ax, ax
	mov al,22
	mov bl,80
	mul bl
	add ax,[bp+4]
	shl ax,1
	mov di,ax

	mov ax, 0xb800
	mov es, ax ; 

	mov word[es:di], 0x1720
	add di,8
	mov word[es:di], 0x1720
	sub di,8
	add di,160

	mov word[es:di], 0x1720
	add di,8
	mov word[es:di], 0x1720
	sub di,8
	add di,160

	mov word[es:di], 0x1720
	add di,2

	mov word[es:di], 0x1720
	add di,2
	mov word[es:di], 0x1720
	add di,2
	mov word[es:di], 0x1720

	add di,2
	mov word[es:di], 0x1720

	pop es
	pop bx
	pop di
	pop ax
	mov sp,bp
	pop bp
	ret 2



printcoin:

	push bp
	mov bp, sp
	push ax
	push di
	push bx
	push dx
	push es
	;bp+4 mai y cordinate of coin
	;bp+6 mai x cordinate of coin

	xor ax, ax
	mov al,[bp+4]
	mov bl,80
	mul bl
	add ax,[bp+6]
	shl ax,1
	mov di,ax
	mov ax, 0xb800
	mov es, ax ; 

	add di,2
	xor ax, ax
	mov al, [bp + 8]
	mov bl, 16
	mul bl
	mov ah, 0x47
	add ah, al
	mov al, 0x20
	mov word[es:di], ax
	sub di,2
	add di,160
	mov word[es:di], ax
	add di,2
	mov al, [bp + 8]
	mov dl, ah
	mov ah, 0x04
	add ah, al
	add al, 0x30

	mov word[es:di], ax
	add di,2
	mov ah, dl
	mov al, 0x20
	mov word[es:di], ax
	add di,160
	sub di,2
	mov word[es:di], ax
	
	
	add di,2
	mov word[es:di],0x0720
    sub di,4
  	mov word[es:di],0x0720
	sub di,320
    mov word[es:di],0x0720
    add di,4
	mov word[es:di],0x0720


	
pop es
	pop dx
	pop bx
	pop di
	pop ax
	mov sp,bp
	pop bp
	ret 6



printdanger:

	push bp
	mov bp, sp
	push ax
	push di
	push bx
	push dx
	push es
	;bp+4 mai y cordinate of coin
	;bp+6 mai x cordinate of coin

	xor ax, ax
	mov al,[bp+4]
	mov bl,80
	mul bl
	add ax,[bp+6]
	shl ax,1
	mov di,ax
	mov ax, 0xb800
	mov es, ax ; 


	mov word[es:di], 0x4020
	add di,2
	mov word[es:di], 0x4020
	add di,2
	mov word[es:di], 0x4020
	add di,160
	mov word[es:di], 0x4020
	sub di,2
	mov word[es:di], 0x4020
	sub di,2
	mov word[es:di], 0x4020
	add di,160
	mov word[es:di], 0x4020
	add di,2
	mov word[es:di], 0x4020
	add di,2
	mov word[es:di], 0x4020

pop es
	pop dx
	pop bx
	pop di
	pop ax
	mov sp,bp
	pop bp
	ret 4





printstr:
	 push bp 
	 mov bp, sp 
	 push es 
	 push ax 
	 push cx 
	 push si 
	 push di 
	 mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [bp+8] ; multiply with y position 
	 add ax, [bp+10] ; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, [bp+6] ; point si to string 
	 mov cx, [bp+4] ; load length of string in cx 
	 
	 cld ; auto increment mode 
	nextchar: lodsb ; load next char in al 
	 stosb ; print char/attribute pair 
	 add di, 1
	 loop nextchar ; repeat for the whole string 
	 pop di 
	 pop si 
	 pop cx 
	 pop ax 
	 pop es 
	 pop bp 
	 ret 8





printscore:
	push bp
	mov bp, sp
	push ax

	mov ax, 63
	push ax
	mov ax, 1
	push ax
	mov ax, [bp + 6]
	push ax
	mov ax, 16
	push ax
	call printstr

	mov ax, 79
	push ax
	mov ax, 1
	push ax
	mov ax, 0
	push ax
	mov ax, [bp + 4]
	push ax
	call printnum

	pop ax
	pop bp
	ret 4



printnum:
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

	mov ax, 0xb800
	mov es, ax ; point es to video base
	mov al, 80 ; load al with columns per row 
	 mul byte [bp+8] ; multiply with y position 
	 add ax, [bp+10] ; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	mov ax, [bp+4] ; load number in ax
	mov bx, 10 ; use base 10 for division
	mov cx, 0
	nextdigit3: 
	inc cx
	mov dx, 0 ; zero upper half of dividend
	div bx ; divide by 10
	add dl, 0x30 ; convert digit into ascii value
	cmp byte[bp + 6], 1
	jne simple
	cmp cx, 3
	jne simple
	sub di, 2
	simple:
	mov [es:di], dl ; save ascii value on stack
	sub di, 2
	cmp ax, 0 ; is the quotient zero
	jnz nextdigit3 ; if no divide it again

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 8



printtime:
	push bp
	mov bp, sp
	push ax

	mov ax, 0
	push ax
	mov ax, 1
	push ax
	mov ax, [bp + 6]
	push ax
	mov ax, 12
	push ax
	call printstr

	mov ax, 11
	push ax
	mov ax, 1
	push ax
	mov ax, 1
	push ax
	mov ax, [bp + 4]
	push ax
	call printnum

	pop ax
	pop bp
	ret 4


printdashes:
	push bp
	mov bp, sp
	push ax
	push es
	push di
	push cx
	push bx

	mov ax, 1
	mov bl, 80
	mul bl
	add ax, 10
	shl ax, 1
	mov di, ax
	mov ax, 0xb800
	mov es, ax
	mov cx, 58
	mov ax, 0x6720
	rep stosw

	mov ax, 9
	mov bl, 80
	mul bl
	add ax, 10
	shl ax, 1
	mov di, ax
	mov ax, 0xb800
	mov es, ax
	mov cx, 58
	mov ax, 0x6720
	rep stosw


	mov di, 178
	mov cx, 9
	mov ax, 0x6720
	loop1:
	mov [es:di], ax
	add di, 160
	loop loop1

	mov di, 294
	mov cx, 9
	loop2:
	mov [es:di], ax
	add di, 160
	loop loop2



	;C print
	mov di, 508
	mov ax, 0x7720
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax



	;A print
	mov di, 516
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax


	add di, 160
	sub di, 4
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax






	;T print
	mov di, 524
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di , 2
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax



	;C print
	mov di, 532
	mov ax, 0x7720
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax



	;H print
	mov di, 540
	mov [es:di], ax
	add di, 2

	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax


	add di, 160
	sub di, 4
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax




	;X print
	mov di, 554
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	add di, 2
	mov [es:di], ax
	add di, 2


	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax




	;S print
	mov di, 568
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax


	sub di, 4
	add di, 160
	add di, 2
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax





	;C print
	mov di, 576
	mov ax, 0x7720
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax





	;O print
	mov di, 584
	mov ax, 0x7720
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 4
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 4
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 4
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax






	;R print
	mov di, 592
	mov ax, 0x7720
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 4
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di, 2
	add di, 160
	mov [es:di], ax
	add di, 4
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax







	;E print
	mov di, 600
	mov ax, 0x7720
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax




	pop bx
	pop cx
	pop di
	pop es
	pop ax
	pop bp
	ret


printdashes1:
	push bp
	mov bp, sp
	push ax
	push es
	push di
	push cx
	push bx

	mov ax, 1
	mov bl, 80
	mul bl
	add ax, 10
	shl ax, 1
	mov di, ax
	mov ax, 0xb800
	mov es, ax
	mov cx, 58
	mov ax, 0x6720
	rep stosw

	mov ax, 9
	mov bl, 80
	mul bl
	add ax, 10
	shl ax, 1
	mov di, ax
	mov ax, 0xb800
	mov es, ax
	mov cx, 58
	mov ax, 0x6720
	rep stosw


	mov di, 178
	mov cx, 9
	mov ax, 0x6720
	loop3:
	mov [es:di], ax
	add di, 160
	loop loop3

	mov di, 294
	mov cx, 9
	loop4:
	mov [es:di], ax
	add di, 160
	loop loop4






	mov ax, 0x7720
	;I print
	mov di, 524
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di , 2
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 160
	sub di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax





	;T print
	mov di, 532
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di , 2
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax



	;S print
	mov di, 540
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax


	sub di, 4
	add di, 160
	add di, 2
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax







	;X print
	mov di, 554
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	add di, 2
	mov [es:di], ax
	add di, 2


	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax

	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax







	;O print
	mov di, 568
	mov ax, 0x7720
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 4
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 4
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 4
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax





	;V print
	mov di, 576
	mov [es:di], ax
	add di, 4
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	sub di, 4
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 4
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	sub di, 4
	mov [es:di], ax
	add di, 160
	add di, 2
	mov [es:di], ax





	;E print
	mov di, 584



	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	mov [es:di], ax



	;R print
	mov di, 592
	mov ax, 0x7720
	mov ax, 0x7720
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	add di, 2
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 4
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	mov [es:di], ax
	sub di, 2
	add di, 160
	mov [es:di], ax
	add di, 4
	mov [es:di], ax
	sub di, 4
	add di, 160
	mov [es:di], ax
	add di, 2
	add di, 2
	mov [es:di], ax









	pop bx
	pop cx
	pop di
	pop es
	pop ax
	pop bp
	ret






startscr:
push bp
push ax


call clearscreen
call printdashes



mov ax, 28
push ax
mov ax, 12
push ax
mov ax, press
push ax
mov ax, 22
push ax
call printstr


mov ax, 1
push ax
mov ax, 4
push ax
mov ax, 15
push ax
call printcoin


mov ax, 9
push ax
mov ax, 16
push ax
mov ax, this1
push ax
mov ax, 26
push ax
call printstr

mov ax, 2
push ax
mov ax, 44
push ax
mov ax, 21
push ax
call printcoin


mov ax, 49
push ax
mov ax, 22
push ax
mov ax, this2
push ax
mov ax, 27
push ax
call printstr



mov ax, 3
push ax
mov ax, 4
push ax
mov ax, 21
push ax
call printcoin


mov ax, 9
push ax
mov ax, 22
push ax
mov ax, this3
push ax
mov ax, 27
push ax
call printstr




mov ax, 44
push ax
mov ax, 15
push ax
call printdanger


mov ax, 49
push ax
mov ax, 16
push ax
mov ax, this4
push ax
mov ax, 25
push ax
call printstr


pop ax
pop bp
ret



endscr:
push bp
push ax
call clearscreen
call printdashes1

cmp word[timevar1], 200
je won 
mov ax, 32
push ax
mov ax, 12
push ax
mov ax, msg1
push ax
mov ax, 16
push ax
call printstr

jmp outt

won:

mov ax, 32
push ax
mov ax, 12
push ax
mov ax, msg2
push ax
mov ax, 25
push ax
call printstr

outt:

mov ax, 26
push ax
mov ax, 13
push ax
mov ax, msg3
push ax
mov ax, 26
push ax
call printstr

mov ax, 51
push ax
mov ax, 13
push ax
mov ax, 1
push ax
mov ax, [cs:timevar1]
push ax
call printnum



mov ax, 26
push ax
mov ax, 14
push ax
mov ax, msg4
push ax
mov ax, 30
push ax
call printstr

mov ax, 55
push ax
mov ax, 14
push ax
mov ax, 0
push ax
mov ax, [cs:scorevar]
push ax
call printnum




mov ax, 26
push ax
mov ax, 16
push ax
mov ax, msg5
push ax
mov ax, 28
push ax
call printstr

mov ax, 53
push ax
mov ax, 16
push ax
mov ax, 0
push ax
mov ax, [cs:count5]
push ax
call printnum

mov ax, 26
push ax
mov ax, 17
push ax
mov ax, msg6
push ax
mov ax, 29
push ax
call printstr

mov ax, 54
push ax
mov ax, 17
push ax
mov ax, 0
push ax
mov ax, [cs:count10]
push ax
call printnum

mov ax, 26
push ax
mov ax, 18
push ax
mov ax, msg7
push ax
mov ax, 29
push ax
call printstr

mov ax, 54
push ax
mov ax, 18
push ax
mov ax, 0
push ax
mov ax, [cs:count15]
push ax
call printnum

mov ax, 26
push ax
mov ax, 20
push ax
mov ax, msg8
push ax
mov ax, 22
push ax
call printstr

pop ax
pop bp
ret





delay:
push bp
push ax
push cx
mov cx, 0xfa
delayloop1:
mov ax, cx
mov cx, 0x26f
delayloop2:
loop delayloop2
mov cx, ax
loop delayloop1

pop cx
pop ax
pop bp
ret





scrolldown:
push bp
push ax
push cx
push ds
push si
push di
push es

mov ax, 0xb800
mov es, ax
mov ds, ax

mov di, 3518
mov si, 3358
std

mov cx, 1520

rep movsw

mov di, 320
mov cx, 80
cld
mov ax, 0x1720
rep stosw


pop es
pop di
pop si
pop ds
pop cx
pop ax
pop bp
ret




remove:

	push bp
	mov bp, sp
	push ax
	push di
	push bx
	push dx
	push es
	;bp+4 mai y cordinate of coin
	;bp+6 mai x cordinate of coin

	xor ax, ax
	mov al,[bp+4]
	mov bl,80
	mul bl
	add ax,[bp+6]
	shl ax,1
	mov di,ax
	mov ax, 0xb800
	mov es, ax ; 


	mov word[es:di], 0x1720
	add di,2
	mov word[es:di], 0x1720
	add di,2
	mov word[es:di], 0x1720
	add di,160
	mov word[es:di], 0x1720
	sub di,2
	mov word[es:di], 0x1720
	sub di,2
	mov word[es:di], 0x1720
	add di,160
	mov word[es:di], 0x1720
	add di,2
	mov word[es:di], 0x1720
	add di,2
	mov word[es:di], 0x1720

pop es
	pop dx
	pop bx
	pop di
	pop ax
	mov sp,bp
	pop bp
	ret 4






timerisr:
push ax
inc word[cs:timetick]
cmp word[cs:timetick], 20
jne endtimisr
inc word[cs:timevar]
inc word[cs:timevar1]
mov word[cs:timetick], 0
cmp word[cs:timevar], 60
jne endtimisr
add word[cs:timevar1], 100
sub word[cs:timevar1], 60
sub word[cs:timevar], 60

endtimisr:

pop ax
jmp far[cs:oldtimerisr]





randomgen:
push bp
push ax
push bx
push cx
push si
push dx

mov ax, [cs:random]
mov bx, [cs:random1]     ;(ax * bl + si) mod cx
mov si, [cs:random2]
mov cx, 3

mul bl
add ax, si
mov dx, 0
div cx 

add ax, [cs:random3]

mov [cs:random], ax

mov bx, 40
push bx
mov bx, 0
push bx
mov bx, 0
push bx
push word[cs:random]
call printnum

dec word[cs:random1]
dec word[cs:random2]
mov ax, [cs:random1]
add [cs:random2], ax

mov ax, [cs:random2]
mov bl, [cs:random]
mul bl
add [cs:random3], ax

pop dx
pop si
pop cx
pop bx
pop ax
pop bp
ret

game:
			push bp
			mov bp, sp
			pusha

			call clearscreen
			
			mov ax, [es: 8 * 4]
			mov [cs:oldtimerisr], ax
			mov ax, [es: 8 * 4 + 2]
			mov [cs:oldtimerisr + 2], ax
			cli
			mov word[es: 8 * 4], timerisr
			mov [es: 8 * 4 + 2], cs
			sti
			
			mov ax, score
			push ax
			mov ax, [cs:scorevar]
			push ax ; place number on stack
			call printscore

			mov ax, time
			push ax
			mov ax, [cs:timevar1]
			push ax ; place number on stack
			call printtime

			mov ax, 32       ;col
			push ax
			mov ax, 1        ;row
			push ax
			mov ax, titles
			push ax
			mov ax, 13       ;length
			push ax
			call printstr
			
			push word[bucketx]
			call printbucket
			
	bruh:
			mov si,0
			addrow:
			mov cx,[cs:objnumber]
			shl cx,1
			cmp si,cx
			jnb exitrow
			inc word[cs:objtypex+si]
			add si,2
			jmp addrow
			exitrow:
			
			mov ax, time
			push ax
			mov ax, [cs:timevar1]
			push ax ; place number on stack
			call printtime
			
			mov ax, score
			push ax
			mov ax, [cs:scorevar]
			push ax ; place number on stack
			call printscore
			
			cmp word[cs:timevar1], 200
			jne check
			mov word[cs:die], 1
			
			check: cmp word[cs:die], 1
			jne check1
			jmp gameov
			check1:
			
			
			
			
			;==================
			cmp word[cs:objnumber],6
			jne check2
			jmp noadd
			check2:
			
			call randomgen     ;this mod tell whether we print or not
			mov bx,5
			mov ax,[cs:random]
			mov dx,0
			div bx
			
			cmp dx, 0
			je check3
			jmp noadd
			check3:
			
			 
			mov si,[cs:objnumber] ;this mod tell object type
			shl si,1
			mov bx,4
			mov ax,[cs:random]
		    mov dx,0
			 div bx
			
			 mov [cs:objtype+si],dx
			
			
			mov bx, 78     ;mod give column
			mov ax,[cs:random]
			mov dx,0
			div bx
			
			push si
			mov si,0
			
			compare:
			mov cx,[cs:objnumber]
			shl cx,1
			cmp si,cx
			jnb exitcompare
			
			mov ax,[cs:objtypey+si]
			sub ax,dx
			cmp ax,-2
			jl  nocollision
			cmp ax,2
			jle collisiony
			jmp nocollision
			
			
			collisiony:
			mov ax,[cs:objtypex+si]
			sub ax,1
			cmp ax, 3
			jle collision
			jmp nocollision
			
			collision:
			call randomgen
			mov bx,75
			mov ax,[cs:random]
			mov dx,0
			div bx
			
			mov si,-2
			
			nocollision:
			add si,2
			jmp compare
			
			exitcompare:
			
			pop si
			
			mov [cs:objtypey+si],dx
			mov word[cs:objtypex+si],2
			
			
			 mov ax,[cs:objnumber]
			 add ax,1
			 mov [cs:objnumber],ax
			 
			 cmp word[cs:objtype+si],0
			 jnz coin1
			 
			 push dx
			 mov ax,2
			push ax
			 call printdanger
			 jmp noadd
			 
			coin1:
			
			push word[cs:objtype+si]
			;tcr
			push dx
			mov ax,2
			push ax
			call printcoin
			
			
			noadd:
			
			cmp word[cs:objnumber], 0
			jne	check5
			jmp objectend
			check5:
			
			cmp word[cs:objtypex], 19
			je check6
			jmp objectend
			
			check6:
			mov ax, [cs:bucketx]
			sub ax, [cs:objtypey]
			cmp ax, -4
			jl objectend1
			cmp ax, 2
			jg objectend1
			
			cmp word[cs:objtype], 0
			je dangerfound
			
			cmp word[cs:objtype], 1
			jne not1
			inc word[cs:count5]
			jmp normal
			
			not1: cmp word[cs:objtype], 2
			jne not2
			inc word[cs:count10]
			jmp normal
			
			not2: inc word[cs:count15]
			
			normal:
			mov ax, [cs:objtype]
			mov bl, 5
			mul bl
			add [cs:scorevar], ax
			jmp objectend1
			
			dangerfound:
			mov word[cs:die], 1
			jmp objectend1
			
			objectend1:
			
			mov ax, [cs:objtypey]
			push ax
			mov ax, [cs:objtypex]
			push ax
			call remove
			
			mov si,0
			dec word[cs:objnumber]
			
			shiftarr:
			mov cx,[cs:objnumber]
			shl cx,1
			cmp si,cx
			jnb objectend
			
			mov ax, [cs:objtype+si + 2]
			mov bx, [cs:objtypex+si + 2]
			mov cx, [cs:objtypey+si + 2]
			
			mov [cs:objtype+si], ax
			mov [cs:objtypex+si], bx
			mov [cs:objtypey+si], cx
			
			add si,2
			jmp shiftarr
			
			
			objectend:
			
			
			cmp word[cs:gamend], 1
			jae gameov
			
			
			call scrolldown
			call delay
			call delay
			
			jmp bruh
		

			gameov:
			popa
			pop bp

			ret
			







doleftshift:
	push bp
	push ds
	push ax
	push es
	push si
	push di
	push cx
	push bx
	push dx
	
	mov ax, 0xb800
	mov es, ax
	mov ds, ax
	mov bx, 0
	loopshift1:
	cld
	mov si, 3522
	mov ax, bx
	mov dl, 160
	mul dl
	add si, ax
	mov di, 3520
	add di, ax
	mov cx, 79
	rep movsw
	add bx, 1
	cmp bx, 3
	jne loopshift1
	
	mov di, 3678
	mov word[es:di], 0x4720
	mov di, 3838
	mov word[es:di], 0x4720
	mov di, 3998
	mov word[es:di], 0x4720


pop dx
pop bx
pop cx
pop di
pop si
pop es
pop ax
pop ds
pop bp
ret




dorightshift:



push bp
	push ds
	push ax
	push es
	push si
	push di
	push cx
	push bx
	push dx


mov ax, 0xb800
	mov es, ax
	mov ds, ax
	mov bx, 0
	loopshift:
	std
	mov si, 3676
	mov ax, bx
	mov dl, 160
	mul dl
	add si, ax
	mov di, 3678
	add di, ax
	mov cx, 79
	rep movsw
	add bx, 1
	cmp bx, 3
	jne loopshift
	
	mov di, 3520
	mov word[es:di], 0x4720
	mov di, 3680
	mov word[es:di], 0x4720
	mov di, 3840
	mov word[es:di], 0x4720


pop dx
pop bx
pop cx
pop di
pop si
pop es
pop ax
pop ds
pop bp
ret






kbisr:
pusha
pushf

in ax, 0x60
cmp al, 0x4b
jne right
cmp word[cs:bucketx], 0
je nomatch
dec word[cs:bucketx]
call doleftshift
jmp nomatch

right:
cmp al, 0x4d
jne escchk
cmp word[cs:bucketx], 75
je nomatch
inc word[cs:bucketx]
call dorightshift
jmp nomatch

escchk:
cmp al, 1
jne endisr
mov word[cs:gamend], 1
jmp nomatch

endisr:
popf
popa

jmp far[cs:oldkbisr]

nomatch:
mov al, 0x20
out 0x20, al
popf
popa
iret



start:
call clearscreen

mov ah, 0x2c
int 21h

mov bx, 0
add bl, dh ;dh contains seconds

add bl, dl

mov al, cl  ;minutes
mov dl, 60
mul dl

add bx, ax  

mov ax, 0
mov al, ch ;ch hours
shr al, 1
mov dx, 3600
mul dx

add bx, ax


mov [random], bx

cli
mov ax, 59659      ;1193180 / 59659 = 20
out 0x40, al
mov al, ah
out 0x40, al
sti

mov ah, 0x01     ;turns cursor blinking off
mov cx, 0x2607  ;invinsible attribute
int 10h


call startscr

mov ah, 0
int 0x16


xor ax, ax
mov es, ax
mov cx, [es: 9 * 4]
mov [oldkbisr], cx
mov dx, [es: 9 * 4 + 2]
mov [oldkbisr + 2], dx
cli
mov word [es: 9 * 4], kbisr
mov [es: 9 * 4 + 2], cs
sti

call game
cli
mov cx, [oldkbisr]
mov [es: 9 * 4], cx
mov dx, [oldkbisr + 2]
mov [es: 9 * 4 + 2], dx
sti

cli
mov si, [oldtimerisr]
mov [es: 8 * 4], si
mov di, [oldtimerisr+2]
mov [es: 8 * 4 + 2], di
sti

cmp word[gamend], 1
je endit


call endscr

mov ah, 0
int 0x16



endit:

mov ah, 0x01
mov cx, 0x0607  ;normal cursor attribute
int 10h

cli
mov ax, 0xffff      ;1193180 / 65535 = 18.2
out 0x40, al
mov al, ah
out 0x40, al
sti

mov ax, 4c00h
int 21h