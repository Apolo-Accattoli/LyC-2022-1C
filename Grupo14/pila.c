#include <stdlib.h>
#include <string.h>
#include "pila.h"

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

void sacardePila(struct tPila *theStack)
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