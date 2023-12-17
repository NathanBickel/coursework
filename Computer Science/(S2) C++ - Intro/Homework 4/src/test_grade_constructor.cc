// Copyright 2022 CSCE 240
//

#include <hw4/inc/grade.h>
#include <iostream>

inline bool TestConstructor() {
  std::cout << "Testing Grade::Grade(int, int)" << std::endl;
  const Grade a(7, 8);
  if (a.scored() == static_cast<unsigned int>(7)
      && a.total() == static_cast<unsigned int>(8)
      // using arbitrarily true comparison to force signedness warning
      && a.scored() < static_cast<unsigned int>(8)
      && a.total() < static_cast<unsigned int>(9)) {
    std::cout << "  PASSED" << std::endl;
    return true;
  }

  std::cout << "  Expected 7/8, Actual: " << a.scored() << "/"
    << a.total() << '\n' << "  FAILED" << std::endl;
    return false;
}


int main(int argc, char* argv[]) {
  return TestConstructor() ? 0 : 1;
}
