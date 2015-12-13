#import <Foundation/Foundation.h>

#import "LCHEnterprise.h"
#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"
#import "LCHCar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LCHEnterprise *enterprise = [LCHEnterprise enterprise];
        NSLog(@"Enterprise is: %@", enterprise);
        
        LCHManager *manager = [LCHManager employee];
        [enterprise hireAnEmployee:manager];
        NSLog(@"Manager is: %@", manager);
        
        LCHAccountant *accountant = [LCHAccountant employee];
        [enterprise hireAnEmployee:accountant];
        NSLog(@"Accountant is: %@", accountant);
        
        // Should not be added!
        LCHAccountant *accountant2 = [LCHAccountant employee];
        [enterprise hireAnEmployee:accountant2];
        NSLog(@"Accountant2 is: %@", accountant2);
        
        LCHWasherman *washerman = [LCHWasherman employee];
        [enterprise hireAnEmployee:washerman];
        NSLog(@"Washerman is: %@", washerman);
        
        NSSet *cars = [NSSet setWithObjects:[LCHCar car], [LCHCar car], [LCHCar car], [LCHCar car], nil];
        for (LCHCar *car in cars) {
            NSLog(@"Is car clean: %hhd Money is: %lu", car.isClean, car.wallet);
        }
        
        [enterprise performWorkWithCars:cars];
        
        for (LCHCar *car in cars) {
            NSLog(@"Is car clean: %hhd Money is: %lu", car.isClean, car.wallet);
        }
    }
    
    return 0;
}
