INCLUDE macros.asm
INCLUDE macros2.asm
INCLUDE number.asm
INCLUDE numbers.asm
.MODEL LARGE
.386
.STACK 200h
	.DATA
	MAXTEXTSIZE equ 200
a                               	dd	0
b                               	dd	0
c                               	dd	0
i                               	dd	0
x                               	dd	0
cadena                          	dd	0
f1                              	dd	0
f2                              	dd	0
f3                              	dd	0
_3.25                           	db	"3.25",'$', 0 dup (?)
_5                              	db	"5",'$', 0 dup (?)
_6                              	db	"6",'$', 0 dup (?)
_30                             	db	"30",'$', 0 dup (?)
_31                             	db	"31",'$', 0 dup (?)
_10                             	db	"10",'$', 0 dup (?)
_Else                           	db	"Else",'$', 0 dup (?)
_7                              	db	"7",'$', 0 dup (?)
_40                             	db	"40",'$', 0 dup (?)
_41                             	db	"41",'$', 0 dup (?)
_120                            	db	"120",'$', 0 dup (?)
_1                              	db	"1",'$', 0 dup (?)
_100                            	db	"100",'$', 0 dup (?)
_menor                          	db	"menor",'$', 0 dup (?)
_mayor                          	db	"mayor",'$', 0 dup (?)
_primero                        	db	"primero",'$', 0 dup (?)
_4                              	db	"4",'$', 0 dup (?)
_9                              	db	"9",'$', 0 dup (?)
_3.33                           	db	"3.33",'$', 0 dup (?)
_2                              	db	"2",'$', 0 dup (?)
_15                             	db	"15",'$', 0 dup (?)
_si BETWEEN                     	db	"si BETWEEN",'$', 0 dup (?)
_no BETWEEN                     	db	"no BETWEEN",'$', 0 dup (?)
_12                             	db	"12",'$', 0 dup (?)
_34                             	db	"34",'$', 0 dup (?)
_48                             	db	"48",'$', 0 dup (?)
_si INLIST                      	db	"si INLIST",'$', 0 dup (?)
_no INLIST                      	db	"no INLIST",'$', 0 dup (?)
_una cadena                     	db	"una cadena",'$', 0 dup (?)
_ewr                            	db	"ewr",'$', 0 dup (?)
@aux1                           	dd	0
@aux2                           	dd	0
@aux3                           	dd	0
@aux4                           	dd	0
@aux5                           	dd	0
@aux6                           	dd	0
@aux7                           	dd	0
@aux8                           	dd	0
@aux9                           	dd	0
@aux10                          	dd	0
@aux11                          	dd	0

.CODE

START:
MOV AX,@DATA
MOV DS,AX
MOV es,ax
FINIT
FFREE

fld f1
fst 3.25
fld 5
fild a
fxch
fcom
fstsw ax
sahf
JB else1
JMP startIf1
else1:
fild x
fst 6
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
fild c
fst 10
JMP endif2
startIf2:
endif2:
fild i
fst 7
endif1:
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
fild b
fst 120
endif3:
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
fild x
fst 1
fld 100
fild c
fxch
fcom
fstsw ax
sahf
JNA else4
JMP startIf4
else4:
JMP endif4
startIf4:
endif4:
JMP condicionWhile2
endwhile2:
JMP condicionWhile1
endwhile1:
fild a
fild b
fadd
fistp @aux1
fild a
fist @aux1
fild b
fld 4
fadd
fstp @aux2
fild a
fst @aux2
fild b
fld 9
fadd
fstp @aux3
fild a
fld @aux3
fmul
fstp @aux4
fild a
fst @aux4
fld f1
fild a
fadd
fistp @aux5
fild @aux5
fld 3.33
fadd
fstp @aux6
fld f2
fst @aux6
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
JMP endif5
startIf5:
endif5:
fld 2
fild b
fmul
fistp @aux7
fild @aux7
fld 7
fadd
fstp @aux8
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
JMP endif6
startIf6:
endif6:
fld cadena
fst una cadena

liberar:
	ffree
	mov ax, 4c00h
	int 21h
	jmp fin
fin:
	End START
