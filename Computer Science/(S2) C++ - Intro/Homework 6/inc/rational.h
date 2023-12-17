// Copyright 2022 Nathan Bickel CSCE 240

// This is the public interface for the Rational class. It specifies an
// overloaded equals operator method and an overloaded extraction operator
// function. Other operators may need be overloaded as you see fit for your
// grade class.
//
// My solution required:
//   + const Rational operator/(const Rational&) const
//   + const Rational operator/(int) const
//   + double operator/(double) const
// and
//   + const Rational operator+(const Rational&) const
//
// Your requirements may vary.
//

#ifndef HW6_INC_RATIONAL_H_
#define HW6_INC_RATIONAL_H_

#include <ostream>


namespace csce240::hw6 {


class Rational {
 public:
  // Create the following constructors in any way you see fit (you may use
  //   default values).
  //
  // constructor ()          creates rational 0/1
  // constructor (int)       creates rational n/1
  // constructor (int, int)  creates rational n/d
  Rational();

  explicit Rational(int);

  Rational(int, int);

  // returns numerator, provides an object's signed-ness
  int num() const;

  // returns denominator as positive integer, greater than 0
  unsigned int den() const;

  // Equals Operator
  // Returns true or false depending on the equality of the ratio of the
  // calling object and a parameter Rational object, e.g.
  //   Rational(-1, 2).Equals(Rational(-2, 4))
  // returns true, while
  //   Rational(1, 2).Equals(Rational(1, 4))
  // returns false.
  bool operator==(const Rational&) const;

  const Rational operator/(const Rational&) const;

  const Rational operator/(int) const;

  double operator/(double) const;

  const Rational operator+(const Rational&) const;

 private:
  int num_;
  unsigned int den_;
};


// Overloaded extraction operator: overload this function as expected. Make
// sure you accept a non-const std::ostream& and return that same reference.
//
// The format is as follows:
//   "n/d" when numerator is not 0 and denominator is not 1,
//   "n" when denominator is 1, and
//   "0" when numerator is 0
// Where n and d are the integers representing the numerator and denominator,
// respectively.
std::ostream& operator<<(std::ostream& lhs, const Rational& rhs);


}  // namespace csce240::hw6

#endif  // HW6_INC_RATIONAL_H_
