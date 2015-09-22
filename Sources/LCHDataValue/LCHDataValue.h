#ifndef LCHDataValue_h
#define LCHDataValue_h

#pragma mark -
#pragma mark Public Declarations

#define LCHDeclarePrintDataValue(type) int output_ ## type (type value)

#define LCHPrintDataValue(type, specifier) int output_ ## type (type value) \
    { printf("Value of data with type " #type " = " #specifier"\n", value); return 0; }

#define LCHCallPrintDataValue(type, value) output_ ## type (value)

#endif
