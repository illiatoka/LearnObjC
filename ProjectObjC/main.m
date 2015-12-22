#import <Foundation/Foundation.h>

#import "LCHEnterprise.h"
#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"
#import "LCHCar.h"

#import "LCHObservable.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LCHEnterprise *enterprise = [LCHEnterprise enterprise];
        [enterprise hireBasicStuff];

        NSSet *cars = [NSSet setWithObjects:[LCHCar car], [LCHCar car], [LCHCar car], [LCHCar car], nil];
        for (LCHCar *car in cars) {
            NSLog(@"Is car clean: %hhd Money is: %lu", car.isClean, car.wallet);
        }
        
        for (LCHCar *car in cars) {
            [enterprise performWorkWithCar:car];
        }
        
        while (true) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        }
    }
    
    return 0;
}
