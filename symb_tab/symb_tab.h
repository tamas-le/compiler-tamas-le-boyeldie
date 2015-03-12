
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



//initialiser la table
void init_table();


//retourne l'adresse pour le nom d'un element, renvoie -1 si l'élément n'existe pas
int get_id_for_name(char * name);

symbole * symb_pop();

// mettre un element dans la table
int insert(char * nom,int state);

//changer le flag d'un élément
int change_state(int newstate,char * name);

void destroy_table();

#endif