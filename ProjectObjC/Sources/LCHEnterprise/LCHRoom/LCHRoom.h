#import <Foundation/Foundation.h>

@class LCHContainerWithCapacity;

@interface LCHRoom : NSObject
@property (nonatomic, readonly) LCHContainerWithCapacity    *employees;

+ (instancetype)room;
+ (instancetype)roomWithCapacity:(NSUInteger)capacity;

- (instancetype)initWithCapacity:(NSUInteger)capacity;

- (void)addEmployee:(id)employee;
- (void)removeEmployee:(id)employee;

- (BOOL)isFullOfEmployees;

@end
