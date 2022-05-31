/*---- Declaraciones ----*/

%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
#include <string.h>

FILE  *yyin;
FILE *graph;
FILE *intermedia;
int yyerror();
int yylex();


/* --- MOVER --- */
enum tipoError
{
    ErrorSintactico,
    ErrorLexico
};
/* Tipos de datos para la tabla de simbolos */
#define Integer 1
#define Float 2
#define String 3
#define CteInt 4
#define CteFloat 5
#define CteString 6
#define SinTipo 7
#define SIN_MEM -4
#define NODO_OK -3
#define TRUE 1
#define FALSE 0

#define TAMANIO_TABLA 300
#define TAM_NOMBRE 32
#define ES_CTE_CON_NOMBRE 1

/* Defino estructura de informacion para el arbol*/
typedef struct {
	char* dato;
	char* tipoDato;		
}tInfo;

/* Defino estructura de nodo de arbol*/
typedef struct sNodo{
	tInfo info;
	struct sNodo *izq, *der;
}tNodo;

/* Defino estructura de arbol*/
typedef tNodo* tArbol;

tNodo* crearNodo(const char* dato, tNodo *pIzq, tNodo *pDer);
tNodo* crearHoja(char* dato,char* tipo);
tArbol * hijoMasIzq(tArbol *p);
void enOrden(tArbol *p, FILE* file);
void verNodo(const char *p, FILE* file);
void postOrden(tArbol *p, FILE* file);
void _tree_print_dot_subtree(int nro_padre, tNodo *padre, int nro, tArbol *nodo, FILE* stream);
void tree_print_dot(tArbol *p,FILE* stream);
void llenarGragh(tNodo* padre, FILE *arch, int numNodo);
void escribirGragh(tNodo* padre);

typedef struct sNodoPila {
  tNodo *dato;
  struct sNodoPila *next;
}tNodoPila;

typedef struct 
{
  tNodoPila *tope;
  size_t tam; 
}tPila;

tPila *crearPila(void);
tNodo *copiarDato(tNodo *);
void ponerenPila( tPila *, tNodo *value);
tNodo *topedePila( tPila *);
void sacardePila(tPila *);
void vaciarPila( tPila *);
void borrarPila( tPila **);
	
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

char* getTipoId(const char* id); 

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
tPila* pilaBloqueAux;
tPila* pilaCondicion;
tPila* pilaCondiciones;
tPila* pilaEtiq;
tPila* pilaEtiqExpMax;

//Declaración de punteros árbol sintáctico

tArbol 	asigPtr,			//Puntero de asignaciones
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
		auxMaxCond,
		listaExpPtr,
		inlistPtr,
		betweenPtr,
		condicionIfPtr,
		accionPtr;

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
			postOrden(&bloquePtr, intermedia); //Agregamos funciones
			tree_print_dot(&bloquePtr, graph);
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
				bloquePtr = (tNodo *)crearNodo("BLOQUE", sentenciaPtr, NULL);
			} else {
				bloquePtr = sentenciaPtr;
			}
		}
        | bloque sentencia
        { 
			printf("Bloque.\n"); 
			if(bloquePtr != NULL){
				bloquePtr = (tNodo *)crearNodo("BLOQUE", bloquePtr, sentenciaPtr);
			} else {
				bloquePtr = (tNodo *)crearNodo("BLOQUE", sentenciaPtr,NULL);
			}
		}
		;

