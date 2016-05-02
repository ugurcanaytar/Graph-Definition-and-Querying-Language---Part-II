      	 # Makefile example -- scanner and parser.
        # Creates "query_parser" from “lexer.l”, “parser_for_query.y” and "query_parser"

        LEX     = flex
        YACC    = bison -y
        YFLAGS  = -d
        objects = lexer.o parser_for_query.o query_parser.o

        query_parser: $(objects)
        lexer.o: lexer.l parser_for_query.c
        parse.o: parser_for_query.y
        query_parser.o: query_parser.c