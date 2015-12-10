#import <Foundation/Foundation.h>

@class LCHContainerWithCapacity;

@interface LCHRoom : NSObject
@property (nonatomic, readonly) LCHContainerWithCapacity *employees;

- (void)addEmployee:(id)employee;
- (void)removeEmployee:(id)employee;

@end
