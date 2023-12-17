// Copyright 2022 CSCE 240
//
#include <hw4/inc/test_gradebook.h>


bool TestGradeBookAdd(const GradeBook& book1, const GradeBook& book2) {
  GradeBook actual = book1.Add(book2);

  bool passed = true;
  size_t index = 0;
  // test for contents of book 1
  for (size_t i = 0; i < kTest1_grades_size; ++i, ++index)
    if (!actual.Get(index).Equals(kTest1_grades[i])) {
      std::cout << "  Expected union.Get(" << index << "): " << kTest1_grades[i]
        << ", Actual: " << actual.Get(index) << '\n';
      passed = false;
    }

  // test for contents of book 2
  for (size_t i = 0; i < kTest2_grades_size; ++i, ++index)
    if (!actual.Get(index).Equals(kTest2_grades[i])) {
      std::cout << "  Expected union.Get(" << index << "): " << kTest2_grades[i]
        << ", Actual: " << actual.Get(index) << '\n';
      passed = false;
    }

  if (passed)
     std::cout << "  PASSED" << std::endl;
  else
    std::cout << "  FAILED" << std::endl;

  return passed;
}

bool TestGradeBookAdd() {
  std::cout << "Testing GradeBook::Add(GradeBook)\n";
  GradeBook book1;
  for (const Grade& grade : kTest1_grades)
    book1.Add(grade);

  GradeBook book2;
  for (const Grade& grade : kTest2_grades)
    book2.Add(grade);

  return TestGradeBookAdd(book1, book2);
}

int main(int argc, char* argv[]) {
  return TestGradeBookAdd() ? 0 : 1;
}
