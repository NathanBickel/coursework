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
const std::string kGoodExpected = "aname";  // NOLINT

const std::string kExpectedID = "aname";  // NOLINT

const std::string kBadInput[] = { "aname" };  // NOLINT
const size_t kBadInputSize = 1;
const std::string kBadExpected = "";  // NOLINT

bool TestGetID();
bool TestGetIDFormatCorrupt();  // true when returns -10 for corrupt format


int main(int argc, char* argv[]) {
  int passed = 0;
  // test get_num_grades
  std::cout << "Testing GetID" << std::endl;
  if (TestGetID()) {
    std::cout << "  PASSED" << std::endl;
  } else {
    std::cout << "  FAILED" << std::endl;
    passed = 1;
  }

  std::cout << "Testing GetID with format corrupt" << std::endl;
  if (TestGetIDFormatCorrupt()) {
    std::cout << "  PASSED" << std::endl;
  } else {
    std::cout << "  FAILED" << std::endl;
    passed = 1;
  }

  return passed;
}


bool TestGetID() {  // true when correct grade returned for given gade index
  std::string actual = GetID(kGoodInput, kGoodInputSize);

  if (kGoodExpected != actual) {
    std::cout << "\tExpected ID " << kGoodExpected << ": " << " Actual ID : "
      << actual << std::endl;

    return false;
  }

  return true;
}


bool TestGetIDFormatCorrupt() {
  std::string actual = GetID(kBadInput, kBadInputSize);

  if (kBadExpected != actual) {
    std::cout << "\tExpected: " << kBadExpected << ", Actual: " << actual
      << std::endl;

    return false;
  }

  return true;
}
