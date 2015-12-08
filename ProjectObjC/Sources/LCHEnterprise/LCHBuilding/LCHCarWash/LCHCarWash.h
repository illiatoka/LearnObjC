#import "LCHBuilding.h"

@class LCHWashBox;

@interface LCHCarWash : LCHBuilding

+ (instancetype)building;
+ (instancetype)buildingWithWashBox:(LCHWashBox *)washBox;

- (instancetype)initWithWashBox:(LCHCarWash *)washBox;

- (void)addRoom:(LCHRoom *)room;
- (void)removeRoom:(LCHRoom *)room;

@end