sentencia:
            asignacion
            { 
				printf("Sentencia.\n"); 
				sentenciaPtr=asigPtr;
			}
            | seleccion
            { 
				printf("Sentencia.\n"); 
				sentenciaPtr=seleccionPtr;
			}
            | iteracion
            { 
				printf("Sentencia.\n"); 
				sentenciaPtr=iteracionPtr;
			}
            | salida
            { 
				printf("Sentencia.\n"); 
				sentenciaPtr=salidaPtr;
			}
			| entrada
            { 
				printf("Sentencia.\n"); 
				sentenciaPtr=entradaPtr;
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
				salidaPtr=(tNodo *)crearNodo("WRITE", crearHoja(punt, getTipoId(punt)), NULL);
			}
			printf("Salida >>>\n"); //Acá se insertarían en el arbol las salidas ¿Cómo se haría?
				//Posiblemente un nodo con una sola hoja para el write, o solo la hoja
		}
		| WRITE CONS_STR {
			salidaPtr=(tNodo *)crearNodo("WRITE", crearHoja($2, "CONS_STR"), NULL);
			printf("Salida >>>\n");
		}
		| WRITE CONS_FLOAT {
			char* name = (char*) malloc(sizeof($2));
			sprintf(name, "%g", $2);
			salidaPtr=(tNodo *)crearNodo("WRITE", crearHoja(name,"CONS_FLOAT"), NULL);
			printf("Salida >>>\n");
		}
		| WRITE CONS_INT {
			char* name = (char*) malloc(sizeof($2));
			sprintf(name, "%d", $2);
			salidaPtr=(tNodo *)crearNodo("WRITE", crearHoja(name,"CONS_INT"), NULL);
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
						entradaPtr=(tNodo *)crearNodo("READ", crearHoja(punt, getTipoId(punt)), NULL);
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
										asigPtr=(tNodo *)crearHoja(punt,getTipoId(punt));
										asigPtr=(tNodo *)crearNodo("OPASIG", asigPtr, exprAritPtr);
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
										
										asigPtr=(tNodo *)crearNodo("OPASIG", crearHoja(punt,getTipoId(punt)), crearHoja($3,"CONS_STR"));
									}
									printf("Asignacion.\n");
								}
			;

seleccion:
            condicionif bloque ENDIF 
			{ 
				seleccionPtr=(tNodo *)crearNodo("IF", condicionPtr, bloquePtr);
				
				if (topedePila(pilaCondiciones)){
					condicionPtr = topedePila(pilaCondiciones);
					sacardePila(pilaCondiciones);
				}
				if (topedePila(pilaBloque)){
					  bloquePtr = topedePila(pilaBloque);
					  sacardePila(pilaBloque);
				}
				printf("Seleccion\n");
			}
            | condicionif bloque {
									if(auxBloquePtr) {
										ponerenPila(pilaBloqueAux,auxBloquePtr);
					
									}
									auxBloquePtr=bloquePtr;
									bloquePtr=NULL;
										
				} 
			ELSE bloque ENDIF
            { 
				seleccionPtr =(tNodo *) crearNodo("IF-ELSE", condicionPtr, crearNodo("cuerpo",auxBloquePtr,bloquePtr));
				if (topedePila(pilaCondiciones)){
					condicionPtr = topedePila(pilaCondiciones);
					sacardePila(pilaCondiciones);
				}
				if (topedePila(pilaBloque)){
					  bloquePtr = topedePila(pilaBloque);
					  sacardePila(pilaBloque);
				}
				if (topedePila(pilaBloqueAux)){
					  auxBloquePtr = topedePila(pilaBloqueAux);
					  sacardePila(pilaBloqueAux);
				}
				printf("Seleccion con ELSE\n"); 
			}
			;

condicionif: IF PARENTESISA {
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
				}
			};
			
