%{
	#include <stdio.h>	
	#include "y.tab.h"
%}



%%

"main" {printf("FOUND MAIN "); return tMAIN;}
"(" {printf("FOUND ( "); return tPO;}
")" {printf("FOUND ) "); return tPF;}
"{" {printf("FOUND { "); return tAO;}
"}" {printf("FOUND } "); return tAF;}
"const" {printf("FOUND CONST "); return tCONST;}
"int" {printf("FOUND INT "); return tINT;}
"+" {printf("FOUND + "); return tPLUS;}
"-" {printf("FOUND - "); return tMOINS;}
"*" {printf("FOUND * "); return tMUL;}
"/" {printf("FOUND / "); return tDIV;}
"=" {printf("FOUND = "); return tEGAL;}
" " {}
"	" {}
"," {printf("FOUND ; "); return tVIR;}
"\n" {}
";" {printf("FOUND ; "); return tPV;}
"printf" {printf("FOUND PRINTF "); return tPRINT;}
[0-9]+|[0-9]+e"-"?[0-9]+ {printf("FOUND NUMBER "); yylval.nb = atof(yytext); return tNB; }
[a-zA-Z][_a-zA-Z0-9]* {printf("FOUND ID ");yylval.id=strdup(yytext); return tID;}
