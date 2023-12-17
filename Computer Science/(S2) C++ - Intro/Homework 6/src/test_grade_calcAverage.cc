// Copyright 2022 CSCE 240
//
// Requires csce240::hw6::Rational::Rational(unsigned int, unsigned int)
//          csce240::hw6::Rational::operator==(csce240::hw6::Rational)
//          csce240::hw6::operator<<(std::ostream, csce240::hw6::Rational)
//
//          csce240::hw6::Grade<int | double | Rational>::Grade(double)
//
// Tests csce240::hw6::Grade<int | double | Rational>::CalcAverage(
//         std::vector<int | double | Rational>
//       )
#include <hw6/inc/test_grade.h>


// Overloads extraction to make a comma-separated list of elements of rhs
//
template <class T>
std::ostream& operator<<(std::ostream& lhs, const std::vector<T>& rhs) {
  for (auto itr = rhs.begin(); itr != rhs.end(); ++itr)
    if (itr + 1 != rhs.end())
      lhs << *itr << ", ";  // not last elem, use delimiter
    else
      lhs << *itr;

  return lhs;
}


// Passes a vector of type T scores to the static method Grade::CalcAverage and
// compares result to expected value.
//
template <class T>
inline bool TestGradeCalcAverage(const char* type,
                                 const std::vector<T>& scores,
                                 const T& expected ) {
  std::cout << "TESTING " << kGrade_c_str << '<' << type
    <<  ">::CalcAverage({" << scores << "})\n";

  csce240::hw6::Grade<T> actual{csce240::hw6::Grade<T>::CalcAverage(scores)};

  std::cout << "  Expected " << expected
    << ", Actual: " << actual.score() << '\n';

  if (actual.score() == expected) {
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
int TestGradeCalcAverage(int test) {
  if (test == -1) {
    int kTest_count = 3;
    int code = 0;
    for (int i = 0; i < kTest_count; ++i) {
      if (code == 0)
        code = TestGradeCalcAverage(i);
      else
        TestGradeCalcAverage(i);
    }

    return code;
  }

  switch (test) {
    case 0: {
      const std::vector<int> scores{91, 78, 79, 92};
      return TestGradeCalcAverage<int>("int", scores, 85) ? 0 : 1;
    } case 1: {
      const std::vector<double> scores{89.0, 78.0, 79.0, 93.0};
      return TestGradeCalcAverage<double>("double", scores, 84.75) ? 0 : 1;
    } case 2: {
      const std::vector<csce240::hw6::Rational> scores{
        csce240::hw6::Rational(1, 2),
        csce240::hw6::Rational(3, 4),
        csce240::hw6::Rational(1, 4),
        csce240::hw6::Rational(4, 8)
      };
      return TestGradeCalcAverage<csce240::hw6::Rational>(
        "csce240::hw6::Rational",
        scores,
        csce240::hw6::Rational(1, 2)
      ) ? 0 : 1;
    }
  }

  return 17;
}


int main(int argc, char* argv[]) {
  const int kTest_idx = 1;

  return TestGradeCalcAverage(argc == 2 ? atoi(argv[kTest_idx]) : -1);
}
