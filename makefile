compiler: source.lex source.yacc list/list.c symb_tab/symb_tab.c symb_tab/symb_tab.h ass_file/file_ass.c jumper/jump.c
	yacc -d source.yacc
	flex source.lex
	gcc -c list/list.c
	gcc -c symb_tab/symb_tab.c
	gcc -c jumper/jump.c
	gcc -c ass_file/file_ass.c
	gcc -c list_fonction/list_fonction.c
	gcc -c y.tab.c -ll -ly
	gcc -c lex.yy.c
	gcc list.o symb_tab.o list_fonction.o jump.o y.tab.o lex.yy.o file_ass.o -ll -ly -o compiler
	
test: compiler
	./compiler < test.c


