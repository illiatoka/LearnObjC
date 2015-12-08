#import "LCHBuilding.h"

@class LCHAdminRoom;

@interface LCHOffice : LCHBuilding

+ (instancetype)building;
+ (instancetype)buildingWithAdminRoom:(LCHAdminRoom *)adminRoom;

- (instancetype)initWithAdminRoom:(LCHAdminRoom *)adminRoom;

- (void)addRoom:(LCHRoom *)room;
- (void)removeRoom:(LCHRoom *)room;

@end
