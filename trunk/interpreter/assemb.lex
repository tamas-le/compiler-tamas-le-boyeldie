%{
	#include <stdio.h>	
	#include "y.tab.h"
%}



%%
"AFC" {return tAFC;}
"ADD" {return tADD;}
"MUL" {return tMUL;}
"SOU" {return tSOU;}
"DIV" {return tDIV;}
"COP" {return tCOP;}
"JMP" {return tJMP;}
"JMF" {return tJMF;}
"INF" {return tINF;}
"SUP" {return tSUP;}
"EQU" {return tEQU;}
"PRI" {return tPRI;}
"@" {return taro;}
" " {}
"	" {}
"\n" {}
[0-9]+|[0-9]+e"-"?[0-9]+ {yylval.nb = atof(yytext); return tNB; }
[a-zA-Z][_a-zA-Z0-9]* {yylval.id=strdup(yytext); return tID;}


