#ifndef LCHPerformStructures_h
#define LCHPerformStructures_h

#include <stdio.h>
#include <stddef.h>
#include <stdbool.h>

#define LCHPrintOffsetOfStructureElements(structure) \
    printf("\tOffset of bool1 is: %lu\n", offsetof(structure, bool1)); \
    printf("\tOffset of bool2 is: %lu\n", offsetof(structure, bool2)); \
    printf("\tOffset of doubleValue is: %lu\n", offsetof(structure, doubleValue)); \
    printf("\tOffset of bool3 is: %lu\n", offsetof(structure, bool3)); \
    printf("\tOffset of bool4 is: %lu\n", offsetof(structure, bool4)); \
    printf("\tOffset of bool5 is: %lu\n", offsetof(structure, bool5)); \
    printf("\tOffset of bool6 is: %lu\n", offsetof(structure, bool6)); \
    printf("\tOffset of shortValue1 is: %lu\n", offsetof(structure, shortValue1)); \
    printf("\tOffset of floatValue is: %lu\n", offsetof(structure, floatValue)); \
    printf("\tOffset of shortValue2 is: %lu\n", offsetof(structure, shortValue2)); \
    printf("\tOffset of shortValue3 is: %lu\n", offsetof(structure, shortValue3)); \
    printf("\tOffset of intValue is: %lu\n", offsetof(structure, intValue)); \
    printf("\tOffset of longlongValue is: %lu\n", offsetof(structure, longLongValue)); \
    printf("\tOffset of string is: %lu\n\n", offsetof(structure, string));

#define LCHPrintOffsetOfUnionElements(structure) \
    printf("\tOffset of longlongValue is: %lu\n", offsetof(structure, longLongValue)); \
    printf("\tOffset of doubleValue is: %lu\n", offsetof(structure, doubleValue)); \
    printf("\tOffset of floatValue is: %lu\n", offsetof(structure, floatValue)); \
    printf("\tOffset of intValue is: %lu\n", offsetof(structure, intValue)); \
    printf("\tOffset of string is: %lu\n", offsetof(structure, string)); \
    printf("\tOffset of shortValue1 is: %lu\n", offsetof(structure, shortValue1)); \
    printf("\tOffset of shortValue2 is: %lu\n", offsetof(structure, shortValue2)); \
    printf("\tOffset of shortValue3 is: %lu\n", offsetof(structure, shortValue3)); \
    printf("\tOffset of boolFlags is: %lu\n\n", offsetof(structure, boolFlags));

typedef struct {
    bool bool1;
    bool bool2;
    double doubleValue;
    bool bool3;
    bool bool4;
    bool bool5;
    bool bool6;
    short shortValue1;
    float floatValue;
    short shortValue2;
    short shortValue3;
    int intValue;
    long long longLongValue;
    char *string;
} LCHRandomStructure;

typedef struct {
    long long longLongValue;
    double doubleValue;
    float floatValue;
    int intValue;
    char *string;
    short shortValue1;
    short shortValue2;
    short shortValue3;
    bool bool1;
    bool bool2;
    bool bool3;
    bool bool4;
    bool bool5;
    bool bool6;
} LCHOptimizedStructure;

typedef struct {
    long long longLongValue;
    double doubleValue;
    float floatValue;
    int intValue;
    char *string;
    short shortValue1;
    short shortValue2;
    short shortValue3;
    union {
        struct {
            bool bool1: 1;
            bool bool2: 1;
            bool bool3: 1;
            bool bool4: 1;
            bool bool5: 1;
            bool bool6: 1;
        };
        char boolFlags;
    };
} LCHOptimizedUnion;

#endif
