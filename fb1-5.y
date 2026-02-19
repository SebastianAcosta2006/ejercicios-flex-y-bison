%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);
%}

%union {
  int num;
}

%token <num> NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token OP CP

%type <num> exp factor term

%%

calclist:
    /* empty */
  | calclist exp EOL { printf("= %d (0x%x)\n", $2, $2); }
  ;

exp: factor
  | exp ADD factor { $$ = $1 + $3; }
  | exp SUB factor { $$ = $1 - $3; }
  ;

factor: term
  | factor MUL term { $$ = $1 * $3; }
  | factor DIV term { $$ = $1 / $3; }
  ;

term: NUMBER
  | ABS term { $$ = $2 >= 0 ? $2 : -$2; }
  | OP exp CP { $$ = $2;}
  ;

%%

int main(void)
{
  return yyparse();
}

int yyerror(const char *s)
{
  fprintf(stderr, "error: %s\n", s);
  return 0;
}

