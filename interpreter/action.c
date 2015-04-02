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