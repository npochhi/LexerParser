#include "lex.yy.c"
int main(int argc ,char *argv[]){
  int parser_out;
  while((parser_out = yyparse())){
    if(parser_out < 0)break;
  };
  return 0;
}
