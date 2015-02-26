compiler: source.lex source.yacc
	yacc -d source.yacc
	flex source.lex
	gcc y.tab.c lex.yy.c -ll -o compiler
	
test: compiler
	./compiler < test.c