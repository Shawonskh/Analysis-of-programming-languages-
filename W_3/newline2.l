%top{
#include <stdio.h>
char buf[64000];
int pos;
}

%option noyywrap
%s STR

%%

\n			;
<STR>[^\"]	buf[pos++] = yytext[0];
<STR>\\\"	buf[pos++] = '\"';
<STR>\\n	buf[pos++] = '\n';
<STR>\"		buf[pos++] = 0; printf("%s", buf); BEGIN(INITIAL);
\"			pos = 0; BEGIN(STR);
.			;

%%

int main(void){
	return yylex();
}
