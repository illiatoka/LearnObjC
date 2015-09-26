#include <stdio.h>
#include <stdlib.h>

#include "LCHPrintBytesOfValue.h"

#pragma mark -
#pragma mark Public Implementations

void LCHPrintBytesOfValue(void *value, unsigned long typeSize) {
    unsigned long *valuePointer = ((unsigned long *)value);
    unsigned long sizeOfType = typeSize;
    unsigned long iterator = 0;
    
    printf("Bits of value with pointer %p is: \n", valuePointer);

    for (iterator = (sizeOfType << 3); iterator !=0; iterator--) {
        if (0 == iterator % 8 && iterator != sizeOfType << 3) {
            printf(" ");
        }
        
        if (((*valuePointer >> (iterator - 1)) & 1) != 0) {
            printf("1");
        }
        else {
            printf("0");
        }
    }
    
    printf(" - %lu byte%s\n\n", typeSize, ((typeSize == 1) ? " " : "s" ));
}
