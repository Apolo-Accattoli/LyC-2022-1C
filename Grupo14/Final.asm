INCLUDE macros.asm
INCLUDE macros2.asm
INCLUDE number.asm
INCLUDE numbers.asm
.MODEL LARGE
.386
.STACK 200h
	.DATA
	MAXTEXTSIZE equ 200
a                               	dd	?
b                               	dd	?
c                               	dd	?
i                               	dd	?
x                               	dd	?
cadena                          	dd	?
f1                              	dd	?
f2                              	dd	?
f3                              	dd	?
_3.25                           	dd	3.25
_5                              	dd	5
_6                              	dd	6
_30                             	dd	30
_31                             	dd	31
_10                             	dd	10
_Else                           	db	"Else",'$', 4 dup (?)
_7                              	dd	7
_40                             	dd	40
_41                             	dd	41
_120                            	dd	120
_1                              	dd	1
_100                            	dd	100
_menor                          	db	"menor",'$', 5 dup (?)
_mayor                          	db	"mayor",'$', 5 dup (?)
_primero                        	db	"primero",'$', 7 dup (?)
_4                              	dd	4
_9                              	dd	9
_3.33                           	dd	3.33
_2                              	dd	2
_15                             	dd	15
_si_BETWEEN                     	db	"si BETWEEN",'$', 10 dup (?)
_no_BETWEEN                     	db	"no BETWEEN",'$', 10 dup (?)
_12                             	dd	12
_34                             	dd	34
_48                             	dd	48
_si_INLIST                      	db	"si INLIST",'$', 9 dup (?)
_no_INLIST                      	db	"no INLIST",'$', 9 dup (?)
_una_cadena                     	db	"una cadena",'$', 10 dup (?)
_ewr                            	db	"ewr",'$', 3 dup (?)
@aux1                           	dd	?
@aux2                           	dd	?
@aux3                           	dd	?
@aux4                           	dd	?
@aux5                           	dd	?
@aux6                           	dd	?
@aux7                           	dd	?
@aux8                           	dd	?
@aux9                           	dd	?
@aux10                          	dd	?
@aux11                          	dd	?

.CODE
strlen proc
	mov bx, 0
	strLoop:
		cmp BYTE PTR [si+bx],'$'
		je strend
		inc bx
		jmp strLoop
	strend:
		ret
strlen endp
assignString proc
	call strlen
	cmp bx , MAXTEXTSIZE
	jle assignStringSizeOk
	mov bx , MAXTEXTSIZE
	assignStringSizeOk:
		mov cx , bx
		cld
		rep movsb
		mov al , '$'
		mov byte ptr[di],al
		ret
assignString endp

START:
MOV AX,@DATA
MOV DS,AX
MOV es,ax
FINIT
FFREE

fld 3.25
fst f1
fld 5
fild a
fxch
fcom
fstsw ax
sahf
JB else1
JMP startIf1
else1:
fld 6
fist x
JMP endif1
startIf1:
fld 30
fild a
fxch
fcom
fstsw ax
sahf
JAE startIf2
fld 31
fild a
fxch
fcom
fstsw ax
sahf
JE startIf2
JMP else2
JMP startIf2
else2:
fld 10
fist c
JMP endif2
startIf2:
displayString _Else
newLine 1
endif2:
fld 7
fist i
endif1:
GetFloat x
fld 40
fild a
fxch
fcom
fstsw ax
sahf
JNAE endif3
fld 41
fild a
fxch
fcom
fstsw ax
sahf
JNE endif3
startIf3:
fld 120
fist b
endif3:
DisplayFloat x,2
newLine 1
condicionWhile1:
fld 1
fild a
fxch
fcom
fstsw ax
sahf
JB startWhile1
fld 1
fild b
fxch
fcom
fstsw ax
sahf
JB startWhile1
startWhile1:
condicionWhile2:
fld 1
fild c
fxch
fcom
fstsw ax
sahf
JNB endwhile2
startWhile2:
fld 1
fist x
fld 100
fild c
fxch
fcom
fstsw ax
sahf
JNA else4
JMP startIf4
else4:
displayString _menor
newLine 1
JMP endif4
startIf4:
displayString _mayor
newLine 1
endif4:
JMP condicionWhile2
endwhile2:
displayString _primero
newLine 1
JMP condicionWhile1
endwhile1:
fild a
fild b
fadd
fistp @aux1
fild @aux1
fist a
fild b
fild 4
fadd
fistp @aux2
fld @aux2
fist a
fild b
fild 9
fadd
fistp @aux3
fild a
fild @aux3
fmul
fistp @aux4
fld @aux4
fist a
fld f1
fild a
fadd
fistp @aux5
fild @aux5
fld 3.33
fadd
fstp @aux6
fld @aux6
fst f2
fld 2
fild a
fxch
fcom
fstsw ax
sahf
JNB else5
fld 15
fild a
fxch
fcom
fstsw ax
sahf
JNA else5
JMP startIf5
else5:
displayString _si_BETWEEN
newLine 1
JMP endif5
startIf5:
displayString _no_BETWEEN
newLine 1
endif5:
fld 2
fild b
fmul
fistp @aux7
fild @aux7
fild 7
fadd
fistp @aux8
fld @aux8
fild a
fxch
fcom
fstsw ax
sahf
JE startIf6
fld 12
fild a
fxch
fcom
fstsw ax
sahf
JE startIf6
fld 34
fild i
fadd
fistp @aux9
fild b
fild @aux9
fmul
fistp @aux10
fild a
fild @aux10
fadd
fistp @aux11
fild @aux11
fild a
fxch
fcom
fstsw ax
sahf
JE startIf6
fld 48
fild a
fxch
fcom
fstsw ax
sahf
JE startIf6
JMP else6
JMP startIf6
else6:
displayString _si_INLIST
newLine 1
JMP endif6
startIf6:
displayString _no_INLIST
newLine 1
endif6:
MOV si, OFFSET   _una_cadena
MOV di, OFFSET  cadena
CALL assignString
displayString _ewr
newLine 1

liberar:
	ffree
	mov ax, 4c00h
	int 21h
	jmp fin
fin:
	End START
