#import <Foundation/Foundation.h>

@class LCHOffice;
@class LCHCarWash;
@class LCHRoom;

@interface LCHBuilding : NSObject
@property (nonatomic, readonly) NSSet *rooms;

- (void)addRoom:(LCHRoom *)room;
- (void)removeRoom:(LCHRoom *)room;

@end
