
ass3_15CS10032_parser.out : ass3_15CS10032_parser.c ass3_15CS10032_lexer.out 
	gcc ./ass3_15CS10032_parser.c -o ./ass3_15CS10032_parser.out

ass3_15CS10032_lexer.out : ass3_15CS10032_lexer.c lex.yy.c
	gcc ./ass3_15CS10032_lexer.c -o ./ass3_15CS10032_lexer.out

lex.yy.c : ass3_15CS10032.l ass3_15CS10032.tab.c
	flex ./ass3_15CS10032.l

ass3_15CS10032.tab.c : ass3_15CS10032.y
	bison ./ass3_15CS10032.y 


