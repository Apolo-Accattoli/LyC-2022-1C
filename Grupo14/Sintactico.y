/*---- 1. Declaraciones ----*/

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
int esNumero(const char*,char*);
char mensajes[100];

%}

%union {
int tipo_int;
double tipo_double;
char *tipo_str;
}

/*---- 2. Tokens - Start ----*/

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

/*---- 3. Definición de reglas gramaticales ----*/
%locations

%%

PROGRAMA:
        bloque_declaraciones bloque
        { guardarTS(); printf("\nCompilacion OK.\n");}
        ;

bloque_declaraciones:
                    DECVAR declaraciones ENDDEC {printf("\nTermina el bloque de declaraciones de variables.\n");}
                    ;

declaraciones:
            declaracion
            | declaraciones declaracion
            ;

declaracion:
             lista_variables DOSPUNTOS INTEGER {
                                                    
                                                for(i=0;i<cantid;i++) /*vamos agregando todos los ids que leyo */
                                                {
                                                    
                                                    if(insertarTS(idvec[i], "INTEGER", "", 0, 0) != 0) //no lo guarda porque ya existe
                                                    {
                                                        sprintf(mensajes, "%s%s%s", "Error: la variable '", idvec[i], "' ya fue declarada");
                                                        yyerror(mensajes, @3.first_line, @3.first_column, @3.last_column);
                                                    }
                                                    
                                                }
                                                cantid=0;
                                                
                                            } 
            | lista_variables DOSPUNTOS STRING  {                                                    
                                                    for(i=0;i<cantid;i++)
                                                    {
                                                        
                                                        if(insertarTS(idvec[i], "STRING", "", 0, 0) != 0)
                                                        {
                                                            sprintf(mensajes, "%s%s%s", "Error: la variable '", idvec[i], "' ya fue declarada");
                                                            yyerror(mensajes, @3.first_line, @3.first_column, @3.last_column);
                                                        }
                                                        
                                                    } cantid=0;
                                                    
                                                }
            | lista_variables DOSPUNTOS FLOAT {                                                    
                                                    for(i=0;i<cantid;i++)
                                                    {
                                                        
                                                        if(insertarTS(idvec[i], "FLOAT", "", 0, 0) != 0)
                                                        {
                                                            sprintf(mensajes, "%s%s%s", "Error: la variable '", idvec[i], "' ya fue declarada");
                                                            yyerror(mensajes, @3.first_line, @3.first_column, @3.last_column);
                                                        }
                                                        
                                                    } cantid=0;
                                                    
                                                }
            ;

lista_variables:
                ID  {                        
                        strcpy(vecAux, yylval.tipo_str); //tomamos el nombre de la variable
                        punt = strtok(vecAux, " ,\n"); //eliminamos extras
                        strcpy(idvec[cantid], punt); //copiamos al array de ids
                        cantid++;
                        
                    }
                |ID {                        
                        strcpy(vecAux, yylval.tipo_str); //se repite aca tambien, no lo toma de arriba
                        punt = strtok(vecAux, " ,\n");
                        strcpy(idvec[cantid], punt);
                        cantid++;
                        

                    } 

                COMA lista_variables
                ;

bloque:
        sentencia
        | bloque sentencia
        ;

sentencia:
            asignacion
            | seleccion
            | iteracion
            | salida
			| entrada
            ;

salida:
        WRITE ID {printf("WRITE>>>\n");}
		| WRITE CONS_STR {printf("WRITE>>>\n");}
        ;
		
entrada:
        READ ID {printf("READ>>>\n");}
		;

asignacion:
            ID OPASIG expresion {
                                                
                                                strcpy(vecAux, $1); /*en $1 esta el valor de ID*/
                                                punt = strtok(vecAux," +-*/[](){}:=,\n"); /*porque puede venir de cualquier lado, pero ver si funciona solo con el =*/
                                                if(!existeID(punt)) /*No existe: entonces no esta declarada*/
                                                {
                                                    sprintf(mensajes, "%s%s%s", "Error: no se declaro la variable '", punt, "'");
                                                    yyerror(mensajes, @1.first_line, @1.first_column, @1.last_column);
                                                }
                                            }
			| ID OPASIG CONS_STR
			;

seleccion:
            IF PARENTESISA condicion PARENTESISC bloque ENDIF {printf("IF\n");}
            | IF PARENTESISA condicion PARENTESISC  bloque ELSE bloque ENDIF {printf("IF-ELSE\n");}
            ;

iteracion: 
            WHILE PARENTESISA condicion PARENTESISC bloque ENDWHILE {printf("WHILE\n");}
            ;

condicion:
            comparacion //a==B
            | condicion AND comparacion {printf("AND\n");} // ... AND b==c
            | condicion OR comparacion {printf("OR\n");} // .... OR b==c
            | NOT comparacion {printf("NOT\n");} //NOT a==b
			| NOT PARENTESISA condicion PARENTESISC // NOT (a==b AND b==c)
			;

comparacion:
            expresion OPIDENTICO expresion {printf("<expresion> == <expresion>\n");}
            | expresion OPMENORIGUAL expresion {printf("<expresion> <= <expresion>\n");}
            | expresion OPMAYORIGUAL expresion {printf("<expresion> >= <expresion>\n");}
            | expresion OPMAYOR expresion{printf("<expresion> > <expresion>\n");}
            | expresion OPMENOR expresion{printf("<expresion> < <expresion>\n");}
            | expresion OPDISTINTO expresion{printf("<expresion> != <expresion>\n");}
			| between
			| inlist
            ;


expresion:
            expresion OPSUMA termino {printf("Suma OK\n");}
            | expresion OPRESTA termino {printf("Resta OK\n");}
            | termino
            ;

termino:
        termino OPMUL factor {printf("Multiplicacion OK\n");}
        | termino OPDIV factor {printf("Division OK\n");}
        | factor
        ;

factor:/*verificando aca en este ID si existe o no, se cubre en todas las apariciones en el codigo fuente????*/
        ID {
            
                strcpy(vecAux, $1);
                punt = strtok(vecAux," +-*/[](){}:=,\n"); /*porque puede venir de cualquier lado*/
                if(!existeID(punt)) /*No existe: entonces no esta declarada --> error*/
                {
                    sprintf(mensajes, "%s%s%s", "Error: no se declaro la variable '", punt, "'");
                    yyerror(mensajes, @1.first_line, @1.first_column, @1.last_column);
                }
           }
        | CONS_INT { $<tipo_int>$ = $1; printf("CTE entera: %d\n", $<tipo_int>$);}
        | CONS_FLOAT { $<tipo_double>$ = $1; printf("CTE FLOAT: %g\n", $<tipo_double>$);}

        | PARENTESISA expresion PARENTESISC
        ;


between:
        BETWEEN PARENTESISA ID COMA CORCHETEA expresion PUNTOCOMA expresion CORCHETEC PARENTESISC {printf("Between OK\n");}
        ; 
		
inlist:
        INLIST PARENTESISA ID COMA CORCHETEA lista_expresiones CORCHETEC PARENTESISC {printf("Inlist OK\n");}
        ; 

lista_expresiones:
					expresion PUNTOCOMA lista_expresiones
					| expresion

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
        crearTablaTS();//tablaTS.primero = NULL;
        yyparse();
        fclose(yyin);
        system("Pause"); /*Esta pausa la puse para ver lo que hace via mensajes*/
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

