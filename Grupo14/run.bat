del Segunda.exe
del ts.txt
del intermedia.png
del intermedia.dot
del intermedia.txt

flex .\Lexico.l
bison -dyv .\Sintactico.y
gcc.exe lex.yy.c y.tab.c -o Segunda.exe
.\Segunda.exe prueba.txt
dot -Tpng intermedia.dot > intermedia.png
pause

del lex.yy.c
del y.tab.c
del y.tab.h
del y.output

