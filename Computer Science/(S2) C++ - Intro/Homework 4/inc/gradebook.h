// Copyright 2022 Nathan Bickel CSCE 240

#ifndef HW4_INC_GRADEBOOK_H_
#define HW4_INC_GRADEBOOK_H_

#include <hw4/inc/grade.h>
#include <cstddef>
#include <vector>

// GradeBook: stores a list of Grade instances representing some collection of
//  evenly weighted grades.
class GradeBook {
 public:
  // Default Constructor
  //  May or may not be required depending on how you manage memory.
  GradeBook();

  // size: accessor method for number of grades stored.
  //
  //  * Returns the number of grades currently stored by the GradeBook. Should
  //    return the value of the same type as STL containers, i.e. size_t.
  //  * Does not modify calling instance; const method.
  size_t size() const;

  // Get: accessor for element at given index.
  //
  //  * Accepts an unsigned integer---the index of the accessed element. The
  //    unsigned integer should be the same type used by container classes of
  //    STL, i.e. a size_t.
  //  * Returns the grade at the supplied index. When that index is out of
  //    range, a value of 0/1 is returned.
  //  * Does not modify calling instance; const method.
  const Grade Get(int index) const;

  // Add: appends a new grade to the gradebook instance, increasing size by 1.
  //
  //  * Accepts a Grade instance which should be copied and appended to current
  //    list or becomes the first element if list is empty.
  void Add(Grade grade);

  // Add: calculates and returns the union of the calling instance and the
  //  parameter without modifying either. Order is enforced, e.g.
  //    calling instance: 4/5, 7/10
  //    parameter: 6/10, 9/10
  //    returned: 4/5, 7/10, 6/10, 9/10
  //
  //  * Accepts a reference to a read-only GradeBook instance.
  //  * Returns a new GradeBook instance, the union, as a read-only value.
  //  * Does not modify calling instance; const method.
  const GradeBook Add(const GradeBook gradebook) const;

  // CalcAverage: calculates and returns a Grade instance representing the
  //  average ratio of all Grade instances stored.
  //
  //  * Returns the average ratio of all grades stored in GradeBook instance or
  //    1/1 if the GradeBook stores no Grade instances. Returns Grade instance
  //    as read-only value.
  //  * Does not modify calling instance; const method.
  const Grade CalcAverage() const;

 private:
  std::vector<Grade> grades_;
};

#endif  // HW4_INC_GRADEBOOK_H_
