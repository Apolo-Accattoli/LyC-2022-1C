INCLUDE macros2.asm
INCLUDE number.asm
.MODEL LARGE
.386
.STACK 200h
	.DATA
	MAXTEXTSIZE equ 200
a                               	dd	?
b                               	dd	?
f1                              	dd	?
f2                              	dd	?
_3_33                           	dd	3.33
_2_22                           	dd	2.22
_25                             	dd	25
_3                              	dd	3
_5                              	dd	5
_1_11                           	dd	1.11
_si_BETWEEN                     	db	"si BETWEEN",'$', 10 dup (?)
@aux1                           	dd	?
@aux2                           	dd	?
@aux3                           	dd	?
@aux4                           	dd	?

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
displayString _si_BETWEEN
newLine 1

liberar:
	ffree
	mov ax, 4c00h
	int 21h
	jmp fin
fin:
	End START
