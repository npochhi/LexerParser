%{
int yyerror (char *);
extern int yylex (void);
%}



%token ELSE
%token SWITCH
%token IF
%token CONTINUE
%token FOR
%token CASE
%token WHILE
%token BREAK
%token GOTO
%token DEFAULT
%token DO	
%token FLOAT
%token SIGNED
%token BOOL
%token INT
%token LONG
%token DOUBLE
%token MATRIX
%token CHAR
%token SHORT
%token VOID
%token UNSIGNED

%token ID
%token INTEGER
%token ZEROCONST
%token CHARCONST
%token FLOATING



%token STRLIT

%token OBS
%token CBS
%token OBC
%token CBC
%token OBCU
%token CBCU
%token DOT
%token ARROW
%token INC
%token DEC
%token AND
%token MUL
%token PLUS
%token MINUS
%token NEG
%token NEQ
%token PERCENT
%token LSHIFT
%token RSHIFT
%token LESS
%token GREATER
%token LESSE
%token GREATERE
%token EQUALITY
%token NOTEQ	
%token POWER
%token OR
%token ANDAND
%token OROR
%token QUESTION
%token COLON
%token SCOLON
%token EQUAL
%token MULINC
%token DIVINC
%token MODINC
%token PLUSINC	
%token SUBINC
%token LEFTINC
%token RIGHTINC
%token ANDINC
%token XORINC
%token ORINC
%token COMMA
%token HASH
%token TPOSE
%token RETURN
%token SLASH

%start translation_unit


//expresions

%%
primary_expression : ID {printf ("primary_expression - identifier\n");}
				  | INTEGER {printf ("primary_expression - integer_constant\n");}
				  | ZEROCONST {printf ("primary_expression - zero_constant\n");}
				  | FLOATING {printf ("primary_expression -> floatingconstant\n");}
				  | CHARCONST {printf ("primary_expression -> characterconstant\n");}				  
				  | STRLIT {printf ("primary_expression -> stringLiteral\n");}
				  | OBC expression CBC {printf ("primary_expression -> ( expression )\n");};







postfix_expression : primary_expression {printf ("postfix_expression -> primary_expression\n");}
				  | postfix_expression OBS expression CBS {printf ("postfix_expression -> postfix_expression [ expression ]\n");}
				  | postfix_expression OBC argument_expression_list_optional CBC {printf ("postfix_expression ---> postfix_expression      ( argument_expression_list_optional )\n");}
				  | postfix_expression DOT ID {printf ("postfix_expression ---> postfix_expression . identifier\n");}
				  | postfix_expression ARROW  {printf ("postfix_expression ---> postfix_expression -> identifier\n");}
				  | postfix_expression INC {printf ("postfix_expression ---> postfix_expression ++\n");}
				  | postfix_expression DEC {printf ("postfix_expression ---> postfix_expression --\n");}
				  | postfix_expression TPOSE {printf ("postfix_expression ---> postfix_expression .'\n");};






argument_expression_list_optional: %empty {printf ("argument_expression_list_optional ---> empty\n");}
								 | argument_expression_list {printf ("argument_expression_list_optional ---> argument_expression_list\n");};




argument_expression_list : assignment_expression {printf ("argument_expression_list -> assignment_expression\n");}
					    | argument_expression_list COMMA assignment_expression {printf ("argument_expression_list -> argument_expression_list , assignment_expression\n");};



unary_expression : postfix_expression {printf ("unary_expression -> postfix_expression\n");}
			    | INC unary_expression {printf ("unary_expression -> ++unary_expression\n");}
			    | DEC unary_expression {printf ("unary_expression -> --unary_expression\n");}
			    | unary_operator cast_expression {printf ("unary_expression -> unary_operator cast_expression\n");};


unary_operator : AND {printf ("unary_operator -> &\n");}
			  | MUL {printf ("unaryoperator -> *\n");}
			  | PLUS {printf ("unaryoperator -> +\n");}
			  | MINUS {printf ("unaryoperator -> -\n");};



cast_expression: unary_expression {printf ("cast_expression -> unary_expression\n");};



multiplicative_expression: cast_expression {printf ("multiplicative_expression -> cast_expression\n");}
					     |	multiplicative_expression MUL cast_expression  {
printf ("multiplicative_expression -> multiplicative_expression * cast_expression\n");}
				     |	multiplicative_expression SLASH cast_expression  {printf ("multiplicative_expression -> multiplicative_expression / c~ast_expression\n");}
					     |	multiplicative_expression PERCENT cast_expression  {printf ("multiplicative_expression -> multiplicative_expression %% cast_expression\n");};





