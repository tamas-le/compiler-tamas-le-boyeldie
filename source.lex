%{
	#include <stdio.h>	
	#include "y.tab.h"
%}



%%

"(" {return tPO;}
")" {return tPF;}
"{" {return tAO;}
"}" {return tAF;}
"const" {return tCONST;}
"int" {return tINT;}
"if" {return tIF;}
"else" {return tELSE;}
"while" {return tWHILE;}
"return" {return tRETURN;}
"+" {return tPLUS;}
"-" {return tMOINS;}
"*" {return tMUL;}
"/" {return tDIV;}
"=" { return tEGAL;}
"<" { return tLT;}
">" {return tGT;}
" " {}
"//"[^\n]*"\n" {}
"	" {}
"," {return tVIR;}
"\n" {yylineno = yylineno + 1;}
";" {return tPV;}
"printf" {return tPRINT;}
[0-9]+|[0-9]+e"-"?[0-9]+ {yylval.nb = atof(yytext); return tNB; }
[a-zA-Z][_a-zA-Z0-9]* {yylval.id=strdup(yytext); return tID;}
