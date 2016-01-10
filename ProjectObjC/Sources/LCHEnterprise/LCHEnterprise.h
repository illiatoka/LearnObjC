#import <Foundation/Foundation.h>

@class LCHCar;
@class LCHContainer;

@interface LCHEnterprise : NSObject
@property (nonatomic, readonly) LCHContainer    *employees;

- (void)performWorkWithCar:(LCHCar *)car;
- (void)performWorkWithCars:(NSArray *)cars;

@end
