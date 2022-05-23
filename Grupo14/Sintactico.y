/*---- Declaraciones ----*/

%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
#include <string.h>
#include "arbol_sintactico.h"
#include "pila.h"
FILE  *yyin;

int yyerror();
int yylex();


/* --- Tabla de simbolos --- */
typedef struct
{
        char *nombre;
        char *tipo;
        union Valor{
                int valor_int;
                double valor_double;
                char *valor_str;
        }valor;
        int longitud;
}t_data;

typedef struct s_simbolo
{
        t_data data;
        struct s_simbolo *next;
}t_simbolo;


typedef struct
{
        t_simbolo *primero;
}t_tabla;

void crearTablaTS();
int insertarTS(const char*, const char*, const char*, int, double);
t_data* crearDatos(const char*, const char*, const char*, int, double);
void guardarTS();
t_tabla tablaTS;

char idvec[32][50];
int cantid = 0, i=0;
char vecAux[20];
char* punt;

/* --- Validaciones --- */
int existeID(const char*);
char mensajes[100];
int esNumero(const char*,char*);

/* ---  Funciones auxiliares   --- */
void crearNodoCMP(char * comp);

/* ---  Pilas   --- */
tPila* pilaExpresion;
tPila* pilaBloque;
tPila* pilaCondicion;
tPila* pilaCondiciones;
tPila* pilaEtiq;
tPila* pilaEtiqExpMax;

//Declaración de punteros árbol sintáctico

tArbol 	asigPtr,			//Puntero de asignaciones
		exprPtr,			//Puntero de expresiones
		exprCadPtr,			//Puntero de expresiones de cadenas
		exprAritPtr,		//Puntero de expresiones aritmeticas
		terminoPtr,			//Puntero de terminos
		factorPtr,			//Puntero de factores
		bloquePtr,			//Puntero de bloque
		sentenciaPtr,		//Puntero de sentencia	
		iteracionPtr,		//Puntero de bloque de While	
		listaExpComaPtr,	//Puntero de lista expresion coma
		elseBloquePtr,		//Puntero para el bloque del else
		thenBloquePtr,		//Puntero para el bloque del then
		expreLogAuxPtr,
		auxBloquePtr,
		auxAritPtr,
		auxPtr,
		auxIfPtr,
		salidaPtr,
		entradaPtr,
		declConstantePtr,	//Puntero decl_constante
		auxMaximoHojaPtr,	//Puntero del Maximo
		auxMaxSelNodo,		//Puntero del Maximo
		auxMaxAsigNodo,		//Puntero del Maximo
		auxMaxIFNodo,		//Puntero del Maximo
		auxMaxNodoAnterior,	//Puntero del Maximo
		exprCMPPtr,
		seleccionPtr,
		seleccionIFPtr,
		seleccionIFElsePtr,
		terminoLogicoPtr,
		comparacionPtr,
		comparacionAuxPtr,
		condicionPtr,
		auxCondicionPtr,
		auxMaxNodo,
		exprMaximoPtr,
		auxEtiqPtr,
		auxWhilePtr,
		auxMaxCond;


%}

%union {
int tipo_int;
double tipo_double;
char *tipo_str;
}

/*---- Tokens - Start ----*/

%start PROGRAMA
%token DECVAR "DECVAR"
%token ENDDEC "ENDDEC"
%token INTEGER "INTEGER"
%token FLOAT "FLOAT"
%token STRING "STRING"
%token IF "IF"
%token ELSE "ELSE"
%token ENDIF "ENDIF"
%token WHILE "WHILE"
%token ENDWHILE "ENDWHILE"
%token PUNTOCOMA ";"
%token COMA ","
%token DOSPUNTOS "."
%token OPASIG ":="
%token OPSUMA "+"
%token OPRESTA "-"
%token OPMUL "*"
%token OPDIV "/"
%token PARENTESISA "("
%token PARENTESISC ")"
%token CORCHETEA "["
%token CORCHETEC "]"
%token LLAVEA "{"
%token LLAVEC "}"
%token OPIDENTICO "=="
%token OPDISTINTO "!="
%token OPMENOR "<"
%token OPMENORIGUAL "<="
%token OPMAYOR ">"
%token OPMAYORIGUAL ">="
%token AND "AND" 
%token OR "OR"
%token NOT "NOT"
%token WRITE "WRITE"
%token READ "READ"
%token <tipo_str>ID "identificador"
%token <tipo_int>CONS_INT "constante entera"
%token <tipo_double>CONS_FLOAT "constante real"
%token <tipo_str>CONS_STR "constante string"
%token BETWEEN "BETWEEN"
%token INLIST "INLIST"

