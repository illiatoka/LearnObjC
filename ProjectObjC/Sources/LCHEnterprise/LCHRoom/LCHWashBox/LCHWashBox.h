#import "LCHRoom.h"

@interface LCHWashBox : LCHRoom
@property (nonatomic, readonly) LCHContainerWithCapacity    *cars;

@property (nonatomic, readonly, getter=isAbleToContainCars) BOOL    ableToContainCars;

+ (instancetype)roomWithCapacity:(NSUInteger)capacity;

- (instancetype)initWithCapacity:(NSUInteger)capacity;

- (void)addCar:(id)car;
- (void)removeCar:(id)car;

- (BOOL)isFullOfCars;

@end
