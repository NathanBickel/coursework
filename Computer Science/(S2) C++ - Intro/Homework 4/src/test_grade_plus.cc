// Copyright 2022 CSCE 240
//
// Test Precondition: passes Grade::ToString and Grade::Equals.
//
#include <hw4/inc/grade.h>
#include <iomanip>
#include <iostream>
#include <string>


inline bool TestPlus(int a, int b,
                          int c, int d,
                          const Grade& expected) {
  std::cout << "Testing Grade::Plus()" << std::endl;
  const Grade kLhs(a, b), kRhs(c, d);
  Grade actual = kLhs.Plus(kRhs);

  if (actual.Equals(expected)) {
    std::cout << "  PASSED" << std::endl;
    return true;
  }

  std::cout << "  Expected: " << expected.ToString()
    << ", Actual: " <<  actual.ToString() << '\n';
  std::cout << "  FAILED" << std::endl;

  return false;
}


bool TestPlus() {
  bool passed = TestPlus(1, 2, 2, 1, Grade(5, 2));
  passed = TestPlus(2, 3, 1, 3, Grade(3, 3)) && passed;

  return passed;
}


int main(int argc, char* argv[]) {
  return TestPlus() ? 0 : 1;
}