/*---- Reglas gramaticales ----*/
%locations

%%

PROGRAMA:
        bloque_declaraciones bloque
        { 
			guardarTS();
			//Acá iría grabar arbol
			printf("\nCompilacion exitosa.\n");
		}
        ;

bloque_declaraciones:
                    DECVAR declaraciones ENDDEC { printf("Bloque declaraciones.\n"); }
                    ;

declaraciones:
            declaracion { printf("Declaraciones.\n"); }
            | declaraciones declaracion { printf("Declaraciones.\n"); }
            ;

declaracion:
             lista_variables DOSPUNTOS INTEGER  {
													for(i=0;i<cantid;i++) //vamos agregando todos los ids que leyo
													{
														if(insertarTS(idvec[i], "INTEGER", "", 0, 0) != 0) //devuelve error porque ya existe, entonces no lo guarda
														{
															sprintf(mensajes, "%s%s%s", "Error: la variable '", idvec[i], "' ya fue declarada");
															yyerror(mensajes, @3.first_line, @3.first_column, @3.last_column);
														}
													}
													cantid=0;												
												} 
            { printf("Declaracion.\n"); }
		    | lista_variables DOSPUNTOS STRING  {                                                    
                                                    for(i=0;i<cantid;i++)
                                                    {
                                                        
                                                        if(insertarTS(idvec[i], "STRING", "", 0, 0) != 0)
                                                        {
                                                            sprintf(mensajes, "%s%s%s", "Error: la variable '", idvec[i], "' ya fue declarada");
                                                            yyerror(mensajes, @3.first_line, @3.first_column, @3.last_column);
                                                        }
                                                        
                                                    } 
													cantid=0;
                                                }
			{ printf("Declaracion.\n"); }
            | lista_variables DOSPUNTOS FLOAT 	{                                                    
                                                    for(i=0;i<cantid;i++)
                                                    {
                                                        if(insertarTS(idvec[i], "FLOAT", "", 0, 0) != 0)
                                                        {
                                                            sprintf(mensajes, "%s%s%s", "Error: la variable '", idvec[i], "' ya fue declarada");
                                                            yyerror(mensajes, @3.first_line, @3.first_column, @3.last_column);
                                                        }   
                                                    }
													cantid=0;                                                    
                                                }
            { printf("Declaracion.\n"); }
			;

lista_variables:
                ID  {                        
                        strcpy(vecAux, yylval.tipo_str); //leemos el nombre de la variable
                        punt = strtok(vecAux, " ,\n"); //eliminamos el caracter separador de la lista de variables
                        strcpy(idvec[cantid], punt); //copiamos al array de ids
                        cantid++;
                    }
				{ printf("Lista de variables.\n"); }
                |ID {                        
                        strcpy(vecAux, yylval.tipo_str); //se repite aca tambien, no lo toma de arriba
                        punt = strtok(vecAux, " ,\n");
                        strcpy(idvec[cantid], punt);
                        cantid++;
                    } 
                COMA lista_variables
				{ printf("Lista de variables.\n"); }
                ;

