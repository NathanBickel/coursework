// Copyright 2022 CSCE 240
//
#include <hw2/parse_scores.h>

#include <cstddef>
#include <iostream>
#include <string>


const std::string kGoodInput[] = {  // NOLINT
  "aname", "3", "90.23", "81.21", "89.33",
};
const size_t kGoodInputSize = 5;
const double kExpectedGrades[] = {
  90.23, 81.21, 89.33
};
const size_t kExpectedGradesSize = 3;

const size_t kBadInputSize = 4;
std::string kBadInput[][kBadInputSize] = {  // NOLINT
  { "aname", "-2", "89.1", "88.0" },
  { "aname", "2", "-89.1", "88.0" },
  { "aname", "2", "eighty9.3", "88.0" },
};
const size_t kBadInputNoTests = 3;

bool TestGetGrade();
bool TestGetGradeNoIndex();  // true when returns -2 for missing index
bool TestGetGradeFormatCorrupt();  // true when returns -10 for corrupt format


int main(int argc, char* argv[]) {
  int passed = 0;
  // test get_num_grades
  std::cout << "Testing GetGrade" << std::endl;
  if (TestGetGrade()) {
    std::cout << "  PASSED" << std::endl;
  } else {
    std::cout << "  FAILED" << std::endl;
    passed = 1;
  }

  std::cout << "Testing GetGrade with no matching grade index"
            << std::endl;
  if (TestGetGradeNoIndex()) {
    std::cout << "  PASSED" << std::endl;
  } else {
    std::cout << "  FAILED" << std::endl;
    passed = 1;
  }

  std::cout << "Testing GetGrade with format corrupt" << std::endl;
  if (TestGetGradeFormatCorrupt()) {
    std::cout << "  PASSED" << std::endl;
  } else {
    std::cout << "  FAILED" << std::endl;
    passed = 1;
  }

  return passed;
}


bool TestGetGrade() {  // true when correct grade returned for given gade index
  bool passed = true;

  for (size_t i = 0; i < kExpectedGradesSize; ++i) {
    double actual_grade = GetGrade(i, kGoodInput, kGoodInputSize);

    if (kExpectedGrades[i] != actual_grade) {
      std::cout << "\tExpected Grade at " << i << ": " << kExpectedGrades[i]
                << " Actual Grade : " << actual_grade << std::endl;

      passed = false;
    }
  }
  return passed;
}


bool TestGetGradeNoIndex() {
  double expected = -2;

  double actual = GetGrade(3, kGoodInput, kGoodInputSize);

  if (expected != actual) {
    std::cout << "\tExpected: " << expected << ", Actual: " << actual
      << std::endl;

    return false;
  }

  return true;
}


bool TestGetGradeFormatCorrupt() {
  const double kExpected = -1.0;

  bool passed = true;
  for (size_t i = 0; i < kBadInputNoTests; ++i) {
    double actual = GetGrade(0, kBadInput[i], kBadInputSize);

    if (kExpected != actual) {
      std::cout << "\tExpected: " << kExpected << ", Actual: " << actual
        << std::endl;

      passed = false;
    }
  }

  return passed;
}
