all:
	yacc -d -t -v compiler.y
	flex lexical.l
	@#-d
	gcc lex.yy.c y.tab.c symboleTable.c -o compiler

clean:
	rm -f lex.yy.c y.tab.c y.tab.h compiler
