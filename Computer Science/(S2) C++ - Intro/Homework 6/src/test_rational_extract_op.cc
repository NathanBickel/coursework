// Copyright 2022 CSCE 240
//
// Requires csce240::hw6::Rational::Rational(unsigned int, unsigned int)
//          csce240::hw6::Rational::num()
//          csce240::hw6::Rational::den()
//
// Tests csce240::hw6::operator<<(std::ostream, csce240::hw6::Rational)
//
#include <hw6/inc/test_rational.h>


// Uses a stringstream to mock the standard output stream, extracts the
// contents of given Rational object, and compares to provided string.
//
inline bool TestRationalExtractOp(const csce240::hw6::Rational& ratio,
                                  const std::string& expected) {
  std::cout << "TESTING csce240::hw6::operator<<(std::ostream&, "
    << "csce240::hw6::Rational(" << ratio.num() << ", " << ratio.den()
    << "))" << std::endl;

  std::stringstream sout;  // STDOUT mock

  sout << ratio;  // extract rational

  std::cout << "  Expected " << expected << ", Actual: " << sout.str() << '\n';

  if (sout.str() == expected) {
    std::cout << "  PASSED" << std::endl;

    return true;
  } else {
    std::cout << "  FAILED" << std::endl;

    return false;
  }
}

// Calls the function above with various scores and expected values. Uses
// recursion to call all or an individual function. Recursion occurs when test
// is -1 and never surpases depth 1.
//
int TestRationalExtractOp(int test) {
  if (test == -1) {
    int kTest_count = 5;
    int code = 0;
    for (int i = 0; i < kTest_count; ++i) {
      if (code == 0)
        code = TestRationalExtractOp(i);
      else
        TestRationalExtractOp(i);
    }

    return code;
  }

  switch (test) {
    case 0:
      return TestRationalExtractOp(csce240::hw6::Rational(3, 4), "3/4") ? 0 : 1;
    case 1:
      return TestRationalExtractOp(csce240::hw6::Rational(-3, 4), "-3/4")
        ? 0 : 1;
    case 2:
      return TestRationalExtractOp(csce240::hw6::Rational(-3, -4), "3/4")
        ? 0 : 1;
    case 3:
      return TestRationalExtractOp(csce240::hw6::Rational(81), "81")
        ? 0 : 1;
    case 4:
      return TestRationalExtractOp(csce240::hw6::Rational(0, 5), "0")
        ? 0 : 1;
  }

  return 17;
}


int main(int argc, char* argv[]) {
  const int kTest_idx = 1;

  return TestRationalExtractOp(argc == 2 ? atoi(argv[kTest_idx]) : -1);
}
