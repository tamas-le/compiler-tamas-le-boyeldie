%{
	
	#include <stdio.h>
	
	
%}

%union
{int nb;}

%token tMOV tADD tMUL tSOU tDIV tCOP tAFC tJMP tJMF tINF tSUP tEQU tPRI
%token <nb> tNB;

%%


Insts : Inst Insts
		|Inst;
		
Inst : tADD tNB tNB //{mem[$2]=mem[$2]+mem[$3];}
		|tMUL tNB tNB //{mem[$2]=mem[$2]*mem[$3];}
		|tSOU tNB tNB //{mem[$2]=mem[$2]-mem[$3];}
		|tDIV tNB tNB //{mem[$2]=mem[$2]/mem[$3];} 
		|tCOP tNB tNB //{mem[$2]=mem[$3];}
		|tAFC tNB tNB //{mem[$2]=mem[$3];}
		|tJMP tNB {}
		|tJMF tNB {}
		|tINF tNB tNB //{$2<$3;} //comment stocker un boolean
		|tSUP tNB tNB //{$2>$3;}
		|tEQU tNB tNB //{$2==$3;}
		|tPRI tNB //{printf(mem($2));}


// Mes questions :
// Différences entre COP et AFC, comment faire pour avoir un tCONST ?
// Qu'est ce que mem au final. Comment on accède à notre table des symboles ?
// Les opérations assembleurs de type ADD @1 R1 R2, et ici seulement tNB correspondant "aux registes"


%%

int main(){
	return yyparse();	
}

yyerror(char *s){
		
}
