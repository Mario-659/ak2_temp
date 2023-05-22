#include <stdio.h>

// Declare the external function.
extern double calculateSum();

int main() {
    // Call the function.
    double result = calculateSum();

    // Print the result.
    printf("The sum is: %f\n", result);

    return 0;
}
