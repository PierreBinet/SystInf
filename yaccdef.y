/* Yacc file to use only with STEP1 LEXDEF.L */
%{
#include <stdio.h>
#include "symboltab.c"
#include "tab_inst.c" 

int yylex(void);
void yyerror(char*);

int yydebug = 1;
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
//global variables
char* type; 
int is_init;
int is_const;
int index_last_sym_inserted;
char* name;
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
	//Boolean
	INT
{
	index_last_sym_inserted = insert_symb_tmp(type, is_init, is_const);
}
	|VAR_NAME
	|Expression PLUS Expression
{
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",1,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("ADD",3,1,2);
	int k = insert_symb_tmp("int", is_init, is_const);
	insert_instru("STORE", get_addr(k), 3,0); //Attention a STORE - comment renvoyer l'entier?
}
	|Expression MINUS Expression
{
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",1,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("SOU",3,1,2);
	int k = insert_symb_tmp("int", is_init, is_const);
	insert_instru("STORE", get_addr(k), 3,0); //Attention a STORE - comment renvoyer l'entier?
}
	|Expression MULT Expression
{
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",1,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("MUL",3,1,2);
	int k = insert_symb_tmp("int", is_init, is_const);
	insert_instru("STORE", get_addr(k), 3,0); //Attention a STORE - comment renvoyer l'entier?
}
	|Expression DIV Expression
{
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",1,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("DIV",3,1,2);
	int k = insert_symb_tmp("int", is_init, is_const);
	insert_instru("STORE", get_addr(k), 3,0); //Attention a STORE - comment renvoyer l'entier?
}
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
	|Expression COND_EQUAL Expression
	|Expression COND_UNEQUAL Expression
	|Expression COND_INF Expression
	|Expression COND_SUP Expression
	|Expression COND_INFEQUAL Expression
	|Expression COND_SUPEQUAL Expression
	;
	
Printf:
	PRINTF PARTH_STA VAR_NAME PARTH_END;

Assignement:
	VAR_NAME EQUAL Expression
{
	is_init=1;
	int i = suppr_sym_tmp();
	int index = get_index($1,tab[i].depth);
	insert_instru("LOAD",1,get_addr(i),0);
	insert_instru("STORE",get_addr(index),1,0);
};

Declaration:
	Type Const VAR_NAME {is_init=0;} Embedded_assignement
{
	if (is_init==1) {
		int i = suppr_sym_tmp();
		insert_symb($3, type, is_init, is_const);
		insert_instru("LOAD",1,get_addr(i),0);
	}
} Multiple_declaration;

Multiple_declaration:
	COMMA Const VAR_NAME {name = strdup($3);} Embedded_assignement
{	
	if (is_init==1) {
		int i = suppr_sym_tmp();
		insert_symb($3, type, is_init,is_const);
		insert_instru("LOAD",1,get_addr(i),0);
	}
} Multiple_declaration
	|
	;

Embedded_assignement:	
	EQUAL Expression {is_init=1;}
	|				 {is_init=0;}
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

int main() {
	yyparse();
	printf("\n");
	print_tab();
	return 0;
}


