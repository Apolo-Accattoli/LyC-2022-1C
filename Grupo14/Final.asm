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
_30                             	dd	30
_31                             	dd	31
_True1                          	db	"True1",'$', 5 dup (?)
_40                             	dd	40
_51                             	dd	51
_True2                          	db	"True2",'$', 5 dup (?)
_False2                         	db	"False2",'$', 6 dup (?)
_False1                         	db	"False1",'$', 6 dup (?)

.CODE

START:
MOV AX,@DATA
MOV DS,AX
MOV es,ax
FINIT
FFREE

fld 3.25
fst f1
fild a
fld 30
fxch
fcom
fstsw ax
sahf
JNA startIf1
fild x
fld 31
fxch
fcom
fstsw ax
sahf
JE startIf1
JMP else1
startIf1:
displayString _True1
newLine 1
JMP endif1
else1:
fild b
fld 40
fxch
fcom
fstsw ax
sahf
JA else2
fild i
fld 51
fxch
fcom
fstsw ax
sahf
JNE else2
startIf2:
displayString _True2
newLine 1
JMP endif2
else2:
displayString _False2
newLine 1
endif2:
displayString _False1
newLine 1
endif1:

liberar:
	ffree
	mov ax, 4c00h
	int 21h
	jmp fin
fin:
	End START
