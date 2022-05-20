/*---- Declaraciones ----*/

%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
#include <string.h>
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

/* ---  Arbol   --- */

/* ---  Pila   --- */


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
        { printf("Bloque.\n"); }
        | bloque sentencia
        { 
			printf("Bloque.\n"); 
			//creación de nodo para bloque con el puntero anterior a bloque y la sentencia
		}
		;

sentencia:
            asignacion
            { printf("Sentencia.\n"); }
            | seleccion
            { printf("Sentencia.\n"); }
            | iteracion
            { printf("Sentencia.\n"); }
            | salida
            { printf("Sentencia.\n"); }
			| entrada
            { printf("Sentencia.\n"); }
			//Estos serían de igualación de punteros
			;

salida:
        WRITE ID 
			{
				printf("Salida >>>\n"); //Acá se insertarían en el arbol las salidas ¿Cómo se haría?
				//Posiblemente un nodo con una sola hoja para el write, o solo la hoja
			}
		| WRITE CONS_STR {printf("Salida >>>\n");}
		| WRITE CONS_FLOAT {printf("Salida >>>\n");}
		| WRITE CONS_INT {printf("Salida >>>\n");}
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
					//Acá tendríamos que insertar en el árbol la entrada ¿Como se inserta?
					//Posiblemente un nodo con una sola hoja o una hoja nomás.
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

								}
			{ printf("Asignacion.\n"); 
			
			//ASIGPT=CrearNOdo(OPASIG, crearHoja (ID), EPTR)
			}
			| ID OPASIG CONS_STR {
									printf("Asignacion.\n"); 
								//ASIGPT=CrearNOdo(OPASIG, crearHoja (ID), crearHoja (CONST_STR))	
								}
			;

seleccion:
            IF PARENTESISA condicion PARENTESISC bloque ENDIF 
			{ 
			//¿Como se maneja los if anidados para no perder los punteros 
			//a condiciones anteriores?
			
				printf("Seleccion\n");
				//Acá va lo de l bloque de IF	
				// EL profesor lo pone antes de reconocer toda la seleccion, apenas
				//termina la accion, pero creo que podría ir acá
				//sleeccionptr=(IF, CONDPTR, BLOQUEPTR)
			}
            | IF PARENTESISA condicion PARENTESISC  bloque ELSE 
			{
				//acá leí el ELSE, probablemente debería guardar el
				//sub-arbol del bloque para no perderlo y después guardar
				//Aca va lo del bloque de IF con ELSE
			}bloque ENDIF
            { //ACA se crea el CUERPO (CUERPO; BLOQUETRUE, BLOQUE) y luego se crea el IF (IF, COND, CUERPO)
			printf("Seleccion\n"); 
			}
			
			
			 ;

iteracion: 
            WHILE {/*ACA VA EL CUERPO?*/} PARENTESISA condicion PARENTESISC bloque ENDWHILE 
			{ 
				//ARBOL WHILE, por un lado la parte de condicion y por otro el bloque
				//No sé cómo haría con la anidación de bloques (de nuevo)
				printf("Iteracion\n"); 
			}

            ;

condicion:
            condicion OR termino_logico {
				printf("Condicion OR\n"); 
				//Se crea un nodo COND=(OR, COND, TELOGPT)
				} // .... OR b==c
            | NOT termino_logico { printf("Condicion NOT\n"); } //NOT a==b Se igualan punteros
			| termino_logico { printf("Condicion\n"); }//a==B Se igualan punteros
			;
			
termino_logico:
			comparacion { printf("Termino logico\n"); } //Se iguala puntero 
			| termino_logico AND comparacion { 
				printf("Termino logico\n"); 
				//Se crea un nodo ( TELOGPT=(AND,TELOGPT, COMPPT)
			}
			;
comparacion:
            expresion OPIDENTICO expresion { printf("Comparacion ==\n"); }
            | expresion OPMENORIGUAL expresion { printf("Comparacion <=\n"); }
            | expresion OPMAYORIGUAL expresion { printf("Comparacion >=\n"); }
            | expresion OPMAYOR expresion { printf("Comparacion >\n"); }
            | expresion OPMENOR expresion { printf("Comparacion <\n"); }
            | expresion OPDISTINTO expresion { printf("Comparacion !=\n"); }
			| between { printf("Coparacion Between\n"); }
			| inlist { printf("Comparacion Inlist\n"); }
			|PARENTESISA condicion PARENTESISC { printf("Comparacion ()\n"); }
			
			//A ver cómo saco dos expresiones (¿Dos punteros asignados al reconocer cada expresion?
			//para luego crear el nodo de la comparación
			//expresion { exp1=EXPT } OPIDENTICO expresion {ComparacionPT=CrearNodo(OPERADORLOGICO, exp1, EXPT)}
            ;


expresion:
            expresion OPSUMA termino 
			{ 
				printf("Expresion suma\n"); 
				//Puntero de Expresion (EXPT) = Crear nodo(+, EXPT, TEPT)
			}
            | expresion OPRESTA termino { 
				printf("Expresion resta\n"); 
					//Puntero de Expresion (EXPT) = Crear nodo(-, EXPT, TEPT)
				}
            | termino { printf("Expresion\n"); //copiado de punteros 
				}
            ;

termino:
        termino OPMUL factor { printf("Termino multiplicacion\n"); 
			//Crear nodo con TEPT=crearnodo(*,TEPT, FAPT)
		}
        | termino OPDIV factor { printf("Termino division\n");
			//Crear nodo con TEPT=crearnodo(/,TEPT, FAPT)
		}
        | factor { printf("Termino\n"); //copiado de punteros TEPT=FAPT
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
			if(!esNumero(punt,error)) /*No es una variable numérica --> error*/
			{
				sprintf(mensajes, "%s", error);
				yyerror(mensajes, @1.first_line, @1.first_column, @1.last_column);
			}
                
        }
		{ printf("Factor ID\n");
		//Crear una hoja con ID a FAPT (Puntero a Factor)
		}
        | CONS_INT { $<tipo_int>$ = $1; printf("Constante entera: %d\n", $<tipo_int>$);}
		{ printf("Factor cte entera\n"); 
		//Crear una hoja con Constante Entera a FAPT (Puntero a Factor)
		}
        | CONS_FLOAT { $<tipo_double>$ = $1; printf("Constante real: %g\n", $<tipo_double>$);}
		{ printf("Factor cte real\n"); 
		//Crear una hoja con Constante Real a FAPT (Puntero a Factor)
		}
        | PARENTESISA expresion PARENTESISC
		{ printf("Factor ()\n"); 
		//Ver cómo se crea un nodo de expresión entre paréntesis a FAPT (Puntero a Factor)
		//Posiblemente se pueda reconocer la expresión, el cierre de paréntesis e igualar ese
		//así FAPT = EXPT, capaz que antes del paréntesis.
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
		
		//
		; 

lista_expresiones:	//Se cambió la recursividad para que sea a izquierda
					lista_expresiones PUNTOCOMA expresion
					{ 
					
						printf("Lista de expresiones\n"); 
						
					}
					| expresion
					{ 
						printf("Lista de expresiones\n"); 
						// IF ( ID = expresion OR ID = expresion 2, etc)
						//
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