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

^#.*\n /* Comment */
^E return 'E';
^F return 'F';
^G return 'G';
^H return 'H';
^L return 'L';
^O return 'O';
^P return 'P';
^S return 'S';
^U return 'U';
" " return ' ';
"\t" return '\t';
"\n" return '\n';
"*" return '*';

([0-9]+[MDIP])+ return CIGAR;
([0-9]+[MDIP])+(,([0-9]+[MDIP])+)+ return CIGARS1;
0|[1-9][0-9]* return INTEGER;
[-+] return ORIENTATION;
0|[1-9][0-9]*"$"? return POSITION;
[A-Za-z0-9][A-Za-z0-9]:[ABHJZif]:[ -~]* return TAGGED_FIELD;
[0-9]+(,[0-9]+)+ return TRACE;
[!-~]+ return STRING;

. {
	yyerror("Unexpected character");
	exit(EXIT_FAILURE);
}

%%
