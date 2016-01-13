#import <Foundation/Foundation.h>
#import "LCHEmployeeObserverProtocol.h"

@interface LCHController : NSObject <LCHEmployeeObserverProtocol>

+ (instancetype)controllerWithEnterprise:(id)enterprise;

- (instancetype)initWithEnterprise:(id)enterprise;

- (void)startWork;

@end
