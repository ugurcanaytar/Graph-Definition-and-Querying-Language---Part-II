// Define the tokens

%{
#include <stdio.h>
int yyparse();
int yylex(void);
void yyerror(char *);
extern int yylineno;
int errornumber = 0;
%}

%union
{
	char * stripp;
	int integer;
	float Float;
}

%token COMMENT
%token NOT_MARK
%token LEFT_BRACKET
%token RIGHT_BRACKET
%token LEFT_PARANTHESIS
%token RIGHT_PARANTHESIS
%token COMMA
%token LEFT_CURLY_BRACKET
%token RIGHT_CURLY_BRACKET
%token ASSIGNMENT_OP
%token BEG_MAIN
%token END_MAIN
%token FLOAT
%token STRING
%token INTEGER
%token EDGE
%token VERTEX
%token PROPERTY
%token LIST
%token MAP
%token PATH
%token DIRECTED_GRAPH
%token UNDIRECTED_GRAPH
%token ADD_FCN
%token ADD_VERTEX_FCN
%token CONNECT_TO_FCN
%token CONNECT_FCN
%token ATTACH_PRP_FCN
%token ADD_PRP_FCN
%token DELETE_FCN
%token CONTAINS_PATH
%token NAME_PATH
%token VALUE_PATH
%token BOOLEAN_ASSIGNMENT
%token BOOLEAN_NOT_ASSIGN
%token BOOLEAN_SMALLEREQ
%token BOOLEAN_SMALLER
%token BOOLEAN_BIGGEREQ
%token BOOLEAN_BIGGER
%token PATH_ARROW
%token PATH_REPEAT
%token PATH_ALTERNATION
%token CHAR_SPOTTED
%token IDENTIFIER



%type <integer> INTEGER
%type <string> STRING
%type <string> IDENTIFIER
%type <float> FLOAT

%%

program  : BEG_MAIN stmt_list END_MAIN
		 ;

stmt_list  : stmt
		   | stmt stmt_list
		   ;

stmt   : def_stmt
	   | assign_stmt
	   | logic_stmt
	   | comment_stmt
	   ;
	   
def_stmt : data_types identifiers
		 ;
		 
data_types   : FLOAT
		 	 | STRING
		 	 | INTEGER
		 	 | EDGE
		 	 | VERTEX
		 	 | PROPERTY
		  	 | LIST
		 	 | MAP
		 	 | DIRECTED_GRAPH
		 	 | UNDIRECTED_GRAPH
		 	 ;
			 
identifiers : IDENTIFIER 
			| IDENTIFIER assign_stmt
			| IDENTIFIER function_callers
			;
	
assign_stmt   : ASSIGNMENT_OP LEFT_PARANTHESIS STRING COMMA STRING RIGHT_PARANTHESIS
			  | ASSIGNMENT_OP LEFT_PARANTHESIS error_no3 RIGHT_PARANTHESIS
			  | ASSIGNMENT_OP LEFT_PARANTHESIS STRING COMMA INTEGER RIGHT_PARANTHESIS
			  | LEFT_PARANTHESIS STRING COMMA STRING RIGHT_PARANTHESIS
			  | LEFT_PARANTHESIS error_no2 RIGHT_PARANTHESIS
			  | LEFT_PARANTHESIS STRING COMMA INTEGER RIGHT_PARANTHESIS
			  | LEFT_PARANTHESIS RIGHT_PARANTHESIS
			  ;
			  
error_no3	  : INTEGER COMMA INTEGER {printf("%s, lineNumber: %d\n", "***ERROR***: ASSIGNMENT OPERATOR MUST TAKE AT LEAST ONE STRING AS ITS PARAMETER!", yylineno);}
			  ;

error_no2	  : STRING COMMA STRING COMMA STRING {printf("%s, lineNumber: %d\n", "***ERROR***: INITIALIZING OPERATOR UNSUCCESSFUL: INITIALIZE TWO IDENTIFIER AT MAXIMUM IN ONE TIME!", yylineno);}		
			  ;
			  
function_callers   : ADD_FCN LEFT_PARANTHESIS IDENTIFIER RIGHT_PARANTHESIS 
			  	   | ADD_VERTEX_FCN LEFT_PARANTHESIS IDENTIFIER RIGHT_PARANTHESIS
				   | ADD_VERTEX_FCN LEFT_PARANTHESIS error_no5 RIGHT_PARANTHESIS 
			  	   | CONNECT_TO_FCN LEFT_PARANTHESIS IDENTIFIER COMMA IDENTIFIER RIGHT_PARANTHESIS
			       | CONNECT_FCN LEFT_PARANTHESIS IDENTIFIER COMMA IDENTIFIER RIGHT_PARANTHESIS
				   | CONNECT_FCN LEFT_PARANTHESIS error_no4 RIGHT_PARANTHESIS
			  	   | ATTACH_PRP_FCN LEFT_PARANTHESIS IDENTIFIER RIGHT_PARANTHESIS
			  	   | ADD_PRP_FCN LEFT_PARANTHESIS IDENTIFIER RIGHT_PARANTHESIS
				   | ADD_PRP_FCN LEFT_PARANTHESIS error_no1 RIGHT_PARANTHESIS
			  	   | DELETE_FCN LEFT_PARANTHESIS IDENTIFIER RIGHT_PARANTHESIS
			  	   | CONTAINS_PATH LEFT_PARANTHESIS STRING RIGHT_PARANTHESIS
			  	   ;

error_no5	: IDENTIFIER COMMA IDENTIFIER {printf("%s, lineNumber: %d\n", "***ERROR***: ADD_VERTEX FUNCTION ONLY ADD ONE VERTEX FOR EACH TIME, NOT MORE.", yylineno);}
			   
error_no4	: IDENTIFIER COMMA IDENTIFIER COMMA IDENTIFIER {printf("%s, lineNumber: %d\n", "***ERROR***: CONNECT FUNCTION TAKES ONLY TWO PARAMETER AS VERTEX DATA TYPE!", yylineno);}	
			;
			
error_no1	: IDENTIFIER COMMA STRING {printf("%s, lineNumber: %d\n", "***ERROR***: ADD_PROPERTY FUNCTION TAKES ONLY ONE PARAMETER AS PROPERTY DATA TYPE!", yylineno);}		
			;

logic_stmt :  expr  
	       |  expr logical_op
	       |  expr logical_op expr
		   ;

comment_stmt : COMMENT stmt_list
			 ;

expr    : identifiers  
        | function_callers
	    | UNDIRECTED_GRAPH
	    | DIRECTED_GRAPH
	    | EDGE
	    | VERTEX
	    | LIST
	    | MAP
	    | PROPERTY
		;

logical_op : BOOLEAN_ASSIGNMENT | BOOLEAN_NOT_ASSIGN | BOOLEAN_SMALLEREQ | BOOLEAN_SMALLER | BOOLEAN_BIGGEREQ | ASSIGNMENT_OP | BOOLEAN_BIGGER | NOT_MARK | PATH_REPEAT | PATH_ALTERNATION | CHAR_SPOTTED 
			;



%%

/*int main() 
{
  int ret = yyparse();
  if (ret!=0)
    return EXIT_FAILURE;
  return EXIT_SUCCESS;
}
*/
// report errors

void yyerror(char *s) 
{
  printf("%s\n", s);
}

