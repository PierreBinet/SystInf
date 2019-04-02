comp : main.c y.tab.c lex.yy.c
	gcc -o comp main.c y.tab.c lex.yy.c -ly -ll

y.tab.c : yaccdef.y
	yacc -d yaccdef.y

lex.yy.c : lexdef.l
	flex  lexdef.l

test : comp
	./comp < test.c

clean :
	rm lex.yy.c y.tab.c y.tab.h
