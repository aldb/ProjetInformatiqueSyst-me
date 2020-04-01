struct Symbol 
{
		char* id ;
		int isConst ;
		int depth ;  

} ;

typedef struct Symbol Symbol;


void initSymbolTab();

void freeSymbolTab();

void suprimer_temp_var();

int new_temp_var();

void add_symbol(char* id, int isConst) ;

int findSymbolById(char* id);

void incrementDepth();

void decrementDepth();

int isSymbolInit(Symbol symbol);

int isSymbolConst(Symbol symbol);
