%{
/**
 * Parse a GFA file.
 * @author Shaun Jackman <sjackman@gmail.com>
 */

#include <stdio.h>
%}

%defines
%error-verbose

%union {
	unsigned long long i;
	char c;
	char* s;
}

%token <s> CIGAR
%token <s> CIGARS1
%token <i> INTEGER
%token <c> ORIENTATION
%token <i> POSITION
%token <s> REF
%token <s> STRING
%token <s> TAGGED_FIELD
%token <s> TRACE

%start gfa

%{
/** The current line number. */
extern int yylineno;

/** The next lexeme. */
extern const char* yytext;

/** The tokenizer. */
int yylex();

void yyerror(const char* s)
{
	fprintf(stderr, "error: %u: %s near `%s'\n",
		yylineno, s, yytext);
}

int yywrap()
{
	return 1;
}
%}

%%

gfa : records

records : record | records record

record : header | segment | fragment | edge | link | gap | ordered_set | unordered_set | path1

/* Header record. */
header : 'H' tagged_fields '\n'

/* Segment record of GFA 1. */
segment1 : 'S' '\t' id '\t' sequence tagged_fields '\n'

/* Segment record of GFA 2. */
segment2 : 'S' '\t' id '\t' INTEGER '\t' sequence tagged_fields '\n'

/* Segment record. */
segment : segment1 | segment2

/* Fragment record. */
fragment : 'F' '\t' optional_id '\t' REF '\t' pos '\t' pos '\t' pos '\t' pos '\t' alignment tagged_fields '\n'

/* Edge record. */
edge : 'E' '\t' optional_id '\t' REF '\t' REF '\t' pos '\t' pos '\t' pos '\t' pos '\t' alignment tagged_fields '\n'

/* Link record of GFA 1. */
link : 'L' '\t' id '\t' ORIENTATION '\t' id '\t' ORIENTATION '\t' alignment tagged_fields '\n'

/* Gap record. */
gap : 'G' '\t' optional_id '\t' REF '\t' REF '\t' INTEGER '\t' INTEGER tagged_fields '\n'

/* Orderd set. */
ordered_set : 'O' '\t' id '\t' refs tagged_fields '\n'

/* Unordered set. */
unordered_set : 'U' '\t' id '\t' ids tagged_fields '\n'

/* Path record of GFA 1. */
path1 : 'P' '\t' id '\t' ids1 '\t' opt_cigars1 tagged_fields '\n'

/* An identifier.
 * A string that is a valid CIGAR, integer or position is also a valid indentifier.
 */
id : STRING | CIGAR | CIGARS1 | INTEGER | POSITION

/* An optional identifier. */
optional_id : '*' | id

/* A list of identifiers. */
ids : id | ids ' ' id

/* A comma-separated list of identifiers from GFA1. */
ids1 : REF

/* A list of oriented identifiers. */
refs : REF | refs ' ' REF

/* An optional comma-separated list of CIGAR strings from GFA1. */
opt_cigars1 : '*' | CIGARS1

/* A position.
 * An integer is also a valid position.
 */
pos : POSITION | INTEGER

/* An optional nucleotide sequence. */
sequence : '*' | STRING

/* An optional alignment in CIGAR or trace format. */
alignment : '*' | CIGAR | TRACE

/* Optional tagged fields. */
tagged_fields : /*empty*/ | tagged_fields '\t' TAGGED_FIELD
