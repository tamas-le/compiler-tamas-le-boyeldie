
#define NOT_INITIALISED 0
#define CONSTANT 1
#define INITIALISED 2

#include "list/list.h"

#ifndef SYMB
#define SYMB
#endif

typedef struct symbole
{
	int id;
	char * nom;
	int state;

} symbole;

llist * table_des_symboles;

//initialiser la table
void init_table();


//retourne l'adresse pour le nom d'un element, renvoie -1 si l'élément n'existe pas
int get_id_for_name(char * name);


//supprimer un element de la table
int remove_symb(char * nom);

// mettre un element dans la table
int insert(char * nom,int state);

//changer le flag d'un élément
int change_state(int newstate,char * name);

void destroy_table();