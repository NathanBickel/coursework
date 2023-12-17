#include <cstddef>  // size_t
#include <string>


// Description:
//   Extracts a single grade for a given grade index.
// Preconditions:
// - Parameter input has at least size elements.
// Parameters:
// - grade_index: index of the grade to be returned for given student id
// - input: an array of string values representing student grade data
// - size: number of elements in input array
// Returns:
// - Grade selected
// - A -1.0 when input format is corrupt
// - A -2.0 when grade_index is not found (or grades are empty)
//
double GetGrade(size_t grade_index, const std::string input[], size_t size);


/* Description:
 *   Parses the input array to determine how many grades are claimed to be
 *     present and validates the claim
 * Preconditions:
 * - Parameter input has at least parameter size elements.
 * Parameters:
 * - input: a series of string input representing students and grades
 * - size: number of elements in input array
 * Returns:
 * - The number of grades for student
 * - Integer -1 when the format is corrupt i.e. 1 1234 3 99.7 82.1
 */
int GetGradeCount(const std::string input[], size_t size);


// Description:
//   Extracts the ID for the present student.
// Preconditions:
// - Parameter input has at least size elements.
// Parameters:
// - input: an array of string values representing student grade data
// - size: number of elements in input array
// Returns:
// - Student ID
// - The empty string ("") when input format is corrupt
//
std::string GetID(const std::string input[], size_t size);


// Description:
//   Extracts the highest grade.
// Preconditions:
// - Parameter input has at least parameter size elements.
// - Grades are nonnegative. Adjust accordingly.
// Parameters:
// - input: a series of string input representing students and grades
// - size: number of elements in input array
// Returns:
// - The highest grade found.
// - A floating point -1.0 when no format is corrupt
// - A floating point -2.0 when no grades exist (but format is valid)
double GetMaxGrade(const std::string input[], const size_t kSize);


const size_t kIdempotency = 0;  // must be present for compilation against my
                                // tests
