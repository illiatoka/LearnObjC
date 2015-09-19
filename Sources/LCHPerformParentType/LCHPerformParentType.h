#ifndef LCHPerformParentType_h
#define LCHPerformParentType_h

#pragma mark -
#pragma mark Public Declarations

typedef enum {
    kLCHParentTypeUndefined = 0,
    kLCHParentTypeMother,
    kLCHParentTypeFather,
    kLCHParentTypeMotherFather
} LCHParentType;

extern LCHParentType LCHPerformParentType(int value);

#endif
