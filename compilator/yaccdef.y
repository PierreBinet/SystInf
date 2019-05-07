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
	|If Body
	|While Body
	;

Expression:
	INT
{
	int i = insert_symb_tmp(type, is_init, is_const);
	insert_instru("AFC",1,$1,0);
	insert_instru("STORE",get_addr(i),1,0);
}
	|VAR_NAME
{
	int i = insert_symb_tmp(type, is_init, is_const);
	int index = get_index($1, tab[i].depth);
	insert_instru("LOAD", 1, get_addr(index), 0);
	insert_instru("STORE", get_addr(i), 1, 0);
}
	|Expression PLUS Expression
{
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",1,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("ADD",3,1,2);
	int k = insert_symb_tmp("int", is_init, is_const);
	insert_instru("STORE",get_addr(k), 3,0);
}
	|Expression MINUS Expression
{
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",1,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("SOU",3,1,2);
	int k = insert_symb_tmp("int", is_init, is_const);
	insert_instru("STORE",get_addr(k), 3,0);
}
	|Expression MULT Expression
{
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",1,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("MUL",3,1,2);
	int k = insert_symb_tmp("int", is_init, is_const);
	insert_instru("STORE",get_addr(k), 3,0);
}
	|Expression DIV Expression
{
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",1,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("DIV",3,1,2);
	int k = insert_symb_tmp("int", is_init, is_const);
	insert_instru("STORE",get_addr(k), 3,0);
}
	|PARTH_STA Expression PARTH_END
	;

While:
	WHILE PARTH_STA Boolean PARTH_END BRACE_STA {depthadd();} Body BRACE_END {depthsub();};

If:
	IF PARTH_STA Boolean PARTH_END BRACE_STA {depthadd();} Body BRACE_END {depthsub();} Else;

Else:
	|ELSE If
	|ELSE BRACE_STA {depthadd();} Body BRACE_END {depthsub();}
	;

Boolean:
	TRUE
{
	int i = insert_symb_tmp(type, is_init, is_const);
	insert_instru("AFC",1,1,0);
	insert_instru("STORE",get_addr(i),1,0);
}
	|FALSE
{
	int i = insert_symb_tmp(type, is_init, is_const);
	insert_instru("AFC",1,0,0);
	insert_instru("STORE",get_addr(i),1,0);
}
	|PARTH_STA Boolean PARTH_END
	|Boolean AND Boolean
{
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",3,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("MUL",1,2,3);			// false = 0 donc si l'un des deux bools est faux, le produit sera faux
	int k = insert_symb_tmp(type,is_init,is_const);
	insert_instru("STORE",get_addr(k),1,0);
}
	|Boolean OR Boolean
{
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",3,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("ADD",4,2,3);			// Si les deux bools sont faux, la somme sera fausse
	insert_instru("AFC",5,1,0);
	insert_instru("SUPE",1,4,5);		// Si les deux bools sont vrais, la somme sera de 2, donc on teste si elle est >= 1
	int k = insert_symb_tmp(type,is_init,is_const);
	insert_instru("STORE",get_addr(k),1,0);
}
	|NOT Boolean
{
	int i = suppr_sym_tmp();
	insert_instru("LOAD",2,get_addr(i),0);
	insert_instru("AFC",3,0,0);
	insert_instru("EQU",1,2,3);			//R1 prend 1 si la valeur du symbole temporaire est 0, prend 0 sinon
	int j = insert_symb_tmp(type,is_init,is_const);
	insert_instru("STORE",get_addr(j),1,0);
}
	|Expression COND_EQUAL Expression
{
	type = "bool";
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",3,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("EQU",1,2,3);
	int k = insert_symb_tmp(type,is_init,is_const);
	insert_instru("STORE",get_addr(k),1,0);
}
	|Expression COND_UNEQUAL Expression
{
	type = "bool";
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",3,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("EQU",4,2,3);
	insert_instru("AFC",5,0,0);		//Meme traitement que NOT Boolean
	insert_instru("EQU",1,4,5);
	int k = insert_symb_tmp(type,is_init,is_const);
	insert_instru("STORE",get_addr(k),1,0);
}
	|Expression COND_INF Expression
{
	type = "bool";
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",3,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("INF",1,2,3);
	int k = insert_symb_tmp(type,is_init,is_const);
	insert_instru("STORE",get_addr(k),1,0);
}
	|Expression COND_SUP Expression
{
	type = "bool";
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",3,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("SUP",1,2,3);
	int k = insert_symb_tmp(type,is_init,is_const);
	insert_instru("STORE",get_addr(k),1,0);
}
	|Expression COND_INFEQUAL Expression
{
	type = "bool";
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",3,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("INFE",1,2,3);
	int k = insert_symb_tmp(type,is_init,is_const);
	insert_instru("STORE",get_addr(k),1,0);
}
	|Expression COND_SUPEQUAL Expression
{
	type = "bool";
	int i = suppr_sym_tmp();
	int j = suppr_sym_tmp();
	insert_instru("LOAD",3,get_addr(i),0);
	insert_instru("LOAD",2,get_addr(j),0);
	insert_instru("SUPE",1,2,3);
	int k = insert_symb_tmp(type,is_init,is_const);
	insert_instru("STORE",get_addr(k),1,0);
}
	|Expression
{
	type = "bool";
	int i = suppr_sym_tmp();
	insert_instru("LOAD",2,get_addr(i),0);
	insert_instru("AFC",3,0,0);
	insert_instru("EQU",4,2,3);		//On compare l'expression a 0 = true, sinon false
	insert_instru("EQU",1,3,4);		//Puis on inverse ce resultat pour avoir 0 = false, sinon true
	int k = insert_symb_tmp(type,is_init,is_const);
	insert_instru("STORE",get_addr(k),1,0);
}
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
		insert_symb($3, type, is_init,is_const);
	}
} Multiple_declaration;

Multiple_declaration:
	COMMA Const VAR_NAME {name = strdup($3);} Embedded_assignement
{	
	if (is_init==1) {
		int i = suppr_sym_tmp();
		insert_symb($3, type, is_init,is_const);
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
	;

%% /*programs*/

int main() {
	yyparse();
	printf("\n");
	print_tab();
	return 0;
}