additive_expression: multiplicative_expression {printf ("additive_expression -> multiplicative_expression\n");}
				   | additive_expression PLUS multiplicative_expression {printf ("additive_expression -> additive_expression + multiplicative_expression\n");}
				   | additive_expression MINUS multiplicative_expression {printf ("additive_expression -> additive_expression - multiplicative_expression\n");};




shift_expression: additive_expression {printf ("shift_expression -> additive_expression\n");}
			    | shift_expression LSHIFT additive_expression {printf ("shift_expression -> shift_expression << additive_expression\n");}
			    | shift_expression RSHIFT additive_expression {printf ("shift_expression -> shift_expression >> additive_expression\n");};






















relational_expression: shift_expression {printf ("relational_expression -> shift_expression\n");}
				     | relational_expression LESS shift_expression {printf ("relational_expression -> relational_expression < shift_expression\n");}
				     | relational_expression GREATER shift_expression {printf ("relational_expression -> relational_expression > shift_expression\n");}
				     | relational_expression LESSE shift_expression {printf ("relational_expression -> relational_expression <= shift_expression\n");}
				     | relational_expression GREATERE shift_expression {printf ("relational_expression -> relational_expression <= shift_expression\n");};
				     

equality_expression: relational_expression {printf ("equality_expression -> relational_expression\n");}
				   | equality_expression EQUALITY relational_expression {printf ("equality_expression -> equality_expression == relational_expression\n");}
				   | equality_expression NOTEQ relational_expression {printf ("equality_expression -> equality_expression != relational_expression\n");};
				   

AND_expression: equality_expression {printf ("AND_expression -> equality_expression\n");}
			  | AND_expression AND equality_expression {printf ("AND_expression -> AND_expression & equality_expression\n");}
			  

exclusive_OR_expression: AND_expression {printf ("exclusive_OR_expression -> AND_expression\n");}
					   | exclusive_OR_expression POWER AND_expression {printf ("exclusive_OR_expression -> exclusive_OR_expression ^ AND_expression\n");};
					   

inclusive_OR_expression: exclusive_OR_expression {printf ("inclusive_OR_expression -> exclusive_OR_expression\n");}
					   | inclusive_OR_expression OR exclusive_OR_expression {printf ("inclusive_OR_expression -> inclusive_OR_expression | exclusive_OR_expression\n");};
					   

logical_AND_expression: inclusive_OR_expression {printf ("logical_AND_expression -> inclusive_OR_expression\n");}
					  | logical_AND_expression ANDAND inclusive_OR_expression {printf ("logical_AND_expression -> logical_AND_expression && inclusive_OR_expression\n");};
					  

logical_OR_expression: logical_AND_expression {printf ("logical_OR_expression -> logical_AND_expression\n");}
					 | logical_OR_expression OROR logical_AND_expression {printf ("logical_OR_expression -> logical_OR_expression || logical_AND_expression\n");};
					 

conditional_expression: logical_OR_expression {printf ("conditional_expression -> logical_OR_expression\n");}
				      | logical_OR_expression QUESTION expression COLON conditional_expression {
printf ("conditional_expression -> logical_OR_expression ? expression : conditional_expression\n");};
				      

assignment_expression: conditional_expression {printf ("assignment_expression -> conditional_expression\n");}
				     | unary_expression assignment_operator assignment_expression {printf ("assignment_expression -> unary_expression assignment_operator assignment_expression\n");};
				     

assignment_operator: EQUAL {printf ("assignment_operator -> =\n");}
				   | MULINC {printf ("assignment_operator -> *=\n");}
				   | DIVINC {printf ("assignment_operator -> /=\n");}
				   | MODINC {printf ("assignment_operator -> %%=\n");}
				   | PLUSINC {printf ("assignment_operator -> +=\n");}
				   | SUBINC {printf ("assignment_operator -> -=\n");}
				   | LEFTINC {printf ("assignment_operator -> <<=\n");}
				   | RIGHTINC {printf ("assignment_operator -> >>=\n");}
				   | ANDINC {printf ("assignment_operator -> &=\n");}
				   | XORINC {printf ("assignment_operator -> ^=\n");}
				   | ORINC {printf ("assignment_operator -> |=\n");};
				   

expression: assignment_expression {printf ("expression -> assignment_expression\n");}
		  | expression COMMA assignment_expression {printf ("expression -> expression , assignment_expression\n");};
		  

constant_expression: conditional_expression {printf ("constant_expression -> conditional_expression\n");};
				   



// declarations

