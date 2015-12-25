#import <Foundation/Foundation.h>

@protocol LCHObserverProtocol <NSObject>
- (void)performAsyncWorkWithObject:(id<LCHCashProtocol>)object;

@end
