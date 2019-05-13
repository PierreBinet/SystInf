comp : y.tab.c lex.yy.c
	gcc -o comp y.tab.c lex.yy.c -ly -ll

y.tab.c : yaccdef.y
	yacc -d -t yaccdef.y

lex.yy.c : lexdef.l
	flex  lexdef.l

test : comp
	./comp < test.c > assembleur
	sed -i '1d' assembleur
	sed -i '$$d' assembleur
	python3 interpreteur.py
	
clean :
	rm lex.yy.c y.tab.c y.tab.h comp assembleur