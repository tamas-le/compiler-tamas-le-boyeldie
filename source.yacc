%{
	#include <stdio.h>
	#include "symb_tab/symb_tab.h"
	#include "jumper/jump.h"
	#include "ass_file/file_ass.h"

	FILE *fic;
	int nb_instructions_assembleur=0;
	extern int yylineno;
	extern char * yytext;
%}


/********************************************************/
/*******************    TOKENS         ******************/
/********************************************************/


%union
{int nb; char *id;}

	
%token tMAIN tPO tPF tAO tAF tCONST tINT tVIR tPV tPRINT tLT tGT 
%token tPLUS tMOINS tMUL tDIV tEGAL
%token tIF tELSE tWHILE
%token <nb> tNB;
%token <id> tID;


%type <id> AffectationDeclaration;
%type <nb> Number;
%type <nb> Condition;


%right tEGAL 
%left tPLUS tMOINS
%left tMUL tDIV


%start S

%% 


/********************************************************/
/*******************     AXIOM         ******************/
/********************************************************/


//Fonction peut se dériver soit en main soit en une autre fonction
//Faire fonctionner les constantes

S:Main {
	//printf("Main is OK\n");
	//print_tab_symb();

	fclose(fic);
	printf("Nombre d'instructions assembleur : %d\n",nb_instructions_assembleur);

	destroy_table();
	destroy_jump_table();
	//print_tab_symb();
}

Main : tINT tMAIN tPO tPF tAO Declarationlist Statementlist tAF

/*Fonctionlist : Fonction Fonctionlist
			| Fonction

Fonction : tINT tID tPO tPF tAO tAF*/


/********************************************************/
/*******************    DECLARATION    ******************/
/********************************************************/


Declarationlist : 
	Declarations
	|Declarations Declarationlist 
	|


Declarations : 
	Declaration tPV {printf("Declaration is OK\n");}
	|tCONST tINT tID tEGAL Number tPV {
		symb_pop();
		printf("Constante is OK \n");
		int adr=insert($3,CONSTANT);
		fprintf(fic, "COP @%d @%d\n",adr,$5);
		nb_instructions_assembleur++; 
	}
	|DeclarationMultiples tPV {printf("DeclarationMul OK \n");} 


Declaration : tINT tID {insert($2,NOT_INITIALISED);} // int i
Declaration : tINT tID tEGAL Number{
					symb_pop();
					int adr=insert($2,INITIALISED);
					fprintf(fic, "COP @%d @%d\n",adr,$4);
					nb_instructions_assembleur++;
				} 




/********************************************************/
/**********    DECLARATION MULTIPLES    *****************/
/********************************************************/


AffectationDeclaration : 
	tID tEGAL Number {
		$$=$1;
		symb_pop();
		int adr=insert($1,INITIALISED);
		fprintf(fic, "COP @%d @%d\n",adr,$3);
		nb_instructions_assembleur++;
	}

DeclarationMultiples : tINT DMlist

DMlist : 
	AffectationDeclaration tVIR DMlist 
	| AffectationDeclaration 
	| tID tVIR DMlist {insert($1,NOT_INITIALISED);}
	| tID {insert($1,NOT_INITIALISED);}




/********************************************************/
/*******************    STATEMENT    ********************/
/********************************************************/


Statementlist : 
	Statement  
   	|Statement Statementlist 
   	|

Statement : 
	Affectation tPV {printf("Affectation is OK\n");}
	|Printf tPV { printf("printf is OK\n");}
	|If
	|While
	




/********************************************************/
/*******************    AUTRES       ********************/
/********************************************************/



Affectation : tID tEGAL Number{
				if(get_state($1)==CONSTANT) yyerror("Une constante ne peut pas être affectée"); 
				
				int adr=get_id_for_name($1);
				if (adr ==-1){
					yyerror("La variable n'a pas été déclarée");
				}
				change_state(INITIALISED,$1);
				fprintf(fic,"COP @%d @%d \n",adr,$3);
				symb_pop();
				nb_instructions_assembleur++;
}
	
	
/********************************************************/
/*******************     PRINT       ********************/
/********************************************************/
	

Printf : tPRINT tPO tID tPF{
			int id = get_id_for_name($3);
			if (id ==-1){
				yyerror("La variable n'existe pas");
			} else {
				fprintf(fic, "PRI @%d\n",id);
				nb_instructions_assembleur++;
			}
}



/********************************************************/
/*******************   OPERATIONS    ********************/
/********************************************************/


//ID : tID {printf("variable : %s \n",$1);$$=$1;}

