// Copyright 2022 CSCE 240
//
#include <hw2/parse_scores.h>

#include <iostream>
#include <string>

const std::string kGoodInput[] = {    // NOLINT
  "gsmith", "4", "90.23", "81.21", "89.33", "100.0"
};
const size_t kGoodInputSize = 6;

const size_t kBadInputSize = 4;
std::string kBadInput[][kBadInputSize] = {  // NOLINT
  { "aname", "-2", "89.1", "88.0" },
  { "aname", "2", "-89.1", "88.0" },
  { "aname", "2", "i8.1", "88.0" }
};
const size_t kBadInputNoTests = 3;



bool TestGetGradeCount();
bool TestGetGradeCountCorrupt();

int main(int argc, char* argv[]) {
  int passed = 0;
  // test GetStudentGradeCount
  std::cout << "Testing GetGradeCount" << std::endl;
  if (TestGetGradeCount()) {
    std::cout << "  PASSED" << std::endl;
  } else {
    std::cout << "  FAILED" << std::endl;
    passed = 1;
  }

  std::cout << "Testing GetGradeCount with corrupt format" << std::endl;
  if (TestGetGradeCountCorrupt()) {
    std::cout << "  PASSED" << std::endl;
  } else {
    std::cout << "  FAILED" << std::endl;
    passed = 1;
  }

  return passed;
}

bool TestGetGradeCount() {
  const size_t kExpected = kGoodInputSize - 2;

  size_t actual = GetGradeCount(kGoodInput, kGoodInputSize);
  if (kExpected != actual) {
    std::cout << "\tExpected: " << kExpected << ", Actual: " << actual
      << std::endl;

    return false;
  }

  return true;
}


bool TestGetGradeCountCorrupt() {
  const double kExpected = -1.0;

  bool passed = true;
  for (size_t i = 0; i < kBadInputNoTests; ++i) {
    double actual = GetGradeCount(kBadInput[i], kBadInputSize);
    if (kExpected != actual) {
      std::cout << "\tExpected: " << kExpected << ", Actual: " << actual
        << std::endl;

      passed = false;
    }
  }

  return passed;
}
