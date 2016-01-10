#import <Foundation/Foundation.h>
#import "LCHObserverProtocol.h"

@class LCHQueue;

@interface LCHDispatcher : NSObject <LCHObserverProtocol>
@property (nonatomic, readonly) LCHQueue    *queue;

+ (instancetype)dispatcherWithEnterprise:(id)enterprise;

- (instancetype)initWithEnterprise:(id)enterprise;

- (void)performWorkWithObject:(id)object;

- (id)freeHandlerOfClass:(Class)class;

@end
