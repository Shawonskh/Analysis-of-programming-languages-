%top{
#include "sql.tab.h"
}
%option noyywrap
%option warn
%option case-insensitive
%option yylineno

%%

\-\-.*\n			;
\".*\"				{ return STRING; }
\'.*\'				{ return STRING; }
"SELECT"			{ return SELECT; }
"BETWEEN"			{ return BETWEEN; }
"WHERE"				{ return WHERE; }
"FROM"				{ return FROM; }
"AS"				{ return AS; }
"AND"				{ return AND; }
"OR"				{ return OR; }
"IN"				{ return IN; }
"LIKE"				{ return LIKE; }
"IS"				{ return IS; }
"NOT"				{ return NOT; }
"NULL"				{ return NUL; }
[A-Z]+				{ return ID; }
[0-9]+				{ return DIGIT; }
"("					{ return FPARENT; }
")"					{ return RPARENT; }
"||"				{ return CONC; }
">="				{return EQ; }
"<="        		{return EQ; }
"="         		{return EQ; }
"<"         		{return EQ; }
">"         		{return EQ; }
[;,=<>\+\-\*/]		{ return *yytext; }
\n					; 
\t					;
" "					;

%%