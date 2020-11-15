%{
#include <stdio.h>
extern int yylineno;
extern FILE *yyin;
extern int yylex();
void yyerror(const char *s);
%}

%error-verbose

%token SELECT FROM AS WHERE BETWEEN AND OR IN LIKE IS NUL NOT ID DIGIT FPARENT RPARENT STRING CONC EQ

%%

prog	: 
		| prog stmt
		;

stmt	: SELECT cols FROM ID cond ';'	{ printf("\nLine %d ok\n", yylineno); }
		| error ';'						{ yyerrok; }
		;

cond	:
		| WHERE conl
		;
		
conl	: coni
		| coni AND conl
		| coni OR conl
		;
		
coni	: var EQ var
		| var BETWEEN var AND var
		| var NOT BETWEEN var AND var
		| var IN FPARENT list RPARENT
		| var NOT IN FPARENT list RPARENT
		| var IS NUL
		| var IS NOT NUL
		;

list	: var ',' list
		| var
		;

cols	: col
		| cols ',' col
		| col ali
		| cols ',' col ali
		;
	
col		: '*'	
		| var conc
		| var
		;

math    : DIGIT op var
		| ID op var
		;
		
ali		: ID
		| AS ID
		| AS STRING
		| STRING
		;
		
op		: '+'
		| '-'
		| '/'
		| '*'
		;

conc	: CONC var conc
		| CONC var
		;

var		: DIGIT
		| ID
		| STRING
		| math
		| FPARENT var RPARENT
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