#import <Foundation/Foundation.h>

@class LCHEmployee;
@class LCHCar;

@interface LCHEnterprise : NSObject
@property (nonatomic, readonly) NSSet   *employees;

+ (instancetype)enterprise;

- (void)hireBasicStuff;

- (void)performWorkWithCar:(LCHCar *)car;
- (void)performWorkWithCars:(NSArray *)cars;

@end
