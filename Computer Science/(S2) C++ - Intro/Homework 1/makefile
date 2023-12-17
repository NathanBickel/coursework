# Make a compiler variable, named cc
cc = g++

# Make a compiler variable for C++ 17 standard flag named flags
flags = -std=c++17
# Append the "all warnings" flag to variable
flags += -Wall

# Create link variable to compile, assemble, link, and name
link = $(cc) $(flags) -o

# Create variable compile to compile, assemble, but not link
compile = $(cc) $(flags) -c

base_decomposer : base_decomposer.o
	$(link) $@ $^ 

base_decomposer.o : base_decomposer.cc
	$(compile) $^ 

test1 : base_decomposer
	python3 test_decomposer.py 1

test2 : base_decomposer
	python3 test_decomposer.py 2

test : test1 test2
	@echo "Tests Ran!" 

clean:
	$(RM) base_decomposer.o
	$(RM) base_decomposer
