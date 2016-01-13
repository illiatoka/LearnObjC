#import <Foundation/Foundation.h>
#import "LCHEmployeeObserverProtocol.h"

@class LCHHandlerContainer;
@class LCHQueue;

@interface LCHDispatcher : NSObject <LCHEmployeeObserverProtocol>
@property (nonatomic, readonly) NSArray *handlers;

- (void)performWorkWithObject:(id)object;

- (void)addHandler:(id)handler;
- (void)removeHandler:(id)handler;

@end