declaration: declaration_specifiers init_declarator_list_optional SCOLON {printf ("declaration -> declaration_specifiers init_declarator_list_optional\n");};
		   

declaration_specifiers: type_specifier {printf ("declaration_specifiers -> type_specifier\n");}
					  | declaration_specifiers type_specifier {printf ("declaration_specifiers -> declaration_specifiers type_specifier\n");};
					  

init_declarator_list_optional: %empty {printf ("init_declarator_list_optional -> empty\n");}
							 | init_declarator_list {printf ("init_declarator_list_optional -> init_declarator_list\n");};
							 

init_declarator_list: init_declarator {printf ("init_declarator_list ---> init_declarator\n");}
					| init_declarator_list COMMA init_declarator {printf ("init_declarator_list -> init_declarator_list , init_declarator\n");};
					

init_declarator: declarator {printf ("init_declarator ---> declarator\n");}
			   | declarator EQUAL initializer {printf ("init_declarator -> declarator = initializer\n");};
			   

type_specifier: VOID {printf ("type_specifier -> void\n");}
			  | CHAR  {printf ("type_specifier -> char\n");}
			  | SHORT {printf ("type_specifier -> short\n");}
			  | INT   {printf ("type_specifier -> int\n");}
			  | LONG  {printf ("type_specifier -> long\n");}
			  | FLOAT {printf ("type_specifier -> float\n");}
			  | DOUBLE {printf ("type_specifier -> double\n");}
			  | MATRIX {printf ("type_specifier -> Matrix\n");}
			  | SIGNED {printf ("type_specifier -> signed\n");}
			  | UNSIGNED {printf ("type_specifier -> unsigned\n");}
			  | BOOL {printf ("type_specifier -> Bool\n");};
			  

pointer_optional: %empty {printf ("pointer_optional -> empty\n");}
				| pointer_optional MUL {printf ("pointer_optional -> pointer_optional *\n");};
			    

assignment_expression_optional: %empty {printf ("assignment_expression_optional -> empty\n");}
							  | assignment_expression {printf ("assignment_expression_optional ---> assignment_expression\n");};
							  

declarator: pointer_optional direct_declarator {printf ("declarator -> pointer_optional direct_declarator\n");}
	      

direct_declarator: ID {printf ("direct_declarator -> identifier\n");}
				 | OBC declarator CBC {printf ("direct_declarator -> ( declarator )\n");}
				 | direct_declarator OBS assignment_expression_optional CBS {printf ("direct_declarator ---> direct_declarator [ assignment_expression_optional ]\n");}
				 | direct_declarator OBC parameter_type_list CBC {printf ("direct_declarator -> direct_declarator ( parameter_type_list )\n");}
				 | direct_declarator OBC identifier_list_optional CBC {printf ("direct_declarator -> direct_declarator ( identifier_list_optional )\n");};
				 

identifier_list_optional:  identifier_list {printf ("identifier_list_optional -> identifier_list\n");}
                           |%empty {printf ("identifier_list_optional -> empty\n");};
						
						

parameter_type_list: parameter_list {printf ("parameter_type_list -> parameter_list\n");};
				   

parameter_list: parameter_declaration {printf ("parameter_list ---> parameter_declaration\n");}
			  | parameter_list COMMA parameter_declaration {printf ("parameter_list ---> parameter_list , parameter_declaration\n");};
			  

parameter_declaration: declaration_specifiers declarator {printf ("parameter_declaration ---> declaration_specifiers declarator\n");}
					 | declaration_specifiers {printf ("parameter_declaration ---> declaration_specifiers\n");};
					 

identifier_list: ID{printf ("identifier_list ---> identifier\n");}
			   | identifier_list COMMA ID {printf ("identifier_list ---> identifier_list , identifier\n");};
			   

initializer: assignment_expression {printf ("initializer ---> assignment_expression\n");}
		   | OBCU initializer_row_list CBCU {printf ("initializer ---> { initializer_row_list }\n");};
		   

initializer_row_list: initializer_row {printf ("initializer_row_list ---> initializer_row\n");}
					| initializer_row_list SCOLON initializer_row {printf ("initializer_row_list ---> initializer_row_list ; initializer_row\n");};
					

initializer_row: designation_optional initializer {printf ("initializer_row ---> designation_optional initializer\n");}
			   | initializer_row COMMA designation_optional initializer {printf ("initializer_row ---> initializer_row , designation_optional initializer\n");};
			   

designation_optional: %empty {printf ("designation_optional ---> empty\n");}
					| designation {printf ("designation_optional ---> designation\n");};
					

