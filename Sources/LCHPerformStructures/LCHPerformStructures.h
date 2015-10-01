#ifndef LCHPerformStructures_h
#define LCHPerformStructures_h

#include <stdio.h>
#include <stddef.h>
#include <stdbool.h>

#define LCHPrintTextForOffsetOfStructure(structure, structureElement) \
    printf("\tOffset of " #structureElement " is: %lu\n", offsetof(structure, structureElement));

#define LCHPrintOffsetOfStructureElements(structure) \
    LCHPrintTextForOffsetOfStructure(structure, bool1) \
    LCHPrintTextForOffsetOfStructure(structure, bool2) \
    LCHPrintTextForOffsetOfStructure(structure, bool3) \
    LCHPrintTextForOffsetOfStructure(structure, bool4) \
    LCHPrintTextForOffsetOfStructure(structure, bool5) \
    LCHPrintTextForOffsetOfStructure(structure, bool6) \
    LCHPrintTextForOffsetOfStructure(structure, doubleValue) \
    LCHPrintTextForOffsetOfStructure(structure, shortValue1) \
    LCHPrintTextForOffsetOfStructure(structure, floatValue) \
    LCHPrintTextForOffsetOfStructure(structure, shortValue2) \
    LCHPrintTextForOffsetOfStructure(structure, shortValue3) \
    LCHPrintTextForOffsetOfStructure(structure, intValue) \
    LCHPrintTextForOffsetOfStructure(structure, longLongValue) \
    LCHPrintTextForOffsetOfStructure(structure, string) \
    printf("\n");

#define LCHPrintOffsetOfUnionElements(structure) \
    LCHPrintTextForOffsetOfStructure(structure, string) \
    LCHPrintTextForOffsetOfStructure(structure, longLongValue) \
    LCHPrintTextForOffsetOfStructure(structure, doubleValue) \
    LCHPrintTextForOffsetOfStructure(structure, floatValue) \
    LCHPrintTextForOffsetOfStructure(structure, intValue) \
    LCHPrintTextForOffsetOfStructure(structure, shortValue1) \
    LCHPrintTextForOffsetOfStructure(structure, shortValue2) \
    LCHPrintTextForOffsetOfStructure(structure, shortValue3) \
    LCHPrintTextForOffsetOfStructure(structure, boolFlags) \
    printf("\n");

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
    char *string;
    long long longLongValue;
    double doubleValue;
    float floatValue;
    int intValue;
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
    char *string;
    long long longLongValue;
    double doubleValue;
    float floatValue;
    int intValue;
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
