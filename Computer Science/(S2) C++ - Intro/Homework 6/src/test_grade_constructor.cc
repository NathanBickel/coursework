// Copyright 2022 CSCE 240
//
// Requires csce240::hw6::Rational::Rational(unsigned int, unsigned int)
//          csce240::hw6::operator<<(std::ostream, csce240::hw6::Rational)
//          csce240::hw6::Rational::operator==(csce240::hw6::Rational)
//
// Tests csce240::hw6::Grade<int | double | Rational>::Grade(double)
//       csce240::hw6::Grade<int | double | Rational>::score()
//
#include <hw6/inc/test_grade.h>


// Tests mapping of constructor parameters to their respective accessors
template <class T>
inline bool TestGradeConstructor(const T& expected, const char* type) {
  std::cout << "TESTING " << kGrade_c_str << '<' << type
    <<  ">::Grade(" << expected << ")\n";

  const csce240::hw6::Grade<T> g_obj{expected};

  std::cout << "  Expected " << expected
    << ", Actual: " << g_obj.score() << '\n';

  if (g_obj.score() == expected) {
    std::cout << "  PASSED" << std::endl;

    return true;
  } else {
    std::cout << "  FAILED" << std::endl;

    return false;
  }
}

int TestGradeConstructor(int test) {
  if (test == -1) {
    const int kTest_count = 3;

    int code = 0;
    for (int i = 0; i < kTest_count; ++i) {
      if (code == 0)
        code = TestGradeConstructor(i);
      else
        TestGradeConstructor(i);
    }

    return code;
  }
  switch (test) {
    case 0:
      return TestGradeConstructor<int>(89, "int") ? 0 : 1;
    case 1:
      return TestGradeConstructor<double>(89.9, "double") ? 0 : 1;
    case 2:
      return TestGradeConstructor<csce240::hw6::Rational>(
        csce240::hw6::Rational(899, 10),
        "csce240::hw6::Rational"
      ) ? 0 : 1;
    default:
      return 17;
  }
}


int main(int argc, char* argv[]) {
  const int kTest_idx = 1;

  return TestGradeConstructor(argc == 2 ? atoi(argv[kTest_idx]) : -1);
}
