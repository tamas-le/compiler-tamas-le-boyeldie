#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "list.h"

/* Creates a list (node) and returns it
 * Arguments: The data the list will contain or NULL to create an empty
 * list/node and a CmpFunc
 */
llist* list_create(int (*CmpFunc)(list_node*,void*),void (*DpyFunc)(list_node*))
{

	llist *l = malloc(sizeof(llist));

	l->CmpFunc = CmpFunc;
	l->DpyFunc = DpyFunc;
	l->node = NULL;
	return l;
}

/* Completely destroys a list
 * Arguments: A pointer to a pointer to a list
 */
void list_destroy(llist *l)
{
	if (l) return;
	while (l->node != NULL) {
		list_pop(l);
	}
	free(l);
}

list_node* list_node_create(void *data)
{
	if (!data) return NULL;
	list_node *node = malloc(sizeof(list_node));
	if (node) {
		node->data = data;
		node->next = NULL;
	}
	return node;
}

void list_node_destroy(list_node *node)
{
	if (node) {
		free(node);
	}
}

/* Creates a list node and inserts it after the specified node
 * Arguments: A node to insert after and the data the new node will contain
 */
list_node* list_insert_after(list_node *node, void *data)
{
	if (!node) return NULL;
	list_node *new_node = list_node_create(data);
	if (new_node) {
		new_node->next = node->next;
		node->next = new_node;
	}
	return new_node;
}

/* Creates a new list node and inserts it in the beginning of the list
 * Arguments: The list the node will be inserted to and the data the node will
 * contain
 */
list_node* list_insert_beginning(llist *l, void *data)
{
	if (!l) return NULL;
	list_node *new_node = list_node_create(data);
	if (new_node) {
		new_node->next = l->node;
		l->node = new_node;
	}
	return new_node;
}

/* Creates a new list node and inserts it at the end of the list
 * Arguments: The list the node will be inserted to and the data the node will
 * contain
 */
list_node* list_insert_end(llist *l, void *data)
{
	list_node *new_node = list_node_create(data);
	if (l->node == NULL){
			l->node = new_node;
	} else {
		if (new_node) {
			list_node *it;
			for(it = l->node; it; it = it->next) {
				if (it->next == NULL) {
					it->next = new_node;
					break;
				}
			}
		}	
	}
	

	return new_node;
}

/* Removes a node from the list
 * Arguments: The list and the node that will be removed
 */
void list_remove(llist *l, list_node *node)
{
	if (!l || !node) return;
	list_node *tmp = l->node;

	while (tmp->next && tmp->next != node) tmp = tmp->next;
	if (tmp->next) {
		tmp->next = node->next;
		list_node_destroy(node);
		node = NULL;
	}
}

/* Find an element in a list by the pointer to the element
 * Arguments: A pointer to a list and a pointer to the node/element
 */
list_node* list_find_node(llist *l, list_node *node)
{
	if (!l) return NULL;
	list_node *it;
	for (it = l->node; it; it = it->next)
		{ if (it == node) return it; }
	return NULL;
}

list_node* list_find_by_data(llist *l, void *data)
{
	if (!l) return NULL;
	list_node *it;
	for (it = l->node; it; it = it->next)
		{ if (l->CmpFunc(it, data) == 0) return it; }
	return NULL;
}

/* Finds a node in a list by the data pointer
 * Arguments: A pointer to a list and a pointer to the data
 */
list_node* list_find_by_data_ptr(llist *l, void *data)
{
	if (!l) return NULL;
	list_node *it;
	for (it = l->node; it; it = it->next)
		{ if (it->data == data) return it; }
	return NULL;
}

void *list_pop(llist *l)
{
	void *data = NULL;
	list_node *tmp_node = NULL;
	if (l) {
		tmp_node = l->node;
		data = tmp_node->data;
		l->node = tmp_node->next;
		list_node_destroy(tmp_node);
	}
	return data;
}

void print_list(llist *l){
	list_node *it;
	if (l->node == NULL){
		printf("La liste est vide\n");
	} else {
		printf("La liste n'est pas vide\n");
		for (it = l->node; it; it = it->next)
		{ 
			l->DpyFunc(it);
			if (it->next==NULL){
				break;
			}
		}

	}
}




// Fonctions de test

typedef struct struct_test
{
	int i;
	int j;
} struct_test;

int compare(list_node * pcellule,void * valeur){
	int * pvaleur=(int *)valeur;

	struct_test * test=(struct_test *)pcellule->data;

	if (test->i==*pvaleur){
		return 0;
	} 
	return 1;
}

void display(list_node * pcellule){
	struct_test * test=(struct_test *)pcellule->data;
	if (pcellule!=NULL){
		printf("i : %d\n",test->i);
		printf("j : %d\n",test->j);
	}
}





// int main(int argc, char const *argv[])
// {
// 	llist * mylist;
// 	struct_test *ptest;
// 	ptest=malloc(sizeof(struct_test));
// 	ptest->i=5;
// 	ptest->j=6;


// 	struct_test *ptest2;
// 	ptest2=malloc(sizeof(struct_test));
// 	ptest2->i=8;
// 	ptest2->j=9;

// 	int nombre = 60;

// 	list_node * plistnode=malloc(sizeof(list_node));
// 	plistnode->next=NULL;
// 	plistnode->data=ptest;



// 	if (compare(plistnode,&nombre)==0){
// 		printf("C'est bon\n");
// 	} else {
// 		printf("Pas égal\n");
// 	}

// 	int (*pFonction)(list_node*,void*);
// 	void (*pFonctionDisplay)(list_node*);
// 	pFonction=compare;
// 	pFonctionDisplay=display;

// 	mylist=list_create(pFonction,pFonctionDisplay);
// 	list_insert_end(mylist,ptest);
// 	print_list(mylist);

// 	list_insert_end(mylist,ptest2);
// 	print_list(mylist);

// 	int k=8;

// 	return 0;
// }

