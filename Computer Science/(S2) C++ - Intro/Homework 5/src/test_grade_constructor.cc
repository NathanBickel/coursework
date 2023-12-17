// Copyright 2022 CSCE 240
//
// Tests csce240::hw5::Grade::Grade(unsigned int, unsigned int)
//       csce240::hw5::Grade::scored() : unsigned int
//       csce240::hw5::Grade::total() : unsigned int
//
#include <hw5/inc/test_grade_header.h>

// Tests mapping of constructor parameters to their respective accessors
// Ensures Rational's num and den are Grade's scored and total
inline bool TestGradeConstructor() {
  std::cout << "TESTING " << kGrade_c_str << "::Grade(int, int)" << std::endl;

  const unsigned int scored = 9, total = 10;
  const csce240::hw5::Grade g_obj{scored, total};

  std::cout << "  Expected " << scored << '/' << total
    << ", Actual: " << g_obj.scored() << '/' << g_obj.total() << '\n';

  bool passed = g_obj.scored() == scored && g_obj.total() == total
                // using arbitrarily true comparison to force signedness warning
                && g_obj.scored() < scored + 1
                && g_obj.total() < total + 1;

  // ensure the accessors are accessing the same variables
  const csce240::hw5::Rational *r_ptr = &g_obj;

  std::cout << "TESTING " << kGrade_c_str
    << "::Grade(" << scored << ", " << total << ")::{scored, total}" << std::endl
    << "     == " << kRational_c_str << "::Rational(" << scored << ", " << total
    << ")::{num, den}\n  Expected: [" << g_obj.scored() << ", " << g_obj.total()
    << "], Actual: [" << r_ptr->num() << ", " << r_ptr->den() << ']' << std::endl;

  passed = r_ptr->num() == static_cast<int>(g_obj.scored())
           && r_ptr->den() == static_cast<int>(g_obj.total())
           && passed;
  PrintPassed(passed);

  return passed;
}


int main(int argc, char* argv[]) {
  return TestGradeConstructor() ? 0 : 1;
}
