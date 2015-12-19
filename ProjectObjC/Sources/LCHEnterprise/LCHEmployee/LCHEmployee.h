#import <Foundation/Foundation.h>

#import "LCHObservable.h"
#import "LCHCashProtocol.h"

typedef NS_ENUM(NSUInteger, LCHEmployeeState) {
    kLCHEmployeeIsFree,
    kLCHEmployeeIsWorking,
    kLCHEmployeeIsOnHold,
};

@interface LCHEmployee : LCHObservable <LCHCashProtocol>
@property (nonatomic, readwrite, assign)    LCHEmployeeState    state;
@property (nonatomic, readwrite, assign)    NSUInteger          salary;
@property (nonatomic, readwrite, assign)    NSUInteger          experience;

+ (instancetype)employee;
+ (instancetype)employeeWithSalary:(NSUInteger)salary experience:(NSUInteger)experience;

- (instancetype)initWithSalary:(NSUInteger)salary experience:(NSUInteger)experience;

- (void)performWorkWithObject:(id<LCHCashProtocol>)object;

@end
