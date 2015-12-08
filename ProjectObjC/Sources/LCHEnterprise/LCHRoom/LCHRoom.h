#import <Foundation/Foundation.h>

@class LCHEmployee;

@interface LCHRoom : NSObject
@property (nonatomic, readonly) NSSet *employees;

- (void)addEmployee:(id)employee;
- (void)removeEmployee:(id)employee;

@end
