%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

int comparisons = 0;
int short_circuits = 0;
%}

%union {
    int intval;
    int boolval;
}

%token <intval> NUMBER
%token AND OR NOT EQ NE LT GT LE GE LPAREN RPAREN EXIT
%left OR
%left AND
%right NOT
%left EQ NE LT GT LE GE
%left LPAREN RPAREN
%type <boolval> expression boolean_expression comparison_expression

%%

input:
    /* empty */
    | input line
    | input EXIT '\n' { exit(0); }
    ;

line:
    expression '\n' { printf("Output: %s, %d, %d\n", $1>0 ? "TRUE" : "FALSE", comparisons, short_circuits); comparisons = 0; short_circuits = 0; }
    | '\n'
    ;

expression:
    boolean_expression { $$ = $1;}
    ;

boolean_expression:
    boolean_expression OR boolean_expression { 
        if($1>=1){
            if($3>=1) 
                {$$ = $1%1000+$3%1000;
                 $$ += ($1/1000+$3%1000)*1000;}
            else 
                {$$ = $1%1000-$3%1000; 
                 $$ += ($1/1000-$3%1000)*1000; }
            
        }
        else{
            if($3>=1) 
                {$$ = -$1%1000+$3%1000;
                 $$ += (-$1/1000+$3/1000)*1000;}
            else 
                {$$ = $1%1000+$3%1000;
                 $$ += ($1/1000+$3/1000)*1000;}
            
        } 
        short_circuits = $$>0?$$/1000:-$$/1000;
        comparisons = $$>0?$$%1000:-$$%1000;
    }
    |boolean_expression AND boolean_expression { 
        if($1>=1){
            if($3>=1) 
                {$$ = $1%1000+$3%1000;
                 $$ += ($1/1000+$3/1000)*1000;}
            else 
                {$$ = -$1%1000+$3%1000;
                 $$ += (-$1/1000+$3/1000)*1000;}
        }
        else{
            if($3>=1) 
                {$$ = $1%1000-$3%1000;
                 $$ += ($1/1000-$3%1000)*1000;}
            else 
                {$$ = $1+$3;
                 $$ += ($1/1000+$3%1000)*1000;}
        }
        short_circuits = $$>0?$$/1000:-$$/1000;
        comparisons = $$>0?$$%1000:-$$%1000;
    }
    | NOT boolean_expression { $$ = -$2;   short_circuits = $$>0?$$/1000:-$$/1000;
        comparisons = $$>0?$$%1000:-$$%1000;}
    | LPAREN boolean_expression RPAREN { $$ = $2;   short_circuits = $$>0?$$/1000:-$$/1000;
        comparisons = $$>0?$$%1000:-$$%1000;}
    | comparison_expression
    ;

comparison_expression:
    NUMBER EQ NUMBER { $$ = $1 == $3? 1:-1; comparisons += 1; }
    | NUMBER NE NUMBER { $$ = $1 != $3? 1:-1; comparisons += 1; }
    | NUMBER LT NUMBER { $$ = $1 < $3? 1:-1; comparisons += 1; }
    | NUMBER GT NUMBER { $$ = $1 > $3? 1:-1; comparisons += 1; }
    | NUMBER LE NUMBER { $$ = $1 <= $3? 1:-1; comparisons += 1; }
    | NUMBER GE NUMBER { $$ = $1 >= $3? 1:-1; comparisons += 1; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Please enter an expression:\n");
    yyparse();
    return 0;
}
