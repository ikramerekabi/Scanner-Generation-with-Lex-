%{
#include <stdio.h>
%}
digit [0-9]
letter [a-zA-Z]   
keyword (if|while|return|else|int|void)
special_symbol [-+*/<>=;,\(\)\[\]\{\}]

%%

<<EOF>> {
    // Handle actions related to the end of the input
    printf("Reached end of input");
    return 0; // Terminate the lexer
}
.|\n {
    /* Ignore all other characters */
}

{special_symbol} {printf("special_symbol);}
{keyword} {printf("keyword");}
{letter}({letter}|{digit})*([.#$_]?({letter}|{digit})+) {printf("ID");}
{digit}+(\.{digit}+)?([Ee][\+-]?{digit}+)? {printf("NUM");}


  

%%
int main()
{
yyin = fopen("a1_input.cpp", "r");
yylex();
printf(" \n ");
fclose(yyin);
return 0;
}