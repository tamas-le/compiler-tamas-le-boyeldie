
#include "../list/list.h"

#ifndef JUMP
#define JUMP

typedef struct jump
{
	int from;
	int to;
} jump;

void init_jump();


int add_jump(int from,int to);


int update_jump(int from, int to);

#endif