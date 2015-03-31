%{
	
	#include <stdio.h>
	#include "list_interpreter.h"

	int jumper;
	
%}

%union
{int nb; char *id;}

	
%token tMAIN tPO tPF tAO tAF tCONST tINT tVIR tPV tPRINT tLT tGT 
%token tPLUS tMOINS tMUL tDIV tEGAL
%token tIF tELSE tWHILE

%token tAFC tADD

%token taro

%token <nb> tNB;
%token <id> tID;



%start S

%%



S: Instructions  {printf("Main is OK\n");}

Instructions : Instructions Instruction
			| Instruction
			|


Instruction : tAFC  Adresse tNB {printf("Nb :%d \n",$3);}
			| tADD Adresse Adresse {printf("Oui l'addition\n");}

Adresse : taro tNB {printf("Adresse : %d\n",$2 );}





		
// Inst : tADD tNB tNB //{mem[$2]=mem[$2]+mem[$3];}
// 		|tMUL tNB tNB //{mem[$2]=mem[$2]*mem[$3];}
// 		|tSOU tNB tNB //{mem[$2]=mem[$2]-mem[$3];}
// 		|tDIV tNB tNB //{mem[$2]=mem[$2]/mem[$3];} 
// 		|tCOP tNB tNB //{mem[$2]=mem[$3];}
// 		|tAFC Adresse tNB tFIN {printf("Affectation\n");} //{mem[$2]=mem[$3];}
// 		|tJMP tNB {}
// 		|tJMF tNB {}
// 		|tINF tNB tNB //{$2<$3;} //comment stocker un boolean
// 		|tSUP tNB tNB //{$2>$3;}
// 		|tEQU tNB tNB //{$2==$3;}
// 		|tPRI tNB //{printf(mem($2));}
// 		|Commentaire tFIN

//Commentaire 





// Mes questions :
// Différences entre COP et AFC, comment faire pour avoir un tCONST ?
// Qu'est ce que mem au final. Comment on accède à notre table des symboles ?
// Les opérations assembleurs de type ADD @1 R1 R2, et ici seulement tNB correspondant "aux registes"


%%

int main(){
	printf("Début du programme d'interpretation\n");
	init_list();
	return yyparse();	
}

yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}
