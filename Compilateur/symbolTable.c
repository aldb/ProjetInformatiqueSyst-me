#include "symbolTable.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stddef.h>


Symbol* symbolTab;
int currentIndex = 0;
int currentTempIndex = 100;
int currentDepth = 0;

int asmLine=0;

char* asmTab[100]; 

void printAsm(){
	for(int i=0; i<asmLine; i++)
	{
		printf("%s \n", asmTab[i]);
	}
}

void patch(int from, int to) {
	char s[50];
	sprintf(s,"%d",to);
	asmTab[from]= strcat(asmTab[from],s);
}

int insert(char* instruction){
	
	asmTab[asmLine]=strdup(instruction);
	asmLine++;
	return asmLine-1;
}

int get_nb_lignes_asm()
{
	return asmLine; 
}


void initSymbolTab()
{
	symbolTab = malloc(103 * sizeof(Symbol));
	
}


void freeSymbolTab()
{
	free(symbolTab);
	
}

void suprimer_temp_var()
{
	currentTempIndex = 100;
}

int new_temp_var()
{

    return currentTempIndex++ ;
    

}

void add_symbol(char* id, int isConst) 
{
   	Symbol newSymbol = { id, isConst, currentDepth};
	symbolTab[currentIndex] = newSymbol;
	
	currentIndex++;
}


int findSymbolById(char* id)
{
	for(int i = currentIndex - 1; i >= 0; i--)
	{
		if(strcmp(symbolTab[i].id, id)==0)
		{
			return i; // = i
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



int isSymbolConst(int addr)
{
	return symbolTab[addr].isConst;
	
}




