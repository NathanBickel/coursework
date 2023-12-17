// Copyright 2022 Nathan Bickel CSCE 240

#include <hw6/inc/grade.h>

namespace csce240::hw6 {


template<class T>
Grade<T>::Grade(T score) : score_(score) { }

template<class T>
T Grade<T>::score() const {
    return score_;
}

template<class T>
std::string Grade<T>::ToLetter(unsigned int plusThreshold) const {
    double ratio = score_ / 1.0;
    double PTR = 10.0;
    double big = 2147483647.0;
    double epsilon = 0.00001;
    if (plusThreshold != 0)
        PTR = static_cast<double>(plusThreshold) / 10.0;
    double cutoffs[9] = {60.0, 60.0+PTR, 70.0, 70.0+PTR,
                            80.0, 80.0+PTR, 90.0, 90.0+PTR, big};
    std::string cutoffNames[9] = {"F", "D", "D+", "C", "C+",
                                    "B", "B+", "A", "A+"};
    for (int i = 0; i < 9; i++) {
        if (ratio + epsilon < cutoffs[i]) {
            return cutoffNames[i];
            break;
        }
    }
    return "error";
}

template<class T>
Grade<T> Grade<T>::CalcAverage(const std::vector<T>& vec) {
    T gradeTotal = T(0);
    for (size_t i = 0; i < vec.size(); i++)
        gradeTotal = gradeTotal + vec[i];
    return Grade<T>(T(gradeTotal / static_cast<int>(vec.size())));
}


}  // namespace csce240::hw6
