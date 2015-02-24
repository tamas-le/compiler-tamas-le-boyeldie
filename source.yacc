%{
	#include <stdio.h>
%}
%union
{int nb; char *id;}
	
%token tMAIN tPO tPF tAO tAF tCONST tINT tPLUS tMOINS tMUL tDIV tEGAL tVIR tFL tPV tPRINT
%token <nb> tNB;
%token <id> tID;

%right tEGAL 
%left tPLUS tMOINS
%left tMUL tDIV

%% 

S:tINT tMAIN tPO tPF tAO Declarationlist Statementlist tAF {printf("Main is OK\n");}



/********************************************************/
/*******************    DECLARATION    ******************/
/********************************************************/


Declarationlist : 
	Declarations
	|Declarationlist Declarations
	|

Declarations : 
	Declaration tPV {printf("Declaration is OK\n");}
	|tCONST Declaration tPV {printf("Constante is OK \n");}
	|DeclarationMultiples tPV {printf("DeclarationMul OK \n");} 


Declaration : tINT ID  // int i
Declaration : tINT ID tEGAL Number // int i =5 | int i = 4+3;


/********************************************************/
/**********    DECLARATION MULTIPLES    *****************/
/********************************************************/


DeclarationMultiples : tINT DMlist

DMlist : 
	Affectation tVIR DMlist 
	| Affectation
	| ID tVIR DMlist 
	| ID 



/********************************************************/
/*******************    STATEMENT    ********************/
/********************************************************/


Statementlist : 
	Statement  
   	|Statementlist Statement 
   	|

Statement : 
	Affectation tPV {printf("Affectation is OK\n");}
	|Printf tPV { printf("printf is OK\n");}
	





/********************************************************/
/*******************    AUTRES       ********************/
/********************************************************/



Affectation : 
	ID tEGAL Number

Printf : tPRINT tPO ID tPF // printf(i)

ID : tID {printf("variable : %s \n",$1);}

Number : 
	Number tPLUS Number
	|Number tMOINS Number
	|Number tMUL Number
	|Number tDIV Number // (4*5)+5
	|tPO Number tPF // (4)
	|tNB {printf("value : %d \n",$1);}   // 4
	|ID //toto


//S:tMAIN {printf("Main \n");}
//S:tNB {printf("value : %d", $1);}






%% 

main() {
	return yyparse();
}

yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}
	
	
