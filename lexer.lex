%{
#include <string.h>
#include "parser.h"
%}

%option nounput
%option noinput

CHIFFRE  [0-9]
OP       [*+/%-]
IDENT    [a-zA-Z][a-zA-Z0-9]*

%%

{OP}      { return yytext[0];}
{CHIFFRE} { yylval.nb = atoi(yytext); return NB;}
{IDENT}   { strcpy(yylval.id, yytext); return ID;}
VAR       { return VAR;}
"<-"      { return AFFECT;}
"("       { return PAR_O;}
")"       { return PAR_F;}
[\n]      { return NL;}
[ \t]     {}
.         { fprintf(stderr, "[err lexer] caractere inconnu %c\n",yytext[0]); return 1;}


%%
