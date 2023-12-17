// Copyright 2022 Nathan Bickel CSCE 240

#include <hw4/inc/grade.h>
#include <math.h>
#include <cmath>
#include <cstddef>
#include <ctgmath>
#include <string>

// constructor (unsigned int, unsigned int)
//
//  * Initializes instance with two integer parameters. First is points
//      scored. Second is total points.
//  * Precondition: both parameters are > 0. You may assert.
Grade::Grade(size_t scored, size_t total) : scored_(scored), total_(total) { }

// scored: accessor method for points scored
//
//  * Returns points scored as unsigned integer
//  * Does not modify calling instance; const method
size_t Grade::scored() const {
    return scored_;
}


// total: accessor method for total points possible
//
//  * Returns total points as unsigned integer
//  * Does not modify calling instance; const method
size_t Grade::total() const {
    return total_;
}

// ToDouble: converts stored values into a precentage representing the
//   percentage of scored points to total points.
//
//  * Accepts unsigned integer to set precision. The parameter represents the
//      number of decimal places before rounding. For example, when parameter
//      is 3, 7/32 is returned as 21.875; when 2, 7/32 is returned as 21.88.
//  * THE DEFAULT VALUE OF PRECISION PARAMETER IS 3.
//  * Returns floating point (double) approximation of the percentage of the
//      total points earned.
//  * Does not modify calling instance; const method.
double Grade::ToDouble(size_t precision) const {
    precision += 2;
    double ratio = static_cast<double>(scored_) / static_cast<double>(total_);
    int ratioInt = round(ratio * pow(10, precision));
    return 100.0 * ratioInt / pow(10, precision);
}

// ToString: converts stored values into a print-able format, e.g. 6/10
//
//  * Returns string containing s/p where s is the points scored and p is
//      points possible. When s is 0, returns string 0.
//  * Does not modify calling instance; const method.
std::string Grade::ToString() const {
    if (scored_ == 0)
        return std::to_string(0);
    else
        return std::to_string(scored_) + "/" + std::to_string(total_);
}

// ToLetter: converts scored point's percentage of total points to a letter
//   grade with possible +, e.g. 7/8 converts to a B or possibly B+
//
//  * Accepts unsigned integer (plus threshold) parameter which is percent of
//      range at which a + is assigned. For example, when plus threshold is
//      75, then:
//        A+ : grade percent >= 97.5
//        ...
//        D+ : grade percent >= 67.5
//      If plus threshold is a zero, there is no plus.
//  * THE DEFAULT VALUE OF PLUS THRESHOLD PARAMETER IS 0.
//  * Returns string containing the letter grade, including a possible +
//      character. Uses a regular U.S. college-level percent breakdown;
//        A : grade percent >= 90.0
//        B : grade percent >= 80.0
//        C : grade percent >= 70.0
//        D : grade percent >= 60.0
//        F : otherwise
//  * Does not modify calling instance; const method.
std::string Grade::ToLetter(size_t plusThreshold) const {
    double ratio = static_cast<double>(scored_) / static_cast<double>(total_);
    double PTR;
    double big = 2147483647;
    if (plusThreshold == 0)
        PTR = 0.1;
    else
        PTR = plusThreshold / 1000.0;
    double cutoffs[10] = {0, 0.6, 0.6+PTR, 0.7, 0.7+PTR,
                            0.8, 0.8+PTR, 0.9, 0.9+PTR};
    if (plusThreshold > 0)
        cutoffs[9] = big;
    std::string cutoffNames[9] = {"F", "D", "D+", "C", "C+",
                                    "B", "B+", "A", "A+"};
    for (int i = 0; i < 9; i++)
        if (ratio >= cutoffs[i] && ratio < cutoffs[i+1])
            return cutoffNames[i];
    return "A";
}

// Equals: returns Boolean true or false depending on the equality of the
//   ratio of the calling instance and the provided parameter, e.g. 1/2 ==
//   2/4 returns true, 1/2 == 1/4 returns false.
//
//  * Accepts an instance of Grade class. Parameter is used as the
//      right-hand-side of the equation:
//        calling instance == Grade parameter
//  * Returns a boolean value which is true if the calling instance's ratio
//      and Grade parameter's ratio are equal:
//        scored:possible == scored:possible
//      Ratios are calculated exactly---that is floating point values are not
//      used, only integer values.
//  * Does not modify calling instance; const method.
bool Grade::Equals(Grade other) const {
    double kSize = 0.0000000001;
    double ratio = static_cast<double>(scored_) / static_cast<double>(total_);
    double ratioOther = static_cast<double>(other.scored())
        / static_cast<double>(other.total());
    return (ratio - ratioOther < kSize);
}

// DividedBy: calculates and returns quotient (as a Grade instance) of
//   calling instance divided by parameter, e.g. 1/2 / 1/4 returns 2/1
//
//  * Accepts an instance of the Grade class. It is used as the
//      right-hand-side of the equation:
//        calling instance / Grade parameter
//  * Returns an instance of Grade class containing the result of equation
//      above. The two instances' point values should be used as the two
//      numerators and two denominators in the equation
//        scored/possible / scored/possible
//      The equation is calculated using fractional arithmetic.
//  * Does not modify calling instance; const method.
Grade Grade::DividedBy(Grade other) const {
    return Grade(static_cast<double>(scored_) * other.total(),
                    static_cast<double>(other.scored()) * total_);
}

// Plus: calculates and returns the sum of the calling instance a
//
//  * Accepts an instance of Grade class. Parameter is used as the
//      right-hand-side of the equation:
//        calling instance + Grade parameter
//  * Returns an instance of the Grade class containing the result of the
//      above equation. The two instances' point values should be used as the
//      two numerators and two denominators in the equation
//        scored/possible + scored/possible
//      The equation is calculated using fractional arithmetic.
//  * Does not modify calling instance; const method.
Grade Grade::Plus(Grade other) const {
    return Grade(static_cast<double>(scored_) * other.total() +
        static_cast<double>(total_) * other.scored(),
        static_cast<double>(total_) * other.total());
}
