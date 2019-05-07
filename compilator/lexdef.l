/* Lexer for C-like grammar*/
%{
	#include "y.tab.h"
%}

%option noyywrap

/*definitions*/

%% /*rules*/  /* [] indique une regex*/

"main" { return MAIN; }
"const" return(CONST);
"printf" return(PRINTF);

"int" { return DEF_INT; }
"void" return(DEF_VOID);
"bool" return(DEF_BOOL);

"while" return(WHILE);
"if" return(IF);
"else" return(ELSE);

"{" return(BRACE_STA);
"}" return(BRACE_END);

"==" return(COND_EQUAL);
"!=" return(COND_UNEQUAL);
"<" return(COND_INF);
">" return(COND_SUP);
"<=" return(COND_INFEQUAL);
">=" return(COND_SUPEQUAL);

"+" return(PLUS);
"-" return(MINUS);
"*" return(MULT);
"/" return(DIV);
"=" return(EQUAL);

"and" return(AND);
"or" return(OR);
"not" return(NOT);
"true" return(TRUE);
"false" return(FALSE);

"(" return(PARTH_STA);
")" return(PARTH_END);

"\n" { } 

[ \t]+$ ; /*en cas de ligne vide*/

[,] return(COMMA);
";" return(SEMI);

[0-9]+ { yylval.nb = atoi(yytext);
		return(INT); }

[a-z][a-zA-Z0-9_]* { yylval.str = strdup(yytext);
		return(VAR_NAME); }

%% /*sub-programs*/
