#import <Foundation/Foundation.h>

#import "LCHCashProtocol.h"

@interface LCHEmployee : NSObject <LCHCashProtocol>
@property (nonatomic, readonly) id  parrentRoom;

@property (nonatomic, readwrite, assign)    NSUInteger  salary;
@property (nonatomic, readwrite, assign)    NSUInteger  experience;

+ (instancetype)employee;
+ (instancetype)employeeWithSalary:(NSUInteger)salary experience:(NSUInteger)experience;

- (instancetype)initWithSalary:(NSUInteger)salary experience:(NSUInteger)experience;

- (void)performEmployeeSpecificOperationWithPrise:(NSUInteger)price;

- (void)__addParrentRoom:(id)room;
- (void)__removeParrentRoom;

@end
