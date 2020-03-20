
struct{
		char* id ;
		int constant ;
		int type ;
		int add  ; 
		int depht ;
		int instancie;   

} Symbol ;

struct Symbol tab_symbol [100] ;
int curent_index=0; 

void add_symbol (char* id, int constant, char* type, int add, int depht ) 
{
    Symbole newSymbol={id,constant,type,add,depht,0}
	tab_symbol[curent_index]= newSymbol;
	curent_index ++; 
}

int find_symbol (char* id, int depht) 
{
	for(i=0; i<curent_index; i++)
	{
		if(tab_symbol[i].id == id && tab_symbol[i].depth == depth)
		{
			return tab_symbol[i].add; 
		}
	}
}

int get_instancie

void set_instancie


int get_const

void set_const


