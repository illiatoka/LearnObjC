#ifndef LCHPerformStructures_h
#define LCHPerformStructures_h

#include <stdbool.h>

typedef struct {
    char *string;
    bool bool1;
    bool bool2;
    double doubleValue;
    bool bool3;
    bool bool4;
    long long longLongValue;
    bool bool5;
    short shortValue1;
    bool bool6;
    float floatValue;
    short shortValue2;
    short shortValue3;
    int intValue;
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
