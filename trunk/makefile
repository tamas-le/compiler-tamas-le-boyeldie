compiler: source.lex source.yacc list/list.c symb_tab/symb_tab.c symb_tab/symb_tab.h ass_file/file_ass.c jumper/jump.c
	yacc -d source.yacc
	flex source.lex
	gcc -c list/list.c
	gcc -c symb_tab/symb_tab.c
	gcc -c jumper/jump.c
	gcc -c y.tab.c
	gcc -c ass_file/file_ass.c
	gcc -c lex.yy.c
	gcc list.o symb_tab.o jump.o y.tab.o lex.yy.o file_ass.o -ll -o compiler
	
test: compiler
	./compiler < test.c

#gcc y.tab.c lex.yy.c -ll -o compiler