// Copyright 2022 CSCE 240
//
// assumes csce240::hw5::Rational::Rational()
//         csce240::hw5::Rational::Rational(int)
//         csce240::hw5::Rational::Rational(int, int)
//         csce240::hw5::Rational::num() : int
//         csce240::hw5::Rational::den() : int
// tests csce240::hw5::Rational::Equals(csce240::hw5::Rational)
//       csce240::hw5::Rational::Equals(int)
//       csce240::hw5::Rational::operator==(csce240::hw5::Rational)
//       csce240::hw5::Rational::operator==(int)
//       csce240::hw5::operator==(int, csce240::hw5::Rational)

#include <hw5/inc/test_rational_header.h>


// Tests Rational::Equals(Rational)
inline bool TestEqualsRational(int&& num1, int&& den1,
                               int&& num2, int&& den2,
                               bool&& expected) {
  std::cout << "TESTING " << kRational_c_str << "::Rational("
    << num1 << ", " << den1 << ")::Equals(\n    " << kRational_c_str
    << "::Rational(" << num2 << ", " << den2 << ")" << std::endl;

  const csce240::hw5::Rational kLHS(num1, den1), kRHS(num2, den2);

  bool kActual = kLHS.Equals(kRHS);

  std::cout << "  Expected " << (expected ? "true" : "false") << ", Actual "
    << (kActual ? "true" : "false") << '\n';

  PrintPassed(expected == kActual);

  return expected == kActual;
}


// Tests Rational::Equals(int)
inline bool TestEqualsInt(int&& num, int&& den,
                          int&& rhs,
                          bool&& expected) {
  std::cout << "TESTING " << kRational_c_str << "::Rational("
    << num << ", " << den << ")::Equals(" << rhs << ")" << std::endl;

  const csce240::hw5::Rational kLHS(num, den);

  const bool kActual = kLHS.Equals(rhs);

  std::cout << "  Expected " << (expected ? "true" : "false") << ", Actual "
    << (kActual ? "true" : "false") << '\n';

  PrintPassed(expected == kActual);

  return expected == kActual;
}


// Tests Rational::operator==(Rational)
inline bool TestEqualsRationalOp(int&& num1, int&& den1,
                                 int&& num2, int&& den2,
                                 bool&& expected) {
  std::cout << "TESTING " << kRational_c_str << "::Rational("
    << num1 << ", " << den1 << ")::operator==(\n    " << kRational_c_str
    << "::Rational(" << num2 << ", " << den2 << ")" << std::endl;

  const csce240::hw5::Rational kLHS(num1, den1), kRHS(num2, den2);

  bool kActual = kLHS == kRHS;

  std::cout << "  Expected " << (expected ? "true" : "false") << ", Actual "
    << (kActual ? "true" : "false") << '\n';

  PrintPassed(expected == kActual);

  return expected == kActual;
}


// Tests Rational::operator==(int)
// Tests operator==(int, Rational)
inline bool TestEqualsIntOp(int&& num, int&& den,
                            int&& rhs,
                            bool&& expected) {
  std::cout << "TESTING " << kRational_c_str << "::Rational("
    << num << ", " << den << ")::operator==(" << rhs << ")" << std::endl;

  const csce240::hw5::Rational kLHS(num, den);

  const bool kActual1 = kLHS == rhs;

  std::cout << "  Expected " << (expected ? "true" : "false") << ", Actual "
    << (kActual1 ? "true" : "false") << '\n';

  std::cout << "TESTING csce240::hw5::operator==(" << rhs << ", "
    << kRational_c_str << "::Rational(" << num << ", " << den << "))" << '\n';

  const bool kActual2 = kLHS == rhs;

  std::cout << "  Expected " << (expected ? "true" : "false") << ", Actual "
    << (kActual2 ? "true" : "false") << '\n';
  PrintPassed(expected == kActual2);

  return kActual1 == kActual2 && expected == kActual1;
}


// Calls the function above with various scores and expected values. Uses
// recursion to call all or an individual function. Recursion occurs when test
// is -1 and never surpases depth 1.
int RunTests(int test) {
  if (test == -1) {
    int kTest_count = 8;
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
      return TestEqualsRational(131, 87, 262, 174, true) ? 0 : 1;
    case 1:
      return TestEqualsRational(130, 87, 262, 174, false) ? 0 : 1;
    case 2:
      return TestEqualsInt(75, 25, 3, true) ? 0 : 1;
    case 3:
      return TestEqualsInt(5, 1, 15, false) ? 0 : 1;
    case 4:
      return TestEqualsRationalOp(131, 87, 262, 174, true) ? 0 : 1;
    case 5:
      return TestEqualsRationalOp(130, 87, 262, 174, false) ? 0 : 1;
    case 6:
      return TestEqualsIntOp(75, 25, 3, true) ? 0 : 1;
    case 7:
      return TestEqualsIntOp(5, 1, 15, false) ? 0 : 1;
  }

  return -1;
}


int main(int argc, char* argv[]) {
  const int kTest_idx = 1;

  return RunTests(argc == 2 ? atoi(argv[kTest_idx]) : -1);
}
