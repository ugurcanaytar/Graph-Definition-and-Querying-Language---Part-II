%option yylineno

%{
	//#include <cstdlib>
	//#include <iostream>
	#include "y.tab.h"
	void yyerror(char *);
	
%}

digit 			[0-9]
integer 		{digit}+
float 			{digit}*(\.{digit}+)
identifier		[a-zA-Z][a-zA-Z0-9]*
string		 	\"([^\"\\\n]|\\\"|\\n|\\t|\\\\)*\" 
comment 		\/\/[^\n]*

%%
{comment}		;
\!				{return NOT_MARK;}
\[				{return LEFT_BRACKET;}
\]				{return RIGHT_BRACKET;}
\(				{return LEFT_PARANTHESIS;}
\)				{return RIGHT_PARANTHESIS;}
\,				{return COMMA;}
\{				{return LEFT_CURLY_BRACKET;}
\}				{return RIGHT_CURLY_BRACKET;}
\=				{return ASSIGNMENT_OP;}
beginmain		{printf("%s\n", "Beginning Of Program, Hello!"); return BEG_MAIN;}
endmain			{printf("%s\n", "Ending Of Program, Bye!"); return END_MAIN;}
{float}			{yylval.Float = atof(yytext); return FLOAT;}

{string} 		{yylval.stripp = strdup(yytext); return STRING;}
{integer}		{yylval.integer = atoi(yytext); return INTEGER;}
Edge			{printf("%s\n", "Edge created"); return EDGE;}
Vertex			{printf("%s\n", "Vertex created"); return VERTEX;}
Property		{printf("%s\n", "Property created");return PROPERTY;}
List			{printf("%s\n", "List created");return LIST;}
Map				{printf("%s\n", "Map created");return MAP;}
Path			{printf("%s\n", "Path created"); return PATH;}
Directed 		{printf("%s\n", "Directed Graph created"); return DIRECTED_GRAPH;}
Undirected 		{printf("%s\n", "Undirected Graph created"); return UNDIRECTED_GRAPH;}
\.Add			{printf("%s\n", "Add Function call"); return ADD_FCN;}
\.AddVertex		{printf("%s\n", "Add Vertex Function call"); return ADD_VERTEX_FCN;}
\.ConnectTo		{printf("%s\n", "Connect To Function call"); return CONNECT_TO_FCN;}
\.Connect		{printf("%s\n", "Connect Function call"); return CONNECT_FCN;}
\.AttachProperty	{printf("%s\n", "Attach Property Function call"); return ATTACH_PRP_FCN;}
\.AddProperty	{printf("%s\n", "Add Property Function call"); return ADD_PRP_FCN;}
\.Delete		{printf("%s\n", "Delete Function call"); return DELETE_FCN;}
Contains:		{printf("%s\n", "Contains Checker boolean call"); return CONTAINS_PATH;}
name			{printf("%s\n", "Name Checker boolean call"); return NAME_PATH;}
value			{printf("%s\n", "Value Checker boolean call"); return VALUE_PATH;}

\=\=			{printf("%s\n", "Assignment boolean call"); return BOOLEAN_ASSIGNMENT;}
!\=				{printf("%s\n", "Not Mark boolean call");return BOOLEAN_NOT_ASSIGN;}
\<\=			{return BOOLEAN_SMALLEREQ;}
\<				{return BOOLEAN_SMALLER;}
\>\=			{return BOOLEAN_BIGGEREQ;}
\>				{return BOOLEAN_BIGGER;}
->				{printf("%s\n", "Path Arrow call");return PATH_ARROW;}
\*  			{printf("%s\n", "Repetition boolean call"); return PATH_REPEAT;}
\|				{printf("%s\n", "Alternation boolean call");return PATH_ALTERNATION;}
\:				{printf("%s\n", "Marked Char boolean call");return CHAR_SPOTTED;}


{identifier}	{yylval.stripp = strdup(yytext); return IDENTIFIER;}

.|\n ;




%%

int yywrap(void){
	return 1;
}