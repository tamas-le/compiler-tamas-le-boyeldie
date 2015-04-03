#include "../../list/list.h"

#ifndef INTERP
#define INTERP

typedef struct cellule
{
	int id;
	int value;
} cellule;

void display_cellule(list_node * node);
int compare_cellule (list_node * node,void * valeur);

void init_list();

int add_to_list(int value,int id);

int update_list(int value, int id);

cellule * get_value(int id);

void printlist();

void destroylist();

#endif


