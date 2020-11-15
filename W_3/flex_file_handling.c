int main(void){
	yyin = fopen("bnff2014.html", "r");
	yylex();
	fclose(yyin);

}
