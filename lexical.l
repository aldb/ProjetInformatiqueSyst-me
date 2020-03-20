%{
    #include "y.tab.h"
%}

%%
" " {}
"main" return(tMAIN);
"(" return(tPO);
")" return(tPF);
"{" return(tAO);
"}" return(tAF); 
"const" return(tCONST);
"if" return(tIF);
"else" return (tELSE); 
"int" return(tINT);
"+" return(tPLUS); 
"-" return(tMOINS);
"*" return(tFOIS); 
"/" return(tDIV);
"=" return(tEGAL);
";" return(tPV);
"," return(tVR);
"\t" {}
"\n" {}
"printf" return(tPRINTF);
[A-Za-z][A-Za-z0-9_]* { yylval.str=strdup(yytext); return(tID);}
[0-9]+ {yylval.nb=atof(yytext); return(tNB);}
. {printf("erreur");} 


%%



int yywrap(void){return 1; }
