#include <stdio.h>

#define SIZE 256

typedef struct {
	char* inst_name;
	int val1;
	int val2;
	int val3;
	int mem_addr;
} instru;

instru tab_instru[SIZE];
int memory = 0;

int insert_instru(char * inst_name, int val_1, int val_2, int val_3) {
	int i=0;
	int inserted=0;
	while(i<SIZE && inserted==0) {
		if(tab_instru[i].inst_name != NULL) {
			i++;
		} else {
			tab_instru[i].inst_name=strdup(inst_name);
			tab_instru[i].val1=val_1;
			tab_instru[i].val2=val_2;
			tab_instru[i].val3=val_3;
			tab_instru[i].mem_addr=memory;
			inserted = 1;
			memory++;
			return memory-1;
		}
	}
}

void print_tab()
{
	int i=0;
	while(tab_instru[i].inst_name != NULL) {
		printf("%s %d %d %d ; Address: %d\n", tab_instru[i].inst_name, tab_instru[i].val1, tab_instru[i].val2, tab_instru[i].val3, tab_instru[i].mem_addr);
		i++;
	}
	printf("\n");
}

int fix_jmp(int addr_find, int addr_fix){
	int i = 0;
	while(addr_find != tab_instru[i].mem_addr && i<SIZE){
		i++;
	}
	if (i==SIZE) return 1;
	tab_instru[i].val1 = addr_fix;
	return 0;
}

int get_current_mem_addr(){
	return memory;
}