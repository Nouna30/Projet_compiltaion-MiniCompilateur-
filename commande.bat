flex projet.l
bison -d syntaxique.y
gcc lex.yy.c syntaxique.tab.c -o lexer -lfl -ly
lexer <test.txt