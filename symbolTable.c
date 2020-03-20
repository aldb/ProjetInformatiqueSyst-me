#include "symboleTable.h"



Symbol* symbolTab;;
int currentIndex = 0;
int currentDepth = 0;


void initSymbolTab()
{
	symbolTab = malloc(100 * sizeof(Symbol));
}


void freeSymbolTab()
{
	free(symbolTab);
}


void addSymbol(char* id, int isConst) 
{
    Symbol newSymbol = { id, isConst, currentIndex * 4, currentDepth, 0 };
	symbolTab[currentIndex] = newSymbol;
	currentIndex++;
}


int findSymbolById(char* id)
{
	for(int i = currentIndex - 1; i >= 0; i--)
	{
		if(symbolTab[i].id == id)
		{
			return symbolTab[i].addr; // = i
		}
	}
}


void incrementDepth()
{
	currentDepth++;
}


void decrementDepth()
{
	// supprimer tous les symboles de cette profodeur

	currentDepth--;
}


int isSymbolInit(Symbol symbol)
{
	return symbol.isInit;
}


int isSymbolConst(Symbol symbol)
{
	return symbol.isConst;
}




