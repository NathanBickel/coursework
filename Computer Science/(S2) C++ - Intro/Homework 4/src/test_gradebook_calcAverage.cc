// Copyright 2022 CSCE 240
//
#include <hw4/inc/test_gradebook.h>


bool TestGradeBookCalcAverage(const GradeBook& book, const Grade& expected) {
  Grade actual = book.CalcAverage();

  if (!actual.Equals(expected)) {
    std::cout << "  Expected Average: " << expected << ", Actual: " << actual
      << "\n";
    return false;
  }

  return true;
}

bool TestGradeBookCalcAverage() {
  std::cout << "Testing GradeBook::CalcAverage()\n";
  GradeBook book1;
  for (const Grade& grade : kTest1_grades)
    book1.Add(grade);

  bool passed = TestGradeBookCalcAverage(book1, kTest1_grades_average);

  GradeBook book2;
  for (const Grade& grade : kTest2_grades)
    book2.Add(grade);

  passed = TestGradeBookCalcAverage(book2, kTest2_grades_average) && passed;

  if (passed) {
    std::cout << "  PASSED" << std::endl;
    return true;
  } else {
    std::cout << "  FAILED" << std::endl;
    return false;
  }
}

int main(int argc, char* argv[]) {
  return TestGradeBookCalcAverage() ? 0 : 1;
}
