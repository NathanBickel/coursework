// Copyright 2022 Nathan Bickel CSCE 240

#include <hw3/inc/find_sum.h>
#include <iostream>
#include <cstring>

// Return the length of a match at a given (row, col) or -1 if there isn't one
int SearchHorizontally(const int** matrix,
                       const size_t* matrix_size,
                       int search_sum,
                       size_t row,
                       size_t col) {
    int length = 0;
    int found_sum = 0;
    // Go through and check if adding on any of the elements gets to the sum
    for (size_t c = col; c < matrix_size[1]; c++) {
        found_sum += matrix[row][c];
        length++;
        if (found_sum == search_sum)
            return length;
    }
    return -1;
}

int SearchVertically(const int** matrix,
                       const size_t* matrix_size,
                       int search_sum,
                       size_t row,
                       size_t col) {
    int length = 0;
    int found_sum = 0;
    for (size_t r = row; r < matrix_size[0]; r++) {
        found_sum += matrix[r][col];
        length++;
        if (found_sum == search_sum)
            return length;
    }
    return -1;
}

int SearchDiagonallyD(const int** matrix,
                       const size_t* matrix_size,
                       int search_sum,
                       size_t row,
                       size_t col) {
    int length = 0;
    int found_sum = 0;
    for (int r = row, c = col;
        r < static_cast<int>(matrix_size[0])
        && c < static_cast<int>(matrix_size[1]);
        r++, c++) {
            found_sum += matrix[r][c];
            length++;
            if (found_sum == search_sum)
                return length;
    }
    return -1;
}

int SearchDiagonallyA(const int** matrix,
                       const size_t* matrix_size,
                       int search_sum,
                       size_t row,
                       size_t col) {
    int length = 0;
    int found_sum = 0;
    for (int r = row, c = col;
        r >= 0 && c < static_cast<int>(matrix_size[1]);
        r--, c++) {
            found_sum += matrix[r][c];
            length++;
            if (found_sum == search_sum)
                return length;
    }
    return -1;
}

// Count number of times you can find a sum in a matrix
size_t FindNumOccurences(const int** matrix,
                       const size_t* matrix_size,
                       int search_sum) {
    // Get size of matrix to look through
    const size_t kRows = matrix_size[0];
    const size_t kCols = matrix_size[1];
    size_t numOccurences = 0;
    // At each cell, check if you can find it any of the four directions
    for (size_t r = 0; r < kRows; r++) {
        for (size_t c = 0; c < kCols; c++) {
            if (SearchHorizontally(matrix, matrix_size, search_sum, r, c) >= 1)
                numOccurences++;
            if (SearchVertically(matrix, matrix_size, search_sum, r, c) > 1)
                numOccurences++;
            if (SearchDiagonallyD(matrix, matrix_size, search_sum, r, c) > 1)
                numOccurences++;
            if (SearchDiagonallyA(matrix, matrix_size, search_sum, r, c) > 1)
                numOccurences++;
        }
    }
    // After adding each occurence to the total, return it
    return numOccurences;
}

const size_t** FindSum(const int** matrix,
                       const size_t* matrix_size,
                       int search_sum,
                       size_t* sums_found) {
    const size_t kRows = matrix_size[0];
    const size_t kCols = matrix_size[1];
    // Call function to change the output variable to the number of occurences
    *sums_found = FindNumOccurences(matrix, matrix_size, search_sum);
    // No point checking if there isn't anything to find
    if (*sums_found == 0)
        return nullptr;
    // Make an array of size_t pointers
    size_t **coordinates = new size_t*[*sums_found];
    size_t i = 0;
    for (size_t r = 0; r < kRows; r++) {
        for (size_t c = 0; c < kCols; c++) {
            // Find the length of a match in each direction
            int hor = SearchHorizontally(matrix, matrix_size, search_sum, r, c);
            int ver = SearchVertically(matrix, matrix_size, search_sum, r, c);
            int diaD = SearchDiagonallyD(matrix, matrix_size, search_sum, r, c);
            int diaA = SearchDiagonallyA(matrix, matrix_size, search_sum, r, c);
            // Cover case of length 1 here (strictly greater in other cases)
            if (hor >= 1) {
                coordinates[i] = new size_t[kIndices_size];
                coordinates[i][kIndices_start_row_idx] = r;
                coordinates[i][kIndices_start_col_idx] = c;
                coordinates[i][kIndices_end_row_idx] = r;
                coordinates[i][kIndices_end_col_idx] = c + hor - 1;
                i++;
            }
            // If there's a match, add a row to the coordinates matrix
            if (ver > 1) {
                coordinates[i] = new size_t[kIndices_size];
                coordinates[i][kIndices_start_row_idx] = r;
                coordinates[i][kIndices_start_col_idx] = c;
                coordinates[i][kIndices_end_row_idx] = r + ver - 1;
                coordinates[i][kIndices_end_col_idx] = c;
                i++;
            }
            if (diaD > 1) {
                coordinates[i] = new size_t[kIndices_size];
                coordinates[i][kIndices_start_row_idx] = r;
                coordinates[i][kIndices_start_col_idx] = c;
                coordinates[i][kIndices_end_row_idx] = r + diaD - 1;
                coordinates[i][kIndices_end_col_idx] = c + diaD - 1;
                i++;
            }
            if (diaA > 1) {
                coordinates[i] = new size_t[kIndices_size];
                coordinates[i][kIndices_start_row_idx] = r;
                coordinates[i][kIndices_start_col_idx] = c;
                coordinates[i][kIndices_end_row_idx] = r - diaA + 1;
                coordinates[i][kIndices_end_col_idx] = c + diaA - 1;
                i++;
            }
        }
    }
    return const_cast<const size_t**>(coordinates);
}
