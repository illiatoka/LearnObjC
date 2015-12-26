#import <Foundation/Foundation.h>

#import "LCHObserverProtocol.h"

@class LCHEmployee;
@class LCHCar;

@interface LCHEnterprise : NSObject <LCHObserverProtocol>
@property (nonatomic, readonly) NSSet   *employees;

- (void)hireBasicStuff;

- (void)performAsyncWorkWithCar:(LCHCar *)car;
- (void)performAsyncWorkWithCars:(NSSet *)cars;

@end
