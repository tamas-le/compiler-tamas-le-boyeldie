#include "../list/list.h"
#include "jump.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

llist * table_des_jump;

void display_jump(list_node * node){
	jump *j=(jump *)node->data;
	printf("Saut depuis %d vers %d\n", j->from,j->to);
}



void init_jump(){
	void (*pFonctionDisplay)(list_node*);
	pFonctionDisplay=display_jump;
	table_des_jump=list_create(NULL,pFonctionDisplay);
}

int add_jump(int from,int to){
	jump *j = malloc (sizeof(jump));
	j->from=from;
	j->to=to;
	list_insert_beginning(table_des_jump,j);
	return 0;
}


int update_jump(int from, int to){
	list_node *noeud=table_des_jump->node;
	jump *j=(jump *)noeud->data;
	if (from !=-1){
		j->from=from;
	}
	if (to!=-1){
		j->to=to;
	}
	return 0;
}

jump * jump_pop(){
	return (jump *)list_pop(table_des_jump);
}


void print_jump(){
	print_list(table_des_jump);
}

void destroy_jump_table(){
	list_destroy(table_des_jump);
}

/*int main(int argc, char const *argv[])
{
	init_jump();
	add_jump(1,2);
	add_jump(3,4);
	add_jump(5,6);
	add_jump(7,8);
	print_list(table_des_jump);
	update_jump(-1,10);
	print_list(table_des_jump);
	return 0;
}*/