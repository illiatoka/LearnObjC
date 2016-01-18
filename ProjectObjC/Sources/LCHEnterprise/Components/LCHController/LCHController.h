#import <Foundation/Foundation.h>
#import "LCHEmployeeObserverProtocol.h"

@interface LCHController : NSObject <LCHEmployeeObserverProtocol>
@property (nonatomic, assign, getter=isWorking) BOOL    working;

+ (instancetype)controllerWithEnterprise:(id)enterprise;

- (instancetype)initWithEnterprise:(id)enterprise;

@end
