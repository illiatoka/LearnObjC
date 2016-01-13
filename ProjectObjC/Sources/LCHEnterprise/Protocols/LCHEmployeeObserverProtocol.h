#import <Foundation/Foundation.h>

@protocol LCHEmployeeObserverProtocol <NSObject>

@optional
- (void)employeeDidStartWork:(id)employee;
- (void)employeeDidFinishWork:(id)employee;
- (void)employeeDidBecomeFree:(id)employee;

@end