designation: designator_list EQUAL {printf ("designation ---> designator_list =\n");};
		  

designator_list: designator {printf ("designator_list ---> designator\n");}
			   | designator_list designator {printf ("designator_list ---> designator_list designator\n");};
			   

designator: OBS constant_expression CBS {printf ("designator ---> [ constant_expression ]\n");}
		  | DOT ID {printf ("designator ---> . identifier\n");};
		  



// statements

statement: labeled_statement {printf ("statement ---> labeled_statement\n");}
		 | compound_statement {printf ("statement ---> compound_statement\n");}
		 | expression_statement {printf ("statement ---> expression_statement\n");}
		 | selection_statement {printf ("statement ---> selection_statement\n");}
		 | iteration_statement {printf ("statement ---> iteration_statement\n");}
		 | jump_statement {printf ("statement ---> jump_statement\n");};
		 

labeled_statement: ID COLON statement {printf ("labeled_statement ---> identifier : statement\n");}
				 | CASE constant_expression COLON statement {printf ("labeled_statement ---> case constant_expression : statement\n");}
				 | DEFAULT COLON statement {printf ("labeled_statement ---> default : statement\n");};
				 

compound_statement: OBCU block_item_list_optional CBCU {printf ("compound_statement ---> { block_item_list_optional }\n");};	
				  

block_item_list_optional: %empty {printf ("block_item_list_optional -> empty\n");}
				   		| block_item_list {printf ("block_item_list_optional ---> block_item_list\n");};
				   		

block_item_list: block_item {printf ("block_item_list ---> block_item\n");}	
			   | block_item_list block_item {printf ("block_item_list ---> block_item_list block_item\n");}	;
			   

block_item: declaration	{printf ("block_item ---> declaration\n");}	   
		  | statement {printf ("block_item ---> statement\n");};
		  

expression_statement: expression_optional SCOLON {printf ("expression_statement ---> expression_optional ;\n");};
					

selection_statement: IF OBC expression CBC statement {printf ("selection_statement ---> if ( expression ) statement\n");}
				   | IF OBC expression CBC statement ELSE statement {printf ("selection_statement ---> if ( expression ) statement else statement\n");}
				   | SWITCH OBC expression CBC statement {printf ("selection_statement ---> switch ( expression ) statement\n");};
				   

iteration_statement: WHILE OBC expression CBC statement {printf ("iteration_statement ---> while ( expression ) statement\n");}
				   | DO statement WHILE OBC expression CBC SCOLON {printf ("iteration_statement ---> do statement while ( expression ) ;\n");}
				   | FOR OBC expression_optional SCOLON expression_optional SCOLON expression_optional CBC statement {printf ("iteration_statement ---> for ( expression_optional ; expression_optional ; expression_optional ) statement\n");}
				   | FOR OBC declaration expression_optional SCOLON expression_optional CBC statement {printf ("iteration_statement ---> for ( declaration expression_optional ; expression_optional ) statement\n");};
				   

jump_statement: GOTO ID SCOLON {printf ("jump_statement ---> goto identifier ;\n");}
			  | CONTINUE SCOLON {printf ("jump_statement ---> continue ;\n");}
			  | BREAK SCOLON {printf ("jump_statement ---> break ;\n");}
			  | RETURN expression_optional SCOLON {printf ("jump_statement ---> return expression_optional ;\n");};


expression_optional: %empty {printf ("expression_optional ---> empty\n");}
				   | expression {printf ("expression_optional ---> expression\n");};
				   





// external definitions
				   
translation_unit: external_declaration {printf ("translation_unit ---> external_declaration\n");}
				| translation_unit external_declaration {printf ("translation_unit ---> translation_unit external_declaration\n");};
				

external_declaration: function_definition {printf ("external_declaration ---> function_definition\n");}
					| declaration {printf ("external_declaration ---> declaration\n");};
					

function_definition: declaration_specifiers declarator declaration_list_optional compound_statement {printf ("function_definition ---> declaration_specifiers declarator declaration_list_optional compound_statement\n");};
				   

declaration_list_optional: %empty {printf ("declaration_list_optional ---> empty\n");}
				   		 | declaration_list {printf ("declaration_list_optional ---> declaration_list\n");};
				   		 

declaration_list: declaration {printf ("declaration_list ---> declaration\n");}
				| declaration_list declaration {printf ("declaration_list ---> declaration_list declaration\n");};
				


%%




int yyerror(char * error)
{
  printf ("Parsing Error : %s :: nearby %s\n", error, yytext);
  //exit(1);
  return -1;
}












