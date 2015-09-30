#ifndef LCHPerformParentType_h
#define LCHPerformParentType_h

typedef enum {
    kLCHParentTypeUndefined = 0,
    kLCHParentTypeMother,
    kLCHParentTypeFather,
    kLCHParentTypeMotherFather
} LCHParentType;

extern
LCHParentType LCHPerformParentType(int value);

#endif
