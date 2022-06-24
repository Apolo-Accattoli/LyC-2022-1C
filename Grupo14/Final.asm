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
f1                              	dd	?
f2                              	dd	?
cadena                          	dd	?
_3_33                           	dd	3.33
_2_22                           	dd	2.22
_25                             	dd	25
_3                              	dd	3
_5                              	dd	5
_Ingrese_un_numero              	db	"Ingrese un numero",'$', 17 dup (?)
_El_numero_es                   	db	"El numero es",'$', 12 dup (?)
_1_11                           	dd	1.11
_Verdadero                      	db	"Verdadero",'$', 9 dup (?)
_Falso                          	db	"Falso",'$', 5 dup (?)
_10                             	dd	10
_1                              	dd	1
_2                              	dd	2
_7                              	dd	7
_12                             	dd	12
_34                             	dd	34
_48                             	dd	48
_si_INLIST                      	db	"si INLIST",'$', 9 dup (?)
_no_INLIST                      	db	"no INLIST",'$', 9 dup (?)
_90                             	dd	90
_si_BETWEEN                     	db	"si BETWEEN",'$', 10 dup (?)
_no_BETWEEN                     	db	"no BETWEEN",'$', 10 dup (?)
_Escriba_unas_palabras          	db	"Escriba unas palabras",'$', 21 dup (?)
_Usted_escribio                 	db	"Usted escribio",'$', 14 dup (?)
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

.CODE

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
fild _25
fist a
fild _3
fist b
fild a
fild _5
fadd
fistp @aux1
fild b
fild @aux1
fmul
fistp @aux2
fild @aux2
fist a
displayString _Ingrese_un_numero
newLine 1
GetInteger c
displayString _El_numero_es
newLine 1
DisplayInteger c
newLine 1
DisplayInteger a
newLine 1
fld f1
fld f2
fadd
fstp @aux3
fld @aux3
fld _1_11
fadd
fstp @aux4
fld @aux4
fst f2
DisplayFloat f2,2
newLine 1
fild a
fild b
fxch
fcom
fstsw ax
sahf
JB startIf1
fld f2
fld f1
fxch
fcom
fstsw ax
sahf
JB startIf1
JMP else1
startIf1:
displayString _Verdadero
newLine 1
JMP endif1
else1:
displayString _Falso
newLine 1
endif1:
condicionWhile1:
fild c
fild _10
fxch
fcom
fstsw ax
sahf
JAE endwhile1
startWhile1:
fild c
fild _1
fadd
fistp @aux5
fild @aux5
fist c
DisplayInteger c
newLine 1
JMP condicionWhile1
endwhile1:
fild _2
fild b
fmul
fistp @aux6
fild @aux6
fild _7
fadd
fistp @aux7
fild a
fild @aux7
fxch
fcom
fstsw ax
sahf
JE startIf2
fild a
fild _12
fxch
fcom
fstsw ax
sahf
JE startIf2
fild _34
fild c
fadd
fistp @aux8
fild b
fild @aux8
fmul
fistp @aux9
fild a
fild @aux9
fadd
fistp @aux10
fild a
fild @aux10
fxch
fcom
fstsw ax
sahf
JE startIf2
fild a
fild _48
fxch
fcom
fstsw ax
sahf
JE startIf2
JMP else2
startIf2:
displayString _si_INLIST
newLine 1
JMP endif2
else2:
displayString _no_INLIST
newLine 1
endif2:
fild a
fild _2
fxch
fcom
fstsw ax
sahf
JNA else3
fild a
fild _90
fxch
fcom
fstsw ax
sahf
JAE else3
startIf3:
displayString _si_BETWEEN
newLine 1
JMP endif3
else3:
displayString _no_BETWEEN
newLine 1
endif3:
displayString _Escriba_unas_palabras
newLine 1
getString cadena
displayString _Usted_escribio
newLine 1
displayString cadena
newLine 1

liberar:
	ffree
	mov ax, 4c00h
	int 21h
	jmp fin
fin:
	End START
