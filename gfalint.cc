/**
 * Check a GFA file for syntax errors.
 * @author Shaun Jackman <sjackman@gmail.com>
 */

#include "config.h"
#include <cstdlib>
#include <getopt.h>
#include <sstream>
#include <string>
#include <iostream>

using namespace std;

#define PROGRAM "gfalint"

static const char VERSION_MESSAGE[] =
PROGRAM " " VERSION "\n"
"Written by Shaun Jackman.\n"
"\n"
"Copyright 2016 Shaun Jackman\n";

static const char USAGE_MESSAGE[] =
"Usage: " PROGRAM " <FILE\n"
"Check a GFA file for syntax errors.\n"
"\n"
"Options\n"
"      --help     display this help and exit\n"
"      --version  output version information and exit\n"
"\n"
"Report bugs to <" PACKAGE_BUGREPORT ">.\n";

/** Short options. */
static const char shortopts[] = "";

enum { OPT_HELP = 1, OPT_VERSION };

/** Long options. */
static const struct option longopts[] = {
	{ "help", no_argument, NULL, OPT_HELP },
	{ "version", no_argument, NULL, OPT_VERSION },
	{ NULL, 0, NULL, 0 }
};

/** Parse standard input. */
extern "C" int yyparse();

/** Manipulate a FASTG file. */
int main(int argc, char** argv)
{
	bool die = false;
	for (int c; (c = getopt_long(argc, argv,
					shortopts, longopts, NULL)) != -1;) {
		istringstream arg(optarg != NULL ? optarg : "");
		switch (c) {
		  case OPT_HELP:
			cout << USAGE_MESSAGE;
			exit(EXIT_SUCCESS);
		  case OPT_VERSION:
			cout << VERSION_MESSAGE;
			exit(EXIT_SUCCESS);
		}
		if (optarg != NULL && !arg.eof()) {
			cerr << PROGRAM ": invalid option: `-"
				<< (char)c << optarg << "'\n";
			exit(EXIT_FAILURE);
		}
	}

	if (argc - optind > 0) {
		cerr << PROGRAM ": too many arguments\n";
		die = true;
	}

	if (die) {
		cerr << "Try `" << PROGRAM
			<< " --help' for more information.\n";
		exit(EXIT_FAILURE);
	}

	yyparse();

	return 0;
}
