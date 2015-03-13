#include "../list/list.h"
#include "jump.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

llist * table_des_jump;

void display_jump(list_node * node){
	jump *j=(jump *)node;
	printf("Saut depuis %d vers %d\n", j->from,j->to);
}

void init_table(){
	void (*pFonctionDisplay)(list_node*);
	pFonctionDisplay=display_jump;
	table_des_jump=list_create(NULL,pFonctionDisplay);
}





void init_jump(){

}

int add_jump(int from,int to){
	jump *j = malloc (sizeof(jump));
	j->from=from;
	j->to=to;
	list_insert_beginning(table_des_jump,j);
	return 0;
}


int update_jump(int from, int to){

	return 0;
}

int main(int argc, char const *argv[])
{
	init_table();
	add_jump(1,2);
	add_jump(3,4);
	print_list(table_des_jump);
	return 0;
}