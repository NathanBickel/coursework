// Copyright 2022 CSCE 240
//
// Requires csce240::hw6::Rational::Rational(unsigned int, unsigned int)
//          csce240::hw6::operator<<(std::ostream, csce240::hw6::Rational)
//          csce240::hw6::Rational::operator==(csce240::hw6::Rational)
//
//          csce240::hw6::Grade<int | double | Rational>::Grade(double)
//
// Tests csce240::hw6::Grade<int | double | Rational>::ToLetter(unsigned int)
//       csce240::hw6::Grade<int | double | Rational>::ToLetter()
//
#include <hw6/inc/test_grade.h>

// Uses a type T score to build a Grade object. Compares result of Grade
// object's ToLetter method to an expected value. When threshold < 1, ToLetter
// is called, otherwise ToLetter(unsigned int) is tested.
template <class T>
inline bool TestGradeToLetter(const T& score,
                              int threshold,
                              const std::string& expected,
                              const char* type) {
  std::cout << std::fixed << std::setprecision(5)
    << "TESTING " << kGrade_c_str << '<' << type <<  ">(" << score
    << ")::ToLetter(" << (threshold > 0 ? std::to_string(threshold) : "")
    << ")\n";

  const csce240::hw6::Grade<T> g_obj{score};

  const std::string actual = threshold > 0
                           ? g_obj.ToLetter(threshold)
                           : g_obj.ToLetter();

  std::cout << "  Expected " << expected << ", Actual: " << actual << '\n';

  if (actual == expected) {
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
int TestGradeToLetter(int test) {
  if (test == -1) {
    int kTest_count = 5;
    int code = 0;
    for (int i = 0; i < kTest_count; ++i) {
      if (code == 0)
        code = TestGradeToLetter(i);
      else
        TestGradeToLetter(i);
    }

    return code;
  }

  switch (test) {
    case 0:
      return TestGradeToLetter<int>(89, -1, "B", "int") ? 0 : 1;
    case 1:
      return TestGradeToLetter<double>(89.9999, 50, "B+", "double") ? 0 : 1;
    case 2:
      return TestGradeToLetter<double>(89.99999, 50, "A", "double") ? 0 : 1;
    case 3:
      return TestGradeToLetter<csce240::hw6::Rational>(
        csce240::hw6::Rational(849, 10), 50, "B",
        "csce240::hw6::Rational") ? 0 : 1;
    case 4:
      return TestGradeToLetter<csce240::hw6::Rational>(
        csce240::hw6::Rational(84999999, 1000000), 50, "B+",
        "csce240::hw6::Rational") ? 0 : 1;
  }

  return 17;
}


int main(int argc, char* argv[]) {
  const int kTest_idx = 1;

  return TestGradeToLetter(argc == 2 ? atoi(argv[kTest_idx]) : -1);
}
