/* Yacc file to use only with STEP1 LEXDEF.L */
%{
#include <stdio.h>
#include "symboltab.c" 

int yylex(void);
void yyerror(char*);
%}

/*Declarations*/
%token MAIN PRINTF CONST DEF_INT DEF_VOID DEF_BOOL
%token BRACE_STA BRACE_END PARTH_STA PARTH_END
%token MULT DIV EQUAL
%token PLUS MINUS 
%token COMMA SEMI

%union {
	int nb;
	char* str; }
%token <nb> INT
%token <str> VAR_NAME

%token WHILE IF ELSE
%token COND_EQUAL COND_UNEQUAL COND_INF COND_SUP COND_INFEQUAL COND_SUPEQUAL
%token AND OR NOT TRUE FALSE

%start Main

%left NOT
%left AND OR

%left MULT DIV
%left PLUS MINUS

%{
char* type; 
int is_init;
int is_const;
%}

%% /*rules*/

Main:
	Type MAIN PARTH_STA PARTH_END BRACE_STA {depthadd();} Body BRACE_END {depthsub();};

Body:
	|Declaration SEMI Body
	|Expression SEMI Body
	|Assignement SEMI Body
	|Printf SEMI Body
	;

Expression:
	Boolean
	|INT {}
	|VAR_NAME
	|Expression PLUS Expression
{
	int i = suppr_sym_tmp();
	int j =

}
	|Expression MINUS Expression
	|Expression MULT Expression
	|Expression DIV Expression
	|BRACE_STA Expression BRACE_END
	|While
	|If;

While:
	WHILE PARTH_STA Boolean PARTH_END BRACE_STA {depthadd();} Body BRACE_END {depthsub();};

If:
	IF PARTH_STA Boolean PARTH_END BRACE_STA {depthadd();} Body BRACE_END {depthsub();} Else;

Else:
	
	|ELSE If
	|ELSE BRACE_STA {depthadd();} Body BRACE_END {depthsub();};

Boolean:
	TRUE
	|FALSE
	|PARTH_STA Boolean PARTH_END
	|Boolean AND Boolean
	|Boolean OR Boolean
	|NOT Boolean
	|INT COND_EQUAL INT
	|INT COND_UNEQUAL INT
	|INT COND_INF INT
	|INT COND_SUP INT
	|INT COND_INFEQUAL INT
	|INT COND_SUPEQUAL INT;
	
Printf:
	PRINTF PARTH_STA VAR_NAME PARTH_END;

Assignement:
	VAR_NAME EQUAL Expression {is_init=1;};

Declaration:
	Type Const VAR_NAME {is_init=0;} Embedded_assignement Multiple_declaration { add_symb($3, type, is_init,is_const);};

Multiple_declaration:
	COMMA Const VAR_NAME Embedded_assignement Multiple_declaration
	|
	;

Embedded_assignement:	
	EQUAL Expression {is_init=1;};
	|
	;

Const:
	CONST {is_const=1;}
	|	{is_const=0;}
	;

Type:
	DEF_INT {type = "int";}
	|DEF_VOID {type = "void";}
	|DEF_BOOL {type = "bool";}
	;

%% /*programs*/





