compiler: assemb.lex assemb.yacc
	yacc -d source.yacc
	flex source.lex
	gcc -c y.tab.c
	gcc -c lex.yy.c
	gcc  y.tab.o lex.yy.o -ll -o compiler
	
test: compiler
	./compiler < assemb.s

#gcc y.tab.c lex.yy.c -ll -o compiler