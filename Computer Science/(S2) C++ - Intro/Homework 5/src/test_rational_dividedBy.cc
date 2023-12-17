// Copyright 2022 CSCE 240
//
// assumes csce240::hw5::Rational::Rational()
//         csce240::hw5::Rational::Rational(int)
//         csce240::hw5::Rational::Rational(int, int)
//         csce240::hw5::Rational::num() : int
//         csce240::hw5::Rational::den() : int
//         csce240::hw5::Rational::ToString()
//         csce240::hw5::Rational::operator==(Rational)
//         csce240::hw5::Rational::operator==(int)
// tests csce240::hw5::Rational::DividedBy(csce240::hw5::Rational)
//       csce240::hw5::Rational::DividedBy(int)
//       csce240::hw5::Rational::operator/(csce240::hw5::Rational)
//       csce240::hw5::Rational::operator/(int)
//       csce240::hw5::operator/(int, csce240::hw5::Rational)

#include <hw5/inc/test_rational_header.h>


// Tests Rational::DividedBy(Rational)
inline bool TestDividedByRational(int&& num1, int&& den1,
                                  int&& num2, int&& den2,
                                  const csce240::hw5::Rational&& expected) {
  std::cout << "TESTING " << kRational_c_str << "::Rational("
    << num1 << ", " << den1 << ")::DividedBy(\n    " << kRational_c_str
    << "::Rational(" << num2 << ", " << den2 << ")" << std::endl;

  const csce240::hw5::Rational kLHS(num1, den1), kRHS(num2, den2);

  csce240::hw5::Rational kActual = kLHS.DividedBy(kRHS);

  std::cout << "  Expected " << expected << ", Actual " << kActual << '\n';

  PrintPassed(kActual == expected);

  return kActual == expected;
}


// Tests Rational::operator/(Rational)
inline bool TestDividedByRationalOp(int&& num1, int&& den1,
                                    int&& num2, int&& den2,
                                    const csce240::hw5::Rational&& expected) {
  std::cout << "TESTING " << kRational_c_str << "::Rational("
    << num1 << ", " << den1 << ")::operator/(\n    " << kRational_c_str
    << "::Rational(" << num2 << ", " << den2 << ")" << std::endl;

  const csce240::hw5::Rational kLHS(num1, den1), kRHS(num2, den2);

  const csce240::hw5::Rational kActual = kLHS / kRHS;

  std::cout << "  Expected " << expected << ", Actual " << kActual << '\n';

  PrintPassed(expected == kActual);

  return expected == kActual;
}


// Tests Rational::DividedBy(int)
inline bool TestDividedByInt(int&& num, int&& den,
                             int&& rhs,
                             const csce240::hw5::Rational&& expected) {
  std::cout << "TESTING " << kRational_c_str << "::Rational("
    << num << ", " << den << ")::DividedBy(" << rhs << ")" << std::endl;

  const csce240::hw5::Rational kLHS(num, den);

  const csce240::hw5::Rational kActual = kLHS.DividedBy(rhs);

  std::cout << "  Expected: " << expected << ", Actual: " << kActual << '\n';

  PrintPassed(expected == kActual);

  return expected == kActual;
}


// Tests Rational::operator/(int)
// Tests operator/(int, Rational)
inline bool TestDividedByIntOp(int&& num, int&& den,
                               int&& rhs,
                               const csce240::hw5::Rational&& expected) {
  std::cout << "TESTING " << kRational_c_str << "::Rational("
    << num << ", " << den << ")::operator/(" << rhs << ")" << std::endl;

  const csce240::hw5::Rational kLHS(num, den);

  const csce240::hw5::Rational kActual1 = kLHS / rhs;

  std::cout << "  Expected: " << expected << ", Actual: " << kActual1 << '\n';

  std::cout << "TESTING csce240::hw5::operator/(" << rhs << ", "
    << kRational_c_str << "::Rational(" << num << ", " << den << "))" << '\n';

  const csce240::hw5::Rational kExpected2(rhs * den, num);
  const csce240::hw5::Rational kActual2 = rhs / kLHS;

  std::cout << "  Expected: " << kExpected2 << ", Actual: " << kActual2 << '\n';

  PrintPassed(kExpected2 == kActual2);

  return kActual1 == expected && kActual2 == kExpected2;
}


// Calls the function above with various scores and expected values. Uses
// recursion to call all or an individual function. Recursion occurs when test
// is -1 and never surpases depth 1.
int RunTests(int test) {
  if (test == -1) {
    int kTest_count = 4;
    int code = 0;
    for (int i = 0; i < kTest_count; ++i)
      if (code == 0)
        code = RunTests(i);
      else
        RunTests(i);

    return code;
  }

  switch (test) {
    case 0:
      return TestDividedByRational(1, 2, 1, 4, csce240::hw5::Rational(2, 1)) ? 0 : 1;
    case 1:
      return TestDividedByRationalOp(1, 2, 1, 4, csce240::hw5::Rational(2, 1)) ? 0 : 1;
    case 2:
      return TestDividedByInt(1, 2, 3, csce240::hw5::Rational(1, 6)) ? 0 : 1;
    case 3:
      return TestDividedByIntOp(1, 2, 3, csce240::hw5::Rational(1, 6)) ? 0 : 1;
  }

  return -1;
}


int main(int argc, char* argv[]) {
  const int kTest_idx = 1;

  return RunTests(argc == 2 ? atoi(argv[kTest_idx]) : -1);
}
