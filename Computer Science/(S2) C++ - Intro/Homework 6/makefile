cc = g++  # use g++ compiler
path = .. # include pwd in paths
standard = c++17

flags = -std=$(standard)  # compile with correct C++ standard
flags += -Wall  # compile with all warnings
flags += -pedantic  # even more warnings
flags += -I $(path)  # add parent dir to preprocessor include path
flags += -g  # include gdb instrumentation

link = $(cc) $(flags) -o  # final linked build to binary executable

compile = $(cc) $(flags) -c  # compilation to intermediary .o files

# test-style
#
test-style : src/rational.cc inc/rational.h src/grade.cc inc/grade.h
	cpplint --root=$(path) $^

test-rational: test-rational-extract-op test-rational-equals-op
	@./test-rational-extract-op
	@./test-rational-equals-op

# test-rational-extract-op
#
test-rational-extract-op: bin/rational.o bin/test-rational-extract-op.o
	$(link) $@  $^

# builds object file with dependencies
bin/test-rational-extract-op.o : src/test_rational_extract_op.cc \
                                 inc/test_rational.h \
                                 inc/rational.h
	$(compile) $<  -o  $@


# test-rational-equals-op
#
test-rational-equals-op: bin/rational.o bin/test-rational-equals-op.o
	$(link) $@  $^

# builds object file with dependencies
bin/test-rational-equals-op.o : src/test_rational_equals_op.cc \
                                inc/test_rational.h \
                                inc/rational.h
	$(compile) $<  -o  $@


# rational.o
#
# builds object file with dependencies
bin/rational.o : src/rational.cc inc/rational.h
	$(compile) $< -o $@


# test-grade
#
test-grade : test-grade-constructor test-grade-toLetter test-grade-calcAverage
	@./test-grade-constructor
	@./test-grade-toLetter
	@./test-grade-calcAverage

# test-grade-constructors
#
test-grade-constructor : bin/test-grade-constructor.o bin/rational.o
	$(link) $@  $^

# builds object file with dependencies
bin/test-grade-constructor.o : src/test_grade_constructor.cc \
                               inc/test_grade.h \
                               inc/grade.h.gch \
                               bin/rational.o
	$(compile) $<  -o  $@


# test-grade-toLetter
#
test-grade-toLetter: bin/test-grade-toLetter.o bin/rational.o
	$(link) $@  $^

# builds object file with dependencies
bin/test-grade-toLetter.o : src/test_grade_toLetter.cc \
                            inc/test_grade.h \
                            inc/grade.h.gch \
                            bin/rational.o
	$(compile) $<  -o  $@


# test-grade-calcAverage
#
test-grade-calcAverage: bin/test-grade-calcAverage.o bin/rational.o
	$(link) $@  $^

# builds object file with dependencies
bin/test-grade-calcAverage.o : src/test_grade_calcAverage.cc \
                               inc/test_grade.h \
                               inc/grade.h.gch \
                               bin/rational.o
	$(compile) $<  -o  $@


# grade.h (grade.h.gch)
#
# builds header object file with dependencies, g++ maps .h files to .h.gch
# those files exist in dir with .h files
inc/grade.h.gch :  inc/grade.h src/grade.cc
	$(compile) $< -o $@

clean:
	rm -f bin/* inc/*.gch test-*
