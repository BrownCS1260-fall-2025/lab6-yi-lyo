{
  open Parse

  exception Error of string
}

let digit = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z']
let newline = '\r' | '\n' | "\r\n"

rule token = parse
| [' ' '\t'] (* also ignore newlines, not only whitespace and tabs *)
    { token lexbuf }
| '(' { LPAREN }
| ')' { RPAREN }
| newline { NEWLINE }
| '+'
    { PLUS }
| '*'
    { MUL }
| '/'
    { DIV }
| '-'
    { SUB }
| '^'
    { EXP }
| '='
    { EQ }
| "log"
    { LOG }
| "sin"
    { SIN }
| "cos"
    { COS }
| "tan"
    { TAN }
| "print"
    { PRINT }
| ['0'-'9' '.' 'e' '-']+ as i
    { NUMBER (float_of_string i) }
| (alpha) (alpha|digit|'_')* as var
    { VARNAME var }
| eof
    { EOF }
| _
    { raise (Error (Printf.sprintf "At offset %d: unexpected character.\n" (Lexing.lexeme_start lexbuf))) }
