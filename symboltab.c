#include <stdio.h>
#include <string.h> 

#define SIZE 16

typedef struct {
	char* id;
	char* type;
	int depth;
	int is_init;
	int is_const;
	int mem_addr;
}symb;

symb tab[SIZE];
int tab_index =0;
int depth =0;


void depthadd() {
	depth++;
}


void depthsub() {
	depth--;
}


int insert_symb(char * id, char * type, int is_init, int is_const) {
	int index_copy = tab_index;
	while((index_copy >= 0)&&(tab[index_copy].depth == depth)) {
		if((strcmp(tab[index_copy].id,id)==0)){
			return; //si une variable de meme id et meme profondeur est deja dans le tableau alors on n'insert rien
		}
		index_copy--;
	}
	char* id_dup = strdup(id);
	char* type_dup = strdup(type);
	tab[tab_index].id = id_dup;
	tab[tab_index].type = type_dup;
	tab[tab_index].depth = depth;
	tab[tab_index].is_init = is_init;
	tab[tab_index].is_const = is_const;
	tab[tab_index].mem_addr = &tab[tab_index];
}


int insert_sym_tmp(char * id, char * type, int is_init, int is_const) {
	if (tab_index >= SIZE) {
		return;
	} else {
		char* id_dup = strdup(id);
		char* type_dup = strdup(type);
		tab[tab_index].id = id_dup;
		tab[tab_index].type = type_dup;
		tab[tab_index].depth = depth;
		tab[tab_index].is_init = is_init;
		tab[tab_index].is_const = is_const;
		tab[tab_index].mem_addr = &tab[tab_index];
		tab_index++;
		return tab_index-1;
	}
}


int suppr_sym_tmp() {
	tab_index--;
	return tab[tab_index+1].mem_addr;
}


int get_addr(int index) {
	if (index >= SIZE) {
		return;
	} else {
		return tab[tab_index].mem_addr;
	}
}


void print_symb(char * id) {
	int i;
	for (i=0;i<SIZE;i++) {
		if ((tab[i].id != NULL)&&(strcmp(tab[i].id, id)==0)) {
			printf("id       = %s\n", tab[i].id);
			printf("type 	 = %s\n", tab[i].type);
			printf("depth 	 = %d\n", tab[i].depth);
			printf("is_init  = %d\n", tab[i].is_init);
			printf("is_const = %d\n", tab[i].is_const);
		}
	}
}

/*
int main(void) {
	add_symb("a", "int", 1, 0);
	print_symb("a");

	return 0;
}
*/






