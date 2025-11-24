%{ open Ast %}
%token LPAREN
%token RPAREN
%token <float> NUMBER
%token <string> VARNAME
%token PRINT NEWLINE
%token PLUS
%token MUL
%token SUB
%token DIV
%token EXP
%token LOG
%token SIN
%token COS
%token TAN
%token EQ
%token EOF

%start <stmt list> main

%%

main:
| s = stmt NEWLINE rest = main
    { s :: rest }
| s = stmt EOF
  { [s] }
| EOF
  { [] }

stmt:
| PRINT e = expr4
  { Print e }
| n = VARNAME EQ e = expr4
  { Assign (n, e) }


expr4:
| e1 = expr4 PLUS e2 = expr3
  { Plus (e1, e2) }
| e1 = expr4 SUB e2 = expr3
  { Minus (e1, e2) }
| e = expr3 { e }

expr3:
| e1 = expr3 MUL e2 = expr2
  { Times (e1, e2) }
| e1 = expr3 DIV e2 = expr2
  { Divide (e1, e2) }
| e = expr2 { e }

expr2:
| e1 = expr1 EXP e2 = expr2
  { Exp (e1, e2) }
| e = expr1 { e }

expr1:
| LOG e1 = expr0
  { Log e1 }
| SIN e1 = expr0
  { Sin e1 }
| COS e1 = expr0
  { Cos e1 }
| TAN e1 = expr0
  { Tan e1 }
| SUB e = expr0
  { Negate e }
| e = expr0 { e }


expr0:
| n = NUMBER
  { Num n }
| LPAREN e = expr1 RPAREN
  { e }
| s = VARNAME
  { Var s }
