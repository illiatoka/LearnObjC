#include "LCHPerformStructuresTests.h"

#pragma mark -
#pragma mark Private Declarations

static
size_t LCHPrintSizeOfUnion(void);

static
size_t LCHPrintSizeOfRandomStructure(void);

static
size_t LCHPrintSizeOfOptimizedStructure(void);

#pragma mark -
#pragma mark Public Implementations

void LCHPerfomStructuresTests(void) {
    LCHRandomUnion boolValue = {true, false, true, true, false, false};
    
    printf("Size of union is: %lu\n", LCHPrintSizeOfUnion());
    printf("\tValue of bool1 is: %d\n", boolValue.LCHBoolStructure.bool1);
    printf("\tValue of bool2 is: %d\n", boolValue.LCHBoolStructure.bool2);
    printf("\tValue of bool3 is: %d\n", boolValue.LCHBoolStructure.bool3);
    printf("\tValue of bool4 is: %d\n", boolValue.LCHBoolStructure.bool4);
    printf("\tValue of bool5 is: %d\n", boolValue.LCHBoolStructure.bool5);
    printf("\tValue of bool6 is: %d\n\n", boolValue.LCHBoolStructure.bool6);
    
    printf("Size of random structure is: %lu\n", LCHPrintSizeOfRandomStructure());
    printf("\tOffset of bool1 is: %lu\n", offsetof(LCHRandomStructure, bool1));
    printf("\tOffset of bool2 is: %lu\n", offsetof(LCHRandomStructure, bool2));
    printf("\tOffset of doubleValue is: %lu\n", offsetof(LCHRandomStructure, doubleValue));
    printf("\tOffset of bool3 is: %lu\n", offsetof(LCHRandomStructure, bool3));
    printf("\tOffset of bool4 is: %lu\n", offsetof(LCHRandomStructure, bool4));
    printf("\tOffset of bool5 is: %lu\n", offsetof(LCHRandomStructure, bool5));
    printf("\tOffset of bool6 is: %lu\n", offsetof(LCHRandomStructure, bool6));
    printf("\tOffset of shortValue1 is: %lu\n", offsetof(LCHRandomStructure, shortValue1));
    printf("\tOffset of floatValue is: %lu\n", offsetof(LCHRandomStructure, floatValue));
    printf("\tOffset of shortValue2 is: %lu\n", offsetof(LCHRandomStructure, shortValue2));
    printf("\tOffset of shortValue3 is: %lu\n", offsetof(LCHRandomStructure, shortValue3));
    printf("\tOffset of intValue is: %lu\n", offsetof(LCHRandomStructure, intValue));
    printf("\tOffset of longlongValue is: %lu\n", offsetof(LCHRandomStructure, longLongValue));
    printf("\tOffset of string is: %lu\n\n", offsetof(LCHRandomStructure, string));
    
    printf("Size of optimized structure is: %lu\n", LCHPrintSizeOfOptimizedStructure());
    printf("\tOffset of bool1 is: %lu\n", offsetof(LCHOptimizedStructure, bool1));
    printf("\tOffset of bool2 is: %lu\n", offsetof(LCHOptimizedStructure, bool2));
    printf("\tOffset of bool3 is: %lu\n", offsetof(LCHOptimizedStructure, bool3));
    printf("\tOffset of bool4 is: %lu\n", offsetof(LCHOptimizedStructure, bool4));
    printf("\tOffset of bool5 is: %lu\n", offsetof(LCHOptimizedStructure, bool5));
    printf("\tOffset of bool6 is: %lu\n", offsetof(LCHOptimizedStructure, bool6));
    printf("\tOffset of shortValue1 is: %lu\n", offsetof(LCHOptimizedStructure, shortValue1));
    printf("\tOffset of shortValue2 is: %lu\n", offsetof(LCHOptimizedStructure, shortValue2));
    printf("\tOffset of shortValue3 is: %lu\n", offsetof(LCHOptimizedStructure, shortValue3));
    printf("\tOffset of floatValue is: %lu\n", offsetof(LCHOptimizedStructure, floatValue));
    printf("\tOffset of intValue is: %lu\n", offsetof(LCHOptimizedStructure, intValue));
    printf("\tOffset of longlongValue is: %lu\n", offsetof(LCHOptimizedStructure, longLongValue));
    printf("\tOffset of doubleValue is: %lu\n", offsetof(LCHOptimizedStructure, doubleValue));
    printf("\tOffset of string is: %lu\n\n", offsetof(LCHOptimizedStructure, string));
}

#pragma mark -
#pragma mark Private Implementations

size_t LCHPrintSizeOfUnion(void) {
    return sizeof(LCHRandomUnion);
}

size_t LCHPrintSizeOfRandomStructure(void) {
    return sizeof(LCHRandomStructure);
}

size_t LCHPrintSizeOfOptimizedStructure(void) {
    return sizeof(LCHOptimizedStructure);
}
