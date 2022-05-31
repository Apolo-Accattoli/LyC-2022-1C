del Primera.exe
del ts.txt
del grafico.png
del gragh.dot
flex .\Lexico.l
bison -dyv .\Sintactico.y
gcc.exe lex.yy.c y.tab.c -o Primera.exe
.\Primera.exe prueba.txt
dot -Tpng gragh.dot > grafico.png
pause

del lex.yy.c
del y.tab.c
del y.tab.h
del y.output

