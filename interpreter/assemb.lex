%{
	#include <stdio.h>
	#include "y.tab.h"	
	
%}

%%

"ADD" { printf("Found : ADD\n"); return tADD;}
"MUL" { printf("Found : MUL\n"); return tMUL;}
"SOU" { printf("Found : SOU\n"); return tSOU;}
"DIV" { printf("Found : DIV\n"); return tDIV;}
"COP" { printf("Found : COP\n"); return tCOP;}
"AFC" { printf("Found : AFC\n"); return tAFC;}
"JMP" { printf("Found : JMP\n"); return tJMP;}
"JMF" { printf("Found : JMF\n"); return tJMF;}
"INF" { printf("Found : INF\n"); return tINF;}
"SUP" { printf("Found : SUP\n"); return tSUP;}
"EQU" { printf("Found : EQU\n"); return tEQU;}
"PRI" { printf("Found : PRI\n"); return tPRI;}
[0-9]+ {yylval.nb = atof(yytext); return tNB;}
" " {}
"	" {}
"\n" {printf("Found : FIN\n");}
"@" {printf("Found @\n" ); return taro;}
";" {printf("Found ;\n"); return tPV;}
([_a-zA-Z0-9 ])* {yylval.id=strdup(yytext); return tTEXT;}
