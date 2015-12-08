#import "LCHRoom.h"

@interface LCHAdminRoom : LCHRoom

+ (instancetype)room;
+ (instancetype)roomWithEmployee:(LCHEmployee *)employee;

- (instancetype)initWithEmployee:(LCHEmployee *)employee;

- (void)addEmployee:(id)employee;
- (void)removeEmployee:(id)employee;

@end
