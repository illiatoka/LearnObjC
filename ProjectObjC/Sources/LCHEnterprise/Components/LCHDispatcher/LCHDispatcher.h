#import <Foundation/Foundation.h>
#import "LCHObserverProtocol.h"

@class LCHContainer;
@class LCHQueue;

@interface LCHDispatcher : NSObject <LCHObserverProtocol>
@property (nonatomic, readonly) LCHContainer    *handlers;
@property (nonatomic, readonly) LCHQueue        *queue;

- (void)performWorkWithObject:(id)object;

@end
