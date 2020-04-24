%{
    #include <stdio.h>
    #include "symbolTable.h"
    int yylex();
    void yyerror(char* str);
%}
%token tMAIN tINT tEQ  tPO tPF tAO tAF tPV tVR  tPLUS tMOINS tDIV tFOIS  tPRINTF tEGAL tCONST tELSE tSUP tINF 

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
        tMAIN {initSymbolTab();} tPO tPF tAO Body tAF {printAsm(); freeSymbolTab();} ;
Body: 
        /*vide*/
        |Definition Body
        | Affectation Body
        | Fonction Body
	| ifelse Body
	|DefinitionConst Body;

DefinitionConst: 
	 tCONST tINT tID tEGAL Expression tPV { add_symbol($3, 1);int addr= findSymbolById($3); char s[50]; sprintf(s,"COP %d %d ",addr ,$5); insert(s);  suprimer_temp_var(); } ;

Definition:
        tINT tID DefinitionN tPV { add_symbol ($2,0); }
        | tINT tID tEGAL Expression tPV {add_symbol($2, 0) ;int addr= findSymbolById($2); char s[50]; sprintf(s,"COP %d %d ",addr ,$4);insert(s); suprimer_temp_var();}  ;

DefinitionN:
        /*vide*/
        | tVR tID { add_symbol ($2,0); } DefinitionN  ;


Affectation: 
        tID tEGAL Expression tPV {int addr= findSymbolById($1); if (isSymbolConst(addr)==0){ char s[50]; sprintf(s,"COP %d %d ",addr,$3);insert(s); suprimer_temp_var();}}
         
        ;

Expression:
        tID { $$= findSymbolById($1); }
        |tNB { int addr= new_temp_var();char s[50];sprintf(s,"AFC %d %d ", addr,$1); insert(s); $$= addr;}
        |tPO Expression tPF { $$=$2;}
        |Expression tPLUS Expression {int addr= new_temp_var(); char s[50]; sprintf(s,"ADD %d %d %d ", addr ,$1,$3); insert(s); $$=addr; }
        |Expression tMOINS Expression { int addr= new_temp_var(); char s[50]; sprintf(s,"SOU %d %d %d ", addr ,$1,$3);insert(s); $$=addr; }
        |Expression tDIV Expression {int addr= new_temp_var(); char s[50]; sprintf(s,"DIV %d %d %d ",addr ,$1, $3); insert(s) ; $$=addr;}
        |Expression tFOIS Expression {int addr= new_temp_var(); char s[50]; sprintf(s,"MUL %d %d %d ", addr, $1, $3);insert(s); $$=addr; }
	|Expression tEGAL tEGAL Expression{int addr= new_temp_var(); char s[50]; sprintf(s,"EQU %d %d %d ", addr ,$1,$4);insert(s); $$=addr;}
	|Expression tSUP Expression{int addr= new_temp_var(); char s[50]; sprintf(s,"SUP %d %d %d ", addr ,$1,$3); insert(s); $$=addr;}
	|Expression tINF Expression{int addr= new_temp_var(); char s[50]; sprintf(s,"INF %d %d %d ", addr ,$1,$3); insert(s); $$=addr;}
        ;

Fonction: 
        tPRINTF tPO tID tPF tPV {int addr=findSymbolById($3); char s[50]; sprintf(s, "PRI %d",addr); insert(s); }
        ;


ifelse: 
	tIF tPO Expression tPF 
		{	char s[50]; sprintf(s,"JMF %d ",$3);int ligne = insert(s); 
			$1 = ligne;
		}
	
	tAO Body tAF 
		{	int current = get_nb_lignes_asm(); 
			patch($1, current + 2);
			int ligne = insert("JMP ");  
			$1 = ligne;
		}
	tELSE tAO Body tAF
		{	int current = get_nb_lignes_asm();
			patch($1, current + 1);
		}

;












%%
void yyerror(char* str){};
int main() {yyparse(); return 0; }
