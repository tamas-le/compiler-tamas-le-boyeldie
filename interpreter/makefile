compiler: assemb.lex assemb.yacc
	yacc -d assemb.yacc
	flex assemb.lex
	gcc -c y.tab.c
	gcc -c lex.yy.c
	gcc -c ../list/list.c
	gcc -c list_interpreter.c
	gcc  list.o list_interpreter.o y.tab.o lex.yy.o -ll -o interpreter
	
test: interpreter
	./interpreter < assemb.s

#gcc y.tab.c lex.yy.c -ll -o compiler