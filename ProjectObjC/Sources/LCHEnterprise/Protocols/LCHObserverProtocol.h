#import <Foundation/Foundation.h>
#import "LCHCashProtocol.h"

@protocol LCHObserverProtocol <NSObject>

@optional
- (void)employeeDidStartWork:(id)employee;
- (void)employeeDidFinishWork:(id)employee;
- (void)employeeDidBecomeFree:(id)employee;

@end
