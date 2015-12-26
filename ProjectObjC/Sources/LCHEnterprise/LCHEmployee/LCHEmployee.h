#import <Foundation/Foundation.h>

#import "LCHObservable.h"
#import "LCHCashProtocol.h"
#import "LCHStateProtocol.h"
#import "LCHObserverProtocol.h"

@interface LCHEmployee : LCHObservable <LCHCashProtocol, LCHStateProtocol, LCHObserverProtocol>
@property (nonatomic, readwrite, assign)    NSUInteger          salary;
@property (nonatomic, readwrite, assign)    NSUInteger          experience;

+ (instancetype)employee;
+ (instancetype)employeeWithSalary:(NSUInteger)salary experience:(NSUInteger)experience;

- (instancetype)initWithSalary:(NSUInteger)salary experience:(NSUInteger)experience;

@end
