#import <Foundation/Foundation.h>

@class LCHRoom;
@class LCHWashBox;
@class LCHEmployee;
@class LCHCar;

@interface LCHEnterprise : NSObject
@property (nonatomic, readonly) NSSet   *rooms;
@property (nonatomic, readonly) NSSet   *employees;

+ (instancetype)enterprise;
+ (instancetype)enterpriseWithOffice:(LCHRoom *)office washBox:(LCHWashBox *)washBox;

- (instancetype)initWithOffice:(LCHRoom *)office washBox:(LCHWashBox *)washBox;

- (void)addRoom:(LCHRoom *)room;

- (void)hireAnEmployee:(LCHEmployee *)employee;
- (void)fireAnEmployee:(LCHEmployee *)employee;

- (void)performWorkWithCar:(LCHCar *)car;

@end
