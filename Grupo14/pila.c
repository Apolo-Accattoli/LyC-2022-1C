#include <stdlib.h>
#include <string.h>
#include "pila.h"

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