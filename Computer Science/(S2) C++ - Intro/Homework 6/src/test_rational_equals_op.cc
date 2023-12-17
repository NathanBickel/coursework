// Copyright 2022 CSCE 240
//
// Requires csce240::hw6::Rational::Rational(unsigned int, unsigned int)
//          csce240::hw6::operator<<(std::ostream, csce240::hw6::Rational)
//
// Tests csce240::hw6::Rational::operator==(Rational)
//
#include <hw6/inc/test_rational.h>


// Compares the equality of two Rational args with the expected equality using
// the bool operator==(Rational, Rational) overloaded operator function.
inline bool TestRationalEqualsOp(const csce240::hw6::Rational& lhs,
                                 const csce240::hw6::Rational& rhs,
                                 bool expected) {
  std::cout << "TESTING " << kRational_c_str << "(" << lhs << ")::operator==("
    << rhs << ")\n";

  bool actual = lhs == rhs;

  std::cout << "  Expected " << (expected ? "true" : "false")
    << ", Actual: " << (actual ? "true" : "false") << '\n';

  if (actual == expected) {
    std::cout << "  PASSED" << std::endl;

    return true;
  } else {
    std::cout << "  FAILED" << std::endl;

    return false;
  }
}


// Calls the function above with various scores and expected values. Uses
// recursion to call all or an individual function(s). Recursion occurs when test
// is -1 and never surpases call stack depth 1.
int TestRationalEqualsOp(int test) {
  if (test == -1) {
    int kTest_count = 2;
    int code = 0;
    for (int i = 0; i < kTest_count; ++i) {
      if (code == 0)
        code = TestRationalEqualsOp(i);
      else
        TestRationalEqualsOp(i);
    }

    return code;
  }

  switch (test) {
    case 0:
      return TestRationalEqualsOp(
        csce240::hw6::Rational(3, 4),
        csce240::hw6::Rational(36, 48),
        true
      ) ? 0 : 1;
    case 1:
      return TestRationalEqualsOp(
        csce240::hw6::Rational(3888885, 4444440),
        csce240::hw6::Rational(3888886, 4444440),
        false
      ) ? 0 : 1;
  }

  return 17;
}


int main(int argc, char* argv[]) {
  const int kTest_idx = 1;

  return TestRationalEqualsOp(argc == 2 ? atoi(argv[kTest_idx]) : -1);
}
