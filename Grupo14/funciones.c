#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include "funciones.h"

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


struct tPila *crearPila(void)
{
  struct tPila *stack = malloc(sizeof *stack);
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

void ponerenPila(struct tPila *theStack, tNodo *value)
{
  struct tNodoPila *entry = malloc(sizeof *entry); 
  if (entry)
  {
    entry->dato = copiarDato(value);
    entry->next = theStack->tope;
    theStack->tope = entry;
    theStack->tam++;
  }
}

tNodo *topedePila(struct tPila *theStack)
{
  if (theStack && theStack->tope)
    return theStack->tope->dato;
  else
    return NULL;
}

void sacardePila(struct tNodo *theStack)
{
  if (theStack->tope != NULL)
  {
    theStack->tope = theStack->tope->next;
    theStack->tam--;
  }
}

void vaciarPila(struct tPila *theStack)
{
  while (theStack->tope != NULL)
    sacardePila(theStack);
}

void borrarPila(struct tPila **theStack)
{
  vaciarPila(*theStack);
  free(*theStack);
  *theStack = NULL;
}