// Copyright 2022 CSCE 240
//
// Tests csce240::hw5::Rational::Rational()
//       csce240::hw5::Rational::Rational(int)
//       csce240::hw5::Rational::Rational(int, int)
//       csce240::hw5::Rational::num() : int
//       csce240::hw5::Rational::den() : int
//
#include <hw5/inc/test_rational_header.h>

// Tests mapping from constructor parameters to respective accessors
inline bool TestRationalConstructor(const csce240::hw5::Rational&& obj,
                                    const int&& num,
                                    const int&& den) {
  std::cout << "  Expected " << num << '/' << den
    << ", Actual: " << obj.num() << '/' << obj.den() << '\n';

  return obj.num() == num && obj.den() == den;
}


// Tests three constructors of Rational
inline bool TestRationalConstructor() {
  std::cout << "TESTING " << kRational_c_str << "::Rational()" << std::endl;
  bool passed = TestRationalConstructor(csce240::hw5::Rational(), 0, 1);

  std::cout << "TESTING " << kRational_c_str << "Rational(int)" << std::endl;
  passed = TestRationalConstructor(csce240::hw5::Rational(-9), -9, 1) && passed;
  passed = TestRationalConstructor(csce240::hw5::Rational(7), 7, 1) && passed;

  std::cout << "TESTING " << kRational_c_str << "Rational(int, int)"
    << std::endl;
  passed = TestRationalConstructor(csce240::hw5::Rational(2, 3), 2, 3)
    && passed;
  passed = TestRationalConstructor(csce240::hw5::Rational(2, -3), -2, 3)
    && passed;
  passed = TestRationalConstructor(csce240::hw5::Rational(-2, -2), 2, 2)
    && passed;

  if (passed)
    std::cout << "  PASSED" << std::endl;
  else
    std::cout << "  FAILED" << std::endl;

  return passed;
}


int main(int argc, char* argv[]) {
  return TestRationalConstructor() ? 0 : 1;
}
