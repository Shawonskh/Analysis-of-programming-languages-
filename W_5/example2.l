%top{
#include "example2.tab.h"
}
%option noyywrap
%option warn
%option case-insensitive
%option yylineno

%%

\-\-.*\n	;
"SELECT"	{ return SELECT; }
"BETWEEN"	{ return BETWEEN; }
"WHERE"		{ return WHERE; }
"FROM"		{ return FROM; }
"AS"		{ return AS; }
"AND"		{ return AND; }
"OR"		{ return OR; }
"IN"		{ return IN; }
"LIKE"		{ return LIKE; }
"IS"		{ return IS; }
"NOT"		{ return NOT; }
"NULL"		{ return NUL; }
[A-Z]+		{ return ID; }
[;,\+\-\*/()=<>]	{ return *yytext; }
\n		; 
\t		;
" "		;

%%