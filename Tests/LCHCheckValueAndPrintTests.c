#include <stdio.h>

#include "LCHCheckValueAndPrint.h"

// Test function using loop with 1000 iteration
void LCHCheckValueAndPrintTests() {
    
    // Define for loop
    for (int count = 0; count < 1000; count++) {
        
        // Local variable definition
        int currentCount = count;
        
        // Print current counter value
        printf("counter = %d\n", currentCount);
        
        // Run function with current counter value in parameters
        LCHCheckValueAndPrint(currentCount);
        
    }

}
