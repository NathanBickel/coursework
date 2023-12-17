// Copyright 2022 CSCE 240
//
//  Assumes: csce240::hw5::Rational::Rational
//           csce240::hw5::Grade::Grade
//  Tests: csce240::hw5::Grade::ToDouble
//         csce240::hw5::Grade::ToDouble (as csce240::hw5::Rational::ToDouble)
//
#include <hw5/inc/test_grade_header.h>


// Compares two doubles exactly, prints values to a large fixed precision to
//   show any non-printable differences in values.
inline bool CompareDoubles(double expected, double actual) {
  int kPrintPrecision = 12;

  std::cout << std::fixed << std::setprecision(kPrintPrecision)
    << "  Expected: " << expected << ", Actual: " <<  actual << '\n';

  PrintPassed(actual == expected);
 
  return actual == expected;
}


bool TestRationalToDouble(int a, int b, double expected) {
  double actual = csce240::hw5::Rational(a, b).ToDouble();

  std::cout << "TESTING " << kRational_c_str << "::Rational(" << a << ", "
    << b << ").ToDouble()" << std::endl;

  return CompareDoubles(expected, actual);
}


bool TestGradeToDouble(int a, int b, int precision, double expected) {
  const csce240::hw5::Grade kGrade(a, b);
  double actual;

  if (precision > -1) {
    std::cout << "TESTING " << kGrade_c_str << "::Grade(" << a << ", " << b
      << ").ToDouble(" << precision << ")" << std::endl;
    actual = kGrade.ToDouble(precision);  // test Grade::ToDouble(unsigned int)

    return CompareDoubles(expected, actual);
  }
  
  std::cout << "TESTING " << kGrade_c_str << "::Grade(" << a << ", " << b
    << ").ToDouble()" << std::endl;
  actual = kGrade.ToDouble();  // test Grade::ToDouble()
  bool passed = CompareDoubles(expected, actual);

  // cast to Rational to ensure parent method was correctly named explicit and
  // overridden in Grade
  std::cout << "TESTING dynamic_cast<const " << kRational_c_str
    << "::Rational *>(\n    &" << kGrade_c_str << "::Grade(" << a << ", " << b
    << "))->ToDouble()" << std::endl;

  // test Grade::ToDouble as Rational::ToDouble
  actual = dynamic_cast<const csce240::hw5::Rational *>(&kGrade)->ToDouble();
  return CompareDoubles(expected, actual) && passed;
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
      return TestGradeToDouble(2, 6, 4, 33.3333) ? 0 : 1;
    case 1:
      return TestGradeToDouble(2, 6, 2, 33.33) ? 0 : 1;
    case 2:
      return TestGradeToDouble(2, 6, 0, 33.0) ? 0 : 1;
    case 3:
      return TestGradeToDouble(2, 6, -1, 33.333) ? 0 : 1;
  }

  return -1;
}


int main(int argc, char* argv[]) {
  const int kTest_idx = 1;

  return RunTests(argc == 2 ? atoi(argv[kTest_idx]) : -1);
}
