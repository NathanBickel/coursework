// Copyright 2022 CSCE 240
//
#ifndef HW4_INC_TEST_GRADEBOOK_H_
#define HW4_INC_TEST_GRADEBOOK_H_

#include <hw4/inc/grade.h>
#include <hw4/inc/gradebook.h>
#include <cstddef>  // size_t
#include <iostream>


const Grade kTest1_grades[] = {
  Grade(3, 5),
  Grade(4, 5),
  Grade(1, 5),
  Grade(5, 5),
  Grade(2, 5),
  Grade(0, 5)
};
const ::size_t kTest1_grades_size = 6;
const Grade kTest1_grades_average(5, 10);

const Grade kTest2_grades[] = {
  Grade(5, 10),
  Grade(6, 10),
  Grade(3, 10),
  Grade(7, 10),
};
const ::size_t kTest2_grades_size = 4;
const Grade kTest2_grades_average(21, 40);

inline std::ostream & operator<<(std::ostream& out, const Grade& from) {
  out << from.ToString();
  return out;
}


#endif  // HW4_INC_TEST_GRADEBOOK_H_