iteracion: 
            WHILE PARENTESISA {
					if(condicionPtr){
						ponerenPila(pilaCondiciones,condicionPtr);
						condicionPtr=NULL;
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
				
				iteracionPtr=(tNodo *)crearNodo("WHILE", condicionPtr, bloquePtr);
				if (topedePila(pilaBloque)){
					bloquePtr = topedePila(pilaBloque);
					sacardePila(pilaBloque);
				}
				if (topedePila(pilaCondiciones)){
					condicionPtr = topedePila(pilaCondiciones);
					sacardePila(pilaCondiciones);
				}
				printf("Iteracion\n"); 
			}

            ;

condicion:
            condicion OR comparacion {
				printf("Condicion OR\n"); 
				condicionPtr=(tNodo *)crearNodo("OR", condicionPtr, comparacionPtr);
				} 
            | condicion AND comparacion {
				printf("Condicion AND\n"); 
				condicionPtr=(tNodo *)crearNodo("AND", condicionPtr, comparacionPtr);
				} 
            | NOT comparacion { 
				printf("Condicion NOT\n");
				condicionPtr = (tNodo *)crearNodo("NOT",comparacionPtr,NULL);
			} 
			| comparacion { 
				printf("Condicion\n");
				condicionPtr=comparacionPtr;
				}
			;
			
comparacion:
            expresion  {exprCMPPtr = exprAritPtr; } OPIDENTICO expresion { 
				comparacionPtr = (tNodo *)crearNodo("OPIDENTICO",exprCMPPtr,exprAritPtr);
				printf("Comparacion ==\n"); 
			}
            | expresion {exprCMPPtr = exprAritPtr; } OPMENORIGUAL expresion { 
				comparacionPtr = (tNodo *)crearNodo("OPMENORIGUAL",exprCMPPtr,exprAritPtr);
				printf("Comparacion <=\n"); 
			}
            | expresion {exprCMPPtr = exprAritPtr; } OPMAYORIGUAL expresion { 
				comparacionPtr = (tNodo *)crearNodo("OPMAYORIGUAL",exprCMPPtr,exprAritPtr);
				printf("Comparacion >=\n"); 
			}
            | expresion {exprCMPPtr = exprAritPtr; } OPMAYOR expresion { 
				comparacionPtr = (tNodo *)crearNodo("OPMAYOR",exprCMPPtr,exprAritPtr);
				printf("Comparacion >\n"); 
			}
            | expresion {exprCMPPtr = exprAritPtr; } OPMENOR expresion { 
				comparacionPtr = (tNodo *)crearNodo("OPMENOR",exprCMPPtr,exprAritPtr);
				printf("Comparacion <\n"); 
			}
            | expresion {exprCMPPtr = exprAritPtr; } OPDISTINTO expresion { 
				comparacionPtr = (tNodo *)crearNodo("OPDISTINTO",exprCMPPtr,exprAritPtr);
				printf("Comparacion !=\n"); 
			}
			| between { 
			//VER POR LAS DUDAS
				printf("Comparacion Between\n"); 
			}
			| inlist { 
			//VER POR LAS DUDAS
			printf("Comparacion Inlist\n"); 
			}
            ;


expresion:
            expresion OPSUMA termino 
			{ 
				printf("Expresion suma\n"); 
				exprAritPtr=(tNodo *)crearNodo("OPSUMA", exprAritPtr, terminoPtr);
				//exprAritPtr->info.tipoDato= terminoPtr->info.tipoDato;
				//Puntero de Expresion (EXPT) = Crear nodo(+, EXPT, TEPT)
			}
            | expresion OPRESTA termino { 
				printf("Expresion resta\n"); 
				exprAritPtr=(tNodo *)crearNodo("OPRESTA", exprAritPtr, terminoPtr);
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
			terminoPtr=(tNodo *)crearNodo("OPMUL", terminoPtr, factorPtr);
			//terminoPtr->info.tipoDato= factorPtr->info.tipoDato;
		}
        | termino OPDIV factor { printf("Termino division\n");
			terminoPtr=(tNodo *)crearNodo("OPDIV", terminoPtr, factorPtr);
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
                factorPtr = (tNodo *)crearHoja(punt,getTipoId(punt));
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
			char* name = (char*) malloc(sizeof($1));
			sprintf(name, "%d", $1);
		    printf("Factor cte entera\n"); 
            factorPtr = (tNodo *)crearHoja(name,"CONS_INT");
		}
        | CONS_FLOAT { 
			$<tipo_double>$ = $1; 
			char* name = (char*) malloc(sizeof($1));
			sprintf(name, "%g", $<tipo_double>$);
			printf("Factor cte real\n"); 
			printf("name: %s \n",name); 
			factorPtr = (tNodo *)crearHoja(name,"CONS_FLOAT");
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
						//condicionIfPtr=crearNodo(">", crearHoja (printf("%s",$3), getTipoId(printf("%s",$3))), exprAritPtr);
						} 
						PUNTOCOMA expresion{
						//Aca iría una comparación por menor	
						//condicionIfPtr=crearNodo("AND", condicionIfPtr , crearNodo("<", crearHoja (printf("%s",$3), getTipoId(printf("%s",$3))), exprAritPtr));
						//accionPtr=crearNodo("Cuerpo",crearNodo(":=","@between","1"),crearNodo(":=","@between","0"));
						//listaExpPtr=crearNodo("IF",condicionIfPtr,accionPtr);
						} CORCHETEC PARENTESISC {printf("Between\n");}
						//betweenPtr = listaExpPtr;
        ; 
		
inlist:
        INLIST PARENTESISA ID COMA CORCHETEA lista_expresiones CORCHETEC PARENTESISC {
			printf("Inlist\n");
			//comparar ID con cada una de las expresiones.
			//Podría haber una variable @found que indique si se encontró
			inlistPtr = listaExpPtr;
		}; 

lista_expresiones:	//Se cambió la recursividad para que sea a izquierda
					lista_expresiones PUNTOCOMA expresion
					{ 
					
						printf("Lista de expresiones\n"); 
						//listaExpPtr=(tNodo *)crearNodo("OR", listaExpPtr , crearNodo("==", crearHoja (ID, getTipoId(ID)), exprAritPtr));
						
					}
					| expresion
					{ 
						printf("Lista de expresiones\n"); 
						//listaExpPtr=(tNodo *)crearNodo("==", crearHoja (ID, getTipoId(ID)), exprAritPtr);
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

	graph = fopen("gragh.dot", "w");
	if (graph == NULL) 
	{
		printf("\nNo se pudo crear el archivo del grafico de arbol.\r\n");
		return -1;
	}
		intermedia = fopen("intermedia.txt", "wt");
		
	if (intermedia == NULL) 
	{
		printf("\nNo se pudo crear el archivo intermedia.txt \r\n");
		return -1;
	}
	pilaExpresion = crearPila();      
	pilaBloque = crearPila();
	pilaBloqueAux = crearPila();
	pilaCondicion = crearPila();
	pilaCondiciones = crearPila();
	pilaEtiq = crearPila();
	pilaEtiqExpMax = crearPila();
        crearTablaTS(); //tablaTS.primero = NULL;
        yyparse();
        fclose(yyin);
		fclose(graph);
		fclose(intermedia);
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
	comparacionPtr = (tNodo *)crearNodo("CMP",exprCMPPtr,exprAritPtr);
	comparacionPtr = (tNodo *)crearNodo(comp,comparacionPtr,NULL);
}

/* --- MOVER --- */
tNodo* crearNodo(const char* dato, tNodo *pIzq, tNodo *pDer){
    tNodo* nodo = malloc(sizeof(tNodo));   
    tInfo info;

    info.dato = (char*)malloc(sizeof(char) * (strlen(dato) + 1));
	strcpy(info.dato, dato);
    
    nodo->info = info;
    nodo->izq = pIzq;
    nodo->der = pDer;

    return nodo;
}

tNodo* crearHoja(char* dato,char* tipo){	
    tNodo* nodoNuevo = (tNodo*)malloc(sizeof(tNodo));

    nodoNuevo->info.dato = (char*)malloc(sizeof(char) * (strlen(dato) + 1));
	strcpy(nodoNuevo->info.dato, dato);
	
    nodoNuevo->info.tipoDato = (char*)malloc(sizeof(char) * (strlen(tipo) + 1));
    strcpy(nodoNuevo->info.tipoDato, dato);
    
    nodoNuevo->izq = NULL;
    nodoNuevo->der = NULL;
    
    return nodoNuevo;
}

tArbol * hijoMasIzq(tArbol *p){
    if(*p){
        if((*p)->izq)
            return hijoMasIzq(&(*p)->izq);
        else
            return p;
    }
    return NULL;
}

void enOrden(tArbol *p, FILE* file){
    if (*p)
    {
        enOrden(&(*p)->izq, file);
        verNodo((*p)->info.dato, file);
        enOrden(&(*p)->der, file);
		fprintf(file, "\n", p);
    }
}

void postOrden(tArbol *p, FILE* file){
    if (*p){
        postOrden(&(*p)->izq, file);
        postOrden(&(*p)->der,file);
		verNodo((*p)->info.dato,file);
		fprintf(file, "\n", p);
    }
}

void verNodo(const char *p, FILE* file){
    fprintf(file, "%s ", p);
}


tPila *crearPila(void)
{
  tPila *stack = malloc(sizeof *stack);
  if (stack)
  {
    stack->tope = NULL;
    stack->tam = 0;
  }
  return stack;
};

tNodo *copiarDato(tNodo *str)
{
  tNodo *tmp =(tNodo*) malloc(sizeof(tNodo));
  if (tmp)
    memcpy(tmp, str,sizeof(tNodo));
  return tmp;
}

void ponerenPila(tPila *theStack, tNodo *value)
{
  tNodoPila *entry = malloc(sizeof *entry); 
  if (entry)
  {
    entry->dato = copiarDato(value);
    entry->next = theStack->tope;
    theStack->tope = entry;
    theStack->tam++;
  }
}

tNodo *topedePila( tPila *theStack)
{
  if (theStack && theStack->tope)
    return theStack->tope->dato;
  else
    return NULL;
}

void sacardePila(tPila *theStack)
{
  if (theStack->tope != NULL)
  {
    theStack->tope = theStack->tope->next;
    theStack->tam--;
  }
}

void vaciarPila( tPila *theStack)
{
  while (theStack->tope != NULL)
    sacardePila(theStack);
}

void borrarPila( tPila **theStack)
{
  vaciarPila(*theStack);
  free(*theStack);
  *theStack = NULL;
}
void _tree_print_dot_subtree(int nro_padre, tNodo *padre, int nro, tArbol *nodo, FILE* stream)
{
    if (*nodo != NULL)
    {    
        fprintf(stream, "x%d [label=<%s>];\n",nro,(*nodo)->info.dato);
        if (padre != NULL){
            fprintf(stream, "x%d -> x%d;\n",nro_padre,nro);
        }   
        _tree_print_dot_subtree(nro, *nodo, 2 * nro + 1, &(*nodo)->izq, stream);
        _tree_print_dot_subtree(nro, *nodo, 2 * nro + 2, &(*nodo)->der, stream);
        
    }
}
void tree_print_dot(tArbol *p,FILE* stream)
{
	fprintf(stream, "digraph BST {\n");
	if (*p)
		_tree_print_dot_subtree(-1, NULL, 0, &(*p), stream);
	fprintf(stream, "}");
}
void llenarGragh(tNodo* padre, FILE *arch, int numNodo) {
    char* string1 = (char*) malloc(sizeof(char) *50);
    char* string2 = (char*) malloc(sizeof(char) *50);
    if(padre == NULL) {
        return;
    }
    int numHI = numNodo*2+1;
    int numHD = numNodo*2+2;
    
    if(padre->izq) {
        sprintf(string1, "%s|%s", padre->info.dato, padre->info.tipoDato);
        sprintf(string2, "%s|%s", padre->izq->info.dato, padre->izq->info.tipoDato);
        fprintf(arch, "\t\"nodo_%d \\n%s\" -> \"nodo_%d \\n%s\"\n", numNodo, string1, numHI, string2);
    }
    if(padre->der) {
        sprintf(string1, "%s|%s", padre->info.dato, padre->info.tipoDato);
        sprintf(string2, "%s|%s", padre->der->info.dato, padre->der->info.tipoDato);
        fprintf(arch, "\t\"nodo_%d \\n%s\" -> \"nodo_%d \\n%s\"\n", numNodo, string1 ,numHD ,string2);
    }
    llenarGragh(padre->izq, arch, numHI);
    llenarGragh(padre->der, arch, numHD);
    return;
}

void escribirGragh(tNodo* padre) {
    FILE *archivo;

	archivo = fopen("gragh.dot", "w");
	if (archivo == NULL) {
		printf("ERROR");
		return;
	}
    //Escribir plantilla para poder dibujar el grafo
    fprintf(archivo, "%s\n", "digraph G {");
    llenarGragh(padre, archivo, 0);
    fprintf(archivo, "%s", "}");
    
    fclose(archivo);
    return;
}