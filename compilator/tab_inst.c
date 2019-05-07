#include <stdio.h>

#define SIZE 256

typedef struct {
	char* inst_name;
	int val1;
	int val2;
	int val3;
} instru;

instru tab_instru[SIZE];

void insert_instru(char * inst_name, int val_1, int val_2, int val_3) {
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
			inserted = 1;
		}
	}
}

void print_tab()
{
	int i=0;
	while(tab_instru[i].inst_name != NULL) {
		printf("%d: %s %d %d %d\n", i+1, tab_instru[i].inst_name, tab_instru[i].val1, tab_instru[i].val2, tab_instru[i].val3);
		i++;
	}
	printf("\n");
}
