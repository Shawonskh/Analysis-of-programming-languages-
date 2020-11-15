%top{
#include <stdio.h>
}

%option noyywrap
%option stack
%s PAR

%%

\(		yy_push_state(PAR);
<PAR>\)	yy_pop_state();
<PAR>\n	printf("too many opening\n"); //does not get reset tho
\)		printf("too many closing\n");
.		;
\n		;

%%

int main(void){
	return yylex();
}
