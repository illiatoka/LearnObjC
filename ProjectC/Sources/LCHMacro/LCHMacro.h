#ifndef LCHMacro_h
#define LCHMacro_h

#define LCHObjectIvarGetter(object, iVar, returnValue) return NULL != object ? iVar : returnValue

#define LCHObjectAssignSetter(object, iVar, value) \
    if (NULL != object && value != object->iVar) { \
        object->iVar = value; \
    }

#define LCHObjectRetainSetter(object, iVar, value) \
    if (NULL != object && value != object->iVar) { \
        LCHObjectRetain(value); \
        LCHObjectRelease(object->iVar); \
        object->iVar = value; \
    }

#endif
