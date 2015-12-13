#import <Foundation/Foundation.h>

@class LCHCarWash;
@class LCHRoom;

@interface LCHBuilding : NSObject
@property (nonatomic, readonly) NSSet *rooms;

+ (instancetype)building;
+ (instancetype)buildingWithRooms:(NSSet *)rooms;

- (instancetype)initWithRooms:(NSSet *)rooms;

- (void)addRoom:(id)room;
- (void)removeRoom:(id)room;

- (BOOL)canContainCarWashRoom;

@end
