%{
    #include <stdio.h>
    #include <symboleTable.h>
    int yylex();
    void yyerror(char* str);
%}
%token tMAIN tINT tEQ  tPO tPF tAO tAF tPV tVR  tPLUS tMOINS tDIV tFOIS  tPRINTF tEGAL tCONST tIF tELSE 

%union{
        int nb; 
        char* str;
}

%token <nb> tNB
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
        tMAIN tPO tPF tAO Body tAF;
Body: 
        /*vide*/
        |Definition Body
        | Affectation Body
        | Fonction Body;

DefinitionConst: 
	tCONST tINT tID DefinitionN tPV { add_symbol ($3,1); }
	| tCONST tINT tID tEGAL Expression tPV { affectation($3,$5) } ;

Definition:
        tINT tID DefinitionN tPV { add_symbol ($2,0); }
        | tINT tID tEGAL Expression tPV { affectation($2,$4) }  ;

DefinitionN:
        /*vide*/
        | tVR tID DefinitionN { add_symbol ($2,0); } ;


Affectation: 
        tID tEGAL Expression tPV { $$=$3; printf(" affectation %d",$$); affectation($1,$3);  }
        
        ;

Expression:
        tID { printf("  id %s",$1); $$= findSymbolById($1); }
	"""|tConst{ int addr=new_temporaire_variable ; $$=$1; }""
        |tNB { $$=$1; printf(" nombre %d",$$);}
        |tPO Expression tPF { $$=$2; printf(" parenthèse %d",$$);  }
        |Expression tPLUS Expression { $$=$1+$3;  printf(" plus %d",$$); 

int addr= new_temp_var(); printf("ADD %d %d %d ", addr ,$1,$3); $$=addr; }
        |Expression tMOINS Expression { $$=$1-$3; printf(" moins %d",$$); }
        |Expression tDIV Expression { $$=$1/$3; printf(" div:%d",$$); }
        |Expression tFOIS Expression { $$=$1*$3; printf(" mul %d",$$); }
        ;

Fonction: 
        tPRINTF tPO tID tPF tPV { $$=$3; printf(" printf %s",$3); }
        ;








%%
void yyerror(char* str){};
int main() {yyparse(); return 0; }
