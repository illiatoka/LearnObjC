#import <Foundation/Foundation.h>
#import "LCHEmployeeObserverProtocol.h"

@interface LCHDispatcher : NSObject <LCHEmployeeObserverProtocol>

- (void)performWorkWithObject:(id)object;

- (void)addHandler:(id)handler;
- (void)removeHandler:(id)handler;

- (BOOL)containsHandler:(id)handler;

@end
