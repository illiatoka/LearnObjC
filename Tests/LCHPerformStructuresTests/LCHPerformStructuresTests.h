#ifndef LCHPerformStructuresTests_h
#define LCHPerformStructuresTests_h

#include <stdio.h>
#include <stdbool.h>
#include <stddef.h>

#pragma mark -
#pragma mark Public Declarations

extern
void LCHPerfomStructuresTests(void);

typedef union {
    struct {
        bool bool1: 1;
        bool bool2: 1;
        bool bool3: 1;
        bool bool4: 1;
        bool bool5: 1;
        bool bool6: 1;
    } LCHBoolStructure;
} LCHRandomUnion;

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
    bool bool1;
    bool bool2;
    bool bool3;
    bool bool4;
    bool bool5;
    bool bool6;
    short shortValue1;
    short shortValue2;
    short shortValue3;
    float floatValue;
    int intValue;
    long long longLongValue;
    double doubleValue;
    char *string;
} LCHOptimizedStructure;

#endif
