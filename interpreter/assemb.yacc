%{
	
	#include <stdio.h>
	#include "pile/list_interpreter.h"
	#include "action/action.h"
	#include "prog/list_instructions.h"
	
	

	int jumper=0;
	int num_ligne=1;

	
	
%}

%union
{int nb; char *id;}

	


%token tAFC tADD tMUL tSOU tDIV tCOP tJMP tJMF tINF tSUP tEQU tPRI

%token taro

%token <nb> tNB;
%token <id> tID;

%type <nb> Adresse; 



%start S

%%



S: Instructions  {printf("Assembleur qui régale\n");print_list_instruction();go();destroy_list_inst();}

Instructions : Instructions Instruction {num_ligne++;printf("ligne :%d\n",num_ligne);}
			| Instruction {num_ligne++;printf("ligne :%d\n",num_ligne);}
			|


//add_instruction(int num_ligne,type_action action,int arg1,int arg2,int arg3)

Instruction : tAFC Adresse tNB {
	add_instruction(num_ligne,AFC,$2,$3,0);
	//add_to_list($3,$2);
	}
			| tADD Adresse Adresse Adresse {
				add_instruction(num_ligne,ADD,$2,$3,$4);
				//op($2,$3,$4,PLUS)
			}
			| tMUL Adresse Adresse Adresse{ 
				add_instruction(num_ligne,MUL,$2,$3,$4);
				//op($2,$3,$4,FOIS);
			}
			| tSOU Adresse Adresse Adresse{
				add_instruction(num_ligne,SOU,$2,$3,$4);
				//op($2,$3,$4,MOINS);
			}
			| tDIV Adresse Adresse Adresse{
				add_instruction(num_ligne,DIV,$2,$3,$4);
				//op($2,$3,$4,PAR);
			}
			| tCOP Adresse Adresse {
				add_instruction(num_ligne,COP,$2,$3,0);
				//copy($2,$3);
			}


			| tJMP tNB {
				add_instruction(num_ligne,JMP,$2,0,0);
			} 
			| tJMF Adresse tNB {
				add_instruction(num_ligne,JMF,$2,$3,0);
			}

			| tINF Adresse Adresse Adresse{
				add_instruction(num_ligne,INF,$2,$3,$4);
				//op($2,$3,$4,PP);
			}
			| tSUP Adresse Adresse Adresse {
				add_instruction(num_ligne,SUP,$2,$3,$4);
				//op($2,$3,$4,PG);
			}
			| tEQU Adresse Adresse Adresse {
				add_instruction(num_ligne,EQU,$2,$3,$4);
				//op($2,$3,$4,EG);
			}
			| tPRI Adresse {
						add_instruction(num_ligne,PRI,$2,0,0);
						//pri($2);
					}

Adresse : taro tNB {/*printf("Adresse : %d\n",$2 );*/$$=$2;}





		
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
	init_list_instruction();
	return yyparse();	
}

yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}
