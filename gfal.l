/**
 * Tokenize a GFA file.
 * @author Shaun Jackman <sjackman@gmail.com>
 */

%option nodefault
%option yylineno

%{
#include "gfay.h"

void yyerror(const char *s);
%}

%%

^#.*$ /* Comment */
^E return 'E';
^F return 'F';
^G return 'G';
^H return 'H';
^L return 'L';
^O return 'O';
^S return 'S';
^U return 'U';
" " return ' ';
"\t" return '\t';
"\n" return '\n';
"$" return '$';
"*" return '*';

([0-9]+[MDIP])+ return CIGAR;
0|[1-9][0-9]* return INTEGER;
[-+] return ORIENTATION;
[ABCDGHKMNRSTVWYabcdghkmnrstvwy]+ return SEQUENCE;
([A-Z][A-Z]|[a-z][a-z]):[ABHJZif]:[^\t\n]+ return TAGGED_FIELD;
[!-~]+ return ID;

. {
	yyerror("Unexpected character");
	exit(EXIT_FAILURE);
}

%%
