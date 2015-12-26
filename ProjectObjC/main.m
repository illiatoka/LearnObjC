#import <Foundation/Foundation.h>

#import "LCHEnterprise.h"
#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"
#import "LCHCar.h"

#import "LCHObservable.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSUInteger carCount = 4000;
        
        LCHEnterprise *enterprise = [LCHEnterprise object];
        [enterprise hireBasicStuff];

        NSMutableSet *cars = [NSMutableSet setWithCapacity:carCount];
        NSMutableSet *cars2 = [NSMutableSet setWithCapacity:carCount];
        
        for (NSUInteger count = 0; count < carCount; count++) {
            [cars addObject:[LCHCar car]];
        }
        
        for (NSUInteger count = 0; count < carCount; count++) {
            [cars2 addObject:[LCHCar car]];
        }
        
        [enterprise performAsyncWorkWithCars:cars];
        [enterprise performAsyncWorkWithCars:cars2];
        
        while (true) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        }
    }
    
    return 0;
}
