%{
	
	#include <stdio.h>
	#include "list_interpreter.h"
	
	typedef enum operator {
		PLUS, MOINS, MUL, DIV, INF, SUP, EQU
	}operator;

	int jumper=0;
	int num_ligne=0;

	void op(int adr_resultat,int adr_op1,int adr_op2,operator op){
		cellule *c1=get_value(adr_op1), *c2=get_value(adr_op2);
		int operande1=c1->value;
		int operande2=c2->value;

		switch(op){
			case PLUS:
			update_list(operande1+operande2,adr_resultat);
			break;
			case MOINS:
			update_list(operande1-operande2,adr_resultat);
			break;
			case MUL:
			update_list(operande1*operande2,adr_resultat);
			break;
			case DIV:
			update_list(operande1/operande2,adr_resultat);
			break;
			case INF:
			update_list(operande1<operande2,adr_resultat);
			break;
			case SUP:
			update_list(operande1>operande2,adr_resultat);
			break;
			case EQU:
			update_list(operande1==operande2,adr_resultat);
			break;

		}

	}

	void pri(int arg){
		cellule *c=get_value(arg);
		printf("PRI : %d\n",c->value);
	}

	void copy(int arg1, int arg2){
		cellule*c2=get_value(arg2);
		update_list(c2->value,arg1);
	}
	
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



S: Instructions  {printf("Assembleur qui régale\n"); printlist();destroylist();}

Instructions : Instructions Instruction {num_ligne++;printf("ligne :%d\n",num_ligne);}
			| Instruction {num_ligne++;printf("ligne :%d\n",num_ligne);}
			|


Instruction : tAFC Adresse tNB {add_to_list($3,$2);}
			| tADD Adresse Adresse Adresse {op($2,$3,$4,PLUS);}
			| tMUL Adresse Adresse Adresse{ op($2,$3,$4,MUL);}
			| tSOU Adresse Adresse Adresse{op($2,$3,$4,MOINS);}
			| tDIV Adresse Adresse Adresse{op($2,$3,$4,DIV);}
			| tCOP Adresse Adresse {
							copy($2,$3);
			}


			| tJMP tNB {

			} 
			| tJMF Adresse tNB {printf("Oui le jump conditionnel\n");}

			| tINF Adresse Adresse Adresse{op($2,$3,$4,INF);}
			| tSUP Adresse Adresse Adresse {op($2,$3,$4,SUP);}
			| tEQU Adresse Adresse Adresse {op($2,$3,$4,EQU);}

			| tPRI Adresse {
						pri($2);
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
	init_list();
	return yyparse();	
}

yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}
