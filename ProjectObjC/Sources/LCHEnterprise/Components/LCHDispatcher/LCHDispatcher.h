#import <Foundation/Foundation.h>
#import "LCHEmployeeObserverProtocol.h"

@class LCHContainer;
@class LCHQueue;

@interface LCHDispatcher : NSObject <LCHEmployeeObserverProtocol>
@property (nonatomic, readonly) LCHContainer    *handlers;

- (void)performWorkWithObject:(id)object;

@end
