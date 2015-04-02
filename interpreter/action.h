
#ifndef ACTION
#define ACTION

typedef enum operator {
		PLUS, MOINS, FOIS, PAR, PP, PG, EG
	}operator;

void op(int adr_resultat,int adr_op1,int adr_op2,operator op);

void pri(int arg);

void copy(int arg1, int arg2);

void afc(int adr,int val);


#endif

