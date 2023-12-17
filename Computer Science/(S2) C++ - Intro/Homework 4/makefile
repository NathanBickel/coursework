# use g++ compiler
cc = g++
# use parent directory for include directives and style
path = ..

# compile with C++ 17 standard
flags = -std=c++17
# compile with all warnings
flags += -Wall
# add to include path
flags += -I $(path)
# instrument for gdb
flags += -g

# build binary executable
link = $(cc) $(flags) -o

# build intermediary .o files
compile = $(cc) $(flags) -c


test-all: test-all-style test-all-correct
	@echo 'ALL PROVIDED TESTS PASSED'

test-all-correct: test-grade test-gradebook
	@echo 'ALL CORRECTNESS TESTS PASSED'

test-all-style: test-grade-style test-gradebook-style
	@echo 'ALL STYLE TESTS PASSED'


test-grade: test-grade-constructor \
            test-grade-toDouble \
            test-grade-toString \
            test-grade-toLetter \
            test-grade-equals \
            test-grade-dividedBy \
            test-grade-plus
	@echo 'TESTING src/grade.cc:Grade CLASS' \
	&& ./test-grade-constructor \
	&& ./test-grade-toDouble \
	&& ./test-grade-toString \
	&& ./test-grade-toLetter \
	&& ./test-grade-equals \
	&& ./test-grade-dividedBy \
	&& ./test-grade-plus


test-grade-style : src/grade.cc inc/grade.h
	cpplint --root=$(path) $^


test-gradebook: test-gradebook-add-and-get \
                test-gradebook-add \
                test-gradebook-calcAverage
	@echo 'TESTING src/gradebook.cc:GradeBook CLASS' \
	&& ./test-gradebook-add-and-get \
	&& ./test-gradebook-add \
	&& ./test-gradebook-calcAverage


test-gradebook-style : src/gradebook.cc inc/gradebook.h
	cpplint --root=$(path) $^


test-gradebook-add-and-get : bin/test-gradebook-add-and-get.o \
                             bin/gradebook.o \
                             bin/grade.o
	$(link) $@ $^

bin/test-gradebook-add-and-get.o : src/test_gradebook_add_and_get.cc \
                                   inc/test_gradebook.h
	$(compile) $< -o $@


test-gradebook-add : bin/test-gradebook-add.o \
                     bin/gradebook.o \
                     bin/grade.o
	$(link) $@ $^

bin/test-gradebook-add.o : src/test_gradebook_add.cc \
                           inc/test_gradebook.h
	$(compile) $< -o $@


test-gradebook-calcAverage : bin/test-gradebook-calcAverage.o \
                             bin/gradebook.o \
                             bin/grade.o
	$(link) $@ $^

bin/test-gradebook-calcAverage.o : src/test_gradebook_calcAverage.cc \
                                   inc/test_gradebook.h
	$(compile) $< -o $@


test-grade-constructor: src/test_grade_constructor.cc bin/grade.o
	$(link) $@ $^

test-grade-toDouble: src/test_grade_toDouble.cc bin/grade.o
	$(link) $@ $^

test-grade-toString: src/test_grade_toString.cc bin/grade.o
	$(link) $@ $^

test-grade-toLetter: src/test_grade_toLetter.cc bin/grade.o
	$(link) $@ $^

test-grade-equals: src/test_grade_equals.cc bin/grade.o
	$(link) $@ $^

test-grade-dividedBy: src/test_grade_dividedBy.cc bin/grade.o
	$(link) $@ $^

test-grade-plus: src/test_grade_plus.cc bin/grade.o
	$(link) $@ $^

bin/gradebook.o : src/gradebook.cc inc/gradebook.h
	$(compile) $< -o $@

bin/grade.o : src/grade.cc inc/grade.h
	$(compile) $< -o $@

clean:
	rm -f bin/* test-*
