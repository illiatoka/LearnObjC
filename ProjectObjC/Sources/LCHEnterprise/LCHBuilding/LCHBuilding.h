#import <Foundation/Foundation.h>

@class LCHOffice;
@class LCHCarWash;
@class LCHRoom;

@interface LCHBuilding : NSObject
@property (nonatomic, readonly) NSSet *rooms;

+ (instancetype)office;
+ (instancetype)carWash;

+ (instancetype)officeWithRooms:(NSSet *)rooms;
+ (instancetype)carWashWithRooms:(NSSet *)rooms;

- (instancetype)initOfficeWithRooms:(NSSet *)rooms;
- (instancetype)initCarWashWithRooms:(NSSet *)rooms;

- (void)addRoom:(LCHRoom *)room;
- (void)removeRoom:(LCHRoom *)room;

@end
