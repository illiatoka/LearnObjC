#import <Foundation/Foundation.h>

#import "LCHObservable.h"
#import "LCHCashProtocol.h"
#import "LCHStateProtocol.h"

@interface LCHEmployee : LCHObservable <LCHCashProtocol, LCHStateProtocol>

- (void)performAsyncWorkWithObject:(id<LCHCashProtocol>)object;

@end
