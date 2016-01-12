#import <Foundation/Foundation.h>

@protocol LCHObserverProtocol <NSObject>

@optional
- (void)employeeDidStart:(id)employee;
- (void)employeeDidFinish:(id)employee;
- (void)employeeDidBecomeFree:(id)employee;

@end
