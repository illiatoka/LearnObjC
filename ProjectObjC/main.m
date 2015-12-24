#import <Foundation/Foundation.h>

#import "LCHEnterprise.h"
#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"
#import "LCHCar.h"

#import "LCHObservable.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSUInteger carCount = 10010;
        
        LCHEnterprise *enterprise = [LCHEnterprise enterprise];
        [enterprise hireBasicStuff];

        NSMutableArray *cars = [NSMutableArray arrayWithCapacity:carCount];
        for (NSUInteger count = 0; count < carCount; count++) {
            [cars addObject:[LCHCar car]];
        }
        
        [enterprise performWorkWithCars:cars];
        
        while (true) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        }
    }
    
    return 0;
}
