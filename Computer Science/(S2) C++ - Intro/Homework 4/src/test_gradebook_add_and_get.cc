// Copyright 2022 CSCE 240
//
#include <hw4/inc/test_gradebook.h>


bool TestGradeBookAddAndGet() {
  std::cout
    << "Testing GradeBook::Add(Grade) and GradeBook::Get(size_t)\n";


  // use loops to create 5 books of length 1, 2, 3, 4, 5, and 6
  bool passed = true;
  for (size_t i = 1; i < kTest1_grades_size; ++i) {
    GradeBook book_i;
    for (size_t ii = 0; ii < i; ++ii) {
      book_i.Add(kTest1_grades[ii]);
      if (!book_i.Get(ii).Equals(kTest1_grades[ii])) {
        std::cout << "  Expected GradeBook::Get(" << ii << "): "
          << kTest1_grades[ii].ToString()
          << ", Actual: " << book_i.Get(ii).ToString() << '\n';

        passed = false;
      }
    }
  }

  if (passed)
    std::cout << "  PASSED" << std::endl;
  else
    std::cout << "  FAILED" << std::endl;

  return passed;
}


int main(int argc, char* argv[]) {
  return TestGradeBookAddAndGet() ? 0 : 1;
}
