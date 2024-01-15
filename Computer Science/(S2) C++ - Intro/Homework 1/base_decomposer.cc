// Copyright 2022 Nathan Bickel CSCE 240
// base_decomposer.cc
#include <math.h>
#include <iostream>

int main(int arc, char *argv[]) {
    // Reads in input
    int input;
    int length = 1;
    std::cin >> input;
    // Deals with number if negative
    bool negative = false;
    if (input < 0) {
        negative = true;
        input *= -1;
        std::cout << "-(";
    }
    // Find number of digits in number
    for (int temp = input; temp > 9; temp /= 10)
        length++;
    // Expands the number
    while (length > 1) {
        int power = static_cast<int>(pow(10, length-1));
        int digit = input / power;
        std::cout << digit * power << " + ";
        input %= power;
        length--;
    }
    std::cout << input;

    if (negative)
        std::cout << ")";
    return 0;
}
