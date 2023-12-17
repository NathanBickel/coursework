// Copyright 2022 CSCE 240
//
//  Assumes: csce240::hw5::Grade::Grade
//  Tests: csce240::hw5::Grade::ToString
//         csce240::hw5::Grade::ToString (as csce240::hw5::Rational::ToString)
//
#include <hw5/inc/test_grade_header.h>


inline bool TestGradeToString(int a, int b, const std::string& expected) {
  std::cout << "TESTING " << kGrade_c_str << "::Grade(" << a << ", " << b
    << ").ToString()" << std::endl;

  const csce240::hw5::Grade kGrade(a, b);

  std::string actual = kGrade.ToString();
  std::cout << "  Expected: " << expected << ", Actual: " <<  actual << std::endl;

  bool passed = actual == expected;
  PrintPassed(passed);

  std::cout << "TESTING dynamic_cast<const " << kRational_c_str 
    << "::Rational *>(\n    " << kGrade_c_str << "::Grade(" << a << ", " << b
    << "))->ToString()" << std::endl;

  actual = dynamic_cast<const csce240::hw5::Rational *>(&kGrade)->ToString();
  std::cout << "  Expected: " << expected << ", Actual: " <<  actual << std::endl;

  passed = actual == expected;
  PrintPassed(passed);

  return passed;
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
      return TestGradeToString(3, 7, "3/7") ? 0 : 1;
    case 1:
      return TestGradeToString(0, 10, "0/10") ? 0 : 1;
  }

  return -1;
}


int main(int argc, char* argv[]) {
  const int kTest_idx = 1;

  return RunTests(argc == 2 ? atoi(argv[kTest_idx]) : -1);
}
