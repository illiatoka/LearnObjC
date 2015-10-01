#include <stdio.h>
#include <stddef.h>

#include "LCHPerformStructuresTests.h"
#include "LCHPrintSizeOfDataType.h"
#include "LCHPerformStructures.h"

#pragma mark -
#pragma mark Private Declarations

#define LCHPrintTextForOffsetOfStructure(structure, structureElement) \
printf("\tOffset of " #structureElement " is: %lu\n", offsetof(structure, structureElement));

#define LCHPrintOffsetOfStructureBoolElements(structure) \
    LCHPrintTextForOffsetOfStructure(structure, bool1) \
    LCHPrintTextForOffsetOfStructure(structure, bool2) \
    LCHPrintTextForOffsetOfStructure(structure, bool3) \
    LCHPrintTextForOffsetOfStructure(structure, bool4) \
    LCHPrintTextForOffsetOfStructure(structure, bool5) \
    LCHPrintTextForOffsetOfStructure(structure, bool6)

#define LCHPrintOffsetOfStructureElements(structure) \
    LCHPrintTextForOffsetOfStructure(structure, doubleValue) \
    LCHPrintTextForOffsetOfStructure(structure, shortValue1) \
    LCHPrintTextForOffsetOfStructure(structure, floatValue) \
    LCHPrintTextForOffsetOfStructure(structure, shortValue2) \
    LCHPrintTextForOffsetOfStructure(structure, shortValue3) \
    LCHPrintTextForOffsetOfStructure(structure, intValue) \
    LCHPrintTextForOffsetOfStructure(structure, longLongValue) \
    LCHPrintTextForOffsetOfStructure(structure, string) \
    printf("\n");

#define LCHPerformStructuresTestsNamed(structure) \
    LCHPrintSizeOfDataType(structure); \
    LCHPrintOffsetOfStructureBoolElements(structure); \
    LCHPrintOffsetOfStructureElements(structure);

#pragma mark -
#pragma mark Public Implementations

void LCHPerfomStructuresTests(void) {
    LCHPerformStructuresTestsNamed(LCHRandomStructure);
    LCHPerformStructuresTestsNamed(LCHOptimizedStructure);
    
    LCHPrintSizeOfDataType(LCHOptimizedUnion);
    LCHPrintTextForOffsetOfStructure(LCHOptimizedUnion, boolFlags);
    LCHPrintOffsetOfStructureElements(LCHOptimizedUnion);
}
