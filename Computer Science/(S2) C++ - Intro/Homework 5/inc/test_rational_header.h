// Copyright 2022 CSCE 240
//
#ifndef HW5_INC_TEST_RATIONAL_HEADER_H_
#define HW5_INC_TEST_RATIONAL_HEADER_H_

#include <hw5/inc/rational.h>
#include <cstdlib>  // atoi
#include <iostream>
#include <iomanip>
#include <string>


const char *kRational_c_str = "csce240::hw5::Rational";

inline void PrintPassed(bool passed) {
  std::cout << (passed ? "  PASSED" : "  FAILED") << std::endl;
}

inline std::ostream& operator<<(std::ostream& lhs, const csce240::hw5::Rational& rhs) {
  return lhs << rhs.ToString();
}

#endif  // HW5_INC_TEST_RATIONAL_HEADER_H_
