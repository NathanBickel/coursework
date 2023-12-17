// Copyright 2022 CSCE 240
//
// Test Precondition: passes Grade::ToString.
//
#include <hw4/inc/grade.h>
#include <iomanip>
#include <iostream>
#include <string>


inline bool TestEquals(int a, int b, int c, int d, bool expected) {
  std::cout << "Testing Grade::Equals()" << std::endl;
  const Grade kLhs(a, b), kRhs(c, d);
  const bool kActual = kLhs.Equals(kRhs);

  if (kActual == expected) {
    std::cout << "  PASSED" << std::endl;
    return true;
  }

  std::cout << "  Expected: " << kLhs.ToString();
  if (expected)
    std::cout << " == ";
  else
    std::cout << " != ";
  std::cout << kRhs.ToString() << '\n';


  std::cout << "  Actual: " <<  kLhs.ToString();
  if (!expected)
    std::cout << " == ";
  else
    std::cout << " != ";
  std::cout << kRhs.ToString() << '\n';

  std::cout << "  FAILED" << std::endl;

  return false;
}

bool TestEquals() {
  bool passed = TestEquals(1, 2, 1, 2, true);
  passed = TestEquals(2, 6, 1, 3, true) && passed;
  passed = TestEquals(2, 3, 1, 3, false) && passed;

  return passed;
}


int main(int argc, char* argv[]) {
  return TestEquals() ? 0 : 1;
}
