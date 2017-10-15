


%{
#include "ass3_15CS10032.tab.c"
%}

%option noyywrap

digit           [0-9]
nonzerodigit    [1-9]
sign            [+-]
PLUS            [+]
MINUS           [-]
char            [a-zA-Z_]
anychar         (.*)
int             [-]?[1-9][0-9]*


ne [-]
intconst ({ne}?{nonzerodigit}{digit}*)
zero [0]
neg0 ("-0")
digseqe {digit}+
allinteger ({intconst}|{zero})
fracconst (({allinteger}".")|(({allinteger}|{neg0})?"."{digseqe}))
exppart ([eE]{sign}?{digseqe})
float (({fracconst}{exppart}?)|(({allinteger}){exppart}))




zeroconst       [0]+
except          [^'\\\n]
esequence       ("\\'"|"\\\""|"\\?"|"\\\\"|"\\a"|"\\b"|"\\f"|"\\n"|"\\r"|"\\t"|"\\v")
cchar           ({except}|{esequence})
charconst       ("'"({cchar}+)"'")
keyword          ("unsigned"|"break"|"return"|"void"|"case"|"float"|"short"|"char"|"for"|"signed"|"while"|"goto"|"Bool"|"continue"|"if"|"default"|"do"|"int"|"switch"|"double"|"long"|"else"|"Matrix")
                      
idnd            {char}+
id              {char}+({char}|{digit})*
const           ({zeroconst}|{charconst}|{number})
punc            ("["|"]"|"("|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"="|"=="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"|"!")
number          {digit}*(\.{digit}+)?(E[+-]?{digit}+)?
strlit          \"{cchar}+\"
forloop1       ("for")("(")(({id}("=")({int}|{zeroconst}))(";")({id}("<"){int})(";")({id}("++")))")"
forloop2       ("for")("(")(({id}("=")({int}|{zeroconst}))(",")({id}("=")({int}|{zeroconst}))(";"){id}("<")({int}|{zeroconst})(";"){id}("++")","{id}("--"))(")")
while          "while""("({id}("<")({int}|{zeroconst}))(")")
declaration    ({id}"="({int}|{zeroconst})",")*({id}"="({int}|{zeroconst}))
array          {id}"["{id}"]"
ifcondition    "if"("(")(({id}("<")({int}|{zeroconst}))"&&"({id}("<")({int}|{zeroconst})))")"
OR             {id}"++""|""++"{id}
switch         "switch""("{id}")"
matrix          "["(({int}|{zeroconst})","({int}|{zeroconst})","({int}|{zeroconst})";")*({int}|{zeroconst})","({int}|{zeroconst})","({int}|{zeroconst})"]"
increment      {id}"="{id}"+"{int}
WS  	       [ \t\r\v\n\f]
%x SINGLE
%x MULTIPLE

%%







"["  	{return OBS;}
"]"  	{return CBS;}
"("  	{return OBC;}
")"	{return CBC;}
"{"  	{return OBCU;}
"}"  	{return CBCU;}
"."     {return DOT;}
"->"    {return ARROW;}
"++"	{return INC;}
"--"	{return DEC;}
"&"     {return AND;}
"*"	{return MUL;}
"+"	{return PLUS;}
"-"	{return MINUS;}
"!"	{return NEQ;}
"%"	{return PERCENT;}
"<<"	{return LSHIFT;}
">>"	{return RSHIFT;}
"<"	{return LESS;}
">"	{return GREATER;}
"<="	{return LESSE;}
">="	{return GREATERE;}
"=="	{return EQUALITY;}
"!="	{return NOTEQ;}	
"^"	{return POWER;}
"|"	{return OR;}
"&&"	{return ANDAND;}
"||"	{return OROR;}
"?"	{return QUESTION;}
":"	{return COLON;}
";"	{return SCOLON;}
"="	{return EQUAL;}
"*="	{return MULINC;}
"/="	{return DIVINC;}
"%="	{return MODINC;}
"+="	{return PLUSINC;}	
"-="	{return SUBINC;}
"<<="	{return LEFTINC;}
">>="	{return RIGHTINC;}
"&="	{return ANDINC;}
"^="	{return XORINC;}
"|="	{return ORINC;}
","	{return COMMA;}
"#"	{return HASH;}
".'"    {return TPOSE;}
"/"     {return SLASH;}


"unsigned"      {return UNSIGNED;}
"break"	        {return BREAK;}	
"return"	{return RETURN;}	
"void"	        {return VOID;}
"case"	        {return CASE;}
"float"	        {return FLOAT;}
"short"	        {return SHORT;}	
"char"	        {return CHAR;}
"for"	        {return FOR;}
"signed"	 {return SIGNED;}
"while"	         {return WHILE;}
"goto"		 {return GOTO;}
"Bool"		 {return BOOL;}
"continue"       {return CONTINUE;}
"if"		 {return IF;}
"default"        {return DEFAULT;}
"do"		 {return DO;}
"int"		 {return INT;}
"switch"	 {return SWITCH;}	
"double"	 {return DOUBLE;}
"long"		 {return LONG;}
"else"		 {return ELSE;}
"Matrix"	 {return MATRIX;}


{id}    {return ID;}

{strlit}   {return STRLIT;}

{zeroconst} {return ZEROCONST;}

{int}      {return INTEGER;}

{float}    {return FLOATING;}

{charconst} { return CHARCONST;}



{WS}    { /* whitespace separates tokens */ }

"/*" {BEGIN(MULTIPLE);}
                <MULTIPLE>[^\*]*      {;}
                <MULTIPLE>("*"+"/")    {BEGIN(0);}
 "//" {BEGIN(SINGLE);}
                <SINGLE>[^\n]* {;}
                <SINGLE>[\n]  {BEGIN(0);}


. {
printf("Lexer error %s\n",yytext);
}

%%



