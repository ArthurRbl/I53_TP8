%{
#include <string.h>
#include "parser.h"
%}

%option nounput
%option noinput

CHIFFRE  [0-9]

%%

"+"       { return yytext[0];}
{CHIFFRE} { yylval.nb = atoi(yytext); return NB;}
.         { fprintf(stderr, "[err lexer] caractere inconnu %c\n",yytext[0]); return 1;}

%%
