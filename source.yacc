%{
	#include <stdio.h>
	#include "symb_tab.h"
	FILE *fic; 

%}
%union
{int nb; char *id;}

	
%token tMAIN tPO tPF tAO tAF tCONST tINT tPLUS tMOINS tMUL tDIV tEGAL tVIR tFL tPV tPRINT
%token <nb> tNB;
%token <id> tID;
//%type <id> ID;
%type <id> AffectationDeclaration;
%type <nb> Number;

%right tEGAL 
%left tPLUS tMOINS
%left tMUL tDIV

%% 

S:tINT tMAIN tPO tPF tAO Declarationlist Statementlist tAF {printf("Main is OK\n");print_tab_symb();fclose(fic);}


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
	





/********************************************************/
/*******************    AUTRES       ********************/
/********************************************************/



Affectation : 
	tID tEGAL Number{if(get_state($1)==CONSTANT)printf("Erreur\n");change_state(INITIALISED,$1);}

Printf : tPRINT tPO tID tPF // printf(i)

//ID : tID {printf("variable : %s \n",$1);$$=$1;}

Number : 
	Number tPLUS Number {fprintf(fic,"ADD %d %d %d\n", $1, $1, $3);pop(); $$=$1;}
	|Number tMOINS Number {fprintf(fic,"SOU %d %d %d\n", $1, $1, $3);pop(); $$=$1;}
	|Number tMUL Number {fprintf(fic,"MUL %d %d %d\n", $1, $1, $3);pop(); $$=$1;}
	|Number tDIV Number {fprintf(fic,"DIV %d %d %d\n", $1, $1, $3);pop(); $$=$1;}// (4*5)+5
	|tPO Number tPF {$$=$2;}// (4)
	|tNB {printf("value : %d \n",$1);int adr=insert(" ",TMP); fprintf(fic,"AFC %d %d\n",adr,$1);$$=adr;}   // 4
	|tID {int adr=get_id_for_name($1);int tmp=insert(" ",TMP);fprintf(fic,"COP %d %d \n",tmp,adr);$$=adr;} //toto


//S:tMAIN {printf("Main \n");}
//S:tNB {printf("value : %d", $1);}






%% 




int main() {
	
	fic=fopen("./ass.ass", "r+");
	//fprintf(fic, ";Assembleur généré par les duocodeurs\n");
	//init_table();
	/*print_tab_symb();
	return yyparse();*/
	return 0;
}

yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}
	
	
