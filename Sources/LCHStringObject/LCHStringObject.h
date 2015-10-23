#ifndef LCHStringObject_h
#define LCHStringObject_h

typedef struct LCHString LCHString;

extern
void __LCHStringDeallocate(void *object);

extern
LCHString *LCHStringCreate(void);

extern
char *LCHStringValue(LCHString *object);

extern
void LCHStringSetValue(LCHString *object, char *value);

extern
void LCHStringPrintValue(char *value);

#endif
