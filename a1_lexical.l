%{
#include <stdio.h>
%}
digit [0-9]
letter [a-zA-Z]   


%%
{letter}({letter}|{digit})*([.#$_]?({letter}|{digit})+) {printf("ID");}
{digit}+|{digit}+([.]{digit}*)?([Ee][+-]?{digit}+) {printf("NUM");}
    
%%
int main()
{
yyin = fopen("a1_input.cpp", "r");
yylex();
printf(" \n ");
return 0;
}