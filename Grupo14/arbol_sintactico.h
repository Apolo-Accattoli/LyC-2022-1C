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
tInfo infoArbol;

#endif