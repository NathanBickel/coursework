// Copyright 2022 Nathan Bickel CSCE 240

#include <hw5/inc/grade.h>


namespace csce240 {


namespace hw5 {


// constructor (unsigned int, unsigned int)
//
//  * Initializes instance with two integer parameters. First is points
//    scored. Second is total points.
//  * Precondition: first parameter is > -1, second is > 0. You may assert.
Grade::Grade(size_t scored, size_t total) : Rational(scored, total) { }

// scored: accessor method for points scored
//
//  * Returns points scored as unsigned integer
//  * Does not modify calling instance; const method
size_t Grade::scored() const {
    return num();
}

// total: accessor method for total points possible
//
//  * Returns total points as unsigned integer
//  * Does not modify calling instance; const method
size_t Grade::total() const {
    return den();
}

// ToDouble: converts stored values into a precentage representing the
//           percentage of scored points to total points.
//
//  * Accepts unsigned integer to set precision. The parameter represents the
//    number of decimal places before rounding. For example, when parameter is
//    3, 7/32 is returned as 21.875; when 2, 7/32 is returned as 21.88.
//  * Returns floating point (double) approximation of the percentage of the
//    total points earned.
//  * Does not modify calling instance; const method.
double Grade::ToDouble(size_t precision) const {
    precision += 2;
    double ratio = static_cast<double>(scored())
        / static_cast<double>(total());
    int ratioInt = round(ratio * pow(10, precision));
    return 100.0 * ratioInt / pow(10, precision);
}

// ToDouble: as above, but OVERRIDES PARENT METHOD
//
//  * Precision is three (3)
//  * Does not modify calling instance; const method.
double Grade::ToDouble() const {
    return Grade::ToDouble(3);
}

// ToString: converts stored values into a printable format, e.g. 6/10
//
//  * Returns string containing s/p where s is the points scored and p is
//    points possible. When s is 0, returns string 0/p, where p is total
//    points possible.
//  * Does not modify calling instance; const method.
std::string Grade::ToString() const {
    if (scored() == 0)
        return ("0/"+std::to_string(total()));
    else
        return std::to_string(scored()) + "/" + std::to_string(total());
}

// operator==: returns Boolean true or false depending on the equality of the
//             ratio of the calling instance and the provided parameter, e.g.
//             1/2 == 2/4 returns true, 1/2 == 1/4 returns false.
//
//  * Accepts an instance of Grade class. Parameter is used as the
//    right-hand-side of the equation:
//      calling instance == Grade parameter
//  * Returns a boolean value which is true if the calling instance's ratio
//    and Grade parameter's ratio are equal:
//      scored:possible == scored:possible
//    Ratios are calculated exactly---that is floating point values are not
//    used, only integer values.
//  * Does not modify calling instance; const method.
bool Grade::operator==(const Grade grade) const {
    return (scored() * grade.total() == total() * grade.scored());
}

// operator==: As above, but accepts an int parameter as the right-hand-side
//             operand, to allow calling object == int, e.g.
//     Grade(2, 1) == 2
bool Grade::operator==(int number) const {
    return (scored() == total() * number);
}

// operator==: As class method above, but is a function and accepts an int
//             parameter as the left-hand-side operand and a Grade parameter
//             for the right-hand-side, e.g.
//    int == Grade object
bool operator==(int number, const Rational grade) {
    return (grade.num() == number * grade.den());
}


}  // namespace hw5


}  // namespace csce240
