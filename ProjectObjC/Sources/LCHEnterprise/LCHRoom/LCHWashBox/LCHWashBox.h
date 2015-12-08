#import "LCHRoom.h"

@interface LCHWashBox : LCHRoom

+ (instancetype)room;
+ (instancetype)roomWithEmployee:(LCHEmployee *)employee;

- (instancetype)initWithEmployee:(LCHEmployee *)employee;

- (void)addEmployee:(id)employee;
- (void)removeEmployee:(id)employee;

@end
