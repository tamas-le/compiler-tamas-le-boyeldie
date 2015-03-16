
#define NOT_INITIALISED 0
#define CONSTANT 1
#define INITIALISED 2
#define TMP 3

#include "../list/list.h"

#ifndef SYMB
#define SYMB


typedef struct symbole
{
	int id;
	char * nom;
	int state;

} symbole;

int compare_symb (list_node * node,void * valeur);

void display_symb(list_node * node);

void print_symb(symbole *symb);




void init_table();

symbole *get_symbole(char *name);



//retourne l'adresse pour le nom d'un element, renvoie -1 si l'élément n'existe pas
int get_id_for_name(char * name);




symbole* symb_pop();


int insert(char * nom,int state);


int change_state(int newstate,char * name);

int get_state(char *name);

void print_tab_symb();

void destroy_table();


#endif