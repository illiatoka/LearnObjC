#import <Foundation/Foundation.h>

@class LCHRoom;

@interface LCHBuilding : NSObject
@property (nonatomic, readonly) NSSet   *rooms;

+ (instancetype)building;
+ (instancetype)buildingWithRooms:(NSSet *)rooms;

- (instancetype)initWithRooms:(NSSet *)rooms;

- (void)addRoom:(LCHRoom *)room;
- (void)removeRoom:(LCHRoom *)room;

@end
