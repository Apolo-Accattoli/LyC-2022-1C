#ifndef ARBOL_SINTACTICO_H
#define ARBOL_SINTACTICO_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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


#endif