#include "LCHPerformStructuresTests.h"
#include "LCHPerformStructures.h"

#pragma mark -
#pragma mark Private Declarations

static
size_t LCHPrintSizeOfRandomStructure(void);

static
size_t LCHPrintSizeOfOptimizedStructure(void);

static
size_t LCHPrintSizeOfUnion(void);

#pragma mark -
#pragma mark Public Implementations

void LCHPerfomStructuresTests(void) {
    printf("Size of random structure is: %lu\n", LCHPrintSizeOfRandomStructure());
    LCHPrintOffsetOfStructureElements(LCHRandomStructure);
    
    printf("Size of optimized structure is: %lu\n", LCHPrintSizeOfOptimizedStructure());
    LCHPrintOffsetOfStructureElements(LCHOptimizedStructure);
    
    printf("Size of union is: %lu\n", LCHPrintSizeOfUnion());
    LCHPrintOffsetOfUnionElements(LCHOptimizedUnion);
}

#pragma mark -
#pragma mark Private Implementations

size_t LCHPrintSizeOfRandomStructure(void) {
    return sizeof(LCHRandomStructure);
}

size_t LCHPrintSizeOfOptimizedStructure(void) {
    return sizeof(LCHOptimizedStructure);
}

size_t LCHPrintSizeOfUnion(void) {
    return sizeof(LCHOptimizedUnion);
}
