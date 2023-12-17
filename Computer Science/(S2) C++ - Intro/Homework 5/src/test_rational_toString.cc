// Copyright 2022 CSCE 240
//
//  Assumes: csce240::hw5::Rational::Rational
//  Tests: csce240::hw5::Rational::ToString
//
#include <hw5/inc/test_rational_header.h>

inline bool TestRationalToString(int a, int b, const std::string& expected) {
  std::cout << "TESTING " << kRational_c_str << "::Rational(" << a << ", " << b
    << ").ToString()" << std::endl;

  const csce240::hw5::Rational kRational(a, b);

  const std::string kActual = kRational.ToString();
  std::cout << "  Expected: " << expected << ", Actual: " <<  kActual << std::endl;

  const bool kPassed = expected == kActual;
  PrintPassed(kPassed);

  return kPassed;
}


// Calls the function above with various scores and expected values. Uses
// recursion to call all or an individual function. Recursion occurs when test
// is -1 and never surpases depth 1.
int RunTests(int test) {
  if (test == -1) {
    int kTest_count = 2;
    int code = 0;
    for (int i = 0; i < kTest_count; ++i) {
      if (code == 0)
        code = RunTests(i);
      else
        RunTests(i);
    }

    return code;
  }

  switch (test) {
    case 0:
      return TestRationalToString(3, 7, "3/7") ? 0 : 1;
    case 1:
      return TestRationalToString(0, 10, "0") ? 0 : 1;
  }

  return -1;
}


int main(int argc, char* argv[]) {
  const int kTest_idx = 1;

  return RunTests(argc == 2 ? atoi(argv[kTest_idx]) : -1);
}
