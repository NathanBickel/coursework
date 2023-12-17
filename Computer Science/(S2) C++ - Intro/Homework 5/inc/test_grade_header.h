// Copyright 2022 CSCE 240
//
#ifndef HW5_INC_TEST_GRADE_HEADER_H_
#define HW5_INC_TEST_GRADE_HEADER_H_

#include <hw5/inc/grade.h>
#include <hw5/inc/rational.h>
#include <cstdlib>  // atoi
#include <iostream>
#include <iomanip>
#include <string>


const char *kRational_c_str = "csce240::hw5::Rational";
const char *kGrade_c_str = "csce240::hw5::Grade";

inline void PrintPassed(bool passed) {
  std::cout << (passed ? "  PASSED" : "  FAILED") << std::endl;
}

#endif  // HW5_INC_TEST_GRADE_HEADER_H_
