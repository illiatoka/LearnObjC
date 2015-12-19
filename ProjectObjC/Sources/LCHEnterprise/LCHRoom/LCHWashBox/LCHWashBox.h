#import "LCHRoom.h"

@interface LCHWashBox : LCHRoom
@property (nonatomic, readonly) LCHContainerWithCapacity    *cars;

- (void)addCar:(id)car;
- (void)removeCar:(id)car;

- (BOOL)isFullOfCars;

@end
