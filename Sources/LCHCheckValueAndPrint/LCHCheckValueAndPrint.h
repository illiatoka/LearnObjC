#ifndef LCHLearnchardway_LCHCheckValueAndPrint_h
#define LCHLearnchardway_LCHCheckValueAndPrint_h

typedef enum {
    kLCHParentTypeUndefined = 0,
    kLCHParentTypeMother,
    kLCHParentTypeFather,
    kLCHParentTypeMotherFather
} LCHParentType;

extern LCHParentType LCHCheckParentType(int value);

#endif
