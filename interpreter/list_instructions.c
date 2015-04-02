#include "list_instructions.h"
#include <stdio.h>
#include <stdlib.h>
#include "../list/list.h"
#include "action.h"


llist * list_inst;

void display_instruction(list_node * node){
	instruction *i=(instruction *)node->data;
	printf("Ligne : %d | Code : %d | Args : %d %d %d \n",i->num_ligne,i->action,i->arg[0],i->arg[1],i->arg[2]);
}

void init_list_instruction(){
	void (*pFonctionDisplay)(list_node*);
	//int (*pFonctionCompare)(list_node*,void*);
	pFonctionDisplay=display_instruction;
	//pFonctionCompare=compare_cellule;
	list_inst=list_create(NULL,pFonctionDisplay);
}


void add_instruction(int num_ligne,type_action action,int arg1,int arg2,int arg3){
	instruction *i = malloc(sizeof(instruction));
	i->num_ligne=num_ligne;
	i->action=action;
	i->arg[0]=arg1;
	i->arg[1]=arg2;
	i->arg[2]=arg3;
	list_insert_end(list_inst,i);
}

void go(){
	init_list();
	list_node *aux=list_inst->node;
	instruction *instruction_courante;

	while(aux!=NULL){
		instruction_courante=(instruction *)aux->data;
		run_instruction(instruction_courante);
		aux=aux->next;
	}
	printlist();
	destroylist();
}

void run_instruction(instruction *i){
	
	switch(i->action){
		case ADD:
		op(i->arg[0],i->arg[1],i->arg[2],PLUS);
		break;
		case MUL:
		op(i->arg[0],i->arg[1],i->arg[2],FOIS);
		break;
		case SOU:
		op(i->arg[0],i->arg[1],i->arg[2],MOINS);
		break;
		case DIV:
		op(i->arg[0],i->arg[1],i->arg[2],PAR);
		break;
		case COP:
		copy(i->arg[0],i->arg[1]);
		break;
		case AFC:
		afc(i->arg[0],i->arg[1]);
		break;
		case JMP:

		break;
		case JMF:

		break;
		case INF:
		op(i->arg[0],i->arg[1],i->arg[2],PP);
		break;
		case SUP:
		op(i->arg[0],i->arg[1],i->arg[2],PG);
		break;
		case EQU:
		op(i->arg[0],i->arg[1],i->arg[2],EG);
		break;
		case PRI:
		pri(i->arg[0]);
		break;
	}
}

void destroy_list_inst(){
	list_destroy(list_inst);
}

void print_list_instruction(){
	print_list(list_inst);
}



/*int main(int argc, char const *argv[])
{
	printf("Test de la liste des instructions\n");
	init_list_instruction();
	add_instruction(1,AFC,1,2,0);
	add_instruction(2,COP,2,1,0);
	add_instruction(3,ADD,3,1,2);
	print_list_instruction();
	go();
	destroy_list_inst();
	

	return 0;
}*/