#include "LCHPerformStructuresTests.h"
#include "LCHPrintSizeOfDataType.h"
#include "LCHPerformStructures.h"

#pragma mark -
#pragma mark Public Implementations

void LCHPerfomStructuresTests(void) {
    LCHPrintSizeOfDataType(LCHRandomStructure);
    LCHPrintOffsetOfStructureElements(LCHRandomStructure);
    
    LCHPrintSizeOfDataType(LCHOptimizedStructure);
    LCHPrintOffsetOfStructureElements(LCHOptimizedStructure);
    
    LCHPrintSizeOfDataType(LCHOptimizedUnion);
    LCHPrintOffsetOfUnionElements(LCHOptimizedUnion);
}
