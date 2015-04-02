
#include "../list/list.h"

#ifndef JUMP
#define JUMP

typedef struct jump
{
	int from;
	int to;
} jump;

void display_jump(list_node * node);


void init_jump();

int add_jump(int from,int to);


int update_jump(int from, int to);

jump * jump_pop();


void print_jump();
void destroy_jump_table();

#endif