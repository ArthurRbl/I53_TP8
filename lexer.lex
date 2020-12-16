%{
#include <string.h>
#include "parser.h"
%}

%option nounput
%option noinput

CHIFFRE  [0-9]
OP       [*+/%-]

%%

{OP}      { return yytext[0];}
{CHIFFRE} { yylval.nb = atoi(yytext); return NB;}
[\n]      { return NL;}
[ \t]     {}
.         { fprintf(stderr, "[err lexer] caractere inconnu %c\n",yytext[0]); return 1;}


%%
