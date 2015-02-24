%{
	#include <stdio.h>
%}
%union
{int nb; char *id;}
	
%token tMAIN tPO tPF tAO tAF tCONST tINT tPLUS tMOINS tMUL tDIV tEGAL tVIR tFL tPV tPRINT
%token <nb> tNB;
%token <id> tID;

%% 
// printf
//const
//declaration multiples



S:tINT tMAIN tPO tPF tAO Statementlist tAF {printf("Main is OK\n");}
Statementlist : 
	Statement  
   	| Statementlist Statement 

Statement : 
	Declaration tPV {printf("Declaration is OK\n");}
	|Affectation tPV {printf("Affectation is OK\n");}

Declaration : tINT tID  // int i
Declaration : tINT tID tEGAL Number // int i =5 | int i = 4+3; 


Number : 
	tNB // 4
	|tID
	|tPO Number tPF // (4)
	|Number Operateur Number // (4*5)+5

Affectation : 
	tID tEGAL Number


Operateur : tPLUS | tMOINS | tDIV | tEGAL

//S:tMAIN {printf("Main \n");}
//S:tNB {printf("value : %d", $1);}

%% 

main() {
	return yyparse();
}

yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}
	
	
