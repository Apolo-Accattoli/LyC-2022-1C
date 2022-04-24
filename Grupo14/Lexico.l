%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include "y.tab.h"

#define MAX_INT 65535
#define MAX_STRING 30
#define MAX_ID 15


FILE *yyin;
char *yyltext;
int yyval;
int yyerror(char *, int, int , int);
void validarString(char[]);
void validarFloat(double);
void validarInt(int);
%}

%option noyywrap
%option yylineno


DIGITO    		[0-9]
LETRA     		[a-zA-Z]
COMENTARIO		"-/"(.*?)"/-"
CONS_STR  		\"([^\"\\]|\\\"|\\\\)*\"
ID 		  		{LETRA}({LETRA}|{DIGITO})*
CONS_FLOAT 		{DIGITO}*"."{DIGITO}+|{DIGITO}+"."{DIGITO}*
CONS_INT  		{DIGITO}+
PUNTOCOMA 		";"
COMA  	  		","
OPASIG   		":="
DOSPUNTOS   	":"
OPSUMA   		"+"
OPRESTA  		"-"
OPMUL  			"*"
OPDIV    		"/"
OPMAYOR  		">"
OPMENOR  		"<"
OPMENORIGUAL    "<="
OPMAYORIGUAL    ">="
OPDISTINTO 		"!="
OPIDENTICO 		"=="
LLAVEA   		"{"
LLAVEC   		"}"
CORCHETEA   	"["
CORCHETEC   	"]"
PARENTESISA		"("
PARENTESISC		")"
SIMBOLO       	[!|@|#|$|%|^|&|=|*|.|/|-|+|\"|" "|:|)|(|<|>]


%%
"DECVAR"    	{return DECVAR;}
"ENDDEC"    	{return ENDDEC;}
"WRITE"     	{return WRITE;}
"READ"     		{return READ;}
"INTEGER"   	{return INTEGER;}
"FLOAT"     	{return FLOAT;}
"STRING"   		{return STRING;}
"AND"     		{return AND;}
"OR"     		{return OR;}
"NOT"     		{return NOT;}	    
"WHILE"     	{return WHILE;}
"ENDWHILE"     	{return ENDWHILE;}
"IF"        	{return IF;}
"ELSE"      	{return ELSE;}
"ENDIF"      	{return ENDIF;}
"BETWEEN"		{return BETWEEN;}
"INLIST"		{printf("INLISTLex \n");return INLIST;}
				    
{ID}    		{	printf("Id: %s \n", yytext);
					yylval.tipo_str = yytext;
					return ID;
				}
{PUNTOCOMA}   	{return PUNTOCOMA;}
{COMA}      	{return COMA;}
{OPASIG}   		{return OPASIG;}
{DOSPUNTOS}    	{return DOSPUNTOS;}
{OPSUMA}   		{return OPSUMA;}
{OPRESTA}  		{return OPRESTA;}
{OPMUL}  		{return OPMUL;}
{OPDIV}    		{return OPDIV;}
{CONS_STR}		{
					yylval.tipo_str = yytext;
                    validarString(yylval.tipo_str);
                    insertarTS(yylval.tipo_str, "CONS_STR", yylval.tipo_str, 0, 0);
                    return CONS_STR;
				}
{CONS_INT}		{
					
					yylval.tipo_int = atoi(yytext);
                    validarInt(yylval.tipo_int);
                    insertarTS(yytext, "CONS_INT", "", yylval.tipo_int, 0);
                    return CONS_INT;
				}
{CONS_FLOAT}	{
					
                    yylval.tipo_double = atof(yytext);
                    validarFloat(yylval.tipo_double);
                    insertarTS(yytext, "CONS_FLOAT", "", 0, yylval.tipo_double);
					return CONS_FLOAT;
				}    
{OPMAYOR}  		{return OPMAYOR;}
{OPMENOR}  		{return OPMENOR;}
{OPMENORIGUAL}  {return OPMENORIGUAL;}
{OPMAYORIGUAL}  {return OPMAYORIGUAL;}
{OPDISTINTO} 	{return OPDISTINTO;}
{OPIDENTICO}	{return OPIDENTICO;}
{LLAVEA}   		{return LLAVEA;} 
{LLAVEC}   		{return LLAVEC;}
{PARENTESISA}   {printf("ParentesisLex\n"); return PARENTESISA;}
{PARENTESISC}   {return PARENTESISC;}
{CORCHETEA}   {return CORCHETEA;}
{CORCHETEC}   {return CORCHETEC;}

{COMENTARIO}
"\n\t"      
"\r\n"
"\n"
"\t"
" "
.				yyerror("Error lexico, caracter no reconocido",0,0,0);
 
%%

void validarString(char cadena[])
{
    int largo = strlen(cadena);
    if(largo > MAX_STRING)
    {
        printf("Error: Rango de string excedido en linea %d. Se permite un maximo de %d caracteres", yylineno, MAX_STRING);
    }
}
void validarFloat(double numero)
{   
    double max = 3.402823 * pow(10, 38);
    double min = 1.175494 * pow(10, -38);
    if(numero > max || (numero > 0 && numero < min))
    {
        yyerror("Error: Rango de float excedido. Se permite entre [1.175494*10^-38; 3.402823*10^38] o cero.\n",0,0,0);
    }
}
void validarInt(int numero)
{
    if(numero > 65535)
    {
        yyerror("Error: Valor de int excedido, el mayor posible es 65535", 0, 0, 0);
    }
}

int yyerror(char *mensaje, int fila, int ci, int cf)
{
    if(fila == 0 || ci == 0 || cf == 0) /* || fila <= yylineno)*/
        printf("\nLinea %d: %s.\n", yylineno, mensaje);
    else
        printf("\nLinea %d, %d-%d: %s.\n", fila, ci, cf, mensaje);
    
    system("Pause");
    exit(1);
}
