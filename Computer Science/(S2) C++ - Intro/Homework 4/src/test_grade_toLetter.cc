// Copyright 2022 CSCE 240
//
// Test Grade::ToLetter with param and without. Expects default parameter value
// or an overloaded method.
//
#include <hw4/inc/grade.h>
#include <iostream>
#include <string>


inline bool TestToLetter(int a, int b, int t, const std::string& expected) {
  std::cout << "Testing Grade(" << a << ", " << b;
  const Grade kGrade(a, b);
  std::string actual;
  if (t > 0) {
    actual = kGrade.ToLetter(t);  // testing Grade::ToLetter with parameter
    std::cout << ")::ToLetter(" << t << ")\n";
  } else {
    actual = kGrade.ToLetter();  // testing Grade::ToLetter without parameter
    std::cout << ")::ToLetter()\n";
  }

  if (actual == expected) {
    std::cout << "  PASSED" << std::endl;
    return true;
  }

  std::cout << "  Expected: " << expected << ", Actual: " <<  actual << '\n';
  std::cout << "  FAILED" << std::endl;

  return false;
}
bool TestToLetter() {
  bool passed = TestToLetter(11, 10, 75, "A+");
  passed = TestToLetter(39, 40, 75, "A+") && passed;
  passed = TestToLetter(38, 40, 75, "A") && passed;
  passed = TestToLetter(39, 40, -1, "A") && passed;

  return passed;
}


int main(int argc, char* argv[]) {
  return TestToLetter() ? 0 : 1;
}
