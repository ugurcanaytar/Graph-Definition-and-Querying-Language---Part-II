      	 # Makefile example -- scanner and parser.
        # Creates "query_parser" from “lexer.l”, “parser_for_definition.y” and “definition_parser"

        LEX     = flex
        YACC    = bison -y
        YFLAGS  = -d
        objects = lexer.o parser_for_definition.o definition_parser.o

        definition_parser: $(objects)
        lexer.o: lexer.l parser_for_definition.c
        parse.o: parser_for_definition.y
        query_parser.o: definition_parser.c