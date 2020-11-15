%top{
#include <stdio.h>
}

%option noyywrap
%option stack
%s PAR

%%

\(		yy_push_state(PAR);
<PAR>\)	yy_pop_state();
<PAR>\n	{printf("too many opening\n"); 
			while(yy_top_state() == PAR) //this should reset
				yy_pop_state();
			yy_pop_state();
		}
\)		printf("too many closing\n");
.		;
\n		;

%%

int main(void){
	return yylex();
}
