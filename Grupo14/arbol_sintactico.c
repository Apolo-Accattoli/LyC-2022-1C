#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include "arbol_sintactico.h"

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

void enOrden(tArbol *p){
    if (*p)
    {
        enOrden(&(*p)->izq);
        verNodo((*p)->info.dato);
        enOrden(&(*p)->der);
    }
}

void postOrden(tArbol *p){
    if (*p){
        postOrden(&(*p)->izq);
        postOrden(&(*p)->der);
		verNodo((*p)->info.dato);
    }
}

void verNodo(const char *p){
    printf("%s ", p);
}
