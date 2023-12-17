// Copyright 2022 Nathan Bickel CSCE 240

#include <hw5/inc/rational.h>


namespace csce240 {


namespace hw5 {


Rational reduced(int num, int den) {
    int a = num;
    int b = den;
    int gcd = std::__gcd(a, b);
    while (gcd > 1) {
        a /= gcd;
        b /= gcd;
        gcd = std::__gcd(a, b);
    }
    return Rational(a, b);
}

Rational::Rational() : num_(0), den_(1) { }

// constructor (int)
//
//  * Initializes object with an integer parameter; the numerator. The
//    denominator must be 1. You may modify the two parameter constructor to
//    accept a default value of 1, instead.
//  * Is explicit

Rational::Rational(int num) : num_(num), den_(1) { }

// constructor (int, int)
//
//  * Initializes object with two integer parameters; first is numerator,
//    second is denominator
//  * Precondition: second parameter is not 0. You may assert.
//  * Method is explicit if second param has default value.
Rational::Rational(int num, int den) {
    if (num >= 0 && den >= 0) {
        num_ = num;
        den_ = den;
    } else if (den < 0) {
        num_ = -num;
        den_ = -den;
    }
}

// num: accessor method for numerator
//
//  * Returns numerator as a signed integer
//  * Does not modify calling instance; const method.
int Rational::num() const {
    return num_;
}

// den: accessor method for denominator
//
//  * Returns denominator as a signed integer
//  * Does not modify calling instance; const method.
int Rational::den() const {
    return den_;
}

// ToDouble:
//
//  * Returns double precision floating point containing the quotient of the
//    numerator and denominator.
//  * Does not modify calling object; const method.
//  * Virtual method; not abstract.
double Rational::ToDouble() const {
    return static_cast<double>(num_) / den_;
}

// ToString: converts stored values into a print-able format, e.g. 6/10
//
//  * Returns string containing n/d where n is the numerator and d is the
//    denominator.  When n is 0, returns string 0.
//  * Does not modify calling object; const method.
//  * Virtual method; not abstract.
std::string Rational::ToString() const {
    if (num_ == 0)
        return std::to_string(0);
    else
        return std::to_string(num_) + "/" + std::to_string(den_);
}

// Equals: returns true or false depending on the equality of the
//         ratio of the calling object and a parameter Rational object, e.g.
//           Rational(-1, 2).Equals(Rational(2, -4))
//         returns true, while
//           Rational(1, 2).Equals(Rational(1, 4))
//         returns false.
//
//  * Accepts an object of Rational class. Parameter is used as the
//    right-hand-side of the equation:
//      calling object == Rational parameter
//  * Returns a boolean value which is true if the calling object's ratio
//    and Rational parameter's ratio are equal:
//      numerator:denominator == numerator:denominator
//    Ratios are calculated exactly---that is floating point values are not
//    used, only integer values.
//  * Does not modify calling object; const method.
bool Rational::Equals(Rational rat) const {
    Rational a = reduced(num_, den_);
    Rational b = reduced(rat.num(), rat.den());
    return a.num() == b.num() && b.den() == b.den();
}

// operator==: see Equals(Rational) above


// Equals: returns Boolean true or false depending on the equality of the
//         ratio of the calling object and the provided parameter, e.g.
//           Rational(4, -2).Equals(-2)
//         returns true and
//           Rational(65, 2).Equals(32)
//         returns false.
//
//  * Accepts an integer parameter. Parameter is used as the right-hand-side
//    of the equation:
//      calling object == int parameter
//  * Returns a boolean value which is true if the calling object's ratio
//    and integer parameter's ratio are equal:
//      scored:possible == integer:1
//    Ratios are calculated exactly---that is floating point values are not
//    used, only integer values.
//  * Does not modify calling object; const method.
bool Rational::Equals(int number) const {
    Rational rat = reduced(num_, den_);
    return rat.num() == number;
}

// operator==: see Equals(int) above
bool Rational::operator==(int num) const {
    return Equals(num);
}

// DividedBy: calculates and returns quotient (as a Rational object) of
//            calling object divided by parameter, e.g. 1/2 / 1/4 returns 2/1
//
//  * Accepts an object of the Rational class. It is used as the
//    right-hand-side of the equation:
//      calling Rational object / Rational object parameter
//  * Returns an object of Rational class containing the result of equation
//    above. The two objects' point values should be used as the two
//    numerators and two denominators in the equation
//      scored/possible / scored/possible
//    The equation is calculated using fractional arithmetic.
//  * Does not modify calling object; const method.
const Rational Rational::DividedBy(const Rational rat) const {
    return Rational(num_ * rat.den(), den_ * rat.num());
}

// operator/: see DividedBy(Rational) above.
const Rational Rational::operator/(const Rational rat) const {
    return DividedBy(rat);
}

const Rational Rational::DividedBy(int number) const {
    return Rational(num_, den_ * number);
}

// operator/: see DividedBy(Rational) above.
const Rational Rational::operator/(int number) const {
    return DividedBy(number);
}

const Rational Rational::Plus(int number) const {
    return Rational(num_ + den_ * number, den_);
}

const Rational Rational::operator+(int number) const {
    return Plus(number);
}

// Plus: calculates and returns the sum of the calling object and a
//       Rational object.
//
//  * Accepts an object of Rational class. Parameter is used as the
//    right-hand-side of the equation:
//      calling object + parameter
//  * Returns an object of the Rational class containing the result of the
//    above equation.
//  * Does not modify calling object; const method.
Rational Rational::Plus(Rational rat) const {
    return Rational(num_*rat.den() + den_*rat.num(), den_ * rat.den());
}

// operator+: see Plus(Rational) above.
Rational Rational::operator+(Rational rat) const {
    return Plus(rat);
}

// Plus: calculates and returns the sum of the calling object and an
//       integer.
//
//  * Accepts an integer as the right-hand-side of summation with calling
//    object using the equation:
//      calling object + parameter/1
//  * Does not modify calling object; const method.
Rational Plus(int rhs, const Rational lhs) {
    return Rational(lhs.num() + lhs.den() * rhs, lhs.den());
}

// operator+: as Plus(int) above
Rational operator+(int rhs, const Rational lhs) {
    return Plus(rhs, lhs);
}

Rational DividedBy(int rhs, const Rational lhs) {
    return Rational(rhs * lhs.den(), lhs.num());
}

// operator/: see DividedBy(int) above
Rational operator/(int rhs, const Rational lhs) {
    return DividedBy(rhs, lhs);
}


}  // namespace hw5


}  // namespace csce240
