#import <Foundation/Foundation.h>
#import "LCHEmployeeObserverProtocol.h"

@class LCHHandlerContainer;
@class LCHQueue;

@interface LCHDispatcher : NSObject <LCHEmployeeObserverProtocol>
@property (nonatomic, readonly) LCHHandlerContainer *handlers;

- (void)performWorkWithObject:(id)object;

@end
