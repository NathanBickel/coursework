# use g++ compiler
cc = g++

# add parent to include path and root
path = ..

# compile with C++ 17 standard
flags = -std=c++17
# compile with all warnings
flags += -Wall
# compile with PWD appended to compiler library path
flags += -I $(path)
# compile with debug instrumentation
flags += -g

# compile, assemble, link
link = $(cc) $(flags) -o
# compile, assemble, do not link
compile = $(cc) $(flags) -c

test-find-sum : bin/test-find-sum.o bin/find-sum.o
	$(link) $@ $^


test-find-sum-all : test-find-sum
	@echo 'Running All Tests' \
  && ./test-find-sum dat/row_matrix.txt 0  \
	&& ./test-find-sum dat/col_matrix.txt 1  \
	&& ./test-find-sum dat/asc_matrix.txt 2  \
	&& ./test-find-sum dat/dsc_matrix.txt 3  \
	&& ./test-find-sum dat/matrix.txt 4  \
	&& ./test-find-sum dat/matrix.txt 5  \
	&& ./test-find-sum dat/large_matrix.txt 6  \
	&& echo 'Passed All Tests'


test-find-sum-style : src/find_sum.cc inc/find_sum.h
	cpplint --root=$(path) $^


test-find-sum-memory : test-find-sum
	@echo MEMORY TEST 0
	valgrind --leak-check=full --error-exitcode=1 \
    ./test-find-sum dat/row_matrix.txt 0 > /dev/null
	@echo MEMORY TEST 0 PASSED
	@echo MEMORY TEST 1
	valgrind --leak-check=full --error-exitcode=1 \
    ./test-find-sum dat/col_matrix.txt 1  > /dev/null
	@echo MEMORY TEST 1 PASSED
	@echo MEMORY TEST 2
	valgrind --leak-check=full --error-exitcode=1 \
    ./test-find-sum dat/asc_matrix.txt 2 > /dev/null
	@echo MEMORY TEST 2 PASSED
	@echo MEMORY TEST 3
	valgrind --leak-check=full --error-exitcode=1 \
    ./test-find-sum dat/dsc_matrix.txt 3  > /dev/null
	@echo MEMORY TEST 3 PASSED
	@echo MEMORY TEST 4
	valgrind --leak-check=full --error-exitcode=1 \
    ./test-find-sum dat/matrix.txt 4  > /dev/null
	@echo MEMORY TEST 4 PASSED
	@echo MEMORY TEST 5
	valgrind --leak-check=full --error-exitcode=1 \
    ./test-find-sum dat/matrix.txt 5 > /dev/null
	@echo MEMORY TEST 5 PASSED
	@echo MEMORY TEST 6
	valgrind --leak-check=full --error-exitcode=1 \
    ./test-find-sum dat/large_matrix.txt 6 > /dev/null
	@echo MEMORY TEST 6 PASSED
	@echo ALL MEMORY TESTS PASSED


bin/test-find-sum.o : src/test_find_sum.cc inc/test_find_sum.h \
                        inc/find_sum.h
	$(compile) -o $@ $<


bin/find-sum.o : src/find_sum.cc inc/find_sum.h
	$(compile) -o $@ $<


clean:
	$(RM) bin/* test-find-sum
