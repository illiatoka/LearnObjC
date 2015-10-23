#include "LCHPrintSizeOfDataTypeTests.h"
#include "LCHPerformParentTypeTests.h"
#include "LCHPrintValueOfDataTests.h"
#include "LCHPerformStructuresTests.h"
#include "LCHPrintBytesOfValueTests.h"
#include "LCHHumanObjectTests.h"
#include "LCHStringObjectTests.h"
#include "LCHArrayObjectTests.h"
#include "LCHObjectTests.h"

int main(int argc, const char * argv[]) {
    // LCHPrintSizeOfDataTypeTests();
    // LCHPerformParentTypeTests();
    // LCHPrintValueOfDataTests();
    // LCHPerfomStructuresTests();
    // LCHPrintBytesOfValueTests();
    
    LCHPerformHumanObjectTests();
    LCHPerformObjectTests();
    LCHPerformStringTests();
    LCHPerformArrayTests();
    
    return 0;
}
