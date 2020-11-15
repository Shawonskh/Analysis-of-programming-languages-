%top{
#include <stdio.h>
int stack[100];
int pos;
void push(int);
int pop(void);
int a, b;
}

%option noyywrap

%%
[0-9]+	push(atoi(yytext));
\+		{ b = pop(); a = pop(); push(a + b); }
\-		{ b = pop(); a = pop(); push(a - b); }
\*		{ b = pop(); a = pop(); push(a * b); }
\/		{ b = pop(); a = pop(); push(a / b); }
\n		{ printf("Result: %d\n", pop()); 
			if(pos > 0) 
				printf("ERROR: stack not empty!\n");
			pos = 0; //recovery
		}
.		;
%%
void push(int x){
	stack[pos++] = x;
}
int pop(void){
	if(pos == 0){
		printf("stack underflow!\n");
		return 0;
	}
	return stack[--pos];
}
int main(void){
	pos = 0;
	return yylex();
}
