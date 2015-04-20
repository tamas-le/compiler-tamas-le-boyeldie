#include "../list/list.h"
#include "symb_tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

llist * table_des_symboles;

int id_courant =0;
int nb_tmp=0;

int compare_symb (list_node * node,void * valeur){
	char * pvaleur=(char *)valeur;
	symbole * test=(symbole *)node->data;

	return strcmp(test->nom,pvaleur);
	
}

void display_symb(list_node * node){
	symbole * test=(symbole *)node->data;
	char * chaine =malloc(sizeof(char)*30);
	switch (test->state){
		case NOT_INITIALISED:
		chaine="Variable non initialisée";
		break; 
		case CONSTANT:
		chaine="Constante";
		break;
		case INITIALISED:
		chaine="Variable initialisée";
		break;
		case TMP:
		chaine="Variable temporaire";
		break;
		case FUNCTION:
		chaine="Nom de Fonction";
		break;
	}

	if (test->fonction==NULL){
		printf("id : %d | Nom du symbole %s | %s | %s\n",test->id,test->nom,chaine,"Pas de fonction.");
	} else {
		printf("id : %d | Nom du symbole %s | %s | %s\n",test->id,test->nom,chaine,test->fonction);
	}

	

}

void print_symb(symbole *symb){
	printf("----------------------------------------\n");
	printf("Nom du symbole %s \n",symb->nom);
	printf("id : %d\n",symb->id );
	switch (symb->state){
		case NOT_INITIALISED:
		printf("Variable non initialisée\n");
		break; 
		case CONSTANT:
		printf("Constante\n");
		break;
		case INITIALISED:
		printf("Variable initialisée\n");
		break;
		case TMP:
		printf("Variable temporaire\n");
		break;
		case FUNCTION:
		printf("Fonction\n");
		break;
	}
	printf("----------------------------------------\n");

}




void init_table(){
	int (*pFonctionCompare)(list_node*,void*);
	void (*pFonctionDisplay)(list_node*);
	pFonctionCompare=compare_symb;
	pFonctionDisplay=display_symb;
	table_des_symboles=list_create(pFonctionCompare,pFonctionDisplay);
}

symbole *get_symbole(char *name){
	symbole * resultat=NULL;
	list_node * node_finded = list_find_by_data(table_des_symboles,name);
	if (node_finded != NULL){
		resultat=(symbole *)node_finded->data;
	}
	
	return resultat;
}



//retourne l'adresse pour le nom d'un element, renvoie -1 si l'élément n'existe pas
int get_id_for_name(char * name){
	symbole * symb=get_symbole(name);
	if (symb != NULL){
		return symb->id;
	}
	return -1;
}




symbole* symb_pop(){
	symbole * symb=(symbole *)list_pop(table_des_symboles);
	id_courant--;
	return symb;
}

// mettre un element dans la table renvoie son id si succès -1 sinon
int insert(char * nom,type_state state,char * nom_fonction){

	if (nom ==NULL){
		return -1;
	}

	if (state ==TMP){
		nb_tmp++;
		nom = malloc(sizeof(char)*50);
		sprintf(nom,"tmp_%d",nb_tmp);
	}



	if (get_id_for_name(nom)==-1){
		id_courant++;
		symbole *new_symb=malloc(sizeof(symbole));

		new_symb->nom=nom;
		strcpy(new_symb->fonction,nom_fonction);
		new_symb->id =id_courant;
		new_symb->state=state;
		list_insert_beginning(table_des_symboles,new_symb);
	} else {
		return -1;
	}

	return id_courant;
}

//changer le flag d'un élément
int change_state(type_state newstate,char * name){

	if (name ==NULL){
		return -1;
	}
	symbole * symb_to_change=get_symbole(name);
	if (symb_to_change==NULL){
		return -1;
	}
	symb_to_change->state=newstate;


	return 0;

}

int get_state(char *name){
	symbole * symb=get_symbole(name);

	if (symb!=NULL){
		return symb->state; 
	}
	return -1;
}

void print_tab_symb(){
	print_list(table_des_symboles);
}

void destroy_table(){
	list_destroy(table_des_symboles);
}

int smart_insert(char * nom,type_state state,char * nom_fonction){

	if (nom ==NULL){
		return -1;
	}

	if (state ==TMP){
		// Les symboles temporaires on les insère sans vérifier.
		nb_tmp++;
		nom = malloc(sizeof(char)*50);
		sprintf(nom,"tmp_%d",nb_tmp);
		id_courant++;
		symbole *new_symb=malloc(sizeof(symbole));
		new_symb->nom=nom;
		new_symb->fonction=nom_fonction;
		new_symb->id =id_courant;
		new_symb->state=state;
		list_insert_beginning(table_des_symboles,new_symb);
		return id_courant;
	} else {
		if (smart_get(nom,nom_fonction)==-1){
			printf("Existe pas :)\n");
			//Si le symbole n'existe pas déja !
			id_courant++;
			symbole *new_symb=malloc(sizeof(symbole));
			new_symb->nom=nom;
			new_symb->fonction=nom_fonction;
			new_symb->id =id_courant;
			new_symb->state=state;
			list_insert_beginning(table_des_symboles,new_symb);
			return id_courant;
		} else {
			printf("Existe :(\n");
			return -1;
		}
	}

	return -1;
}

int smart_get(char * nom,char * nom_fonction){
	

	symbole *symbole_courant;
	list_node* aux = table_des_symboles->node;
	while(aux !=NULL){
		symbole_courant=(symbole *)aux->data;
		if (strcmp(symbole_courant->nom,nom)==0 && strcmp(symbole_courant->fonction,nom_fonction)==0){
			return symbole_courant->id;
		}
		aux=aux->next;
	}
	return -1;
}

void reset_index(){
	id_courant=0;
}


/*int main (){
	init_table();
	smart_insert("javier",NOT_INITIALISED,"test1");
	smart_insert("javier",NOT_INITIALISED,"test2");
	smart_insert("javier",NOT_INITIALISED,"test1");
	smart_insert("julien",NOT_INITIALISED,"test1");

	print_tab_symb();
	

	printf("-----------------/----------------\n");



	return 0;

}*/