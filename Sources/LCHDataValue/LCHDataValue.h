#ifndef LCHDataValue_h
#define LCHDataValue_h

#pragma mark -
#pragma mark Public Declarations

#define LCHPrintDataValue(type, specifier) \
    void output_ ## type(type value) { \
        printf("Value of data with type " #type " = " #specifier"\n", value); \
    }

#define LCHCallPrintDataValue(type, value) output_ ## type (value)

#endif
