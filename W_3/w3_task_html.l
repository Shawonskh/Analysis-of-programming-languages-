%top{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct {
	char date[10];
	char day[10];
	char name[100];
	char length[10];
	char time[10];
}film;

film *fStack;
int filmAmount = 0;
int filmMem = 0;
char bufDate[10];
char bufDay[10];
char bufName[100] = "";

void cpyDate(char*);
void cpyDay(char*);
void cpyTime(char*);
void cpyLength(char*);
void outPutData(char*);
void cpyName(char str[]);
}

%option case-insensitive
%option noyywrap
%option warn
%x H2
%x DESC
%x INFO
%x STR
%%

"<h2>"           					{BEGIN(H2);}
<H2>[0-9]{2}"."[0-9]{2}"."			{cpyDate(yytext);}
<H2>[a-z]*							{cpyDay(yytext);}
<H2>"</h2>"							{BEGIN(INITIAL);}
"<div class=\"desc_box\">"			{BEGIN(DESC);}
<DESC>[0-9]{2}":"[0-9]{2}			{cpyTime(yytext);}
<DESC>[0-9]{6}" - "[a-z0-9\:\-']+	{strcat(bufName, yytext); strcat(bufName, " "); BEGIN(STR);}
<STR>"</a>"							{cpyName(bufName);BEGIN(INITIAL);}
<STR>[a-z0-9\:\-']+					{strcat(bufName, yytext); strcat(bufName, " ");}
"<p class=\"p_info\">"				{BEGIN(INFO);}
<INFO>[0-9]+"h "[0-9]{2}			{cpyLength(yytext);}
<INFO>"</p>"						{BEGIN(INITIAL);}
\n			;	
.			;

%%

void cpyLength(char *str){
	strcpy(fStack[filmAmount].length, str);
	filmAmount++;
}

void cpyTime(char *str){
	
	if(filmMem == 0){
		fStack = (film*) realloc(fStack, sizeof(film));
		filmMem = 1;
	}
	if(filmMem == filmAmount){
		fStack = (film*) realloc(fStack, sizeof(film) * filmAmount * 2);
		filmMem *= 2;
	}
	strcpy(fStack[filmAmount].time, str);
}

void cpyName(char str[]){
	int i;
	for(i=9;i<strlen(str);i++){
		fStack[filmAmount].name[i-9] = str[i];
	}
	strcpy(fStack[filmAmount].date, bufDate);
	strcpy(fStack[filmAmount].day, bufDay);
	strcpy(bufName, "");
}

void cpyDate(char *str){
	
	strcpy(bufDate, str);
}

void cpyDay(char *str){
	strcpy(bufDay, str);
	
}

void outPutData(char *str){
	printf("\n%s\n", str);
	int i;
	for(i=0;i<filmAmount;i++){
		printf("Name: %s\n", fStack[i].name);
		printf("Date: %s - ", fStack[i].date);
		printf("%s - ", fStack[i].day);
		printf("%s\n", fStack[i].time);
		printf("Length: %sm\n\n", fStack[i].length);
	}
}

int main(void){
	yyin = fopen("poff.html", "r");
	yylex();
	outPutData("results");
	fclose(yyin);

}