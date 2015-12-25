#import <Foundation/Foundation.h>

#import "LCHEnterprise.h"
#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"
#import "LCHCar.h"

#import "LCHObservable.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSUInteger carCount = 10100;
        
        LCHEnterprise *enterprise = [LCHEnterprise object];
        [enterprise hireBasicStuff];

        NSMutableSet *cars = [NSMutableSet setWithCapacity:carCount];
        for (NSUInteger count = 0; count < carCount; count++) {
            [cars addObject:[LCHCar car]];
        }
        
        [enterprise performAsyncWorkWithCars:cars];
        
        while (true) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        }
    }
    
    return 0;
}
