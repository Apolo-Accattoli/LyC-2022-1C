#define FUNCIONES_H

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
void enOrden(tArbol *p);
void verNodo(const char *p);
void postOrden(tArbol *p);


struct tNodoPila {
  tNodo *dato;
  struct tNodoPila *next;
};

struct tPila
{
  struct tNodoPila *tope;
  size_t tam; 
};

struct tPila *crearPila(void);
tNodo *copiarDato(tNodo *);
void ponerenPila(struct tPila *, tNodo *value);
tNodo *topedePila(struct tPila *);
void sacardePila(struct tPila *);
void vaciarPila(struct tPila *);
void borrarPila(struct tPila **);
typedef struct tPila tPila;
