#ifndef LCHPrintValueOfData_h
#define LCHPrintValueOfData_h

#include <stdio.h>

#define LCHPrintDataValue(type, specifier) \
    void output_ ## type(type value) { \
        printf("Value of data with type " #type " = " #specifier"\n", value); \
    }

#define LCHCallPrintDataValue(type, value) output_ ## type (value)

#endif
