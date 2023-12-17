// Copyright 2022 CSCE 240
//
#include <hw4/inc/grade.h>
#include <iomanip>
#include <iostream>


bool TestToDouble(int a, int b, int precision, double expected) {
  const Grade kGrade(a, b);
  double actual;

  if (precision > 0) {
    std::cout << "Testing Grade(" << a << ", " << b
      << ")::ToDouble(" << precision << ")" << std::endl;
    actual = kGrade.ToDouble(precision);  // test Grade::ToDouble(unsigned int)
  } else {
    std::cout << "Testing Grade(" << a << ", " << b
      << ")::ToDouble()" << std::endl;
    actual = kGrade.ToDouble();  // test Grade::ToDouble()
  }

  if (actual == expected) {
    std::cout << "  PASSED" << std::endl;
    return true;
  }

  int kPrintPrecision = 12;
  std::cout << std::fixed << std::setprecision(kPrintPrecision);
  std::cout << "  Expected: " << expected << ", Actual: " <<  actual << '\n';
  std::cout << "  FAILED" << std::endl;
  std::cout << std::defaultfloat << std::resetiosflags;

  return false;
}


bool TestToDouble() {
  bool passed = TestToDouble(5, 10, 3, 50.0);
  passed = TestToDouble(2, 3, -1, 66.667) && passed;
  passed = TestToDouble(2, 3, 2, 66.67) && passed;

  return passed;
}


int main(int argc, char* argv[]) {
  TestToDouble();

  return 0;
}
