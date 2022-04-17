%{
#include <stdio.h>
#include <stdlib.h>

FILE *yyin;
char *yyltext;
int yyval;
int yyerror(void);

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
PARENTESISA		"("
PARENTESISC		")"
SIMBOLO       	[!|@|#|$|%|^|&|=|*|.|/|-|+|\"|" "|:|)|(|<|>]


%%
"DECVAR"    	printf("\nDECVAR  	(%s)",yytext);
"ENDDEC"    	printf("\nENDDEC  	(%s)",yytext);
"WRITE"     	printf("\nWRITE   	(%s)",yytext);
"READ"     		printf("\nREAD   	(%s)",yytext);
"INTEGER"   	printf("\nINTEGER 	(%s)",yytext);
"FLOAT"     	printf("\nFLOAT   	(%s)",yytext);
"STRING"   		printf("\nSTRING 	(%s)",yytext);
"AND"     		printf("\nAND   	(%s)",yytext);
"OR"     		printf("\nOR   		(%s)",yytext);
"NOT"     		printf("\nNOT   	(%s)",yytext);	    
"WHILE"     	printf("\nWHILE   	(%s)",yytext);
"FOR"       	printf("\nFOR     	(%s)",yytext);
"IF"        	printf("\nIF      	(%s)",yytext);
"ELSE"      	printf("\nELSE    	(%s)",yytext);
"ENDIF"      	printf("\nENDIF    	(%s)",yytext);
		    
{ID}    		printf("\nID 	    (%s)",yytext);
{PUNTOCOMA}   	printf("\nPUNTOCOMA 	(%s)",yytext);
{COMA}      	printf("\nCOMA    		(%s)",yytext);
{OPASIG}   		printf("\nOPASIG 		(%s)",yytext);
{DOSPUNTOS}    	printf("\nDOSPUNTOS 		(%s)",yytext);
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
{SIMBOLO}   	printf("\nSimbolo 	(%s)",yytext);
{COMENTARIO}   	printf("\nComentario 	(%s)",yytext);

"\n\t"      
"\r\n"
"\n"
"\t"
" "
.				yyerror(); //Esta función está porque toma cualquier caracter que no se haya reconocido por una regla, y devuelve el error.

%%

//TODO: REVISAR!!!!!!
//CONST_STR Antes estaba así: \"([^\"\\\\]|\\\\.)*\"

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
