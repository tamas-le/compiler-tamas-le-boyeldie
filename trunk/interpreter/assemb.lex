%{
	#include <stdio.h>	
	#include "y.tab.h"
%}



%%
"AFC" {return tAFC;}
"ADD" {return tADD;}
"@" {return taro;}
" " {}
"	" {}
"\n" {}
[0-9]+|[0-9]+e"-"?[0-9]+ {yylval.nb = atof(yytext); return tNB; }
[a-zA-Z][_a-zA-Z0-9]* {yylval.id=strdup(yytext); return tID;}


