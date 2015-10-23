#ifndef LCHStringObject_h
#define LCHStringObject_h

#include <string.h>

#include "LCHObject.h"

typedef struct LCHString LCHString;

extern
void __LCHStringDeallocate(void *object);

extern
LCHString *LCHStringCreate(void);

extern
char *LCHStringName(LCHString *object);

extern
void LCHStringSetName(LCHString *object, char *value);

extern
char *LCHStringSurname(LCHString *object);

extern
void LCHStringSetSurname(LCHString *object, char *value);

extern
char *LCHStringFullname(LCHString *object);

extern
void LCHStringPrintValue(char *value);

#endif
