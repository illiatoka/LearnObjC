#include <stdio.h>

// Print string depends on input value
int LCHCheckValueAndPrint(int value) {
    
    // Local variable definition
    int result = 0;
    
    // Print specific string depends on value
    if (value % 15 == 0) {
        result = 15;
        printf("Mother and Father (result = %d)\n", result);
    } else if (value % 5 == 0) {
        result = 5;
        printf("Father (result = %d)\n", result);
    } else if (value % 3 == 0) {
        result = 3;
        printf("Mother (result = %d)\n", result);
    } else {
        result = 0;
    }
    
    return result;
    
}
