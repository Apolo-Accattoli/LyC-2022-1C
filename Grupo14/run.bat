del Primera.exe
del lex.yy.c
flex .\Lexico.l
gcc .\lex.yy.c -o Primera.exe
.\Primera.exe prueba.txt
pause