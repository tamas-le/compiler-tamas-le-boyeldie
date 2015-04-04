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

	printf("id : %d | Nom du symbole %s | %s\n",test->id,test->nom,chaine);

}

/*void print_symb(symbole *symb){
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

}*/




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

// mettre un element dans la table renvoie 0 si succès -1 sinon
int insert(char * nom,type_state state){

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

	if (name ==NULL || newstate<0 || newstate>3 ){
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


/*int main (){
	init_table();
	insert("toto",NOT_INITIALISED);
	insert("julien",INITIALISED);
	insert("  ",TMP);
	print_tab_symb();
	pop();
	print_tab_symb();



	return 0;

}*/