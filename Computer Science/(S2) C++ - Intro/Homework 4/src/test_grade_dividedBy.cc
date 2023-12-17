// Copyright 2022 CSCE 240
//
// Test Precondition: passes Grade::ToString and Grade::Equals.
//
#include <hw4/inc/grade.h>
#include <iomanip>
#include <iostream>
#include <string>


inline bool TestDividedBy(int a, int b,
                          int c, int d,
                          const Grade& expected) {
  std::cout << "Testing Grade::DividedBy()" << std::endl;
  const Grade kLhs(a, b), kRhs(c, d);
  Grade actual = kLhs.DividedBy(kRhs);

  if (actual.Equals(expected)) {
    std::cout << "  PASSED" << std::endl;
    return true;
  }

  std::cout << "  Expected: " << expected.ToString()
    << ", Actual: " <<  actual.ToString() << '\n';
  std::cout << "  FAILED" << std::endl;

  return false;
}
bool TestDividedBy() {
  bool passed = TestDividedBy(1, 2, 2, 1, Grade(1, 4));
  passed = TestDividedBy(2, 3, 1, 3, Grade(6, 3)) && passed;

  return passed;
}


int main(int argc, char* argv[]) {
  return TestDividedBy() ? 0 : 1;
}
