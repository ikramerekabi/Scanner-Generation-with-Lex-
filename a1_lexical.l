%{
#include <stdio.h>
#include <stdbool.h>
int line_num = 1;
int char_num = 0;
bool in_comment = false;
%}

digit [0-9]
letter [a-zA-Z]   
keyword (if|while|return|else|int|void)
special_symbol [-+*/<>=;,\(\)\[\]\{\}]
id {letter}({letter}|{digit})*([.#$_]?({letter}|{digit})+)?
num {digit}+(\.{digit}*)?([Ee][\+-]?{digit}+)?
wrong_id {letter}[.#$_]+[^a-zA-Z0-9]
wrong_num {digit}+[Ee][\+-]?[^0-9]
comment_start "/*"
comment_end "*/" 
any_char .


%%


<<EOF>> {
    if (in_comment) {
        printf("Error on line %d: Unclosed comment\n", line_num);
    }
    printf("Reached end of input\n");
    return 0; // Terminate the lexer
}
{special_symbol} {printf("Special Symbol: %s\n", yytext); char_num += yyleng;} //detects aspecial symbol in the input
{keyword} {printf("Keyword: %s\n", yytext); char_num += yyleng;} //identifies a keyword in the input, it prints out a message indicating the specific keyword
{id} {printf("ID: %s\n", yytext); char_num += yyleng;}
{num} {printf("NUM: %s\n", yytext); char_num += yyleng;}
{wrong_id} {printf("Error on line %d, char %d: Invalid identifier format: %s\n", line_num, char_num, yytext); char_num += yyleng;}
{wrong_num} {printf("Error on line %d, char %d: Invalid number format: %s\n", line_num, char_num, yytext); char_num += yyleng;}
{comment_start} {in_comment = true; char_num += yyleng;}
{comment_end} {in_comment = false; char_num += yyleng;}// these lines helpidentify entered and exited a comment block by using a boolean flag 
\n {line_num++; char_num = 0;}
{any_char} {printf("Error on line %d, char %d: Unexpected character: %s\n", line_num, char_num, yytext); char_num += yyleng;} //aptures and reports any unexpected or invalid character in the input

%%

int main()
{
    yyin = fopen("a1_input.cpp", "r");
    yylex();
    fclose(yyin);
    return 0;
}