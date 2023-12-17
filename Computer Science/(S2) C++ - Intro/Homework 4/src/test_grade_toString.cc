// Copyright 2022 CSCE 240
//
#include <hw4/inc/grade.h>
#include <iostream>
#include <string>


inline bool TestToString(int a, int b, const std::string& expected) {
  std::cout << "Testing Grade(" << a << ", " << b << ")::ToString()"
    << std::endl;
  const Grade kGrade(a, b);
  std::string actual = kGrade.ToString();

  if (actual == expected) {
    std::cout << "  PASSED" << std::endl;
    return true;
  }

  std::cout << "  Expected: " << expected << ", Actual: " <<  actual << '\n';
  std::cout << "  FAILED" << std::endl;

  return false;
}


inline bool TestToString() {
  bool passed = TestToString(5, 10, "5/10");
  passed = TestToString(0, 3, "0") && passed;

  return passed;
}


int main(int argc, char* argv[]) {
  return TestToString() ? 0 : 1;
}
