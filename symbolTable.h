

typedef struct Symbol
{
	char* id;
	int isConst;
	int addr; // Que des integers : addr = index * 4
	int depth;
	int isInit;
} Symbol;