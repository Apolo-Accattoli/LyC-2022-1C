del Final.asm
del Grupo14.exe
del ts.txt
del intermedia.png
del intermedia.dot
del intermedia.txt

flex .\Lexico.l
bison -dyv .\Sintactico.y
gcc.exe lex.yy.c y.tab.c -o Grupo14.exe
.\Grupo14.exe prueba.txt
dot -Tpng intermedia.dot > intermedia.png
pause

del lex.yy.c
del y.tab.c
del y.tab.h
del y.output

