#import <Foundation/Foundation.h>

@interface LCHEmployee : NSObject
@property (nonatomic, readonly) NSUInteger *salary;
@property (nonatomic, readonly) NSUInteger *experience;

+ (instancetype)employee;
+ (instancetype)employeeWithSalary:(NSUInteger)salary experience:(NSUInteger)experience;

- (instancetype)initWithSalary:(NSUInteger)salary experience:(NSUInteger)experience;

@end
