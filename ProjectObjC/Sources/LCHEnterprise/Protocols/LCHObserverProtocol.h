#import <Foundation/Foundation.h>
#import "LCHCashProtocol.h"

@protocol LCHObserverProtocol <NSObject>

- (void)employeeIsFree:(id)employee;
- (void)employeeIsWorking:(id)employee;
- (void)employeeProcessingNeeded:(id)employee;

@end
