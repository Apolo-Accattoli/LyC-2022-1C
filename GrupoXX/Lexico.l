%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
FILE *yyin;
char *yyltext;
int yyval;
int yyerror(void);

%}

%option noyywrap
%option yylineno


DIGITO    		[0-9]
LETRA     		[a-zA-Z]
ID 		  		{LETRA}({LETRA}|{DIGITO})*
CONS_STR  		\"({LETRA}|{DIGITO}|{SIMBOLO})*\"
CONS_FLOAT 		{DIGITO}+.{DIGITO}+
CONS_INT  		{DIGITO}+
PUNTOCOMA 		";"
COMA  	  		","
OPASIG   		":"
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
PARENTESISA		"("
PARENTESISC		")"
SIMBOLO       	[!|@|#|$|%|^|&|=|*|.|/|-|+|\"|" "|:|)|(|<|>]


%%
"DECVAR"    	printf("\nDECVAR  	(%s)",yytext);
"ENDDEC"    	printf("\nENDDEC  	(%s)",yytext);
"write"     	printf("\nWRITE   	(%s)",yytext);
"Integer"   	printf("\nINTEGER 	(%s)",yytext);
"Float"     	printf("\nFLOAT   	(%s)",yytext);
		    
"while"     	printf("\nWHILE   	(%s)",yytext);
"for"       	printf("\nFOR     	(%s)",yytext);
"if"        	printf("\nIF      	(%s)",yytext);
"else"      	printf("\nELSE    	(%s)",yytext);
		    
{ID}    		printf("\nID 	    (%s)",yytext);

{PUNTOCOMA}   	printf("\nPUNTOCOMA 	(%s)",yytext);
{COMA}      	printf("\nCOMA    		(%s)",yytext);
{OPASIG}   		printf("\nOPASIG 		(%s)",yytext);
{OPSUMA}   		printf("\nOPSUMA 		(%s)",yytext);
{OPRESTA}  		printf("\nOPRESTA  		(%s)",yytext);
{OPMUL}  		printf("\nOPMULT  		(%s)",yytext);
{OPDIV}    		printf("\nOPDIV 		(%s)",yytext);
{CONS_STR}		printf("\nCONS_STR 		(%s)",yytext);
{CONS_INT}		printf("\nCONS_INT 		(%s)",yytext);
{CONS_FLOAT}	printf("\nCONS_FLOAT	(%s)",yytext);    
{OPMAYOR}  		printf("\nOPMAYOR		(%s)",yytext);
{OPMENOR}  		printf("\nOPMENOR 		(%s)",yytext);
{OPMENORIGUAL}  printf("\nOPMENORIGUAL 	(%s)",yytext);
{OPMAYORIGUAL}  printf("\nOPMAYORIGUAL 	(%s)",yytext);
{OPDISTINTO} 	printf("\nOPDISTINTO 	(%s)",yytext);
{OPIDENTICO}	printf("\nOPIDENTICO 	(%s)",yytext);
{LLAVEA}   		printf("\nLLAVEA 		(%s)",yytext); 
{LLAVEC}   		printf("\nLLAVEC 		(%s)",yytext);
{PARENTESISA}   printf("\nPARENTESISA 	(%s)",yytext);
{PARENTESISC}   printf("\nPARENTESISAC 	(%s)",yytext);


"\n\t"      
"\r\n"
"\n"
"\t"
" "
.				yyerror(); //Esta función está porque toma cualquier caracter que no se haya reconocido por una regla, y devuelve el error.

%%

int main(int argc,char *argv[])
{
	if ((yyin = fopen(argv[1], "rt")) == NULL)
	{
		printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
	}
	else
	{
		yylex();
	}
	fclose(yyin);
	return 0;
}

int yyerror(void)
{
	printf("Error lexico: Caracter invalido: %s en linea: %d\n",yytext,yylineno);
	exit(1);
}
