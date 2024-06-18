%{
#include <stdio.h>
#include "mytool.tab.h"
void yyerror(const char *s); // 添加对 yyerror 的声明
%}

digit   [0-9]+
%%
{digit}                 { yylval.intval = atoi(yytext); return NUMBER; }
"&&"                    { return AND; }
"||"                    { return OR; }
"!"                     { return NOT; }
"=="                    { return EQ; }
"!="                    { return NE; }
"<="                    { return LE; }
">="                    { return GE; }
"<"                     { return LT; }
">"                     { return GT; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
"exit"                  { return EXIT; }
[ \t]+                  ;  /* ignore whitespace */
\n                      { return '\n'; }  /* 处理换行符 */
.                       { yyerror("Invalid character"); return 0; }
%%
int yywrap(void) {
    return 1;
}