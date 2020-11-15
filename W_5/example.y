%{
#include <stdio.h>
extern int yylineno;
extern FILE *yyin;
extern int yylex();
void yyerror(const char *s);
%}

%error-verbose

%token SELECT FROM AS WHERE BETWEEN AND OR IN LIKE IS NUL NOT ID

%%

prog	: 
	| prog stmt
	;

stmt	: SELECT '*' FROM ID ';'		{ printf("\nLine %d ok\n", yylineno); }
	| error ';'				{ yyerrok; }
	;

%%

int main(int argc, char *argv[]){
	if(argc < 2)
		return -1;
	yyin = fopen(argv[1], "r");
	if(yyin)
		yyparse();
	fclose(yyin);	
	return 0;
}

void yyerror(const char *s){
	printf("\nERROR at line %d\n", yylineno);
	printf("%s\n", s);
}