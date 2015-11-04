#ifndef LCHStringObject_h
#define LCHStringObject_h

typedef struct LCHString LCHString;

extern
void __LCHStringDeallocate(void *object);

extern
LCHString *LCHStringCreate(char *value);

extern
char *LCHStringValue(LCHString *object);

extern
void LCHStringSetValue(LCHString *object, char *value);

extern
uint16_t LCHStringLength(LCHString *object);

#endif
