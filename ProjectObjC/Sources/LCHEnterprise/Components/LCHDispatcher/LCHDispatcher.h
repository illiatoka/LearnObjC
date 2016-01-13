#import <Foundation/Foundation.h>
#import "LCHEmployeeObserverProtocol.h"

@class LCHContainer;
@class LCHQueue;

@interface LCHDispatcher : NSObject <LCHEmployeeObserverProtocol>
@property (nonatomic, readonly) LCHContainer    *handlers;
@property (nonatomic, readonly) LCHQueue        *queue;

- (void)performWorkWithObject:(id)object;

@end
