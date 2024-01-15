// Copyright 2022 Nathan Bickel CSCE 240
// parse_scores.cc

#include <hw2/parse_scores.h>
#include <iostream>
#include <string>
#include <stdexcept>
#include <regex>  // NOLINT


bool isCorrupt(const std::string input[], size_t size) {
    if (size < 2)
        return true;

    if (!std::regex_match(input[1], std::regex("[0-9]+")))
        return true;
    size_t number_of_grades;
    try {
        number_of_grades = std::stoi(input[1]);
        if (number_of_grades != size - 2)
            return true;
    } catch (const std::invalid_argument& exception) {
        return true;
    }

    for (size_t i = 2; i < size; i++) {
        if (!std::regex_match(input[i], std::regex("[0-9]*([\\.][0-9]+)?")))
            return true;
        try {
            std::stod(input[i]);
        } catch (const std::invalid_argument& exception) {
            return true;
        }
    }

    return false;
}

double GetGrade(size_t grade_index, const std::string input[], size_t size) {
    if (isCorrupt(input, size))
        return -1.0;
    size_t number_of_grades = std::stoi(input[1]);
    if (number_of_grades == 0 || grade_index >= number_of_grades)
        return -2.0;
    else
        return std::stod(input[grade_index + 2]);
}

int GetGradeCount(const std::string input[], size_t size) {
    if (isCorrupt(input, size))
        return -1;
    else
        return std::stoi(input[1]);
}

std::string GetID(const std::string input[], size_t size) {
    if (isCorrupt(input, size))
        return "";
    else
        return input[0];
}

double GetMaxGrade(const std::string input[], const size_t kSize) {
    if (isCorrupt(input, kSize))
        return -1.0;
    size_t number_of_grades = std::stoi(input[1]);
    if (number_of_grades == 0)
        return -2.0;
    double max = std::stod(input[2]);
    for (size_t i = 2; i < number_of_grades + 2; i++) {
        double current_grade = std::stod(input[i]);
        if (current_grade > max)
            max = current_grade;
    }
    return max;
}
