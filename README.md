# Analysis-of-programming-languages #

Here I used a scanner / filter with flex that would extract and print useful information from the file example.html


The result includes:

Date

Time

Film name

Length of film


# Another important task #


Making a parser using Flex and Bison that describes enough of SQL grammar that it:


a: can parse every statement in file oracle.sql and would print that the statement is OK;

b: cannot parse statements in error.sql and would print the parser error message.



To speed things up a small example (example.l & example.y) is used that can parse the test.sql file.


A further example (example2.l & example2.y) can successfully parse 2 statements from oracle.sql file.



To run the various tools the following commands were used:

flex example.l

bison -d -r all example.y

gcc lex.yy.c example.tab.c -o example


./example test.sql
