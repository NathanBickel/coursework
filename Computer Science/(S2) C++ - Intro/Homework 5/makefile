cc = g++  # use g++ compiler
path = ..
standard = c++17

flags = -std=$(standard)  # compile with standard
flags += -Wall  # compile with all warnings
flags += -pedantic  # even more warnings
flags += -I $(path)  # add parent to preprocessor include path
flags += -g  # include gdb instrumentation

link = $(cc) $(flags) -o  # final linked build to binary executable

compile = $(cc) $(flags) -c -o  # compilation to intermediary .o files


# test-rational
#
test-rational: test-rational-constructor \
               test-rational-toDouble \
               test-rational-toString \
               test-rational-equals \
               test-rational-dividedBy \
               test-rational-plus
	@./test-rational-constructor
	@./test-rational-toDouble
	@./test-rational-toString
	@./test-rational-equals
	@./test-rational-dividedBy
	@./test-rational-plus
	@echo 'ALL Rational TESTS PASSED'

# test-rational-style
#
test-rational-style : src/rational.cc inc/rational.h
	cpplint --root=$(path) $^


# test-grade
#
test-grade: test-grade-constructor \
               test-grade-toDouble \
               test-grade-toString \
               test-grade-equals
	@./test-grade-constructor
	@./test-grade-toDouble
	@./test-grade-toString
	@./test-grade-equals
	@echo 'ALL Grade TESTS PASSED'

# test-grade-style
#
test-grade-style : src/grade.cc inc/grade.h
	cpplint --root=$(path) $^


# test-rational-constructor
#
test-rational-constructor : bin/rational.o bin/test-rational-constructor.o
	$(link) $@  $^

bin/test-rational-constructor.o : src/test_rational_constructor.cc \
                                  inc/test_rational_header.h \
                                  inc/rational.h
	$(compile) $@ $<


# test-grade-constructor
#
test-grade-constructor : bin/grade.o \
                         bin/rational.o \
                         bin/test-grade-constructor.o
	$(link) $@ $^

bin/test-grade-constructor.o : src/test_grade_constructor.cc \
                               inc/test_grade_header.h \
                               inc/grade.h \
                               inc/rational.h
	$(compile) $@ $<


# test-rational-toDouble
#
test-rational-toDouble : bin/rational.o bin/test-rational-toDouble.o
	$(link) $@ $^

bin/test-rational-toDouble.o : src/test_rational_toDouble.cc \
                               inc/test_rational_header.h \
                               inc/rational.h
	$(compile) $@ $<


# test-grade-toDouble
#
test-grade-toDouble : bin/grade.o \
                      bin/rational.o \
                      bin/test-grade-toDouble.o
	$(link) $@ $^

bin/test-grade-toDouble.o : src/test_grade_toDouble.cc \
                            inc/grade.h \
                            inc/rational.h \
                            inc/test_grade_header.h
	$(compile) $@ $<


# test-rational-toString
#
test-rational-toString: bin/rational.o bin/test-rational-toString.o
	$(link) $@  $^

bin/test-rational-toString.o : src/test_rational_toString.cc \
                               inc/test_rational_header.h \
                               inc/rational.h
	$(compile) $@ $<


# test-grade-toString
#
test-grade-toString: bin/rational.o bin/grade.o bin/test-grade-toString.o
	$(link) $@  $^

bin/test-grade-toString.o : src/test_grade_toString.cc \
                            inc/grade.h \
                            inc/rational.h \
                            inc/test_grade_header.h
	$(compile) $@ $<


# test-rational-dividedBy
#
test-rational-dividedBy: bin/rational.o bin/test-rational-dividedBy.o
	$(link) $@  $^

bin/test-rational-dividedBy.o : src/test_rational_dividedBy.cc \
                                inc/test_rational_header.h \
                                inc/rational.h
	$(compile) $@ $<


# test-rational-plus
#
test-rational-plus: bin/rational.o bin/test-rational-plus.o
	$(link) $@  $^

bin/test-rational-plus.o : src/test_rational_plus.cc \
                           inc/test_rational_header.h \
                           inc/rational.h
	$(compile) $@ $<


# test-rational-equals
#
test-rational-equals: bin/rational.o bin/test-rational-equals.o
	$(link) $@  $^

bin/test-rational-equals.o : src/test_rational_equals.cc \
                             inc/test_rational_header.h \
                             inc/rational.h
	$(compile) $@ $<



# test-grade-equals
#
test-grade-equals: bin/grade.o bin/rational.o bin/test-grade-equals.o
	$(link) $@  $^

bin/test-grade-equals.o : src/test_grade_equals.cc \
                          inc/grade.h \
                          inc/rational.h \
                          inc/test_rational_header.h
	$(compile) $@ $<


# grade.o
#
bin/grade.o : src/grade.cc inc/grade.h inc/rational.h
	$(compile) $@ $<

# rational.o
#
bin/rational.o : src/rational.cc inc/rational.h
	$(compile) $@ $<

clean:
	rm -f bin/* test-*
