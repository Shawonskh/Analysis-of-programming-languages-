%top{
#include <stdio.h>
char buf[64000];
int pos;
}

%option noyywrap
%x STR

%%

\"			pos = 0; BEGIN(STR);
<STR>[^\"]	buf[pos++] = yytext[0];
<STR>\\\"	buf[pos++] = '\"';
<STR>\\n	buf[pos++] = '\n';
<STR>\"		buf[pos++] = 0; printf("%s", buf); BEGIN(INITIAL);
\n			;
.			;

%%

int main(void){
	return yylex();
}
