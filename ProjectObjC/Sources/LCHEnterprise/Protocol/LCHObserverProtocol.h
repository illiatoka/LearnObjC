#import <Foundation/Foundation.h>
#import "LCHCashProtocol.h"

@protocol LCHObserverProtocol <NSObject>

@optional
- (void)performAsyncWorkWithObject:(id<LCHCashProtocol>)object;

- (void)washerman:(id)washerman didFinishWithObject:(id<LCHCashProtocol>)object;
- (void)accountant:(id)accountant didFinishWithObject:(id<LCHCashProtocol>)object;

@end
