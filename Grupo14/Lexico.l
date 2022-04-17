%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MAX_INT 65535
#define MAX_STRING 30
#define MAX_ID 15


FILE *yyin;
char *yyltext;
int yyval;
int yyerror(void);
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
CONS_FLOAT 		{DIGITO}*.{DIGITO}+|{DIGITO}+.{DIGITO}*
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
"FOR"       	{return FOR;}
"ENDFOR"       	{return ENDFOR;}
"IF"        	{return IF;}
"ELSE"      	{return ELSE;}
"ENDIF"      	{return ENDIF;}
"BETWEEN"		{return BETWEEN;}
"INLIST"		{return INLIST;}
				    
{ID}    		{
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
					validarString(yytext);
					return CONS_STR;
				}
{CONS_INT}		{
					int entero = atoi(yytext);
					validarInt(entero);
					return CONS_INT;
				}
{CONS_FLOAT}	{
					int real = atof(yytext);
					validarFloat(real);
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
{PARENTESISA}   {return PARENTESISA;}
{PARENTESISC}   {return PARENTESISC;}
{CORCHETEA}   {return CORCHETEA;}
{CORCHETEC}   {return CORCHETEC;}

{COMENTARIO}
"\n\t"      
"\r\n"
"\n"
"\t"
" "
.				yyerror();

%%

int main(int argc,char *argv[])
{
	if ((yyin = fopen(argv[1], "rt")) == NULL)
	{
		{returnNo se puede abrir el archivo: %s\n", argv[1]);
	}
	else
	{
		yylex();
	}
	fclose(yyin);
	return 0;
}

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
        yyerror("Error: Rango de float excedidom en linea %d. Se permite entre [1.175494*10^-38; 3.402823*10^38] o cero.\n", yylineno);
    }
}
void validarInt(int numero)
{
    if(numero > 65535)
    {
        yyerror("Error: Valor de int excedido, el mayor posible es %d", yylineno, MAX_INT);
    }
}

int yyerror(void)
{
	printf("Error lexico: Caracter invalido: %s en linea: %d\n",yytext,yylineno);
	exit(1);
}