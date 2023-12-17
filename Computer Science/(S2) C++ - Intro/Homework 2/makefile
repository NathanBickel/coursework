cc = g++  # use g++ compiler

root = ..

flags = -std=c++17  # compile with C++ 17 standard
flags += -Wall      # compile with all warnings
flags += -g         # compile with debugger instrumentation
flags += -I $(root)

link = $(cc) $(flags) -o  # final linked build to binary executable

compile = $(cc) $(flags) -c  # compilation to intermediary .o files


parse_scores.o : parse_scores.cc parse_scores.h
	$(compile) $< -o $@

parse-scores-style : parse_scores.cc parse_scores.h
	cpplint --root=$(root) $^

test-get-id : test_get_id.cc parse_scores.o
	$(link) $@ $^

test-get-grade : test_get_grade.cc parse_scores.o
	$(link) $@ $^

test-get-grade-count : test_get_grade_count.cc parse_scores.o
	$(link) $@ $^

test-get-max-grade : test_get_max_grade.cc parse_scores.o
	$(link) $@ $^

test : test-get-id test-get-grade test-get-grade-count test-get-max-grade
	./test-get-id
	./test-get-grade
	./test-get-grade-count
	./test-get-max-grade

clean:
	$(RM) *.o test-get-grade test-get-grade-count test-get-id \
        test-get-max-grade
