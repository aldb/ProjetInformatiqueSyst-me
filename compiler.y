%{
    #include <stdio.h>
    #include "symbolTable.h"
    int yylex();
    void yyerror(char* str);
%}
%token tMAIN tINT tEQ  tPO tPF tAO tAF tPV tVR  tPLUS tMOINS tDIV tFOIS  tPRINTF tEGAL tCONST tIF tELSE 

%union{
        int nb; 
        char* str;
}

%token <nb> tNB tIF
%token <str> tID
%type <nb> Expression Affectation
%type <str> Fonction


%left tPLUS tMOINS 
%left tFOIS tDIV
%right tEQ

%%


%start File;
File:
        Main; 
Main:
        tMAIN {initSymbolTab();} tPO tPF tAO Body tAF {freeSymbolTab();} ;
Body: 
        /*vide*/
        |Definition Body
        | Affectation Body
        | Fonction Body;

DefinitionConst: 
	tCONST tINT tID DefinitionNC tPV { add_symbol ($3,1); }
	| tCONST tINT tID tEGAL Expression tPV { addSymbol($3, 1),int addr= findSymbolById($3); printf("COP %d %d ",addr ,$5); suprimer_temp_var(); } ;

Definition:
        tINT tID DefinitionN tPV { add_symbol ($2,0); }
        | tINT tID tEGAL Expression tPV {add_symbol($2, 0) ;int addr= findSymbolById($2); printf("COP %d %d ",addr ,$4); suprimer_temp_var();}  ;

DefinitionN:
        /*vide*/
        | tVR tID { add_symbol ($2,0); } DefinitionN  ;

DefinitionNC:
        /*vide*/
        | tVR tID DefinitionNC { add_symbol ($2,1); } ;

Affectation: 
        tID tEGAL Expression tPV {int addr= findSymbolById($1); printf("COP %d %d ",addr,$3); suprimer_temp_var();}
         
        ;

Expression:
        tID { $$= findSymbolById($1); }
        |tNB { int addr= new_temp_var();printf("AFC %d %d ", addr,$1); $$= addr;}
        |tPO Expression tPF { $$=$2;}
        |Expression tPLUS Expression {int addr= new_temp_var(); printf("ADD %d %d %d ", addr ,$1,$3); $$=addr; }
        |Expression tMOINS Expression { int addr= new_temp_var(); printf("SOU %d %d %d ", addr ,$1,$3); $$=addr; }
        |Expression tDIV Expression {int addr= new_temp_var(); printf("DIV %d %d %d ", addr ,$1,$3); $$=addr;}
        |Expression tFOIS Expression {int addr= new_temp_var(); printf("MUL %d %d %d ", addr ,$1,$3); $$=addr; }
        ;

Fonction: 
        tPRINTF tPO tID tPF tPV {int addr=findSymbolById($3); printf("PRI %d",addr); }
        ;

if: 
	tIF tPO Expression tPf tAO Body tAF

	;
ifelse: 
	tIF tPO Expression tPf 
		{	fprintf(f, « JMPF ???\n ») ;
			int ligne = get_nb_lignes_asm() ; // ligne == L2
			$1 = ligne ;
		}	
	
	tAO Body tAF 
		{	int current = get_nb_lignes_asm() ; // current == 4
			patch($1, current + 2) ;
			int ligne = insert(JMP) ; // ligne == L5
			$1 = ligne ;
		}

	tELSE tAO Body tAF
		{	int current = get_nb_lignes_asm() ; // current == 6
			patch($1, current + 1) ;
		}

	;	

void patch(int from, int to) {
	/* Mémorisation pour patcher apres la compilation. */
	labels[from] = to ;
}








%%
void yyerror(char* str){};
int main() {yyparse(); return 0; }
