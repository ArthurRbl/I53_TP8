%{
  #include <stdio.h>
  #include <ctype.h>
  #include <unistd.h>

  #include "asa.h"
  #include "ts.h"

  extern int yylex();

%}

%union{
  int nb;
  struct asa * noeud;
 };

%define parse.error verbose

%token <nb> NB

%token NL

%type <noeud> EXP INST INSTS

%left '+' '-'
%left '*' '/' '%'

%start PROG

%%

PROG : INSTS                 { codegen($1); }
;

INSTS: INST
| INST INSTS
;

INST: EXP NL
;

EXP : NB                   { $$ = creer_feuilleNb(yylval.nb); }
| EXP '+' EXP              { $$ = creer_noeudOp('+', $1, $3); }
| EXP '-' EXP              { $$ = creer_noeudOp('-', $1, $3); }
| EXP '*' EXP              { $$ = creer_noeudOp('*', $1, $3); }
| EXP '/' EXP              { $$ = creer_noeudOp('/', $1, $3); }
| EXP '%' EXP              { $$ = creer_noeudOp('%', $1, $3); }
| '(' EXP ')'              { $$ = $2; }
;

%%

int main( int argc, char * argv[] ) {

  extern FILE *yyin;
  if (argc == 1){
    fprintf(stderr, "aucun fichier fournie\n");
    return 1;
  }
  yyin = fopen(argv[1],"r");
  yyparse();
  return 0;
}
