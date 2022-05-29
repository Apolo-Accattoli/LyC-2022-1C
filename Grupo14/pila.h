#ifndef PILA_H
#define PILA_H

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

#endif