bloque:
        sentencia
        { 
			printf("Bloque.\n"); 
			 
			if(bloquePtr != NULL){
				bloquePtr = crearNodo("BLOQUE", sentenciaPtr, NULL);
			} else {
				bloquePtr = sentenciaPtr;
			}
		}
        | bloque sentencia
        { 
			printf("Bloque.\n"); 
			if(bloquePtr != NULL){
				bloquePtr = crearNodo("BLOQUE", bloquePtr, sentenciaPtr);
			} else {
				bloquePtr = crearNodo("BLOQUE", sentenciaPtr,NULL);
			}
		}
		;

sentencia:
            asignacion
            { 
				printf("Sentencia.\n"); 
				sentenciaPtr=asigPtr
			}
            | seleccion
            { 
				printf("Sentencia.\n"); 
				sentenciaPtr=seleccionPtr
			}
            | iteracion
            { 
				printf("Sentencia.\n"); 
				sentenciaPtr=iteracionPtr
			}
            | salida
            { 
				printf("Sentencia.\n"); 
				sentenciaPtr=salidaPtr
			}
			| entrada
            { 
				printf("Sentencia.\n"); 
				sentenciaPtr=entradaPtr
			}
			
			;

salida:
        WRITE ID 
			{
			strcpy(vecAux, $2); // Comprueba que la variable esté declarada.
			punt = strtok(vecAux," ;\n");
			if(!existeID(punt)) {
				sprintf(mensajes, "%s%s%s", "Error: no se declaro la variable '", punt, "'");
				yyerror(mensajes, @1.first_line, @2.first_column, @2.last_column);
			}
			else {
				salidaPtr=crearNodo("WRITE", crearHoja(punt, getTipoId(punt), NULL);
			}
			printf("Salida >>>\n"); //Acá se insertarían en el arbol las salidas ¿Cómo se haría?
				//Posiblemente un nodo con una sola hoja para el write, o solo la hoja
		}
		| WRITE CONS_STR {
			salidaPtr=crearNodo("WRITE", crearHoja($2, "CONS_STR"), NULL);
			printf("Salida >>>\n");
		}
		| WRITE CONS_FLOAT {
			salidaPtr=crearNodo("WRITE", crearHoja($2, "CONS_FLOAT"), NULL);
			printf("Salida >>>\n");
		}
		| WRITE CONS_INT {
			salidaPtr=crearNodo("WRITE", crearHoja($2, "CONS_INT"), NULL);
			printf("Salida >>>\n");
		}
        ;
		
entrada:
        READ ID {
					printf("Entrada >>>\n");
					strcpy(vecAux, $2); // Comprueba que la variable esté declarada.
                    punt = strtok(vecAux," ;\n");
                    if(!existeID(punt)) {
                        sprintf(mensajes, "%s%s%s", "Error: no se declaro la variable '", punt, "'");
                        yyerror(mensajes, @1.first_line, @2.first_column, @2.last_column);
                    }
					else {
						entradaPtr=crearNodo("READ", crearHoja(punt, getTipoId(punt), NULL);
					}
				}
		;

asignacion:
            ID OPASIG expresion {
									strcpy(vecAux, $1); //en $1 esta el valor de ID
									punt = strtok(vecAux," +-*/[](){}:=,\n");
									if(!existeID(punt)) //No existe: entonces no esta declarada
									{
										sprintf(mensajes, "%s%s%s", "Error: no se declaro la variable '", punt, "'");
										yyerror(mensajes, @1.first_line, @1.first_column, @1.last_column);
									}
									else{
										asigPtr=crearHoja(punt,getTipoId(punt));
										asigPtr=crearNodo("OPASIG", asigPtr, exprAritPtr);
									}
									printf("Asignacion.\n");
								}
			| ID OPASIG CONS_STR {
									strcpy(vecAux, $1); //en $1 esta el valor de ID
									punt = strtok(vecAux," +-*/[](){}:=,\n");
									if(!existeID(punt)) //No existe: entonces no esta declarada
									{
										sprintf(mensajes, "%s%s%s", "Error: no se declaro la variable '", punt, "'");
										yyerror(mensajes, @1.first_line, @1.first_column, @1.last_column);
									}
									else{
										
										asigPtr=crearNodo("OPASIG", crearHoja(punt,getTipoId(punt)), crearHoja($3,"CONS_STR"));
									}
									printf("Asignacion.\n");
								}
			;

seleccion:
            IF PARENTESISA {
				if(condicionPtr){
						ponerenPila(pilaCondiciones,condicionPtr);
						condicionPtr=NULL;
					}
			}condicion PARENTESISC
			{
				if(bloquePtr){
					ponerenPila(pilaBloque,bloquePtr);
					bloquePtr=NULL;
				}
				else{
					if(sentenciaPtr) {
						  ponerenPila(pilaBloque,sentenciaPtr);
					}
			} bloque ENDIF 
			{ 
				seleccionPtr=crearNodo("IF", condicionPtr, bloquePtr);
				
				if (topedePila(pilaCondiciones)){
					condicionPtr = topedePila(pilaCondiciones);
					sacardePila(condicionPtr);
				}
				if (topedePila(pilaBloque)){
					  bloquePtr = topedePila(pilaBloque);
					  sacardePila(pilaBloque);
				}
				printf("Seleccion\n");
			}
            | IF PARENTESISA {
				if(condicionPtr){
						ponerenPila(pilaCondiciones,condicionPtr);
						condicionPtr=NULL;
					}
			condicion PARENTESISC {
				if(bloquePtr){
					ponerenPila(pilaBloque,bloquePtr);
					bloquePtr=NULL;
				}
				else{
					if(sentenciaPtr) {
						  ponerenPila(pilaBloque,sentenciaPtr);
					}
			} bloque {auxBloquePtr=bloquePtr;} 
			ELSE bloque ENDIF
            { 
				seleccionPtr = crearNodo("IF-ELSE", condicionPtr, crearNodo("cuerpo",auxBloquePtr,bloquePtr));
				if (topedePila(pilaCondiciones)){
					condicionPtr = topedePila(pilaCondiciones);
					sacardePila(condicionPtr);
				}
				if (topedePila(pilaBloque)){
					  bloquePtr = topedePila(pilaBloque);
					  sacardePila(pilaBloque);
				}
				printf("Seleccion con ELSE\n"); 
			}
			;

iteracion: 
            WHILE PARENTESISA {
					if(condicionPtr){
						ponerenPila(pilaCondiciones,condicionPtr);
						condicionPtr=NULL;
					}
				}		
			} condicion PARENTESISC 
			{
				if(bloquePtr){
					ponerenPila(pilaBloque,bloquePtr);
					bloquePtr=NULL;
				}
				else{
					if(sentenciaPtr) {
						ponerenPila(pilaBloque,sentenciaPtr);
					}
				}		
			} 
			bloque ENDWHILE 
			{ 
				
				iteracionPtr=crearNodo("WHILE", condicionPtr, bloquePtr);
				if (topedePila(pilaBloque)){
					bloquePtr = topedePila(pilaBloque);
					sacardePila(pilaBloque);
				}
				if (topedePila(pilaCondiciones)){
					condicionPtr = topedePila(pilaCondiciones);
					sacardePila(condicionPtr);
				}
				printf("Iteracion\n"); 
			}

            ;

condicion:
            condicion OR termino_logico {
				printf("Condicion OR\n"); 
				condicionPtr=crearNodo("OR", condicionPtr, terminoLogicoPtr);
				} 
            | NOT termino_logico { 
				printf("Condicion NOT\n"); 
				condicionPtr = crearNodo("NOT",terminoLogicoPtr,NULL);
			} 
			| termino_logico { 
				printf("Condicion\n");
				condicionPtr=terminoLogicoPtr;
				}
			;
			
termino_logico:
			comparacion { 
				terminoLogicoPtr=comparacionPtr;
				printf("Termino logico\n"); 
			} 
			| termino_logico AND comparacion { 
				terminoLogicoPtr=crearNodo("AND", terminoLogicoPtr, comparacionPtr);
				printf("Termino logico\n"); 
				
			}
			;
comparacion:
            expresion  {exprCMPPtr = exprPtr; } OPIDENTICO expresion { 
				comparacionPtr = crearNodo("OPIDENTICO",exprCMPPtr,exprPtr);
				printf("Comparacion ==\n"); 
			}
            | expresion {exprCMPPtr = exprPtr; } OPMENORIGUAL expresion { 
				comparacionPtr = crearNodo("OPMENORIGUAL",exprCMPPtr,exprPtr);
				printf("Comparacion <=\n"); 
			}
            | expresion {exprCMPPtr = exprPtr; } OPMAYORIGUAL expresion { 
				comparacionPtr = crearNodo("OPMAYORIGUAL",exprCMPPtr,exprPtr);
				printf("Comparacion >=\n"); 
			}
            | expresion {exprCMPPtr = exprPtr; } OPMAYOR expresion { 
				comparacionPtr = crearNodo("OPMAYOR",exprCMPPtr,exprPtr);
				printf("Comparacion >\n"); 
			}
            | expresion {exprCMPPtr = exprPtr; } OPMENOR expresion { 
				comparacionPtr = crearNodo("OPMENOR",exprCMPPtr,exprPtr);
				printf("Comparacion <\n"); 
			}
            | expresion {exprCMPPtr = exprPtr; } OPDISTINTO expresion { 
				comparacionPtr = crearNodo("OPDISTINTO",exprCMPPtr,exprPtr);
				printf("Comparacion !=\n"); 
			}
			| between { 
			//TAREA
				printf("Coparacion Between\n"); 
			}
			| inlist { 
			//TAREA
			printf("Comparacion Inlist\n"); 
			}
			|PARENTESISA {
				if(condicionPtr){
					ponerenPila(pilaCondicion, condicionPtr);
				}
					
			}condicion PARENTESISC { 
				printf("Comparacion ()\n"); 
				comparacionPtr=condicionPtr;
				if(topedePila(pilaCondicion)){
					condicionPtr = topedePila(pilaCondicion);
					sacardePila(pilaCondicion);
				}
			}
			
			
            ;


expresion:
            expresion OPSUMA termino 
			{ 
				printf("Expresion suma\n"); 
				exprAritPtr=crearNodo("OPSUMA", exprPtr, terminoPtr);
				//exprAritPtr->info.tipoDato= terminoPtr->info.tipoDato;
				//Puntero de Expresion (EXPT) = Crear nodo(+, EXPT, TEPT)
			}
            | expresion OPRESTA termino { 
				printf("Expresion resta\n"); 
				exprAritPtr=crearNodo("OPRESTA", exprPtr, terminoPtr);
				//exprAritPtr->info.tipoDato= terminoPtr->info.tipoDato;
				//Puntero de Expresion (EXPT) = Crear nodo(-, EXPT, TEPT)
				}
            | termino { 
				printf("Expresion\n"); //copiado de punteros 
				exprAritPtr = terminoPtr; 
				//exprAritPtr->info.tipoDato= terminoPtr->info.tipoDato;
			}
            ;

termino:
        termino OPMUL factor { 
			printf("Termino multiplicacion\n");
			terminoPtr=crearNodo("OPMUL", terminoPtr, factorPtr);
			//terminoPtr->info.tipoDato= factorPtr->info.tipoDato;
		}
        | termino OPDIV factor { printf("Termino division\n");
			terminoPtr=crearNodo("OPDIV", terminoPtr, factorPtr);
			//terminoPtr->info.tipoDato= factorPtr->info.tipoDato;
		}
        | factor { 
			terminoPtr = factorPtr;
			//terminoPtr->info.tipoDato= factorPtr->info.tipoDato; Parece innecesario
			printf("Termino\n"); //copiado de punteros TEPT=FAPT
			}
        ;

factor:
        ID {
			char error[50];
			strcpy(vecAux, $1);
			punt = strtok(vecAux," +-*/[](){}:=,\n");
			if(!existeID(punt)) //No existe: entonces no esta declarada --> error
			{
				sprintf(mensajes, "%s%s%s", "Error: no se declaro la variable '", punt, "'");
				yyerror(mensajes, @1.first_line, @1.first_column, @1.last_column);
			}
            else{
                factorPtr = crearHoja(punt,getTipoId(punt));
            }
			if(!esNumero(punt,error)) /*No es una variable numérica --> error*/
			{
				sprintf(mensajes, "%s", error);
				yyerror(mensajes, @1.first_line, @1.first_column, @1.last_column);
			}
            printf("Factor ID\n");
		}
        | CONS_INT { 
            $<tipo_int>$ = $1; 
		    printf("Factor cte entera\n"); 
            factorPtr = crearHoja($1,"CONS_INT");
		}
        | CONS_FLOAT { 
        $<tipo_double>$ = $1; 
		printf("Factor cte real\n"); 
        factorPtr = crearHoja($1,"CONST_FLOAT");
		}
        | PARENTESISA {
			if(exprAritPtr){
				ponerenPila(pilaExpresion,exprAritPtr);
			}
		}

		expresion PARENTESISC
		{ 
			factorPtr = exprAritPtr;
			if(topedePila(pilaExpresion)){
            exprAritPtr = topedePila(pilaExpresion);
            sacardePila(pilaExpresion);
            }
			printf("Factor ()\n"); 
		}
        ;


between:
        BETWEEN PARENTESISA ID {
                            //ver que sea una variable numérica
                            char error[50];
                            strcpy(vecAux, $3);
                            punt = strtok(vecAux," ;\n");
                            if(!esNumero(punt, error))
                            {
                                sprintf(mensajes, "%s", error);
                                yyerror(mensajes, @1.first_line, @1.first_column, @1.last_column);
                            }
                            //insertar en árbol
                        } COMA CORCHETEA expresion 
						{//Acá iría una comparacion por mayor
						} 
						PUNTOCOMA expresion{
						//Aca iría una comparación por menor	
						} CORCHETEC PARENTESISC {printf("Between\n");}
        ; 
		
inlist:
        INLIST PARENTESISA ID COMA CORCHETEA lista_expresiones CORCHETEC PARENTESISC {printf("Inlist\n");}
        //comparar ID con cada una de las expresiones.
		//Podría haber una variable @found que indique si se encontró
		
		//inlistPTR = listaexpPTR
		; 

lista_expresiones:	//Se cambió la recursividad para que sea a izquierda
					lista_expresiones PUNTOCOMA expresion
					{ 
					
						printf("Lista de expresiones\n"); 
						//listaexpPTR=Crearnodo(OR, listaexpPTR ; crearNodo(==, crearhoja (ID), expresionPTR)
						
					}
					| expresion
					{ 
						printf("Lista de expresiones\n"); 
						// ListaExprPTR=nodo(==, crearHoja (ID), expresionptr)
						//IF ( ID = expresion OR ID = expresion 2, etc)
						//		@found=true	
						//
					}


%%


/*---- 4. Código ----*/

int main(int argc, char *argv[])
{

    if((yyin = fopen(argv[1], "rt"))==NULL)
    {
        printf("\nNo se puede abrir el archivo de prueba: %s\r\n", argv[1]);
        return -1;
    }
    else
    { 
		pilaExpresion = crearPila();      
		pilaBloque = crearPila();
		pilaCondicion = crearPila();
		pilaEtiq = crearPila();
		pilaEtiqExpMax = crearPila();
        crearTablaTS(); //tablaTS.primero = NULL;
        yyparse();
        fclose(yyin);
        system("Pause");
        return 0;
    }
}

int insertarTS(const char *nombre,const char *tipo, const char* valString, int valInt, double valDouble)
{
    t_simbolo *tabla = tablaTS.primero;
    char nombreCTE[32] = "_";
    strcat(nombreCTE, nombre);
    
    while(tabla)
    {
	if(strcmp(tabla->data.nombre, nombre) == 0 || strcmp(tabla->data.nombre, nombreCTE) == 0)
    {
            return 1;
    }
        else if(strcmp(tabla->data.tipo, "CONS_STR") == 0)
        {
            if(strcmp(tabla->data.valor.valor_str, valString) == 0)
            {
                return 1;
            }
        }
        
        if(tabla->next == NULL)
        {
            break;
        }
        tabla = tabla->next;
    }

    t_data *data = (t_data*)malloc(sizeof(t_data));
    data = crearDatos(nombre, tipo, valString, valInt, valDouble);
    
    if(data == NULL)
    {
        return 1;
    }
   
    t_simbolo* nuevo = (t_simbolo*)malloc(sizeof(t_simbolo));

    if(nuevo == NULL)
    {
        return 2;
    }

    nuevo->data = *data;
    nuevo->next = NULL;

    if(tablaTS.primero == NULL)
    {
        tablaTS.primero = nuevo;
    }
    else
    {
        tabla->next = nuevo;
    }

    return 0;
}


t_data* crearDatos(const char *nombre, const char *tipo, const char* valString, int valInt, double valDouble)
{
    char full[50] = "_";
    char aux[20];

    t_data *data = (t_data*)calloc(1, sizeof(t_data));
    if(data == NULL)
    {
        return NULL;
    }

    data->tipo = (char*)malloc(sizeof(char) * (strlen(tipo) + 1));
    strcpy(data->tipo, tipo);

    //Es una variable
    if(strcmp(tipo, "STRING")==0 || strcmp(tipo, "INTEGER")==0 || strcmp(tipo, "FLOAT")==0)
    {
        //al nombre lo dejo aca porque no lleva _
        data->nombre = (char*)malloc(sizeof(char) * (strlen(nombre) + 1));
        strcpy(data->nombre, nombre);
        return data;
    }
    else
    {      //Son constantes: tenemos que agregarlos a la tabla con "_" al comienzo del nombre, hay que agregarle el valor
        if(strcmp(tipo, "CONS_STR") == 0)
        {
            data->valor.valor_str = (char*)malloc(sizeof(char) * strlen(valString) +1);
            data->nombre = (char*)malloc(sizeof(char) * (strlen(valString) + 1));
            strcat(full, valString);
            strcpy(data->nombre, full);    
            strcpy(data->valor.valor_str, valString);
        }
        if(strcmp(tipo, "CONS_FLOAT") == 0)
        {
            sprintf(aux, "%g", valDouble);
            strcat(full, aux);
            data->nombre = (char*)malloc(sizeof(char) * strlen(full));

            strcpy(data->nombre, full);
            data->valor.valor_double = valDouble;
        }
        if(strcmp(tipo, "CONS_INT") == 0)
        {
            sprintf(aux, "%d", valInt);
            strcat(full, aux);
            data->nombre = (char*)malloc(sizeof(char) * strlen(full));
            strcpy(data->nombre, full);
            data->valor.valor_int = valInt;
        }
        return data;
    }
    return NULL;
}

void guardarTS()
{
    FILE* arch;
    if((arch = fopen("ts.txt", "wt")) == NULL)
    {
            printf("\nNo se pudo crear la tabla de simbolos.\n\n");
            return;
    }
    else if(tablaTS.primero == NULL)
            return;
    
    fprintf(arch, "%-30s%-30s%-30s%-30s\n", "NOMBRE", "TIPODATO", "VALOR", "LONGITUD");

    t_simbolo *aux;
    t_simbolo *tabla = tablaTS.primero;
    char linea[100];

    while(tabla)
    {
        aux = tabla;
        tabla = tabla->next;
        
        if(strcmp(aux->data.tipo, "INTEGER") == 0) //variable integer
        {
            sprintf(linea, "%-30s%-30s%-30s%-d\n", aux->data.nombre, aux->data.tipo, "--", strlen(aux->data.nombre));
        }
        else if(strcmp(aux->data.tipo, "CONS_INT") == 0)
        {
            sprintf(linea, "%-30s%-30s%-30d%-d\n", aux->data.nombre, aux->data.tipo, aux->data.valor.valor_int, strlen(aux->data.nombre) -1);
        }
        else if(strcmp(aux->data.tipo, "FLOAT") ==0)
        {
            sprintf(linea, "%-30s%-30s%-30s%-d\n", aux->data.nombre, aux->data.tipo, "--", strlen(aux->data.nombre));
        }
        else if(strcmp(aux->data.tipo, "CONS_FLOAT") == 0)
        {
            sprintf(linea, "%-30s%-30s%-30g%-d\n", aux->data.nombre, aux->data.tipo, aux->data.valor.valor_double, strlen(aux->data.nombre) -1);
        }
        else if(strcmp(aux->data.tipo, "STRING") == 0)
        {
            sprintf(linea, "%-30s%-30s%-30s%-d\n", aux->data.nombre, aux->data.tipo, "--", strlen(aux->data.nombre));
        }
        else if(strcmp(aux->data.tipo, "CONS_STR") == 0)
        {
            sprintf(linea, "%-30s%-30s%-30s%-d\n", aux->data.nombre, aux->data.tipo, aux->data.valor.valor_str, strlen(aux->data.nombre) -1);
        }
        fprintf(arch, "%s", linea);
        free(aux);
    }
    fclose(arch); 
}

void crearTablaTS()
{
    tablaTS.primero = NULL;
}

int existeID(const char* id) 
{
    t_simbolo *tabla = tablaTS.primero;
    char nombreCTE[32] = "_";
    strcat(nombreCTE, id);
    int b1 = 0;
    int b2 = 0;

     while(tabla)
    {
        b1 = strcmp(tabla->data.nombre, id);
        b2 = strcmp(tabla->data.nombre, nombreCTE);
        if(b1 == 0 || b2 == 0)
        {
               return 1;
        }
        tabla = tabla->next;
    }
    return 0;
}

//Comprueba si un id es de tipo numérico
int esNumero(const char* id,char* error)
{
    t_simbolo *tabla = tablaTS.primero;
    char nombreCTE[32] = "_";
    strcat(nombreCTE, id);

    while(tabla)
    {
        if(strcmp(tabla->data.nombre, id) == 0 || strcmp(tabla->data.nombre, nombreCTE) == 0)
        {
            if(strcmp(tabla->data.tipo, "INTEGER")==0 || strcmp(tabla->data.tipo, "FLOAT")==0)
            {
				//Me parece que no toma en cuenta los tipos de las constantes, quizá podríamos quitar esta parte
                return 1;
            }
            else
            {
                sprintf(error,"%s%s%s","Error: tipo de dato de la variable '",id,"' incorrecto. Los tipos permitidos son 'int' y 'float'");
                return 0;
            }
        }
        tabla = tabla->next;
    }
    sprintf(error, "%s%s%s", "Error: no se declaro la variable '", id, "'");
    return 0;
}

char* getTipoId(const char* id) 
{
    t_simbolo *tabla = tablaTS.primero;
    char nombreCTE[32] = "_";
    strcat(nombreCTE, id);
    int b1 = 0;
    int b2 = 0;

     while(tabla)
    {
        b1 = strcmp(tabla->data.nombre, id);
        b2 = strcmp(tabla->data.nombre, nombreCTE);
        if(b1 == 0 || b2 == 0)
        {
               return tabla->data.tipo;
        }
        tabla = tabla->next;
    }
    return NULL;
}

void crearNodoCMP(char * comp){
	comparacionPtr = crearNodo("CMP",exprCMPPtr,exprPtr);
	comparacionPtr = crearNodo(comp,comparacionPtr,NULL);
}