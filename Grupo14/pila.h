#ifndef PILA_H
#define PILA_H

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

#endif