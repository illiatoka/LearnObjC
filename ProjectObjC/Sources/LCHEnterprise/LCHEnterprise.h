#import <Foundation/Foundation.h>

@class LCHCar;
@class LCHContainer;

@interface LCHEnterprise : NSObject
@property (nonatomic, readonly) NSArray *handlers;

- (void)performWorkWithCar:(LCHCar *)car;
- (void)performWorkWithCars:(NSArray *)cars;

@end
