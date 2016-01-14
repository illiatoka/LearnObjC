#import <Foundation/Foundation.h>
#import "LCHEmployeeObserverProtocol.h"

@interface LCHController : NSObject <LCHEmployeeObserverProtocol>
@property (nonatomic, readonly, getter=isWorking)   BOOL    working;

+ (instancetype)controllerWithEnterprise:(id)enterprise;

- (instancetype)initWithEnterprise:(id)enterprise;

- (void)startWork;
- (void)stopWork;

@end
