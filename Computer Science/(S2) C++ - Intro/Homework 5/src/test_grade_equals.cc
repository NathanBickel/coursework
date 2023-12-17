// Copyright 2022 CSCE 240
//
// assumes csce240::hw5::Grade::Grade(unsigned int, unsigned int)
//         csce240::hw5::Grade::scored() : unsigned int
//         csce240::hw5::Grade::total() : unsigned int
// tests csce240::hw5::Grade::operator==(csce240::hw5::Grade)
//       csce240::hw5::Grade::operator==(int)
//       csce240::hw5::operator==(int, csce240::hw5::Grade)
//
#include <hw5/inc/test_grade_header.h>


// Tests Grade::Equals(Grade)
inline bool TestEqualsGrade(int&& scored1, int&& total1,
                            int&& scored2, int&& total2,
                            bool&& expected) {
  std::cout << "TESTING " << kGrade_c_str << "::Grade("
    << scored1 << ", " << total1 << ") == " << kGrade_c_str
    << "::Grade(" << scored2 << ", " << total2 << ")" << std::endl;

  const csce240::hw5::Grade kLHS(scored1, total1), kRHS(scored2, total2);

  const bool kActual = kLHS == kRHS;  // testing Grade::operator==(Grade)
  std::cout << "  Expected " << (expected ? "true" : "false")
    << ", Actual " << (kActual ? "true" : "false") << '\n';

  const bool kPassed = kActual == expected;
  PrintPassed(kPassed);

  return kPassed;
}


// Tests Grade::Equals(int)
bool TestEqualsInt(int&& scored, int&& total,
                   int&& rhs,
                   bool&& expected) {
  std::cout << "TESTING " << kGrade_c_str << "::Grade("
    << scored << ", " << total << ") == " << rhs << std::endl;

  const csce240::hw5::Grade kLHS(scored, total);

  bool actual = kLHS == rhs;

  std::cout << "  Expected " << (expected ? "true" : "false") << ", Actual "
    << (actual ? "true" : "false") << '\n';

  const bool kPassed_rhs = actual == expected;

  std::cout << "TESTING " << rhs << " == " << kGrade_c_str << "::Grade("
    << scored << ", " << total << ")" << std::endl;

  actual = rhs == kLHS;
  std::cout << "  Expected " << (expected ? "true" : "false") << ", Actual "
    << (actual ? "true" : "false") << '\n';

  const bool kPassed_lhs = actual == expected;

  PrintPassed(kPassed_rhs && kPassed_lhs);

  return kPassed_rhs && kPassed_lhs;
}


// Calls the function above with various scores and expected values. Uses
// recursion to call all or an individual function. Recursion occurs when test
// is -1 and never surpases depth 1.
int RunTests(int test) {
  if (test == -1) {
    const int kTest_count = 4;
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
      return TestEqualsGrade(3, 7, 6, 14, true) ? 0 : 1;
    case 1:
      return TestEqualsGrade(3, 7, 5, 14, false) ? 0 : 1;
    case 2:
      return TestEqualsInt(12, 3, 4, true) ? 0 : 1;
    case 3:
      return TestEqualsInt(12, 4, 4, false) ? 0 : 1;
  }

  return -1;
}


int main(int argc, char* argv[]) {
  const int kTest_idx = 1;

  return RunTests(argc == 2 ? atoi(argv[kTest_idx]) : -1);
}
