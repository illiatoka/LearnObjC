#import <Foundation/Foundation.h>

@class LCHEmployee;
@class LCHCar;

@interface LCHEnterprise : NSObject
@property (nonatomic, readonly) NSSet   *employees;

- (void)hireBasicStuff;

- (void)performAsyncWorkWithCar:(LCHCar *)car;
- (void)performAsyncWorkWithCars:(NSSet *)cars;

@end
