#include "../../list/list.h"

#ifndef INST
#define INST

typedef enum type_action{
	ADD,MUL,SOU,DIV,COP,AFC,JMP,JMF,INF,SUP,EQU,PRI
}type_action;

typedef struct instruction
{
	int num_ligne;
	type_action action;
	int arg [3];

} instruction;

void display_instruction(list_node * node);

void init_list_instruction();

void add_instruction(int num_ligne,type_action action,int arg1,int arg2,int arg3);

void go();

void run_instruction(instruction *i);

void destroy_list_inst();

void print_list_instruction();

list_node *find_instruction(int ligne);



#endif


