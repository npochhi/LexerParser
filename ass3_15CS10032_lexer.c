
#include "lex.yy.c"
extern char* yytext;

int main() {
	//FILE *myfile = fopen("x.txt", "r");
	
        int token;
	//yylex();
        int PUNCTUATOR[] = {OBS,CBS,OBC,CBC,OBCU,CBCU,DOT,ARROW,INC,DEC,AND,MUL,PLUS,MINUS,OBS,NEQ,PERCENT,LSHIFT,RSHIFT,LESS,GREATER,LESSE,GREATERE,EQUALITY,NOTEQ,POWER,OR,ANDAND,OROR,QUESTION,COLON,
SCOLON,EQUAL,MULINC,DIVINC,MODINC,PLUSINC,SUBINC,LEFTINC,RIGHTINC,ANDINC,XORINC,ORINC,COMMA,HASH,TPOSE};
       int KEYWORD[] = {UNSIGNED,BREAK,RETURN,VOID,CASE,FLOAT,SHORT,CHAR,FOR,SIGNED,WHILE,GOTO,BOOL,CONTINUE,IF,DEFAULT,DO,INT,SWITCH,DOUBLE,LONG,ELSE,MATRIX};        



        while(token=yylex())
       {
            if (token == FLOATING)
              printf("<FLOATINGCONSTANT, %s>", yytext);
            if (token == INTEGER)
              printf("<INTEGERCONSTANT, %s>", yytext);
            if (token ==CHARCONST)
      	      printf("<CHARACTERCONSTANT, %s>", yytext);           
            
            if (token ==  ZEROCONST)
              printf("<ZERO CONSTANT, %s>", yytext);
            if (token == STRLIT)
              printf("<STRING LITERAL, %s>", yytext);
            if (token == ID)
              printf("<IDENTIFIER, %s>", yytext);
            for (int i = 0; i < sizeof(KEYWORD) / sizeof(KEYWORD[0]); i++){
                 if (token == KEYWORD[i])
                     printf("<KEYWORD, %s>", yytext);
               }

           for (int i = 0; i < sizeof(PUNCTUATOR) / sizeof(PUNCTUATOR[0]); i++){
                if (token == PUNCTUATOR[i])
                  printf("<PUNCTUATOR, %s>", yytext);
         }
         printf("\n");	
       }
	return 0;
}
