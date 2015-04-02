#include "../list/list.h"
#include "list_interpreter.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

llist * list;

void display_cellule(list_node * node){
	cellule *c=(cellule *)node->data;
	printf("id : %d | value : %d \n",c->id,c->value );
}

int compare_cellule (list_node * node,void * valeur){
	int * pvaleur=(int *)valeur;
	cellule * test=(cellule *)node->data;
	if (*pvaleur == test->id) 
		return 0;

	return 1;
}

void init_list(){
	void (*pFonctionDisplay)(list_node*);
	int (*pFonctionCompare)(list_node*,void*);
	pFonctionDisplay=display_cellule;
	pFonctionCompare=compare_cellule;
	list=list_create(pFonctionCompare,pFonctionDisplay);
}

int add_to_list(int value,int id){
	cellule *c = malloc (sizeof(cellule));
	c->id=id;
	c->value=value;
	list_insert_beginning(list,c);
	return 0;
}

int update_list(int value, int id){
	cellule *c =get_value(id);
	if (c==NULL){
		add_to_list(value,id);
	} else{
		c->value=value;
	}

	return 0;
}

cellule* get_value(int id){
	cellule * resultat=NULL;
	list_node * node=list_find_by_data(list,(void *)&id);
	if (node!=NULL){
		resultat=(cellule *)node->data;
		return resultat;
	}
	return NULL;
}


void printlist(){
	print_list(list);
}

/*int main(int argc, char const *argv[])
{
	int id=0;
	init_list();
	add_to_list(5,id++);
	add_to_list(6,id++);
	add_to_list(7,id++);
	add_to_list(8,id++);
	add_to_list(9,id++);
	printlist();
	cellule * c=get_value(1);
	printf("id : %d value : %d\n",c->id,c->value);
	update_list(333,2);
	printlist();
	return 0;
}*/

