#import "LCHRoom.h"

@interface LCHWashBox : LCHRoom
@property (nonatomic, readonly) LCHContainerWithCapacity    *cars;

@property (nonatomic, readonly, getter=isAbleToContainCars) BOOL    ableToContainCars;

- (void)addCar:(id)car;
- (void)removeCar:(id)car;

@end
