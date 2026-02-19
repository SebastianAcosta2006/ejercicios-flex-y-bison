/* recognize tokens for the calculator and print them out */
%{
#include <stdlib.h>
#include "fb1-5.tab.h"
%}

%%
"//".*                  /* ignore comments */

0[xX][a-fA-F0-9]+      {
                          yylval.num = strtol(yytext, NULL, 16);
                          return NUMBER;
                        }

[0-9]+                 {
                          yylval.num = atoi(yytext);
                          return NUMBER;
                        }

"+"    {return ADD;}
"-"    {return SUB;}
"*"    {return MUL;}
"/"    {return DIV;}
"|"    {return ABS;}
"("    {return OP;}
")"    {return CP;}

\n     {return EOL;}
[ \t]  {}
.      {printf("Mystery character %c\n", *yytext);}
%%


