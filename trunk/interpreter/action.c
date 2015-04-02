#include "action.h"
#include "list_interpreter.h"
#include <stdio.h>


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
			case FOIS:
			update_list(operande1*operande2,adr_resultat);
			break;
			case PAR:
			update_list(operande1/operande2,adr_resultat);
			break;
			case PP:
			update_list(operande1<operande2,adr_resultat);
			break;
			case PG:
			update_list(operande1>operande2,adr_resultat);
			break;
			case EG:
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

	void afc(int adr,int val){
		add_to_list(val,adr);
	}