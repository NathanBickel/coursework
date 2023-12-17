// Copyright 2022 CSCE 240
//
//  Assumes: csce240::hw5::Rational::Rational
//  Tests: csce240::hw5::Rational::ToDouble
//
#include <hw5/inc/test_rational_header.h>


// Compares two doubles exactly, prints values to a large fixed precision to
//   show any non-printable differences in values.
inline bool CompareDoubles(double expected, double actual) {
  int kPrint_precision = 12;

  std::cout << std::fixed << std::setprecision(kPrint_precision)
    << "  Expected: " << expected << ", Actual: " <<  actual << '\n';

  PrintPassed(actual == expected);
 
  return actual == expected;
}


bool TestRationalToDouble(int a, int b, double expected) {
  double actual = csce240::hw5::Rational(a, b).ToDouble();

  std::cout << "TESTING " << kRational_c_str << "::Rational(" << a << ", "
    << b << ").ToDouble()" << std::endl;

  return CompareDoubles(expected, actual);
}


int main(int argc, char* argv[]) {
  return TestRationalToDouble(2, 6, 1.0/3.0)
      && TestRationalToDouble(1, 4, 1.0/4.0) 
      && TestRationalToDouble(5, 7, 5.0/7.0) ? 0 : 1;
}
