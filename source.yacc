%{
	#include <stdio.h>
	#include "symb_tab/symb_tab.h"
	#include "jumper/jump.h"

	

	FILE *fic;
	int nb_instructions_assembleur=0; 

%}
%union
{int nb; char *id;}

	
%token tMAIN tPO tPF tAO tAF tCONST tINT tPLUS tMOINS tMUL tDIV tEGAL tVIR tFL tPV tPRINT tLT tGT tIF
%token <nb> tNB;
%token <id> tID;
//%type <id> ID;
%type <id> AffectationDeclaration;
%type <nb> Number;
%type <nb> Condition;

%right tEGAL 
%left tPLUS tMOINS
%left tMUL tDIV

%% 

S:tINT tMAIN tPO tPF tAO Declarationlist Statementlist tAF {
	printf("Main is OK\n");
	print_tab_symb();
	fclose(fic);
	print_jump();
	jump *j=(jump *)jump_pop();
	print_jump();
	printf("from : %d to : %d\n",j->from,j->to );
	printf("Nombre d'instructions assembleur : %d\n",nb_instructions_assembleur);
	
}


/********************************************************/
/*******************    DECLARATION    ******************/
/********************************************************/


Declarationlist : 
	Declarations
	|Declarationlist Declarations
	|

Declarations : 
	Declaration tPV {printf("Declaration is OK\n");}
	|tCONST tINT tID tEGAL Number tPV {printf("Constante is OK \n");insert($3,CONSTANT);}
	|DeclarationMultiples tPV {printf("DeclarationMul OK \n");} 


Declaration : tINT tID {insert($2,NOT_INITIALISED);} // int i
Declaration : tINT tID tEGAL Number{insert($2,INITIALISED);} // int i =5 | int i = 4+3;


/********************************************************/
/**********    DECLARATION MULTIPLES    *****************/
/********************************************************/

AffectationDeclaration : 
	tID tEGAL Number {$$=$1;}

DeclarationMultiples : tINT DMlist

DMlist : 
	AffectationDeclaration tVIR DMlist {insert($1,INITIALISED);}
	| AffectationDeclaration {insert($1,INITIALISED);}
	| tID tVIR DMlist {insert($1,NOT_INITIALISED);}
	| tID {insert($1,NOT_INITIALISED);}



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
	|If
	





/********************************************************/
/*******************    AUTRES       ********************/
/********************************************************/



Affectation : 
	tID tEGAL Number{if(get_state($1)==CONSTANT)printf("Erreur\n");change_state(INITIALISED,$1);}

Printf : tPRINT tPO tID tPF
						{
							int id = get_id_for_name($3);
							if (id ==-1){
								yyerror("La variable n'existe pas");
							} else {
								fprintf(fic, "PRI %d\n",id);
								nb_instructions_assembleur++;
							}

						} // printf(i)

//ID : tID {printf("variable : %s \n",$1);$$=$1;}

Number : 
	Number tPLUS Number {fprintf(fic,"ADD %d %d %d\n", $1, $1, $3);symb_pop(); $$=$1;nb_instructions_assembleur++;}
	|Number tMOINS Number {fprintf(fic,"SOU %d %d %d\n", $1, $1, $3);symb_pop(); $$=$1;nb_instructions_assembleur++;}
	|Number tMUL Number {fprintf(fic,"MUL %d %d %d\n", $1, $1, $3);symb_pop(); $$=$1;nb_instructions_assembleur++;}
	|Number tDIV Number {fprintf(fic,"DIV %d %d %d\n", $1, $1, $3);symb_pop(); $$=$1;nb_instructions_assembleur++;}// (4*5)+5
	|tPO Number tPF {$$=$2;}// (4)
	|tNB {printf("value : %d \n",$1);int adr=insert(" ",TMP); fprintf(fic,"AFC %d %d\n",adr,$1);$$=adr;nb_instructions_assembleur++;}   // 4
	|tID {int adr=get_id_for_name($1);int tmp=insert(" ",TMP);fprintf(fic,"COP %d %d \n",tmp,adr);$$=adr;nb_instructions_assembleur++;} //toto


//S:tMAIN {printf("Main \n");}
//S:tNB {printf("value : %d", $1);}

/********************************************************/
/*******************  CONDITIONS     ********************/
/********************************************************/

If : 
	tIF tPO Condition tPF {
			fprintf(fic, "JMF %d ???\n",$3 );
			nb_instructions_assembleur++;
			add_jump(nb_instructions_assembleur,-1);
		} 
	tAO Statementlist tAF {
			update_jump(-1,nb_instructions_assembleur+1);
	}

	|tIF tPO Condition tPF 
		{
			fprintf(fic, "JMF %d ???\n",$3 );
			nb_instructions_assembleur++;
			add_jump(nb_instructions_assembleur,-1);
		} Statement {
			update_jump(-1,nb_instructions_assembleur);
		}


Condition : 
	Number tLT Number 
					{
						fprintf(fic,"INF %d %d %d\n",$1,$1,$3);
						nb_instructions_assembleur++;
						symb_pop();
						$$=$1;
					}
	|Number tGT Number
					{
						fprintf(fic,"SUP %d %d %d\n",$1,$1,$3);
						nb_instructions_assembleur++;
						symb_pop();
						$$=$1;
					}  
	|Number tEGAL tEGAL Number
					{
						fprintf(fic,"EQU %d %d %d\n",$1,$1,$4);
						nb_instructions_assembleur++;
						symb_pop();
						$$=$1;
					}  

%% 




int main() {
	// initialisation du fichier
	fic=fopen("./ass.ass", "w+");
	fprintf(fic, ";Assembleur généré par les duocodeurs\n");
	nb_instructions_assembleur++;
	//initialisation des tables symboles et saut
	init_table();
	init_jump();

	return yyparse();
}




yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}





	
	
