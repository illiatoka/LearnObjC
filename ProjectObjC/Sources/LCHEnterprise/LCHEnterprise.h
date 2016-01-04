#import <Foundation/Foundation.h>

@class LCHCar;

@interface LCHEnterprise : NSObject

- (void)performAsyncWorkWithCar:(LCHCar *)car;
- (void)performAsyncWorkWithCars:(NSSet *)cars;

@end
