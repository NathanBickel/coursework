// Copyright 2022 Nathan Bickel CSCE 240

#include <hw6/inc/rational.h>

namespace csce240::hw6 {


Rational::Rational() : num_(0), den_(1) { }

Rational::Rational(int num) : num_(num), den_(1) { }

Rational::Rational(int num, int den) {
    if (den > 0) {
        num_ = num;
        den_ = den;
    } else if (den < 0) {
        num_ = -num;
        den_ = -den;
    }
}

int Rational::num() const {
    return num_;
}

unsigned int Rational::den() const {
    return den_;
}

bool Rational::operator==(const Rational& rat) const {
    return (num_ * rat.den() == den_ * rat.num());
}

std::ostream& operator<<(std::ostream& lhs, const Rational& rhs) {
    int num = rhs.num();
    int den = rhs.den();
    if (num == 0)
        lhs << 0;
    else if (den == 1)
        lhs << num;
    else
        lhs << std::to_string(num) << "/" << std::to_string(den);
    return lhs;
}

const Rational Rational::operator/(const Rational& rat) const {
    return Rational(num_ * rat.den(), den_ * rat.num());
}

const Rational Rational::operator/(int number) const {
    return Rational(num_, den_ * number);
}

double Rational::operator/(double number) const {
    return num_ / (den_ * number);
}

const Rational Rational::operator+(const Rational& rat) const {
    return Rational(num_ * rat.den() + den_ * rat.num(), den_ * rat.den());
}


}  // namespace csce240::hw6
