// Copyright 2022 CSCE 240
//
#include <hw2/parse_scores.h>

#include <iostream>
#include <string>

std::string kGoodInput[] = {    // NOLINT
  "gsmith", "4", "90.23", "81.21", "89.33", "100.0"
};
const size_t kGoodInputSize = 6;

const size_t kBadInputSize = 4;
std::string kBadInput[][kBadInputSize] = {  // NOLINT
  { "aname", "-2", "89.1", "88.0" },
  { "aname", "2", "-89.1", "88.0" },
  { "aname", "2", "t8.1", "88.0" }
};
const size_t kBadInputNoTests = 3;


bool TestGetMaxGrade();  // "good" path
bool TestGetMaxGradeNoGrades();  // true when returns -2 when no grades exist
bool TestGetMaxGradeFormatCorrupt();  // true when returns -1 for corrupt format


int main(int argc, char* argv[]) {
  int passed = 0;

  std::cout << "Testing GetMaxGrade" << std::endl;
  if (TestGetMaxGrade()) {
    std::cout << "  PASSED" << std::endl;
  } else {
    std::cout << "  FAILED" << std::endl;
    passed = 1;
  }

  std::cout << "Testing GetMaxGrade with no grades exist" << std::endl;
  if (TestGetMaxGradeNoGrades()) {
    std::cout << "  PASSED" << std::endl;
  } else {
    std::cout << "  FAILED" << std::endl;
    passed = 1;
  }

  std::cout << "Testing GetMaxGrade with format corrupt" << std::endl;
  if (TestGetMaxGradeFormatCorrupt()) {
    std::cout << "  PASSED" << std::endl;
  } else {
    std::cout << "  FAILED" << std::endl;
    passed = 1;
  }

  return passed;
}


bool TestGetMaxGrade() {  // true when max grade found
  double expected_max_grade = 100.0;
  double actual_max_grade = GetMaxGrade(kGoodInput, kGoodInputSize);
  if (expected_max_grade != actual_max_grade) {
    std::cout << "\tExpected max grade: " << expected_max_grade
        << ", Actual max grade: " << actual_max_grade << std::endl;
    return false;
  }

  return true;
}


bool TestGetMaxGradeNoGrades() {  // true when returns -2 when no grades exist
  double expected = -2.0;
  std::string values[] = { "gsmith", "0" };
  double actual = GetMaxGrade(values, 2);
  if (expected != actual) {
    std::cout << "\tExpected: " << expected << ", Actual: " << actual
      << std::endl;
    return false;
  }

  return true;
}


bool TestGetMaxGradeFormatCorrupt() {
  const double kExpected = -1.0;

  bool passed = true;
  for (size_t i = 0; i < kBadInputNoTests; ++i) {
    double actual = GetMaxGrade(kBadInput[i], kBadInputSize);
    if (kExpected != actual) {
      std::cout << "\tExpected: " << kExpected << ", Actual: " << actual
        << std::endl;

      passed = false;
    }
  }

  return passed;
}
