bin_PROGRAMS = gfalint

dist_doc_DATA = LICENSE.md README.md

EXTRA_DIST = autogen.sh

gfalint_SOURCES = gfalint.cc \
	gfay.y \
	gfay.h \
	gfal.l

examplesdir = $(docdir)/examples
dist_examples_SCRIPTS = examples/gfalint.test
dist_examples_DATA = $(TESTS) \
	examples/big.gv \
	examples/ir.gv \
	examples/sample.gv

TEST_EXTENSIONS = .gfa
GFA_LOG_COMPILER = $(top_srcdir)/test-driver-gfa
dist_check_SCRIPTS = test-driver-gfa
TESTS = \
	examples/big1.gfa \
	examples/ir1.gfa \
	examples/ir2.gfa \
	examples/sample1.gfa \
	examples/sample2.gfa