Number : 
	Number tPLUS Number {int adr=insert(" ",TMP);fprintf(fic,"ADD @%d @%d @%d\n", adr, $1, $3); $$=adr;nb_instructions_assembleur++;}
	
	|Number tMOINS Number {int adr=insert(" ",TMP);fprintf(fic,"SOU @%d @%d @%d\n", adr, $1, $3); $$=adr;nb_instructions_assembleur++;}
	
	|Number tMUL Number {int adr=insert(" ",TMP);fprintf(fic,"MUL @%d @%d @%d\n", adr, $1, $3); $$=adr;nb_instructions_assembleur++;}
	
	|Number tDIV Number {int adr=insert(" ",TMP);fprintf(fic,"DIV @%d @%d @%d\n",adr, $1, $3); $$=adr;nb_instructions_assembleur++;} //(4*5)+5
	
	|tPO Number tPF {$$=$2;} //(4)
	
	|tNB {printf("value : %d \n",$1);int adr=insert(" ",TMP); fprintf(fic,"AFC @%d %d\n",adr,$1);$$=adr;nb_instructions_assembleur++;} // 4
	
	|tID {int adr=get_id_for_name($1);/*int tmp=insert(" ",TMP);fprintf(fic,"COP @%d @%d \n",tmp,adr);*/$$=adr;/*nb_instructions_assembleur++;*/} //toto



/********************************************************/
/*******************       IF        ********************/
/********************************************************/

If :Ifsimple{
	
	printf("Ya pas de else\n");
	update_jump(-1,nb_instructions_assembleur+1);
	jump *j=(jump *)jump_pop();

	fclose(fic);
	replace_line(j->from,j->to,fic);
	fopen("./ass.ass","a+");
	}
	
	|Ifsimple Else{
		printf("Ya un else !\n");
		update_jump(-1,nb_instructions_assembleur+1);
		jump *j=(jump *)jump_pop();
		fclose(fic);
		replace_line(j->from,j->to,fic);
		fopen("./ass.ass","a+");
	}


Ifsimple:tIF tPO Condition tPF {
		fprintf(fic, "JMF @%d ???\n",$3 );
		nb_instructions_assembleur++;
		add_jump(nb_instructions_assembleur,-1);
		} 
	tAO Statementlist tAF {
		//On met à jour le saut dans la liste et on l'enlève
		update_jump(-1,nb_instructions_assembleur+2);
		jump *j=(jump *)jump_pop();

		//On ajoute un saut inconditionel. On sait pas encore ou on va ça dépend si il y a un else ou non.
		fprintf(fic, "JMP ???\n");
		nb_instructions_assembleur++;
		add_jump(nb_instructions_assembleur,-1);
		


		//Mise à jour du saut dans le fichier avec la bonne valeur
		fclose(fic);
		replace_line(j->from,j->to,fic);
		fopen("./ass.ass","a+");	
	}

Else:tELSE tAO Statementlist tAF {}




/********************************************************/
/*******************      WHILE      ********************/
/********************************************************/


While: tWHILE tPO Condition tPF{
							fprintf(fic, "JMF @%d ???\n",$3 );
							nb_instructions_assembleur++;
							add_jump(nb_instructions_assembleur,-1);
								
		} tAO Statementlist tAF {
							update_jump(-1,nb_instructions_assembleur+2);
							jump *j=(jump *)jump_pop();
							//Saut inconditionel à la condition du while

							fprintf(fic, "JMP %d\n",(j->from)-1);
							nb_instructions_assembleur++;

							//Mise à jour du saut dans le fichier avec la bonne valeur
							fclose(fic);
							replace_line(j->from,j->to,fic);
							fopen("./ass.ass","a+");
		}



/********************************************************/
/******************* CONDITION POUR IF ET WHILE ********************/
/********************************************************/


Condition : 
	Number tLT Number 
					{
						int adr=insert(" ",TMP);
						fprintf(fic,"INF @%d @%d @%d\n",adr,$1,$3);
						nb_instructions_assembleur++;
						$$=adr;
					}
	|Number tGT Number
					{
						int adr=insert(" ",TMP);
						fprintf(fic,"SUP @%d @%d @%d\n",adr,$1,$3);
						nb_instructions_assembleur++;
						$$=adr;
					}  
	|Number tEGAL tEGAL Number
					{
						int adr=insert(" ",TMP);
						fprintf(fic,"EQU @%d @%d @%d\n",adr,$1,$4);
						nb_instructions_assembleur++;
						$$=adr;
					}  

%% 




int main() {
	// initialisation du fichier
	fic=fopen("./ass.ass", "w+");
	//initialisation des tables symboles et saut
	init_table();
	init_jump();

	return yyparse();
}




yyerror(char *s){
	printf("%d : %s %s\n", yylineno, s, yytext );
	printf("Erreur de syntaxe !!!!\n");
}





	
	
