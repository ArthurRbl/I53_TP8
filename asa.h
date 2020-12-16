#ifndef ASA_H
#define ASA_H

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include "ts.h"

typedef enum {typeNb, typeOp, typeInst, typeID} typeNoeud;

typedef struct {
  int val;
} feuilleNb;

typedef struct {
  char nom[64];
} feuilleID;

typedef struct {
  int ope;
  struct asa * noeud[2];
} noeudOp;

typedef struct {
  struct asa * noeud[2];
} noeudInst;

typedef struct asa{
  typeNoeud type;
  int ninst;

  union {
    feuilleNb nb;
    feuilleID id;
    noeudOp op;
    noeudInst inst;
  };
} asa;

// fonction d'erreur utilisée également par Bison
void yyerror(const char * s);

/*
  Les fonctions creer_<type> construise un noeud de l'arbre
  abstrait du type correspondant et renvoie un pointeur celui-ci
 */
asa * creer_feuilleNb( int value );
asa * creer_feuilleID(char * nom);
asa * creer_noeudOp( int ope, asa * p1, asa * p2 );
asa * creer_noeudInst(asa * p1, asa * p2);

void free_asa(asa *p);

// produit du code pour la machine RAM à partir de l'arbre abstrait
// ET de la table de symbole
void codegen(asa *p);

extern ts * tsymb;

#endif
