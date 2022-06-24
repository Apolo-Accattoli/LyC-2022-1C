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

fld _3.25
fst f1
fild a
fld _5
fxch
fcom
fstsw ax
sahf
JA else1
startIf1:
fld _6
fist x
JMP endif1
else1:
fild a
fld _30
fxch
fcom
fstsw ax
sahf
JNA startIf2
fild a
fld _31
fxch
fcom
fstsw ax
sahf
JE startIf2
JMP else2
startIf2:
fld _10
fist c
JMP endif2
else2:
displayString _Else
newLine 1
endif2:
fld _7
fist i
endif1:
GetFloat x
fild a
fld _40
fxch
fcom
fstsw ax
sahf
JA endif3
fild a
fld _41
fxch
fcom
fstsw ax
sahf
JNE endif3
startIf3:
fld _120
fist b
endif3:
DisplayFloat x,2
newLine 1
condicionWhile1:
fild a
fld _1
fxch
fcom
fstsw ax
sahf
JA startWhile1
fild b
fld _1
fxch
fcom
fstsw ax
sahf
JA startWhile1
JMP endwhile1
startWhile1:
condicionWhile2:
fild c
fld _1
fxch
fcom
fstsw ax
sahf
JNA endwhile2
startWhile2:
fld _1
fist x
fild c
fld _100
fxch
fcom
fstsw ax
sahf
JAE else4
startIf4:
displayString _menor
newLine 1
JMP endif4
else4:
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
fild _4
fadd
fistp @aux2
fld @aux2
fist a
fild b
fild _9
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
fld _3.33
fadd
fstp @aux6
fld @aux6
fst f2
fild a
fld _2
fxch
fcom
fstsw ax
sahf
JNA else5
fild a
fld _15
fxch
fcom
fstsw ax
sahf
JAE else5
startIf5:
displayString _si_BETWEEN
newLine 1
JMP endif5
else5:
displayString _no_BETWEEN
newLine 1
endif5:
fld _2
fild b
fmul
fistp @aux7
fild @aux7
fild _7
fadd
fistp @aux8
fild a
fld @aux8
fxch
fcom
fstsw ax
sahf
JE startIf6
fild a
fld _12
fxch
fcom
fstsw ax
sahf
JE startIf6
fld _34
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
fild a
fild @aux11
fxch
fcom
fstsw ax
sahf
JE startIf6
fild a
fld _48
fxch
fcom
fstsw ax
sahf
JE startIf6
JMP else6
startIf6:
displayString _si_INLIST
newLine 1
JMP endif6
else6:
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
