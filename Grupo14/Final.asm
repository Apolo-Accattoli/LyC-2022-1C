INCLUDE macros2.asm
INCLUDE number.asm
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
_3_33                           	dd	3.33
_2_22                           	dd	2.22
_1_11                           	dd	1.11
_25                             	dd	25
_3                              	dd	3
_5                              	dd	5
_8                              	dd	8
_6                              	dd	6
_30                             	dd	30
_31_5                           	dd	31.5
_10                             	dd	10
_a_____                         	db	"a     ",'$', 6 dup (?)
_16                             	dd	16
_Ingrese_repeticiones           	db	"Ingrese repeticiones",'$', 20 dup (?)
_Ingrese_otro_repeticiones      	db	"Ingrese otro repeticiones",'$', 25 dup (?)
_40                             	dd	40
_If_sin_Else                    	db	"If sin Else",'$', 11 dup (?)
_b                              	db	"b",'$', 1 dup (?)
_0                              	dd	0
_1                              	dd	1
_100                            	dd	100
_menor                          	db	"menor",'$', 5 dup (?)
_Mayor                          	db	"Mayor",'$', 5 dup (?)
_Ingrese_1_para_salir           	db	"Ingrese 1 para salir",'$', 20 dup (?)
_2                              	dd	2
_15                             	dd	15
_si_BETWEEN                     	db	"si BETWEEN",'$', 10 dup (?)
_no_BETWEEN                     	db	"no BETWEEN",'$', 10 dup (?)
_7                              	dd	7
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

fld _3_33
fst f1
fld _2_22
fst f2
fld f1
fld f2
fadd
fstp @aux1
fld @aux1
fld _1_11
fadd
fstp @aux2
fld @aux2
fst f2
DisplayFloat f2,2
newLine 1
fild _25
fist a
fild _3
fist b
fild a
fild _5
fadd
fistp @aux3
fild b
fild @aux3
fmul
fistp @aux4
fild @aux4
fist a
fild _8
fist x
fild _25
fist i
fild a
fild _5
fxch
fcom
fstsw ax
sahf
JA else1
startIf1:
fild _6
fist x
JMP endif1
else1:
fild a
fild _30
fxch
fcom
fstsw ax
sahf
JNA startIf2
fld f1
fld _31_5
fxch
fcom
fstsw ax
sahf
JB startIf2
JMP else2
startIf2:
fild _10
fist c
JMP endif2
else2:
displayString _a_____
newLine 1
endif2:
fild _16
fist i
endif1:
DisplayInteger x
newLine 1
DisplayInteger c
newLine 1
DisplayInteger i
newLine 1
displayString _Ingrese_repeticiones
newLine 1
GetInteger x
displayString _Ingrese_otro_repeticiones
newLine 1
GetInteger i
fild x
fild _40
fxch
fcom
fstsw ax
sahf
JA endif3
fild i
fild _5
fxch
fcom
fstsw ax
sahf
JNE endif3
startIf3:
displayString _If_sin_Else
newLine 1
displayString _b
newLine 1
endif3:
fild _0
fist c
fild _0
fist a
condicionWhile1:
fild a
fild x
fxch
fcom
fstsw ax
sahf
JAE endwhile1
fild b
fild _1
fxch
fcom
fstsw ax
sahf
JE endwhile1
startWhile1:
condicionWhile2:
fild c
fild i
fxch
fcom
fstsw ax
sahf
JAE endwhile2
startWhile2:
DisplayInteger c
newLine 1
fild c
fild _100
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
displayString _Mayor
newLine 1
endif4:
fild c
fild _1
fadd
fistp @aux5
fild @aux5
fist c
JMP condicionWhile2
endwhile2:
displayString _Ingrese_1_para_salir
newLine 1
GetInteger b
fild a
fild _1
fadd
fistp @aux6
fild @aux6
fist a
JMP condicionWhile1
endwhile1:
fild a
fild _2
fxch
fcom
fstsw ax
sahf
JNA else5
fild a
fild _15
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
fild _2
fild b
fmul
fistp @aux7
fild @aux7
fild _7
fadd
fistp @aux8
fild a
fild @aux8
fxch
fcom
fstsw ax
sahf
JE startIf6
fild a
fild _12
fxch
fcom
fstsw ax
sahf
JE startIf6
fild _34
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
fild _48
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
displayString cadena
newLine 1
displayString _ewr
newLine 1

liberar:
	ffree
	mov ax, 4c00h
	int 21h
	jmp fin
fin:
	End START
